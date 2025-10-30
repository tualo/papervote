<?php

namespace Tualo\Office\PaperVote\Routes;

use Exception;
use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\Basic\Route as BasicRoute;
use Tualo\Office\Basic\IRoute;
use Tualo\Office\TualoPGP\TualoApplicationPGP;

use Ramsey\Uuid\Uuid;

class Check extends \Tualo\Office\Basic\RouteWrapper
{

    public static function scope(): string
    {
        return 'papervote.sync';
    }
    public static function register()
    {
        BasicRoute::add('/papervote/check', function () {
            App::contenttype('application/json');
            try {
                $db = App::get('session')->getDB();

                $remote_public_key = $db->singleValue("select property FROM system_settings WHERE system_settings_id = 'remote-erp/public'", [], 'property');
                if (!isset($_REQUEST['voter_id'])) throw new Exception("voter_id missed");
                if (!isset($_REQUEST['signature']))  throw new Exception("signature missed");
                if (!isset($_REQUEST['ballotpaper_id']))  throw new Exception("ballotpaper_id missed");
                if (!TualoApplicationPGP::verify($remote_public_key, $_REQUEST['voter_id'], $_REQUEST['signature'])) throw new Exception("Verification failed");

                $sql = 'select * from 
                    wahlschein 
                where 
                    id={voter_id} 
                    and stimmzettel =  {ballotpaper_id}
                    and (wahlscheinstatus,abgabetyp) in (select wahlscheinstatus,abgabetyp from wahlscheinstatus_online_erlaubt)';
                $data = $db->singleRow($sql, $_REQUEST);
                App::result('success', $data !== false);
                App::result('msg', ($data === false) ? 'Der Wähler wurde nicht gefunden.' : '');
            } catch (\Exception $e) {

                App::result('last_sql', $db->last_sql);
                App::result('msg', $e->getMessage());
            }
        }, ['post'], true, [], self::scope());
    }
}
