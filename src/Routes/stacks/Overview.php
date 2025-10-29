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

    public static function register()
    {
        BasicRoute::add('/papervote/blocks/overview', function () {
            $db = App::get('session')->getDB();
            try {

                $sql = "

                    select 
                        wahlschein.blocknumber,
                        wahlschein.abgabetyp,
                        wahlschein.wahlscheinstatus,
                        abgabetyp.name abgabetyp_name,
                        wahlscheinstatus.name wahlscheinstatus_name,
                        count(distinct wahlschein.wahlberechtigte) letters,
                        count(distinct wahlschein.wahlscheinnummer) ballots

                    from 
                        wahlschein
                        join abgabetyp on wahlschein.abgabetyp = abgabetyp.id
                        join wahlscheinstatus on wahlschein.wahlscheinstatus = wahlscheinstatus.id
                    group by 
                        blocknumber,
                        abgabetyp,
                        wahlscheinstatus
                ";
                App::result('data', $db->direct($sql, []));
                App::result('success', true);
            } catch (Exception $e) {
                App::result('msg', $e->getMessage());
            }
            App::contenttype('application/json');
        }, array('get', 'post'), true);
    }
}
