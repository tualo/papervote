<?php

namespace Tualo\Office\PaperVote\Routes\images;

use Exception;
use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\Basic\Route as BasicRoute;
use Tualo\Office\Basic\IRoute;
use Tualo\Office\TualoPGP\TualoApplicationPGP;
use phpseclib\Net\SFTP;
use \PhpOffice\PhpSpreadsheet\Spreadsheet;
use \PhpOffice\PhpSpreadsheet\IOFactory;

use Ramsey\Uuid\Uuid;

class BarcodeImages implements IRoute
{

    public static function register()
    {
        BasicRoute::add('/papervote/images/createbarcodeimages', function () {
            $db = App::get('session')->getDB();
            try {

                $sql = 'select id,barcode from kandidaten ';
                App::result('data',$db->direct($sql,[],''));
                App::result('success', true);

            } catch (Exception $e) {
                App::result('msg', $e->getMessage());
            }
            App::contenttype('application/json');
        }, array('get', 'post'), true);
    }
}
