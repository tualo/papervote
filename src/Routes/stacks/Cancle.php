<?php

namespace Tualo\Office\PaperVote\Routes\stacks;

use Exception;
use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\Basic\Route as BasicRoute;
use Tualo\Office\Basic\IRoute;
use Tualo\Office\TualoPGP\TualoApplicationPGP;
use phpseclib\Net\SFTP;
use \PhpOffice\PhpSpreadsheet\Spreadsheet;
use \PhpOffice\PhpSpreadsheet\IOFactory;

use Ramsey\Uuid\Uuid;

class Cancle implements IRoute
{

    public static function register()
    {
        BasicRoute::add('/papervote/stacks/cancle/(?P<id>[\w.\/\-]+)', function ($matches) {
            $db = App::get('session')->getDB();
            try {

                
                $sql = "update stapel1 set abgebrochen =1 where name={id}";
                $db->direct($sql,$matches);
                $sql = "update stapel2 set abgebrochen =1 where name={id}";
                $db->direct($sql,$matches);


                App::result('success', true);

            } catch (Exception $e) {
                App::result('msg', $e->getMessage());
            }
            App::contenttype('application/json');
        }, array('get', 'post'), true);
    }
}
