<?php

namespace Tualo\Office\PaperVote\Routes\counting;

use Exception;
use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\Basic\Route as BasicRoute;
use Tualo\Office\Basic\IRoute;
use Tualo\Office\TualoPGP\TualoApplicationPGP;

use Ramsey\Uuid\Uuid;

class Save extends \Tualo\Office\Basic\RouteWrapper
{
    public static function scope(): string
    {
        return 'papervote.counting';
    }

    public static function logintoint($login)
    {
        $sum = 0;
        for ($i = 0; $i < strlen($login); $i++) {
            $sum += ord($login[$i]);
        }
        return sprintf('%05d', $sum);
    }


    public static function register()
    {
        BasicRoute::add('/papervote/counting/save', function ($matches) {

            App::contenttype('application/json');
            $db = App::get('session')->getDB();

            $db->autoCommit(false);
            try {
                $str_zaehltyp = ($_REQUEST['zaehltyp'] == '1') ? '1' : '2';
                $str_stapel = $_REQUEST['stapel'];
                $stapelliste = json_decode($_REQUEST['stapelliste'], true);
                $do = true;

                if (json_last_error() !== JSON_ERROR_NONE) {
                    throw new Exception('Invalid JSON in stapelliste: ' . json_last_error_msg());
                }


                $sql = "select * from stapel$str_zaehltyp where id = {id}";
                $stack = $db->singleRow($sql, ['id' => $str_stapel]);
                if ($stack) {
                    throw new Exception('Stack allready exists: ' . $str_stapel);
                }
                // check stack with first count
                if ($str_zaehltyp == '2') {
                    $k = [];
                    $stimmzettelcount = 0;
                    foreach ($stapelliste as $stimmzettelliste) {
                        $stimmzettelcount++;
                        foreach ($stimmzettelliste as $pos) {
                            if (!isset($k[$pos['code']])) {
                                $k[$pos['code']] = 0;
                            }
                            $k[$pos['code']]++;
                        }
                    }

                    $sql = '
                        select 
                            kandidaten1.kandidaten,
                            kandidaten.barcode as code,
                            count(*) c 
                        from 
                            stapel1 
                            join stimmzettel1 on stapel1.id = stimmzettel1.stapel1
                            join kandidaten1  on stimmzettel1.id = kandidaten1.stimmzettel1 
                            join kandidaten on kandidaten.id = kandidaten1.kandidaten
                        where
                            stapel1.id = {stapel}
                        group by 
                            kandidaten1.kandidaten
                    ';
                    $kandidaten_vergleich = $db->direct($sql, ['stapel' => $str_stapel], 'code');
                    if (!$kandidaten_vergleich) {
                        throw new Exception('Stack missing in first count: ' . $str_stapel);
                    }

                    $sql = '
                        select 
                            count(*) c 
                        from 
                            stapel1 
                            join stimmzettel1 on stapel1.id = stimmzettel1.stapel1 
                        where
                            stapel1.id = {stapel}
                    ';
                    $stimmzettelcount_vergleich = $db->singleValue($sql, ['stapel' => $str_stapel], 'c');
                    if ($stimmzettelcount_vergleich != $stimmzettelcount) {
                        throw new Exception('Stimmzettel count does not match: ' . $stimmzettelcount_vergleich . ' != ' . $stimmzettelcount);
                    }


                    foreach ($k as $key => $v) {
                        if (!isset($kandidaten_vergleich[$key])) {
                            $do = false;
                            App::result('msg', 'Kandidat ' . $key . ' fehlte in der Erstz&auml;hlung');
                        } else {
                            if ($kandidaten_vergleich[$key]['c'] != $v) {
                                $do = false;
                                App::result('msg', 'Kandidat ' . $key . ' hat die falsche Stimmenanzahl: (' . $kandidaten_vergleich[$key]['c'] . ' zu ' . $v . ') *2');
                            }
                        }
                    }

                    foreach ($kandidaten_vergleich as $key => $v) {
                        if (!isset($k[$key])) {
                            $do = false;
                            App::result('msg', 'Kandidat ' . $key . ' fehlt in der Zweitz&auml;hlung');
                        } else {
                            if ($k[$key] != $v['c']) {
                                $do = false;
                                App::result('msg', 'Kandidat ' . $key . ' hat die falsche Stimmenanzahl: (' . $k[$key] . ' zu ' . $v['c'] . ') *1');
                            }
                        }
                    }
                }



                if ($do) {
                    if ($stack === false) {


                        $kistennr = $_REQUEST['kistennummer'];
                        $sql = 'insert into kisten' . $str_zaehltyp . ' (
                            id,
                            login,
                            createdatetime,
                            update_time
                        ) values (
                            {kistennr},
                            getSessionUser(),
                            now(),
                            now()
                        ) on duplicate key update
                            update_time = now()
                        ';
                        $db->direct($sql, [
                            'kistennr' => $kistennr
                        ]);

                        $sql = 'insert into stapel' . $str_zaehltyp . ' (
                            id,
                            login,
                            kisten' . $str_zaehltyp . ',
                            abgebrochen,
                            createdatetime
                        ) values (
                            {stapel},
                            getSessionUser(),
                            {kistennr},
                            0,
                            now()
                        ) ';
                        $db->direct($sql, [
                            'stapel' => $str_stapel,
                            'kistennr' => $kistennr
                        ]);





                        foreach ($stapelliste as $stimmzettelliste) {

                            $name = $_REQUEST['stapel'];
                            $stimmzettelnr = $stimmzettelliste[0]['stimmzettel'];

                            $stimmzettel_id = (Uuid::uuid4())->toString();

                            $sql = 'insert into stimmzettel' . $str_zaehltyp . ' (
                                id,
                                login,
                                stapel' . $str_zaehltyp . ',
                                stimmzettel,
                                createdatetime
                            ) values (
                                {stimmzettel_id},
                                getSessionUser(),
                                {stapel},
                                {stimmzettelnr},
                                now()
                            )';

                            $db->direct($sql, [
                                'stimmzettel_id' => $stimmzettel_id,
                                'stapel' => $str_stapel,
                                'stimmzettelnr' => $stimmzettelnr
                            ]);


                            foreach ($stimmzettelliste as $pos) {

                                $code = $pos['code'];
                                $kandidat = $pos['kandidat'];

                                $sql = 'insert into kandidaten' . $str_zaehltyp . ' (
                                    login,
                                    kandidaten,
                                    stimmzettel' . $str_zaehltyp . ',
                                    createdatetime,
                                    stimmen
                                ) values (
                                    getSessionUser(),
                                    {kandidat},
                                    {stimmzettel_id},
                                    now(),
                                    1
                                )';
                                $db->direct($sql, [
                                    'kandidat' => $kandidat,
                                    'stimmzettel_id' => $stimmzettel_id
                                ]);
                            }
                        }
                        App::result('success', true);



                        $db->execute('commit');
                        $db->commit();
                    } else {
                        $db->rollback();
                        App::result('msg', 'Der Stapel ist bereits erfasst');
                    }
                }
            } catch (Exception $e) {
                $db->rollback();
                App::result('last_sql', $db->last_sql);
                App::result('msg', $e->getMessage());
            }
        }, ['post'], true, [
            'errorOnUnexpected' => false,
            'errorOnInvalid' => false,
            'fields' =>
            [
                'stapel' => ['type' => 'string', 'required' => true],
                'zaehltyp' => ['type' => 'string', 'required' => true],
                'stapelliste' => ['type' => 'string', 'required' => true],
                'kistennummer' => ['type' => 'string', 'required' => true],
            ]
        ], self::scope());
    }
}
