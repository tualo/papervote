<?php

namespace Tualo\Office\PaperVote\Routes;

use Exception;
use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\Basic\Route as BasicRoute;
use Tualo\Office\Basic\IRoute;
use Tualo\Office\TualoPGP\TualoApplicationPGP;

use Ramsey\Uuid\Uuid;

class Set implements IRoute
{

    public static function register()
    {

        BasicRoute::add('/papervote/set', function () {
            App::contenttype('application/json');
            $db = App::get('session')->getDB();
            try {


                $db->direct('start transaction;');
                $remote_public_key = $db->singleValue("select property FROM system_settings WHERE system_settings_id = 'remote-erp/public'", [], 'property');
                if (!isset($_REQUEST['voter_id'])) throw new Exception("voter_id missed");
                if (!isset($_REQUEST['signature']))  throw new Exception("signature missed");
                if (!isset($_REQUEST['ballotpaper_id']))  throw new Exception("ballotpaper_id missed");
                if (!TualoApplicationPGP::verify($remote_public_key, $_REQUEST['voter_id'], $_REQUEST['signature'])) throw new Exception("Verification failed");

                if (ctype_digit($_REQUEST['voter_id']) === false) throw new Exception("voter_id is not a number");
                if (ctype_digit($_REQUEST['ballotpaper_id']) === false) throw new Exception("ballotpaper_id is not a number");


                $sql = 'select * from wahlschein where id={voter_id} and stimmzettel  = {stimmzettel} and (wahlscheinstatus,abgabetyp) in (select wahlscheinstatus,abgabetyp from wahlscheinstatus_online_erlaubt)';
                $data = $db->singleRow($sql, [
                    'voter_id'      =>  $_REQUEST['voter_id'],
                    'stimmzettel'   =>  $_REQUEST['ballotpaper_id'],
                ]);

                if ($data !== false) {
                    $db->direct("update wahlschein set wahlscheinstatus=2, abgabetyp=2, update_date=curdate(), update_time=curtime() where id={voter_id}  and stimmzettel={stimmzettel} and (wahlscheinstatus,abgabetyp) in (select wahlscheinstatus,abgabetyp from wahlscheinstatus_online_erlaubt) ", [
                        'voter_id'      => $_REQUEST['voter_id'],
                        'stimmzettel'   => $_REQUEST['ballotpaper_id'],
                    ]);

                    $sql = 'select * from wahlschein where id={voter_id} and stimmzettel  = {stimmzettel} and wahlscheinstatus=2 and abgabetyp=2';
                    $data = $db->singleRow($sql, [
                        'voter_id'      =>  $_REQUEST['voter_id'],
                        'stimmzettel'   => $_REQUEST['ballotpaper_id'],
                    ]);
                    if ($data !== false) App::result('success', true);

                    try {
                        $formdata = $_REQUEST;
                        unset($formdata['signature']);
                        unset($formdata['voter_id']);
                        unset($formdata['ballotpaper_id']);
                        // alter table wm_wahlschein_register add formdata json default null
                        $sql = 'update wm_wahlschein_register set formdata={formdata} where id={voter_id} and stimmzettel={stimmzettel}';
                        $db->direct($sql, [
                            'voter_id'      => $_REQUEST['voter_id'],
                            'stimmzettel'   => $_REQUEST['ballotpaper_id'],
                            'formdata'      => json_encode($formdata)
                        ]);
                    } catch (\Exception $e) {
                    }
                    $db->direct('commit;');
                } else {

                    $db->direct('rollback;');
                    App::result('success', false);
                    App::result('msg', ($data === false) ? 'Konnte nicht gespeichert werden' : '');
                }
            } catch (\Exception $e) {
                $db->direct('rollback;');
                App::result('last_sql', $db->last_sql);
                App::result('msg', $e->getMessage());
            }
        }, ['post'], true);
    }
}
