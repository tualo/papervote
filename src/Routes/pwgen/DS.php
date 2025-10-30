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

class DS extends \Tualo\Office\Basic\RouteWrapper
{
    public static function scope(): string
    {
        return 'papervote.pwgen';
    }

    public static function register()
    {
        BasicRoute::add('/pwgen/ds', function () {


            $db = App::get('session')->getDB();
            try {

                App::result('data', $db->direct(
                    'select 
                "" excel_column,
                "" excel_header,
                data_type,
                false is_new,
                column_name,
                false contains_null
             from 
                ds_column
             where table_name = "pwgen_import" and column_name not in ("import_id","import_datetime","import_filename","import_username")
            '
                ));
                App::result('success', true);
            } catch (Exception $e) {
                App::result('msg', $e->getMessage());
            }
            App::contenttype('application/json');
        }, array('get', 'post'), true, [], self::scope());
    }
}
