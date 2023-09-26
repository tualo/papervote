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

class TestColumn implements IRoute
{

    public static function register()
    {
        BasicRoute::add('/pwgen/testcolumn', function () {


            $db = App::get('session')->getDB();
            try {
                if (!isset($_REQUEST['sheetname'])) throw new \Exception("argument missed");
                if (!isset($_REQUEST['column'])) throw new \Exception("argument missed");
                App::result('pwimportfile', $_SESSION['pwimportfile']);
                $reader = \PhpOffice\PhpSpreadsheet\IOFactory::createReader("Xlsx");
                $index = 0;
                $spreadsheet = $reader->load($_SESSION['pwimportfile']);
                $sheets = $spreadsheet->getSheetNames();
                $info = [
                    'type'              => 's',
                    'typehash'          => [],
                    'contains_null'     => false,
                    'length'            => 1,
                    'unique'            => false,
                    'variation_count'   => 0
                ];

                foreach ($sheets as $sheetName) {

                    if ($sheetName == $_REQUEST['sheetname']) {
                        set_time_limit(300);
                        $sheet = $spreadsheet->getSheet($index);
                        $count = $sheet->getHighestDataRow();
                        $columnCount = $sheet->getHighestColumn();
                 
                        $info['unique'] = true; //count($udata)==count($data);
                        $h = [];
                        for ($row = 2; $row <= $count; $row++) {
                            $cell = $sheet->getCell($_REQUEST['column'] . '' . $row);



                            $type = $cell->getDataType();
                            switch ($type) {
                                case 'str':
                                case 's':
                                case 'inlineStr':
                                case 'mixed':
                                    $type = 'varchar';
                                    break;
                                case 'n':
                                    $type = 'fixed';
                                    break;
                            }
                            if (in_array($cell->getValue(), $h)) {
                                $info['unique'] = false;
                            } else {
                                $h[] = $cell->getValue();
                            }
                            if ($type != 'null') {
                                if (!in_array($type, $info['typehash'])) {
                                    $info['typehash'][] = $type;
                                }
                                if ($type == 'varchar') $info['length'] = max($info['length'], strlen($cell->getValue()));

                                if (count($info['typehash']) == 1) {
                                    $info['type'] = $type;
                                } else {
                                    // $info['type'] = 'mixed';
                                    $info['type'] = 'varchar';
                                    $info['length'] =255;
                                }
                            } else {
                                $info['contains_null'] = true;
                            }
                        }

                        $info['variation_length'] = $count;
                        $info['variation_count'] = count($h);
                    }
                    $index++;
                }
                App::result('info', $info);
                App::result('success', true);
            } catch (Exception $e) {
                App::result('msg', $e->getMessage());
            }
            App::contenttype('application/json');
        }, array('get', 'post'), true);
    }
}
