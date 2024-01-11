<?php

namespace Tualo\Office\PaperVote\Routes\involvement;

use Exception;
use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\Basic\Route as BasicRoute;
use Tualo\Office\Basic\IRoute;
use Tualo\Office\DS\DSExporterHelper;

use Ramsey\Uuid\Uuid;

class Reporting implements IRoute
{
    public static function getData(): array
    {
        $db = App::get('session')->getDB();

        $abgabetyp = ((isset($_REQUEST['abgabetyp'])&&$_REQUEST['abgabetyp']!='') ? (" and ws.abgabetyp = '" . $_REQUEST['abgabetyp'] . "|0' ") : "");
        $testdaten = (isset($_REQUEST['testdaten'])&&$_REQUEST['testdaten']!='') ? intval($_REQUEST['testdaten']) : 0;



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
                App::result('data',Reporting::getData());

                App::result('success', true);
            } catch (Exception $e) {
                App::result('msg', $e->getMessage());
            }
            App::contenttype('application/json');
        }, array('get', 'post'), true);

        BasicRoute::add('/papervote/involvement/reporting/export', function () {
            $db = App::get('session')->getDB();
            try {
                App::result('data',);
                $data = Reporting::getData();
                
                $hcolumns = [];
                foreach($data[0] as $key=>$row){
                    $hcolumns[$key] = [
                        'label'=> $key
                    ];
                }
                $temporary_folder = App::get("tempPath") . '/';

                DSExporterHelper::exportDataToXSLX($db,'report',$hcolumns,$data,$temporary_folder,$fname,$hcolumns);
                App::result('file', $fname);
                App::result('success', true);
            } catch (Exception $e) {
                App::result('msg', $e->getMessage());
            }
            App::contenttype('application/json');
        }, array('get', 'post'), true);

    }
}
