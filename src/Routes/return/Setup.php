<?php

namespace Tualo\Office\PaperVote\Routes\return;

use Exception;
use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\Basic\Route as BasicRoute;
use Tualo\Office\Basic\IRoute;
use Tualo\Office\TualoPGP\TualoApplicationPGP;
use phpseclib\Net\SFTP;
use \PhpOffice\PhpSpreadsheet\Spreadsheet;
use \PhpOffice\PhpSpreadsheet\IOFactory;

use Ramsey\Uuid\Uuid;

class Setup implements IRoute
{

    public static function register()
    {
        BasicRoute::add('/papervote/return/setup', function () {
            $db = App::get('session')->getDB();
            try {

                $sql = 'select id,daten from setup where cmp=\'cmp_wm_ruecklauf\' and rolle=\'_default_\' and id in (\'FORCEBLOCKCODE\')';
                App::result('data',$db->direct($sql,array(),'id'));
                App::result('success', true);

            } catch (Exception $e) {
                App::result('msg', $e->getMessage());
            }
            App::contenttype('application/json');
        }, array('get', 'post'), true);
    }
}
