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
