<?php

namespace Tualo\Office\PaperVote\Routes\counting;

use Exception;
use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\Basic\Route as BasicRoute;
use Tualo\Office\Basic\IRoute;
use Tualo\Office\TualoPGP\TualoApplicationPGP;

use Ramsey\Uuid\Uuid;

class Save implements IRoute
{
    public static function logintoint($login){
        $sum = 0;
        for($i=0;$i<strlen($login);$i++){
          $sum+=ord($login[$i]);
        }
        return sprintf('%05d',$sum);
    }


    public static function register()
    {
        BasicRoute::add('/papervote/counting/save', function ($matches) {

            App::contenttype('application/json');
            $db = App::get('session')->getDB();

            $db->autoCommit(false);
            try {
                App::result('line', __LINE__);

                $str_zaehltyp = ($_REQUEST['zaehltyp'] == '1') ? '1' : '2';
                $str_stapel = $_REQUEST['stapel'];

                $sql = "select * from stapel$str_zaehltyp where name = '$str_stapel'";
                $rs = $db->execute($sql);
                $stapelRS = $rs->toArray('');
                $rs->unload();
                App::result('line', __LINE__);


                $stapelliste = json_decode($_REQUEST['stapelliste'], true);

                App::result('line', __LINE__);
                $do = true;
                if (($_REQUEST['zaehltyp'] == '2')) {

                    $k = array();
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
                    $sql = "select kandidaten1.name,count(*) c from stapel1,stimmzettel1,kandidaten1 where stapel1.ridx = stimmzettel1.stapel1 and stimmzettel1.ridx = kandidaten1.stimmzettel1 and stapel1.name='" . $_REQUEST['stapel'] . "' group by kandidaten1.name";
                    $rs = $db->execute($sql);
                    $k_vergleich = $rs->toArray('name');
                    $rs->unload();
                    App::result('k_vergleich', $k_vergleich);
                    App::result('line', __LINE__);

                    $sql = "select count(*) c from stapel1,stimmzettel1 where stapel1.ridx = stimmzettel1.stapel1 and stapel1.name='" . $_REQUEST['stapel'] . "' ";
                    $rs = $db->execute($sql);
                    $stimmzettelcount_vergleich = $rs->toArray('');
                    $rs->unload();


                    if ($stimmzettelcount_vergleich[0]['c'] != $stimmzettelcount) {
                        $do = false;
                        App::result('msg', 'Die Stimmzettelanzahl stimmt nicht &uuml;berein.');
                    }


                    if (count($k_vergleich) == 0) {
                        $do = false;
                        App::result('msg', 'Der Stapel fehlte in der Erstz&auml;hlung');
                    } else {
                        foreach ($k as $key => $v) {
                            if (!isset($k_vergleich[$key])) {
                                $do = false;
                                App::result('msg', 'Kandidat ' . $key . ' fehlte in der Erstz&auml;hlung');
                            } else {
                                if ($k_vergleich[$key]['c'] != $v) {
                                    $do = false;
                                    App::result('msg', 'Kandidat ' . $key . ' hat die falsche Stimmenanzahl: (' . $k_vergleich[$key]['c'] . ' zu ' . $v . ') *2');
                                }
                            }
                        }

                        foreach ($k_vergleich as $key => $v) {
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
                }
                App::result('line', __LINE__);

                if ($do) {
                    if (count($stapelRS) == 0) {


                        $login = $db->singleValue("select getSessionUser() i ", array(), 'i');
                        App::result('login', $login);
                        $loginint = Save::logintoint($login);

                        $insert_date = date('Y-m-d', time());
                        $update_date = date('Y-m-d', time());

                        $insert_time = date('H:i:s', time());
                        $update_time = date('H:i:s', time());

                        $kistennr = $_REQUEST['kistennummer'];
                        $name  = $kistennr;
                        $kisten_id = str_replace('FC', '', $_REQUEST['kistennummer']);
                        $sql  = "insert into kisten$str_zaehltyp (ridx,id,kostenstelle,name,aktiv,insert_date,update_date,login,insert_time,update_time)  value ";
                        $sql .= "('$name',$kisten_id,0,'$name',1,'$insert_date','$update_date','$login','$insert_time','$update_time') ";
                        $sql .= " on duplicate key update update_date=values(update_date), update_time=values(update_time) ";
                        $db->execute($sql);
                        App::result('line' . __LINE__, $sql);


                        $stapel_id = str_replace('FC', '', $_REQUEST['stapel']);
                        $name = $_REQUEST['stapel'];
                        $sql  = "insert into stapel$str_zaehltyp (ridx,id,kostenstelle,name,aktiv,insert_date,update_date,login,insert_time,update_time,kisten$str_zaehltyp,abgebrochen)  value ";
                        $sql .= "('$name',$stapel_id,0,'$name',1,'$insert_date','$update_date','$login','$insert_time','$update_time','$kistennr',0) ";
                        $sql .= " on duplicate key update update_date=values(update_date), update_time=values(update_time) ";
                        $db->execute($sql);
                        App::result('line' . __LINE__, $sql);



                        foreach ($stapelliste as $stimmzettelliste) {

                            $name = $_REQUEST['stapel'];
                            $stimmzettelnr = $stimmzettelliste[0]['stimmzettel'];
                            $szid = $db->singleValue("select ifnull(max(id),0)+1 i from stimmzettel$str_zaehltyp", array(), 'i'); //$th is->getNewTableIndex("stimmzettel$str_zaehltyp",'id');


                            if ($szid < 1) {
                                $szid = 1;
                            }
                            $sql  = "insert into stimmzettel$str_zaehltyp (ridx,id,kostenstelle,name,aktiv,insert_date,update_date,login,insert_time,update_time,stapel$str_zaehltyp,stimmzettel)  value ";
                            $sql .= "('$szid|$loginint',$szid,$loginint,'$name',1,'$insert_date','$update_date','$login','$insert_time','$update_time','$name','$stimmzettelnr') ";
                            $sql .= " on duplicate key update update_date=values(update_date), update_time=values(update_time) ";
                            $db->execute($sql);
                            App::result('line' . __LINE__, $sql);

                            foreach ($stimmzettelliste as $pos) {

                                $code = $pos['code'];
                                $kandidat = $pos['kandidatridx'];

                                $kid = $db->singleValue("select ifnull(max(id),0)+1 i from kandidaten$str_zaehltyp", array(), 'i'); //$th is->getNewTableIndex("kandidaten$str_zaehltyp",'id');
                                if ($kid < 1) {
                                    $kid = 1;
                                }
                                $sql  = "insert into kandidaten$str_zaehltyp (ridx,id,kostenstelle,name,aktiv,insert_date,update_date,login,insert_time,update_time,stimmzettel$str_zaehltyp,kandidaten)  value ";
                                $sql .= "('$kid',$kid,$loginint,'$code',1,'$insert_date','$update_date','$login','$insert_time','$update_time','$szid|$loginint','$kandidat') ";
                                $sql .= " on duplicate key update update_date=values(update_date), update_time=values(update_time) ";
                                $db->execute($sql);
                                App::result('line' . __LINE__, $sql);
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
        }, ['post'], true);
    }
}
