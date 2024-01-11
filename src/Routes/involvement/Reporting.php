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
    public static function getExcel($name='export.xlsx')
    {
        try {
            $db = App::get('session')->getDB();

            $abgabetyp = "";
            $_REQUEST['dynabgabetyp'] = '1';

            if (isset($_REQUEST['abgabetyp'])) {
                if ($_REQUEST['abgabetyp'] != '') {
                    $abgabetyp = " and wahlschein.abgabetyp = '" . $_REQUEST['abgabetyp'] . "|0' ";
                }
            }
            $sql = 'select ridx,name from abgabetyp where aktiv=1';
            $abgabetypen = $db->direct($sql);


            $sql = 'select * from wahltyp where id=\'' . $_REQUEST['typ'] . '\' ';
            $t = $db->direct($sql);
            if (count($t) === 1) {
                $t = $t[0];
            } else {
                die('Wahltypen Fehler');
            }


            $base = 'stimmzettel_default';

            if ($_REQUEST['base']) {
                $base = $_REQUEST['base'];
            }

            $sql = 'select ridx from wahlscheinstatus';
            $wahlscheinstatus = $db->direct($sql);

            $sql = 'select ridx,name from stimmzettel where wahltyp=\'' . $t['ridx'] . '\' order by id';
            $sql = 'select group_ridx,name from ' . $base . ' where wahltyp=\'' . $t['ridx'] . '\'';
            $stimmzettel_liste = $db->direct($sql, array(), 'group_ridx');

            $stimmzettel_liste_index = array();
            $zeile = 3;
            foreach ($stimmzettel_liste as $key => $pos) {
                $stimmzettel_liste_index[$pos['group_ridx']] = $zeile;
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
            $sql = 'select ridx,id,name,checktyp from wahlbeteiligung_bericht where aktiv=1 order by id';
            $wahlbeteiligung_bericht = $db->direct($sql);


            $sql = 'select id,ridx,name from wahlscheinstatus where ohne_wahlberechtigten=1';
            $ohne_wahlberechtigten = $db->direct($sql);

            $sql = 'select id,ridx,name from wahlscheinstatus where sz_count=1';
            $sz_count = $db->direct($sql);

            $sql = 'select ridx,wahlbeteiligung_bericht,id,wahlscheinstatus from wahlbeteiligung_bericht_status where aktiv=1 order by id';
            $wahlbeteiligung_bericht_status = $db->direct($sql);

            $sql = 'select ridx,id,name from wahlbeteiligung_bericht_formel where aktiv=1 order by id';
            $wahlbeteiligung_bericht_formel = $db->direct($sql);

            $sql = 'select ridx,wahlbeteiligung_bericht_formel,id,wahlbeteiligung_bericht from wahlbeteiligung_bericht_formel_nenner where aktiv=1 order by id';
            $wahlbeteiligung_bericht_formel_nenner = $db->direct($sql);

            $sql = 'select ridx,wahlbeteiligung_bericht_formel,id,wahlbeteiligung_bericht from wahlbeteiligung_bericht_formel_teiler where aktiv=1 order by id';
            $wahlbeteiligung_bericht_formel_teiler = $db->direct($sql);

            $ergebniss = array();



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
                    $stimmzettelfeld = $t['stimmzettelfeld'];
                    $join_stimmzettelfeld = $t['stimmzettelfeld'];
                    if (isset($_REQUEST['join_fld']) && $_REQUEST['join_fld'] != '') {
                        $join_stimmzettelfeld = $_REQUEST['join_fld'];
                    }

                    $wahltypridx = $t['ridx'];


                    $stimmzettel_ohne_wb = array();
                    $stimmzettel_ia = array();
                    if ($base === 'stimmzettel_default') {
                        foreach ($ohne_wahlberechtigten as $pos) {
                            $stimmzettel_ohne_wb[] = 'stimmzettel.anzahl_' . $pos['id'];
                            $stimmzettel_ia[$pos['ridx']] =  'anzahl_' . $pos['id'];
                        }
                    }

                    $stimmzettel_sz_count = array();
                    $stimmzettel_ia_sz_count = array();
                    if ($base === 'stimmzettel_default') {
                        foreach ($sz_count as $pos) {
                            $stimmzettel_sz_count[] = 'stimmzettel.ds_count';
                            $stimmzettel_ia_sz_count[$pos['ridx']] =  'ds_count';
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
                    bs.group_ridx `cellid`,
                    {casefields}
                from wahlschein join ' . $base . ' bs
                    on bs.ridx = wahlschein.' . $join_stimmzettelfeld . '
and wahlschein.testdaten = 0
                join wahlberechtigte
                    on wahlschein.wahlberechtigte = wahlberechtigte.ridx
                join wahlberechtigte_anlage
                on wahlberechtigte_anlage.identnummer = wahlberechtigte.identnummer
and wahlschein.' . $join_stimmzettelfeld . '=wahlberechtigte_anlage.stimmzettel
                ' . $lfilter . '
                where
                    bs.wahltyp=\'' . $wahltypridx . '\'
                    and wahlberechtigte_anlage.' . $feld . ' in (' . $feldwerte . ')
                group by bs.group_ridx
            ';
                    //echo  $sql."\n\n"; 

                    if ($feld == 'aktiv') {
                        $sql = '
                select
                    bs.group_ridx `cellid`,
                    {casefields}
                from wahlschein join ' . $base . ' bs
                    on bs.ridx = wahlschein.' . $join_stimmzettelfeld . '
and wahlschein.testdaten = 0
                join wahlberechtigte
                    on wahlschein.wahlberechtigte = wahlberechtigte.ridx
                join wahlberechtigte_anlage
                on 
wahlberechtigte_anlage.identnummer = wahlberechtigte.identnummer
and wahlschein.' . $join_stimmzettelfeld . '=wahlberechtigte_anlage.stimmzettel
                ' . $lfilter . '
                where
                    bs.wahltyp=\'' . $wahltypridx . '\'
                group by bs.group_ridx
            ';
                    }

                    $cases = array();
                    $formel_hash = array();
                    foreach ($wahlbeteiligung_bericht as $bericht) {

                        //                foreach($abgabetypen as $atyp){
                        //                    $abgabetyp = " and wahlschein.abgabetyp = '".$atyp['ridx']."' ";


                        $sheet->getCell([$spalte, 2])->setValue($bericht['name']);
                        /*
                    $sheet->getCell([$spalte, 2])->getFont()->setBold(true);
                    $sheet->getCell([$spalte, 2])->getAlignment()->setTextRotation(90);
                    
                    $sheet->SetCellValue(PHPExcel_Cell::stringFromColumnIndex($spalte).'2',$bericht['name']);
                    $sheet->getStyle(PHPExcel_Cell::stringFromColumnIndex($spalte).'2')->getFont()->setBold(true);
                    $sheet->getStyle(PHPExcel_Cell::stringFromColumnIndex($spalte) . '2')->getAlignment()->setTextRotation(90);
*/

                        $ias = array();
                        $status = array();
                        foreach ($wahlbeteiligung_bericht_status as $bericht_status) {
                            if ($bericht['ridx'] === $bericht_status['wahlbeteiligung_bericht']) {

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
                            $sheet->SetCellValue('B' . $zeile, $filter_feldwert['wert']);
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
                                    if ($bericht['ridx'] === $bericht_nenner['wahlbeteiligung_bericht_formel']) {
                                        $nenner[] = $formel_hash[$bericht_nenner['wahlbeteiligung_bericht']] . $zi;
                                    }
                                }
                                $teiler = array();
                                foreach ($wahlbeteiligung_bericht_formel_teiler as $bericht_teiler) {
                                    if ($bericht['ridx'] === $bericht_teiler['wahlbeteiligung_bericht_formel']) {
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



        $t = $db->singleRow('select * from wahltyp where ridx={typ}', $_REQUEST);
        if ($t === false) throw new Exception('Wahltypen Fehler');

        $sql = 'select ridx from wahlscheinstatus';
        $wahlscheinstatus = $db->direct($sql);

        $sql = 'select id,ridx,name from wahlscheinstatus where ohne_wahlberechtigten=1';
        $ohne_wahlberechtigten = $db->direct($sql);

        $sql = 'select id,ridx,name from wahlscheinstatus where sz_count=1';
        $sz_count = $db->direct($sql);

        $base = isset($_REQUEST['base']) ? $_REQUEST['base'] : 'stimmzettel_default';


        $sql = 'select ridx,name from ' . $base . ' where wahltyp=\'' . $t['ridx'] . '\'';
        $stimmzettel_liste = $db->direct($sql);

        $sql = 'select ridx,id,name,checktyp from wahlbeteiligung_bericht where aktiv=1 order by id';
        $wahlbeteiligung_bericht = $db->direct($sql);

        if (isset($_REQUEST['abgabetyp'])) {
            if ($_REQUEST['abgabetyp'] != '') {
                //$abgabetyp = " and ws.abgabetyp = '".$_REQUEST['abgabetyp']."|0' ";
                $sql = 'select ridx,id,name,checktyp from wahlbeteiligung_bericht where aktiv=1 and JSON_VALUE(abgabetyp,"$.abgabetyp' . $_REQUEST['abgabetyp'] . '")=true order by id';
                $wahlbeteiligung_bericht = $db->direct($sql);
            }
        }

        $sql = 'select ridx,wahlbeteiligung_bericht,id,wahlscheinstatus from wahlbeteiligung_bericht_status where aktiv=1 order by id';
        $wahlbeteiligung_bericht_status = $db->direct($sql);

        $sql = 'select ridx,id,name from wahlbeteiligung_bericht_formel where aktiv=1 order by id';
        $wahlbeteiligung_bericht_formel = $db->direct($sql);

        $sql = 'select ridx,wahlbeteiligung_bericht_formel,id,wahlbeteiligung_bericht from wahlbeteiligung_bericht_formel_nenner where aktiv=1 order by id';
        $wahlbeteiligung_bericht_formel_nenner = $db->direct($sql);



        $sql = 'select ridx,wahlbeteiligung_bericht_formel,id,wahlbeteiligung_bericht from wahlbeteiligung_bericht_formel_teiler where aktiv=1 order by id';
        $wahlbeteiligung_bericht_formel_teiler = $db->direct($sql);


        if (isset($_REQUEST['abgabetyp'])) {
            if ($_REQUEST['abgabetyp'] != '') {
                //$abgabetyp = " and ws.abgabetyp = '".$_REQUEST['abgabetyp']."|0' ";
                $insql = 'select ridx  from wahlbeteiligung_bericht where aktiv=1 and JSON_VALUE(abgabetyp,"$.abgabetyp' . $_REQUEST['abgabetyp'] . '")=true  ';

                $sql = 'select ridx,wahlbeteiligung_bericht_formel,id,wahlbeteiligung_bericht from wahlbeteiligung_bericht_formel_nenner where aktiv=1 and wahlbeteiligung_bericht in (' . $insql . ') order by id';
                $wahlbeteiligung_bericht_formel_nenner = $db->direct($sql);

                $sql = 'select ridx,wahlbeteiligung_bericht_formel,id,wahlbeteiligung_bericht from wahlbeteiligung_bericht_formel_teiler where aktiv=1 and wahlbeteiligung_bericht in (' . $insql . ') order by id';
                $wahlbeteiligung_bericht_formel_teiler = $db->direct($sql);
            }
        }



        $datahash = array();
        $statusfeld = $t['feld'];
        $stimmzettelfeld = $t['stimmzettelfeld'];
        $join_stimmzettelfeld = $t['stimmzettelfeld'];
        $wahltypridx = $t['ridx'];

        if (isset($_REQUEST['join_fld']) && $_REQUEST['join_fld'] != '') {
            $join_stimmzettelfeld = $_REQUEST['join_fld'];
        }


        $case_tpl = " SUM(CASE WHEN {statusliste} THEN 1 ELSE 0 END) AS `{fieldname}` ";
        $sql_tpl = "
                select
                bs.group_ridx id,
                bs.id stimmzettel_id,
                bs.name stimmzettel_name, ws.$stimmzettelfeld stimmzettel, {casefields}
                from
                wahlschein ws join " . $base . " bs  on bs.ridx = ws.$join_stimmzettelfeld and ws.testdaten=$testdaten

                where
            bs.wahltyp='$wahltypridx'  group by bs.group_ridx ";



        $cases = array();
        $formel_hash = array();
        foreach ($wahlbeteiligung_bericht as $bericht) {
            $status = array();
            foreach ($wahlbeteiligung_bericht_status as $bericht_status) {
                if ($bericht['ridx'] === $bericht_status['wahlbeteiligung_bericht']) {
                    $typ = ' ';
                    if ($bericht['checktyp'] == '1') {
                        $typ = ' ' . $abgabetyp;
                    }
                    $status[] = ' ( ws.' . $statusfeld . '=\'' . $bericht_status['wahlscheinstatus'] . '\' ' . $typ . ')';
                }
            }

            $formel_hash[$bericht['id']] = 'b' . $bericht['id'];
            $case = $case_tpl;
            $case = str_replace('{statusliste}', '' . implode(' or ', $status) . ' ', $case);
            $case = str_replace('{fieldname}', 'b' . $bericht['id'], $case);
            $cases[] = $case;
        }
        $sql = str_replace('{casefields}', '' . implode(',', $cases) . ' ', $sql_tpl);



        // # BEGIN ############### OHNE WAHLSCHEIN #########################
        $case_tpl = " {anzahl} AS `{fieldname}` ";
        $sql_sw = "select ridx,
            stimmzettel.id stimmzettel_id,
            stimmzettel.name stimmzettel_name,
            ridx stimmzettel, {casefields}
            from stimmzettel_default stimmzettel
            where stimmzettel.wahltyp='$wahltypridx'  ";


        if ($base !== 'stimmzettel_default') {
            $sql_sw = "select ridx,
                stimmzettel.id stimmzettel_id,
                stimmzettel.name stimmzettel_name,
                    ridx stimmzettel, {casefields}
                    from stimmzettel
                    where false  ";
        }

        $cases = array();
        foreach ($wahlbeteiligung_bericht as $bericht) {
            $status = array();

            $found = '';
            foreach ($wahlbeteiligung_bericht_status as $bericht_status) {
                if ($bericht['ridx'] === $bericht_status['wahlbeteiligung_bericht']) {
                    foreach ($ohne_wahlberechtigten as $pos) {
                        if ($pos['ridx'] == $bericht_status['wahlscheinstatus']) {
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
        $sql_sw_umschlag = "select ridx,
                stimmzettel.id stimmzettel_id,
                stimmzettel.name stimmzettel_name,
                ridx stimmzettel, {casefields}
                from stimmzettel_default stimmzettel
                where stimmzettel.wahltyp='$wahltypridx'  ";


        if ($base !== 'stimmzettel_default') {
            $sql_sw_umschlag = "select ridx,
                stimmzettel.id stimmzettel_id,
                stimmzettel.name stimmzettel_name,
                    ridx stimmzettel, {casefields}
                    from stimmzettel
                    where false  ";
        }

        $cases = array();
        foreach ($wahlbeteiligung_bericht as $bericht) {
            $status = array();

            $found = '';
            foreach ($wahlbeteiligung_bericht_status as $bericht_status) {
                if ($bericht['ridx'] === $bericht_status['wahlbeteiligung_bericht']) {
                    foreach ($sz_count as $pos) {
                        if ($pos['ridx'] == $bericht_status['wahlscheinstatus']) {
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
                if ($bericht['ridx'] === $bericht_nenner['wahlbeteiligung_bericht_formel']) {
                    $nenner[] = $formel_hash[$bericht_nenner['wahlbeteiligung_bericht']];
                }
            }
            $teiler = array();
            foreach ($wahlbeteiligung_bericht_formel_teiler as $bericht_teiler) {
                if ($bericht['ridx'] === $bericht_teiler['wahlbeteiligung_bericht_formel']) {
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
        BasicRoute::add('/papervote/involvement/reporting', function () {
            $db = App::get('session')->getDB();
            try {
                App::result('data', Reporting::getData());

                App::result('success', true);
            } catch (Exception $e) {
                App::result('msg', $e->getMessage());
            }
            App::contenttype('application/json');
        }, array('get', 'post'), true);

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
