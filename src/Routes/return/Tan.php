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
use Tualo\Office\DS\DSTable;

class Tan implements IRoute
{

    public static function register()
    {
        BasicRoute::add('/papervote/return/tan/(?P<id>[\w.\/\-]+)/(?P<tan>[\w.\/\-]+)', function ($matches) {
            $db = App::get('session')->getDB();
            try {
                $tantable = DSTable::instance('wm_tannummer');
                $tans = $tantable
                    ->f('tannummer', 'eq', $matches['tan'])
                    ->read();
                if ($tans->empty()) throw new Exception("Die Tan wurde nicht gefunden.");

                $tans = $tantable
                    ->f('tannummer', 'eq', $matches['tan'])
                    ->f('aktiv', 'eq', 1)
                    ->read();
                if ($tans->empty()) throw new Exception("Die Tan wurde bereits verwendet.");
                $tan = $tans->getSingle();
                $tan['aktiv'] = 0;
                $tantable->update($tan);


                ($wahlscheintable = DSTable::instance('wahlschein'))
                    ->f('id', 'eq', $matches['id'])
                    ->read();
                if ($wahlscheintable->empty()) throw new Exception("Der Wahlschein wurde nicht gefunden.");

                $wahlschein = $wahlscheintable->getSingle();

                if ($wahlschein['abgabetyp'] == 2) throw new Exception("Der Wahlschein kann nicht entsperrt werden, da Online gewählt wurde.");

                $wahlschein['wahlscheinstatus'] = '-1';
                $wahlschein['abgabetyp'] = '0';

                $wahlscheintable->update($wahlschein);

                App::result('success', true);
            } catch (Exception $e) {
                App::result('msg', $e->getMessage());
            }
            App::contenttype('application/json');
        }, array('get', 'post'), true);
    }
}
