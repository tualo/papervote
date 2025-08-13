<?php

namespace Tualo\Office\PaperVote\Routes\involvement;

use Exception;
use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\Basic\Route as BasicRoute;
use Tualo\Office\Basic\IRoute;
use Tualo\Office\DS\DSExporterHelper;

use PhpOffice\PhpSpreadsheet;
use PhpOffice\PhpSpreadsheet\Spreadsheet;
use PhpOffice\PhpSpreadsheet\Cell\Coordinate;
use PhpOffice\PhpSpreadsheet\Worksheet\Worksheet;
use PhpOffice\PhpSpreadsheet\IOFactory;

use Ramsey\Uuid\Uuid;
use Tualo\Office\Report\Routes\Report;

class Reporting implements IRoute
{
    public static function getExcel($name = 'Beteiligungsbericht.xlsx')
    {
        try {
            $db = App::get('session')->getDB();

            if (!is_numeric($_REQUEST['abgabetyp'])) {
                throw new Exception('Abgabetyp muss numerisch sein');
            }
            if (!is_numeric($_REQUEST['typ'])) {
                throw new Exception('Wahltyp muss numerisch sein');
            }

            $abgabetyp = "";
            $_REQUEST['dynabgabetyp'] = '1';

            if (isset($_REQUEST['abgabetyp'])) {
                if ($_REQUEST['abgabetyp'] != '') {
                    $abgabetyp = " and wahlschein.abgabetyp = {abgabetyp} ";
                }
            }
            $sql = 'select id,name from abgabetyp where aktiv=1';
            $abgabetypen = $db->direct($sql, $_REQUEST);


            $sql = 'select * from wahltyp where id={typ}';
            $t = $db->singleRow($sql, $_REQUEST);
            if ($t === false) {
                App::result('x', $db->last_sql);
                throw new Exception('Wahltypen Fehler');
            }


            $base = 'view_stimmzettel_default';

            if ($_REQUEST['base']) {
                $base = $_REQUEST['base'];
            }



            $sql = 'select id,name from stimmzettel where wahltyp={id} order by id';
            $sql = 'select group_id,name from ' . $base . ' where wahltyp={id}';
            $stimmzettel_liste = $db->direct($sql, $t, 'group_id');

            $stimmzettel_liste_index = [];
            $zeile = 3;
            foreach ($stimmzettel_liste as $key => $pos) {
                $stimmzettel_liste_index[$pos['group_id']] = $zeile;
                $zeile++;
            }
            $filter_feldwerte_offset_count = $zeile;

            $filter_feldwerte = array(array(
                'titel' => 'Gesamt',
                'feld' => '',
                'wert' => ''
            ));

            $ddl_sql = '
            create table if not exists wm_auswertungen_filter(
                feld varchar(64) primary key,
                name varchar(64) not null
            );
            ';
            $db->direct($ddl_sql);

            $db->direct("call addFieldIfNotExists('wm_auswertungen_filter','position','tinyint DEFAULT 0')");
            $db->direct("call addFieldIfNotExists('wm_auswertungen_filter','table_name','varchar(50) DEFAULT \'wahlberechtigte_anlage\'')");


            $sql = 'select name,feld,table_name  from wm_auswertungen_filter order by `position`';
            $auswertungen_filter_liste = $db->direct($sql, array());
            foreach ($auswertungen_filter_liste as $a) {

                $sql = 'select ' . $a['feld'] . ' w from ' . $a['table_name'] . ' group by ' . $a['feld'] . ' ';
                $werte = $db->direct($sql, array());
                foreach ($werte as $w) {
                    $filter_feldwerte[] = array(
                        'titel' => $a['name'],
                        'tabelle' => $a['table_name'],
                        'feld' => $a['feld'],
                        'wert' => $w['w']
                    );
                }
            }

            $sql = 'select * from wm_auswertungen order by pos';
            $auswertungen_liste = $db->direct($sql, array());
            try {
                $sql = 'select * from wm_auswertungen where aktiv=1 order by pos';
                $rs = $db->execute($sql);
                $auswertungen_liste = $rs->toArray('');
                $rs->unload();
            } catch (\Exception $e) {
            }
            $sql = 'select id,name,checktyp from wahlbeteiligung_bericht where aktiv=1 order by id';
            $wahlbeteiligung_bericht = $db->direct($sql);


            $sql = 'select id,name from wahlscheinstatus where ohne_wahlberechtigten=1';
            $ohne_wahlberechtigten = $db->direct($sql);

            $sql = 'select id,name from wahlscheinstatus where sz_count=1';
            $sz_count = $db->direct($sql);

            $sql = 'select wahlbeteiligung_bericht,wahlscheinstatus from wahlbeteiligung_bericht_status where aktiv=1  ';
            $wahlbeteiligung_bericht_status = $db->direct($sql);

            $sql = 'select id,name from wahlbeteiligung_bericht_formel where aktiv=1 order by id';
            $wahlbeteiligung_bericht_formel = $db->direct($sql);

            $sql = 'select wahlbeteiligung_bericht_formel,id,wahlbeteiligung_bericht from wahlbeteiligung_bericht_formel_nenner where aktiv=1 order by id';
            $wahlbeteiligung_bericht_formel_nenner = $db->direct($sql);

            $sql = 'select wahlbeteiligung_bericht_formel,id,wahlbeteiligung_bericht from wahlbeteiligung_bericht_formel_teiler where aktiv=1 order by id';
            $wahlbeteiligung_bericht_formel_teiler = $db->direct($sql);

            $ergebniss = [];



            $temporary_folder = App::get('tempPath')  . '/';

            $objPHPExcel = new Spreadsheet();
            $sheet = $objPHPExcel->getActiveSheet();
            $sheet->setTitle($t['name']);

            $formulaCells = array();

            $filter_feldwerte_offset = 0;
            foreach ($filter_feldwerte as $filter_feldwert) {
                $spalte = 2;

                for ($ix = -1, $_mix = count($auswertungen_liste); $ix < $_mix; $ix++) {
                    if ($ix !== -1) {
                        $pos = $auswertungen_liste[$ix];
                    } else {
                        $pos = array(
                            'name' => 'Allgemein',
                            'feld' => 'aktiv',
                            'feldwerte' => ' \'1\',\'0\' '
                        );
                    }
                    $start_spalte = $spalte;

                    $titel = $pos['name'];
                    $feld = $pos['feld'];
                    $feldwerte = ($pos['feldwerte']);
                    if ($feldwerte == '') {
                        $feldwerte = "'----------------'";
                    }

                    $statusfeld = $t['feld'];

                    $join_stimmzettelfeld = $t['stimmzettelfeld'];
                    if (isset($_REQUEST['join_fld']) && $_REQUEST['join_fld'] != '') {
                        $join_stimmzettelfeld = $_REQUEST['join_fld'];
                    }

                    $wahltyp_id = $t['id'];


                    $stimmzettel_ohne_wb = array();
                    $stimmzettel_ia = array();
                    if ($base === 'view_stimmzettel_default') {
                        foreach ($ohne_wahlberechtigten as $pos) {
                            $stimmzettel_ohne_wb[] = 'stimmzettel.anzahl_' . $pos['id'];
                            $stimmzettel_ia[$pos['id']] =  'anzahl_' . $pos['id'];
                        }
                    }

                    $stimmzettel_sz_count = array();
                    $stimmzettel_ia_sz_count = array();
                    if ($base === 'view_stimmzettel_default') {
                        foreach ($sz_count as $pos) {
                            $stimmzettel_sz_count[] = 'stimmzettel.ds_count';
                            $stimmzettel_ia_sz_count[$pos['id']] =  'ds_count';
                        }
                    }

                    $lfilter = '';
                    if ($filter_feldwert['feld'] <> '') {
                        $lfilter = ' and ' . $filter_feldwert['tabelle'] . '.' . $filter_feldwert['feld'] . '=\'' . $db->escape_string($filter_feldwert['wert']) . '\' ';
                    }


                    $case_tpl = '
                        (SUM(CASE
                        WHEN {statusliste} THEN 1
                        ELSE 0
                        END) + {ias}) AS {fieldname}
                    ';

                    $sql = '
                        select
                            bs.group_id `cellid`,
                            {casefields}
                        from wahlschein join ' . $base . ' bs
                            on bs.id = wahlschein.' . $join_stimmzettelfeld . '
                            and wahlschein.testdaten = 0
                        join wahlberechtigte
                            on wahlschein.wahlberechtigte = wahlberechtigte.id
                        join wahlberechtigte_anlage
                        on 
                            wahlberechtigte_anlage.identnummer = wahlberechtigte.identnummer
                            and wahlschein.' . $join_stimmzettelfeld . '=wahlberechtigte_anlage.stimmzettel
                        ' . $lfilter . '
                        where
                            bs.wahltyp=\'' . $wahltyp_id . '\'
                            and wahlberechtigte_anlage.' . $feld . ' in (' . $feldwerte . ')
                        group by bs.group_id
                    ';

                    if ($feld == 'aktiv') {
                        $sql = '
                            select
                                bs.group_id `cellid`,
                                {casefields}
                            from wahlschein join ' . $base . ' bs
                                on bs.id = wahlschein.' . $join_stimmzettelfeld . '
                                and wahlschein.testdaten = 0
                            join wahlberechtigte
                                on wahlschein.wahlberechtigte = wahlberechtigte.id
                            join wahlberechtigte_anlage
                            on 
                                wahlberechtigte_anlage.identnummer = wahlberechtigte.identnummer
                                and wahlschein.' . $join_stimmzettelfeld . '=wahlberechtigte_anlage.stimmzettel
                            ' . $lfilter . '
                            where
                                bs.wahltyp=\'' . $wahltyp_id . '\'
                            group by bs.group_id
                        ';
                    }

                    $cases = array();
                    $formel_hash = array();
                    foreach ($wahlbeteiligung_bericht as $bericht) {


                        $sheet->SetCellValue(Coordinate::stringFromColumnIndex($spalte) . '2', $bericht['name']);
                        $sheet->getStyle(Coordinate::stringFromColumnIndex($spalte) . '2')->getFont()->setBold(true);
                        $sheet->getStyle(Coordinate::stringFromColumnIndex($spalte) . '2')->getAlignment()->setTextRotation(90);

                        $ias = array();
                        $status = array();
                        foreach ($wahlbeteiligung_bericht_status as $bericht_status) {
                            if ($bericht['id'] === $bericht_status['wahlbeteiligung_bericht']) {

                                if (($bericht_status['wahlscheinstatus'] == '2|0') && ($bericht['checktyp'] == 1)) {

                                    $status[] = ' ( wahlschein.' . $statusfeld . '=\'' . $bericht_status['wahlscheinstatus'] . '\' ' . $abgabetyp . ')';
                                } else {
                                    $status[] = ' ( wahlschein.' . $statusfeld . '=\'' . $bericht_status['wahlscheinstatus'] . '\' )';
                                }

                                if (isset($stimmzettel_ia[$bericht_status['wahlscheinstatus']])) {
                                    $ias[] = $stimmzettel_ia[$bericht_status['wahlscheinstatus']];
                                }

                                if (isset($stimmzettel_ia_sz_count[$bericht_status['wahlscheinstatus']])) {
                                    $ias[] = $stimmzettel_ia_sz_count[$bericht_status['wahlscheinstatus']];
                                }
                            }
                        }
                        $formel_hash[$bericht['id']] = Coordinate::stringFromColumnIndex($spalte);
                        $case = $case_tpl;
                        $case = str_replace('{statusliste}', '' . implode(' or ', $status) . ' ', $case);
                        $case = str_replace('{fieldname}', '`' . Coordinate::stringFromColumnIndex($spalte) . '`', $case);

                        if ((count($ias) > 0)  && ($ix < 0)) {
                            $case = str_replace('{ias}', implode('+', $ias), $case);
                        } else {
                            $case = str_replace('{ias}', '0', $case);
                        }

                        $cases[] = $case;
                        $spalte++;
                        //                }
                    }
                    $sql = str_replace('{casefields}', '' . implode(',', $cases) . ' ', $sql);

                    if (count($stimmzettel_ohne_wb) > 0) {
                        $sql = str_replace('{addfields}', '' . implode(',', $stimmzettel_ohne_wb) . ' ', $sql);
                    } else {
                        $sql = str_replace('{addfields}', '\'none\' addflds ', $sql);
                    }

                    if (count($stimmzettel_sz_count) > 0) {
                        $sql = str_replace('{addfields}', '' . implode(',', $stimmzettel_sz_count) . ' ', $sql);
                    } else {
                        $sql = str_replace('{addfields}', '\'none\' addflds ', $sql);
                    }



                    // ergaenzen der prozent berechnung
                    try {
                        //echo $sql; exit();
                        $data = $db->direct($sql, array(), 'cellid');
                        $last_pos = array();
                        foreach ($data as $key => $pos) {
                            $last_pos = $pos;

                            if (isset($stimmzettel_liste_index[$key])) {
                                $zeile = $stimmzettel_liste_index[$key] + $filter_feldwerte_offset;
                            } else {
                                throw new Exception("Stimmzettel mit dem Index *$key* nicht gefunden", 1);
                            }
                            $sheet->SetCellValue('A' . $zeile, $stimmzettel_liste[$key]['name']);
                            if (!isset($ergebniss[$key])) {
                                $ergebniss[$key] = array();
                            }

                            foreach ($pos as $feld => $wert) {
                                if (($feld != 'cellid')) {
                                    $ergebniss[$key][$feld] = $wert;
                                    $sheet->SetCellValue($feld . $zeile, is_null($wert) ? 0 : $wert);
                                }
                            }
                            // $sheet->SetCellValue('B' . $zeile, $filter_feldwert['wert']);
                            $zeile++;
                        }

                        $zeile = count($stimmzettel_liste) + 3 + $filter_feldwerte_offset;
                        //echo $zeile;

                        //print_r($last_pos); exit();
                        foreach ($last_pos as $feld => $wert) {

                            if ($feld != 'cellid') {
                                $sheet->SetCellValue($feld . $zeile, "=SUM(" . strtoupper($feld) . (3 + $filter_feldwerte_offset) . ':' . strtoupper($feld) . '' . ($zeile - 1) . ')');
                                $sheet->getStyle($feld . $zeile)->getFont()->setBold(true);
                                //echo "=SUM(".strtoupper($feld).(3+$filter_feldwerte_offset).':'.strtoupper($feld).''.($zeile-1).')'.PHP_EOL;
                                $formulaCells[$feld . $zeile] = 1;
                            }
                        }

                        $formeln = array();
                        foreach ($wahlbeteiligung_bericht_formel as $bericht) {

                            $sheet->SetCellValue(Coordinate::stringFromColumnIndex($spalte) . '2', $bericht['name']);
                            $sheet->getStyle(Coordinate::stringFromColumnIndex($spalte) . '2')->getFont()->setBold(true);
                            $sheet->getStyle(Coordinate::stringFromColumnIndex($spalte) . '2')->getAlignment()->setTextRotation(90);

                            for ($zi = 3; $zi <= $zeile; $zi++) {
                                $nenner = array();
                                foreach ($wahlbeteiligung_bericht_formel_nenner as $bericht_nenner) {
                                    if ($bericht['id'] === $bericht_nenner['wahlbeteiligung_bericht_formel']) {
                                        $nenner[] = $formel_hash[$bericht_nenner['wahlbeteiligung_bericht']] . $zi;
                                    }
                                }
                                $teiler = array();
                                foreach ($wahlbeteiligung_bericht_formel_teiler as $bericht_teiler) {
                                    if ($bericht['id'] === $bericht_teiler['wahlbeteiligung_bericht_formel']) {
                                        $teiler[] = $formel_hash[$bericht_teiler['wahlbeteiligung_bericht']] . $zi;
                                    }
                                }

                                $formel = '= if( or( (' . strtoupper(implode('+', $teiler)) . ')="",(' . strtoupper(implode('+', $teiler)) . ')=0 ), "", (' . strtoupper(implode('+', $nenner)) . ')/(' . strtoupper(implode('+', $teiler)) . ') ) '; //.PHPExcel_Cell::stringFromColumnIndex($spalte);
                                $sheet->SetCellValue(Coordinate::stringFromColumnIndex($spalte) . '' . $zi, $formel);
                                $formulaCells[Coordinate::stringFromColumnIndex($spalte) . '' . $zi] = 1;

                                $sheet->getStyle(Coordinate::stringFromColumnIndex($spalte) . $zi)->getFont()->setBold(($zi == $zeile));
                                $sheet->getStyle(Coordinate::stringFromColumnIndex($spalte) . $zi)->getNumberFormat()->setFormatCode('0.000%');
                            }
                            $spalte++;
                        }
                    } catch (Exception $e) {
                        echo $e->getMessage();

                        echo $sql;
                        exit();
                    }
                    //$auswertungen_liste[$ix] = $data;

                    $sheet->SetCellValue(Coordinate::stringFromColumnIndex($start_spalte) . '1', $titel);
                    $sheet->getStyle(Coordinate::stringFromColumnIndex($start_spalte) . '1')->getFont()->setBold(true);
                } // for auswertungen_liste
                $filter_feldwerte_offset += $filter_feldwerte_offset_count;
            }

            $sheet->SetCellValue('A2', 'Stimmzettel');
            $sheet->getStyle('A2')->getFont()->setBold(true);
            $writer = IOFactory::createWriter($objPHPExcel, 'Xlsx');
            // $writer->setPreCalculateFormulas(false);
            $writer->save(App::get('tempPath')  . '/' . $name);
        } catch (Exception $error) {
            echo $error->getMessage();
        }
        return $name;
    }

    public static function getData(): array
    {
        $db = App::get('session')->getDB();

        $abgabetyp = ((isset($_REQUEST['abgabetyp']) && $_REQUEST['abgabetyp'] != '') ? (" and ws.abgabetyp = '" . $_REQUEST['abgabetyp'] . "|0' ") : "");
        $testdaten = (isset($_REQUEST['testdaten']) && $_REQUEST['testdaten'] != '') ? intval($_REQUEST['testdaten']) : 0;



        $t = $db->singleRow('select 
        id,
        name,
        if(ifnull(feld,"")="","stimmzettel",ifnull(feld,"")) stimmzettelfeld
        from wahltyp where id={typ}', $_REQUEST);
        if ($t === false) {
            throw new Exception('Wahltypen Fehler');
        }


        $sql = 'select id,name from wahlscheinstatus where ohne_wahlberechtigten=1';
        $ohne_wahlberechtigten = $db->direct($sql);

        $sql = 'select id,name from wahlscheinstatus where sz_count=1';
        $sz_count = $db->direct($sql);

        $base = isset($_REQUEST['base']) ? $_REQUEST['base'] : 'view_stimmzettel_default';



        $sql = 'select id,name,checktyp from wahlbeteiligung_bericht where aktiv=1 order by id';
        $wahlbeteiligung_bericht = $db->direct($sql);

        if (isset($_REQUEST['abgabetyp'])) {
            if ($_REQUEST['abgabetyp'] != '') {
                //$abgabetyp = " and ws.abgabetyp = '".$_REQUEST['abgabetyp']."|0' ";
                $sql = 'select id,name,checktyp from wahlbeteiligung_bericht where aktiv=1 and JSON_VALUE(abgabetyp,"$.abgabetyp' . $_REQUEST['abgabetyp'] . '")=true order by id';
                $wahlbeteiligung_bericht = $db->direct($sql);
            }
        }

        $sql = 'select wahlbeteiligung_bericht ,wahlscheinstatus from wahlbeteiligung_bericht_status where aktiv=1 ';
        $wahlbeteiligung_bericht_status = $db->direct($sql);

        $sql = 'select id,name from wahlbeteiligung_bericht_formel where aktiv=1 order by id';
        $wahlbeteiligung_bericht_formel = $db->direct($sql);

        $sql = 'select wahlbeteiligung_bericht_formel,id,wahlbeteiligung_bericht from wahlbeteiligung_bericht_formel_nenner where aktiv=1 order by id';
        $wahlbeteiligung_bericht_formel_nenner = $db->direct($sql);



        $sql = 'select wahlbeteiligung_bericht_formel,id,wahlbeteiligung_bericht from wahlbeteiligung_bericht_formel_teiler where aktiv=1 order by id';
        $wahlbeteiligung_bericht_formel_teiler = $db->direct($sql);


        if (isset($_REQUEST['abgabetyp'])) {
            if ($_REQUEST['abgabetyp'] != '') {
                //$abgabetyp = " and ws.abgabetyp = '".$_REQUEST['abgabetyp']."|0' ";
                $insql = 'select id  from wahlbeteiligung_bericht where aktiv=1 and JSON_VALUE(abgabetyp,"$.abgabetyp' . $_REQUEST['abgabetyp'] . '")=true  ';

                $sql = 'select wahlbeteiligung_bericht_formel,id,wahlbeteiligung_bericht from wahlbeteiligung_bericht_formel_nenner where aktiv=1 and wahlbeteiligung_bericht in (' . $insql . ') order by id';
                $wahlbeteiligung_bericht_formel_nenner = $db->direct($sql);

                $sql = 'select wahlbeteiligung_bericht_formel,id,wahlbeteiligung_bericht from wahlbeteiligung_bericht_formel_teiler where aktiv=1 and wahlbeteiligung_bericht in (' . $insql . ') order by id';
                $wahlbeteiligung_bericht_formel_teiler = $db->direct($sql);
            }
        }



        $wahltyp_id = $t['id'];




        $case_tpl = " SUM(CASE WHEN {statusliste} THEN 1 ELSE 0 END) AS `{fieldname}` ";
        $sql_tpl = "
                select
                bs.group_id id,
                bs.id stimmzettel_id,
                bs.name stimmzettel_name, ws.stimmzettel stimmzettel, {casefields}
                from
                wahlschein ws join " . $base . " bs  on bs.id = ws.stimmzettel and ws.testdaten=$testdaten

                where
            bs.wahltyp='$wahltyp_id'  group by bs.group_id ";



        $cases = array();
        $formel_hash = array();
        foreach ($wahlbeteiligung_bericht as $bericht) {
            $status = array();
            foreach ($wahlbeteiligung_bericht_status as $bericht_status) {
                if ($bericht['id'] === $bericht_status['wahlbeteiligung_bericht']) {
                    $typ = ' ';
                    if ($bericht['checktyp'] == '1') {
                        $typ = ' ' . $abgabetyp;
                    }
                    $status[] = ' ( ws.wahlscheinstatus'  . '=\'' . $bericht_status['wahlscheinstatus'] . '\' ' . $typ . ')';
                }
            }

            $formel_hash[$bericht['id']] = 'b' . $bericht['id'];
            $case = $case_tpl;
            if (count($status) == 0) {
                throw new Exception('Keine Status gefunden für Bericht ' . $bericht['name'] . ' (' . $bericht['id'] . ')');
            }
            $case = str_replace('{statusliste}', '' . implode(' or ', $status) . ' ', $case);
            $case = str_replace('{fieldname}', 'b' . $bericht['id'], $case);
            $cases[] = $case;
        }
        $sql = str_replace('{casefields}', '' . implode(',', $cases) . ' ', $sql_tpl);



        // # BEGIN ############### OHNE WAHLSCHEIN #########################
        $case_tpl = " {anzahl} AS `{fieldname}` ";
        $sql_sw = "select 
        
            stimmzettel.id stimmzettel_id,
            stimmzettel.name stimmzettel_name,
            
            {casefields}
            from view_stimmzettel_default stimmzettel
            where stimmzettel.wahltyp=$wahltyp_id  ";


        if ($base !== 'view_stimmzettel_default') {
            $sql_sw = "select
            
                stimmzettel.id stimmzettel_id,
                stimmzettel.name stimmzettel_name,
                    {casefields}
                    from stimmzettel
                    where false  ";
        }

        $cases = array();
        foreach ($wahlbeteiligung_bericht as $bericht) {
            $status = array();

            $found = '';
            foreach ($wahlbeteiligung_bericht_status as $bericht_status) {
                if ($bericht['id'] === $bericht_status['wahlbeteiligung_bericht']) {
                    foreach ($ohne_wahlberechtigten as $pos) {
                        if ($pos['id'] == $bericht_status['wahlscheinstatus']) {
                            if ($found != '') {
                                $found .= ' + ';
                            }
                            $found .= 'anzahl_' . $pos['id'];
                        }
                    }

                    //$status[]='ws.'.$statusfeld.'=\''.$bericht_status['wahlscheinstatus'].'\'';
                }
            }

            if ($found == '') {
                $found = '0';
            } else {
                $found = ' (' . $found . ') ';
            }
            $case = $case_tpl;
            $case = str_replace('{anzahl}', $found, $case);
            $case = str_replace('{fieldname}', 'b' . $bericht['id'], $case);
            $cases[] = $case;
        }
        $sql_sw = str_replace('{casefields}', '' . implode(',', $cases) . ' ', $sql_sw);
        // # END ############### OHNE WAHLSCHEIN #########################




        // # BEGIN ############### WAHLUMSCHLAUG ZÄHLUNG #########################
        $case_tpl = " {anzahl} AS `{fieldname}` ";
        $sql_sw_umschlag = "select 
                stimmzettel.id stimmzettel_id,
                stimmzettel.name stimmzettel_name,
                {casefields}
                from view_stimmzettel_default stimmzettel
                where stimmzettel.wahltyp=wahltyp_id  ";


        if ($base !== 'view_stimmzettel_default') {
            $sql_sw_umschlag = "select
            
                stimmzettel.id stimmzettel_id,
                stimmzettel.name stimmzettel_name,
                    
                 {casefields}
                    from stimmzettel
                    where false  ";
        }

        $cases = array();
        foreach ($wahlbeteiligung_bericht as $bericht) {
            $status = array();

            $found = '';
            foreach ($wahlbeteiligung_bericht_status as $bericht_status) {
                if ($bericht['id'] === $bericht_status['wahlbeteiligung_bericht']) {
                    foreach ($sz_count as $pos) {
                        if ($pos['id'] == $bericht_status['wahlscheinstatus']) {
                            if ($found != '') {
                                $found .= ' + ';
                            }
                            $found .= 'ds_count';
                        }
                    }
                }
            }

            if ($found == '') {
                $found = '0';
            } else {
                $found = ' (' . $found . ') ';
            }
            $case = $case_tpl;
            $case = str_replace('{anzahl}', $found, $case);
            $case = str_replace('{fieldname}', 'b' . $bericht['id'], $case);
            $cases[] = $case;
        }
        $sql_sw_umschlag = str_replace('{casefields}', '' . implode(',', $cases) . ' ', $sql_sw_umschlag);
        // # END ############### WAHLUMSCHLAUG ZÄHLUNG #########################


        //$formel_hash[$bericht['id']]
        $summing = array();
        foreach ($formel_hash as $key => $column) {
            $summing[] = 'sum(' . $column . ') ' . $column . '';
        }



        $sql = 'select id, stimmzettel_name,
            stimmzettel,stimmzettel_id, ' . implode(',', $summing) . ' from
            ( select * from  (' . $sql . ') a  union (' . $sql_sw . ') union (' . $sql_sw_umschlag . ')   )  c
            group by  id 
            order by stimmzettel_id,id';

        // ergaenzen der prozent berechnung
        $formeln = array();
        foreach ($wahlbeteiligung_bericht_formel as $bericht) {
            $nenner = array();
            foreach ($wahlbeteiligung_bericht_formel_nenner as $bericht_nenner) {
                if ($bericht['id'] === $bericht_nenner['wahlbeteiligung_bericht_formel']) {
                    $nenner[] = $formel_hash[$bericht_nenner['wahlbeteiligung_bericht']];
                }
            }
            $teiler = array();
            foreach ($wahlbeteiligung_bericht_formel_teiler as $bericht_teiler) {
                if ($bericht['id'] === $bericht_teiler['wahlbeteiligung_bericht_formel']) {
                    $teiler[] = $formel_hash[$bericht_teiler['wahlbeteiligung_bericht']];
                }
            }
            //$formeln[] = ' \'('.implode('+',$nenner).')*100/('.implode('+',$teiler).')\' '.'f'.$bericht['id'];
            $formeln[] = array(
                'feld' => 'f' . $bericht['id'],
                'nenner' => $nenner,
                'teiler' => $teiler
            );
        }

        //$sql = 'select abc.*,'.implode($formeln,',').' from ('.$sql.') abc';
        //echo $sql;
        App::result('sql', $sql);
        $data = $db->direct($sql);
        error_reporting(E_ERROR);

        $summen = array();
        $summen['name'] = 'Gesamt';
        for ($i = 0, $m = count($data); $i < $m; $i++) {
            foreach ($wahlbeteiligung_bericht as $bericht) {
                if (!isset($summen['b' . $bericht['id']])) $summen['b' . $bericht['id']] = 0;
                $summen['b' . $bericht['id']] += $data[$i]['b' . $bericht['id']];
            }
            foreach ($formeln as $f) {
                $n = 0;
                $t = 0;
                foreach ($f['nenner'] as $_n) {
                    $n += $data[$i][$_n];
                }
                foreach ($f['teiler'] as $_t) {
                    $t += $data[$i][$_t];
                }
                if ($t !== 0) {
                    $data[$i][$f['feld']] = 100 * $n / $t;
                }
            }
        }

        foreach ($formeln as $f) {
            $n = 0;
            $t = 0;
            foreach ($f['nenner'] as $_n) {
                $n += $summen[$_n];
            }
            foreach ($f['teiler'] as $_t) {
                $t += $summen[$_t];
            }
            if ($t !== 0) {
                $summen[$f['feld']] = 100 * $n / $t;
            }
        }

        $data[] = $summen;

        return $data;
    }

    public static function register()
    {

        BasicRoute::add(
            '/papervote/involvement/reportingHeaders',
            function () {
                $db = App::get('session')->getDB();
                try {


                    //App::result('data', Reporting::getData());

                    App::result('data', $db->direct('
                    select 
                        -1 id,
                        concat("use_name") column_name,
                        "Use Name" as column_title
                    union 
                    select 
                        id,
                        concat("wb_",wahlbeteiligung_bericht.id) column_name,
                        wahlbeteiligung_bericht.name as column_title
                    from wahlbeteiligung_bericht where aktiv=1 
                    order by id
                    
                    '));

                    App::result('success', true);
                } catch (Exception $e) {

                    App::result('x', $db->last_sql);
                    App::result('msg', $e->getMessage());
                }
                App::contenttype('application/json');
            },
            [
                'post',
                'get'
            ],
            true
        );

        BasicRoute::add(
            '/papervote/involvement/reporting',
            function () {
                $db = App::get('session')->getDB();
                try {


                    //App::result('data', Reporting::getData());

                    App::result('data', $db->direct('select * from view_wahlbeteiligung_base_pivot'));

                    App::result('success', true);
                } catch (Exception $e) {

                    App::result('x', $db->last_sql);
                    App::result('msg', $e->getMessage());
                }
                App::contenttype('application/json');
            },
            [
                'post',
                'get'
            ],
            true,
            [
                'errorOnUnexpected' => true,
                'errorOnInvalid' => true,
                'fields' =>  [
                    'typ' => [
                        'required' => true,
                        'type' => 'int',
                        'min' => 0,
                        'max' => 10000000
                    ],
                    '_dc' => [
                        'required' => false,
                        'type' => 'string',
                        'minlength' => 0,
                        'maxlength' => 10000
                    ],
                    'abgabetyp' => [
                        'required' => false,
                        'type' => 'string',
                        'minlength' => 0,
                        'maxlength' => 100
                    ],
                    'testdaten' => [
                        'required' => false,
                        'type' => 'int',
                        'min' => 0,
                        'max' => 1
                    ],
                    'base' => [
                        'required' => false,
                        'type' => 'string',
                        'minlength' => 0,
                        'maxlength' => 50
                    ],
                    'join_fld' => [
                        'required' => false,
                        'type' => 'string',
                        'minlength' => 0,
                        'maxlength' => 50
                    ],
                    'page' => [
                        'required' => false,
                        'type' => 'int',
                        'minlength' => 0,
                        'maxlength' => 1000000
                    ],
                    'start' => [
                        'required' => false,
                        'type' => 'int',
                        'minlength' => 0,
                        'maxlength' => 1000000
                    ],
                    'limit' => [
                        'required' => false,
                        'type' => 'int',
                        'minlength' => 0,
                        'maxlength' => 1000000
                    ]
                ]
            ]
        );

        BasicRoute::add('/papervote/involvement/reporting/export', function () {
            $db = App::get('session')->getDB();
            try {
                $fname = Reporting::getExcel();
                App::result('file', $fname);
                App::result('success', true);
            } catch (Exception $e) {
                App::result('msg', $e->getMessage());
            }
            App::contenttype('application/json');
        }, array('get', 'post'), true);
    }
}
