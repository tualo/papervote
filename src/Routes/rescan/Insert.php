<?php

namespace Tualo\Office\PaperVote\Routes\rescan;

use Exception;
use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\Basic\Route as BasicRoute;
use Tualo\Office\Basic\IRoute;
use Tualo\Office\TualoPGP\TualoApplicationPGP;
use phpseclib\Net\SFTP;
use \PhpOffice\PhpSpreadsheet\Spreadsheet;
use \PhpOffice\PhpSpreadsheet\IOFactory;

use Ramsey\Uuid\Uuid;

class Insert implements IRoute
{

    public static function register()
    {
        BasicRoute::add('/papervote/rescan/insert', function () {
            $db = App::get('session')->getDB();
            try {

               /*
                create table nachzaehlung(
                id varchar(20) primary key,
                login varchar(50),
                ctime datetime
                )
                */
                $db->direct('insert into nachzaehlung(id,login,ctime) values ({id},getSessionUser(),now())
                on duplicate key update ctime=values(ctime),login=values(login)
                ',$_REQUEST);
                App::result('success', true);

            } catch (Exception $e) {
                App::result('msg', $e->getMessage());
            }
            App::contenttype('application/json');
        }, array('get', 'post'), true);
    }
}
