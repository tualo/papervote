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

class Open extends \Tualo\Office\Basic\RouteWrapper
{

    public static function scope(): string
    {
        return 'papervote.stacks';
    }
    public static function register()
    {
        BasicRoute::add('/papervote/stacks/open', function () {
            $db = App::get('session')->getDB();
            try {

                $sql = "select stapel1.* from stapel1 left join stapel2 on stapel1.id=stapel2.id where stapel2.id is null and stapel1.abgebrochen=0";
                App::result('data', $db->direct($sql, []));
                App::result('success', true);
            } catch (Exception $e) {
                App::result('msg', $e->getMessage());
            }
            App::contenttype('application/json');
        }, array('get', 'post'), true, [], self::scope());
    }
}
