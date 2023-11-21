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

class Unique implements IRoute
{

    public static function register()
    {
        BasicRoute::add('/pwgen/new_unique', function () {
            $session = App::get('session');
            $db = $session->getDB();
            App::contenttype('application/json');
            set_time_limit(120);
            try{
                App::result('wahlschein',[]);
                App::result('username',[]);
                App::result('password',[]);
                $c = $db->singleRow('select count(*) as c,database() d from wahlschein',[]);
                if ($c['c']==0) $c['c']=1000;

                $db->direct('call createRandomList(8,"ABCDEFGHJKLMNPRSTUVXYZabcdefghijkmpstuvxyz123456789",{c},"wahlscheinnummer")',$c);
                $db->moreResults();
                App::result('wahlschein',$db->direct('select * from temp_random_list',[]));
                set_time_limit(120);

                $db->direct('call createRandomList(8,"1234567890",{c},"username")',$c);
                $db->moreResults();
                App::result('username',$db->direct('select * from temp_random_list',[]));
                set_time_limit(120);

                $db->direct('call createRandomList(8,"ABCDEFGHJKLMNPRSTUVXYZabcdefghijkmpstuvxyz123456789",{c},"pw")',$c);
                $db->moreResults();
                set_time_limit(120);
                App::result('password',$db->direct('select * from temp_random_list',[]));
                App::result('success', true);

            }catch(Exception $e){
                App::result('msg', $e->getMessage());
            }
        },['post','get']);

        BasicRoute::add('/pwgen/unique', function () {
            $session = App::get('session');
            $db = $session->getDB();
            
            try{
                App::result('wahlschein',[]);
                App::result('username',[]);

                try{
                    App::result('wahlschein', $db->direct('select wahlscheinnummer from wahlschein_hstr',[],'wahlscheinnummer'));
                    App::result('username', $db->direct('select username from wahlschein_hstr',[],'username'));
                }catch(Exception $e){
                    App::result('msg', $e->getMessage());
                }
                App::result('success', true);
            }catch(Exception $e){
                App::result('msg', $e->getMessage());
            }
            App::contenttype('application/json');
        },['post','get']);
    }
}
