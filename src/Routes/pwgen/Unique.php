<?php

namespace Tualo\Office\PaperVote\Routes\pwgen;

use Exception;
use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\Basic\Route as BasicRoute;
use Tualo\Office\Basic\IRoute;
use Tualo\Office\TualoPGP\TualoApplicationPGP;
use phpseclib\Net\SFTP;
use \PhpOffice\PhpSpreadsheet\Spreadsheet;
use \PhpOffice\PhpSpreadsheet\IOFactory;

use Ramsey\Uuid\Uuid;

class Unique extends \Tualo\Office\Basic\RouteWrapper
{

    public static function scope(): string
    {
        return 'papervote.pwgen';
    }
    public static function register()
    {
        BasicRoute::add('/pwgen/new_unique', function () {
            $session = App::get('session');
            $db = $session->getDB();
            App::contenttype('application/json');
            set_time_limit(120);
            try {
                App::result('wahlschein', []);
                App::result('username', []);
                App::result('password', []);
                $c = $db->singleRow('select count(*) as c,database() d from wahlschein', []);
                if ($c['c'] == 0) $c['c'] = 1000;

                $counts = $c['c'];

                $c['c'] = 1000;



                $sum = 0;
                $db->direct('drop table if exists temp_random_list');
                while ($sum < $counts) {
                    $db->direct('call createRandomList(8,"1234567890",{c},"wahlscheinnummer")', $c);
                    $db->moreResults();
                    $sum += $c['c'];
                }

                App::result('wahlschein', $db->direct('select temp_random_list.*,rand() r from temp_random_list  order by r', []));
                // create table temp_random_list_wahlschein as select * from temp_random_list
                set_time_limit(120);

                $sum = 0;
                $db->direct('drop table if exists temp_random_list');
                while ($sum < $counts) {
                    $db->direct('call createRandomList(8,"ABCDEFGHJKLMNPRSTUVXYZabcdefghijkmpstuvxyz123456789",{c},"username")', $c);
                    $db->moreResults();
                    $sum += $c['c'];
                }

                App::result('username', $db->direct('select temp_random_list.*,rand() r from temp_random_list order by r', []));
                // create table temp_random_list_username as select * from temp_random_list
                /*
                call appendRandomList(8,"1234567890","wahlscheinnummer");
                call appendRandomList(8,"ABCDEFGHJKLMNPRSTUVXYZabcdefghijkmpstuvxyz123456789","username");
                call appendRandomList(8,"ABCDEFGHJKLMNPRSTUVXYZabcdefghijkmpstuvxyz123456789","pw");
                call cleanRandomTables();
                */
                set_time_limit(120);

                $sum = 0;
                $db->direct('drop table if exists temp_random_list');
                while ($sum < $counts) {
                    $db->direct('call createRandomList(8,"ABCDEFGHJKLMNPRSTUVXYZabcdefghijkmpstuvxyz123456789",{c},"pw")', $c);
                    $db->moreResults();
                    $sum += $c['c'];
                }

                set_time_limit(120);
                App::result('password', $db->direct('select temp_random_list.*,rand() r from temp_random_list  order by r', []));
                // create table temp_random_list_password as select * from temp_random_list
                App::result('success', true);
            } catch (Exception $e) {
                App::result('msg', $e->getMessage());
            }
        }, ['post', 'get'], true);

        BasicRoute::add('/pwgen/unique', function () {
            $session = App::get('session');
            $db = $session->getDB();

            try {
                App::result('wahlschein', []);
                App::result('username', []);

                try {
                    App::result('wahlschein', $db->direct('select wahlscheinnummer from wahlschein FOR SYSTEM_TIME ALL', [], 'wahlscheinnummer'));
                    App::result('username', $db->direct('select username from wahlschein FOR SYSTEM_TIME ALL', [], 'username'));
                } catch (Exception $e) {
                    /*
                    // für ältere system gedacht
                    // neu mit versionierung
                    try{
                        App::result('wahlschein', $db->direct('select wahlscheinnummer from wahls chein_hstr',[],'wahlscheinnummer'));
                        App::result('username', $db->direct('select username from wahlsche in_hstr',[],'username'));
                    }catch(Exception $e){
                        App::result('msg', $e->getMessage());
                    }*/
                }
                App::result('success', true);
            } catch (Exception $e) {
                App::result('msg', $e->getMessage());
            }
            App::contenttype('application/json');
        }, ['post', 'get'], true, [], self::scope());
    }
}
