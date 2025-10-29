<?php

namespace Tualo\Office\PaperVote\Routes\rescan;

use Exception;
use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\Basic\Route as BasicRoute;
use Tualo\Office\Basic\IRoute;
use Tualo\Office\DS\DSTable;

use Tualo\Office\TualoPGP\TualoApplicationPGP;
use phpseclib\Net\SFTP;
use \PhpOffice\PhpSpreadsheet\Spreadsheet;
use \PhpOffice\PhpSpreadsheet\IOFactory;

use Ramsey\Uuid\Uuid;

class Insert extends \Tualo\Office\Basic\RouteWrapper
{

    public static function register()
    {
        BasicRoute::add('/papervote/rescan/insert', function () {
            $db = App::get('session')->getDB();
            try {

                $record = [
                    'wahlscheinstatus' => $_POST['wahlscheinstatus'],
                    'abgabetyp' => $_POST['abgabetyp']
                ];
                if ($_POST['typ'] == 'wahlscheinnummer') {
                    $table_name = 'wm_nachzaehlung_wahlschein_wahlscheinnummer';
                    $record['wahlscheinnummer'] = $_POST['id'];
                } elseif ($_POST['typ'] == 'wahlberechtigter') {
                    $table_name = 'wm_nachzaehlung_wahlschein_wahlberechtigte';
                    $record['wahlberechtigte'] = $_POST['id'];
                } else {
                    throw new Exception('Typ nicht erkannt');
                }
                $table = DSTable::init($db)
                    ->t($table_name);
                $table->insert($record, ['update' => true]);

                if ($table->error()) {
                    throw new Exception($table->errorMessage());
                }
                App::result('success', true);
            } catch (Exception $e) {
                App::result('msg', $e->getMessage());
            }
            App::contenttype('application/json');
        }, array('get', 'post'), true, ['get', 'post'], true, [
            'errorOnUnexpected' => false,
            'errorOnInvalid' => false,
            'fields' => [
                'abgabetyp' => [
                    'required' => true,
                    'type' => 'int',
                    'min' => 0,
                    'max' => 10000000
                ],
                'wahlscheinstatus' => [
                    'required' => true,
                    'type' => 'int',
                    'min' => 0,
                    'max' => 10000000
                ],
                'typ' => [
                    'required' => true,
                    'type' => 'string',
                    'minlength' => 0,
                    'maxlength' => 1000
                ],
                'blocknumber' => [
                    'required' => false,
                    'type' => 'string',
                    'minlength' => 0,
                    'maxlength' => 1000
                ]
            ]
        ]);
    }
}
