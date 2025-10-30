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

class Import extends \Tualo\Office\Basic\RouteWrapper
{
    public static function scope(): string
    {
        return 'papervote.pwgen';
    }
    public static function register()
    {
        BasicRoute::add('/pwgen/uploadsettings', function () {

            function parse_size($size)
            {
                $unit = preg_replace('/[^bkmgtpezy]/i', '', $size); // Remove the non-unit characters from the size.
                $size = preg_replace('/[^0-9\.]/', '', $size); // Remove the non-numeric characters from the size.
                if ($unit) {
                    // Find the position of the unit in the ordered string which is the power of magnitude to multiply a kilobyte by.
                    return round($size * pow(1024, stripos('bkmgtpezy', $unit[0])));
                } else {
                    return round($size);
                }
            }

            $db = App::get('session')->getDB();
            try {
                $max_size = -1;

                if ($max_size < 0) {
                    // Start with post_max_size.
                    $post_max_size = parse_size(ini_get('post_max_size'));
                    if ($post_max_size > 0) {
                        $max_size = $post_max_size;
                    }

                    // If upload_max_size is less, then reduce. Except if upload_max_size is
                    // zero, which indicates no limit.
                    $upload_max = parse_size(ini_get('upload_max_filesize'));
                    if ($upload_max > 0 && $upload_max < $max_size) {
                        $max_size = $upload_max;
                    }
                }
                App::result('success', true);
                App::result('max_size', $max_size);
                App::result('memory_limit', parse_size(ini_get('memory_limit')));
                App::result('max_size_text',  ini_get('upload_max_filesize'));
                App::result('memory_limit_text',  ini_get('memory_limit'));
            } catch (Exception $e) {
                App::result('msg', $e->getMessage());
            }
            App::contenttype('application/json');
        }, array('get', 'post'), true, [], self::scope());



        BasicRoute::add('/pwgen/upload', function () {

            $db = App::get('session')->getDB();
            try {
                $success = false;
                $error = "no error";
                if (isset($_FILES['userfile'])) {
                    $sfile = $_FILES['userfile']['tmp_name'];
                    $name = $_FILES['userfile']['name'];
                    $extension = pathinfo($name, PATHINFO_EXTENSION);
                    $type = $_FILES['userfile']['type'];
                    $error = $_FILES['userfile']['error'];

                    switch ($error) {
                        case UPLOAD_ERR_INI_SIZE:
                            throw new \Exception("UPLOAD_ERR_INI_SIZE: Die Datei ist zu groß");
                            break;
                        case UPLOAD_ERR_FORM_SIZE:
                            throw new \Exception("UPLOAD_ERR_FORM_SIZE: Die Datei ist zu groß");
                            break;
                        case UPLOAD_ERR_PARTIAL:
                            throw new \Exception("UPLOAD_ERR_PARTIAL: Die Datei wurde nur teilweise hochgeladen");
                            break;
                        case UPLOAD_ERR_NO_FILE:
                            throw new \Exception("UPLOAD_ERR_NO_FILE: Es wurde keine Datei hochgeladen");
                            break;
                    }
                    if ($error == UPLOAD_ERR_OK) {
                        $localfname = $db->singleValue('select uuid() u', [], 'u') . '.' . $extension;
                        $fulllocalfname = App::get('tempPath') . '/' . $localfname;

                        if (file_exists($fulllocalfname)) unlink($fulllocalfname);
                        move_uploaded_file($sfile, $fulllocalfname);

                        set_time_limit(300);

                        error_reporting(E_ALL);

                        //$spreadsheet = \PhpOffice\PhpSpreadsheet\IOFactory::load( $fulllocalfname );
                        $reader = \PhpOffice\PhpSpreadsheet\IOFactory::createReader("Xlsx");
                        $spreadsheet = $reader->load($fulllocalfname);

                        @session_start();
                        $_SESSION['pwimportfile'] = $fulllocalfname;

                        session_commit();

                        $sheets = $spreadsheet->getSheetNames();
                        if (count($sheets) == 0) throw new \Exception("No Sheets read");
                        $index = 0;

                        App::result('sheets', $sheets);
                        $sheetsconfig = [];

                        foreach ($sheets as $sheetName) {
                            $sheet = $spreadsheet->getSheet($index);
                            $count = $sheet->getHighestDataRow();
                            $columnCount = $sheet->getHighestColumn();
                            $header = $sheet->rangeToArray(
                                'A1:' . $columnCount . '1',     // The worksheet range that we want to retrieve
                                NULL,        // Value that should be returned for empty cells
                                TRUE,        // Should formulas be calculated (the equivalent of getCalculatedValue() for each cell)
                                TRUE,        // Should values be formatted (the equivalent of getFormattedValue() for each cell)
                                TRUE         // Should the array be indexed by cell row and cell column
                            );
                            foreach ($header['1'] as $k => $v) {
                                if (is_null($v)) unset($header['1'][$k]);
                            }

                            $sheetsconfig[$sheetName] = $header;
                            //$index++;
                        }

                        App::result('header', $header);
                        App::result('count', $count);

                        App::result('sheetsconfig', $sheetsconfig);

                        $success = true;
                    }
                }
                App::result('success', $success);
                App::result('data', []);
                App::result('msg', $error);
            } catch (Exception $e) {
                App::result('last_sql', $db->last_sql);
                App::result('msg', $e->getMessage());
            }
            App::contenttype('application/json');
        }, array('get', 'post'), true, [], self::scope());



        BasicRoute::add('/pwgen/import', function ($matches) {
            $db = App::get('session')->getDB();
            $tablename = $matches['tablename'];
            $current_filename = '';
            $current_md5 = '';
            $dfiles = [];
            App::contenttype('application/json');
            try {



                $success = false;
                if (!function_exists("error2txt")) {
                    function error2txt($error) {}
                }
                $error = "";
                if (isset($_FILES['userfile'])) {
                    $sfile = $_FILES['userfile']['tmp_name'];
                    $name = $_FILES['userfile']['name'];
                    $extension = pathinfo($name, PATHINFO_EXTENSION);
                    $type = $_FILES['userfile']['type'];
                    $error = $_FILES['userfile']['error'];

                    switch ($error) {
                        case UPLOAD_ERR_INI_SIZE:
                            throw new \Exception("UPLOAD_ERR_INI_SIZE: Die Datei ist zu groß");
                            break;
                        case UPLOAD_ERR_FORM_SIZE:
                            throw new \Exception("UPLOAD_ERR_FORM_SIZE: Die Datei ist zu groß");
                            break;
                        case UPLOAD_ERR_PARTIAL:
                            throw new \Exception("UPLOAD_ERR_PARTIAL: Die Datei wurde nur teilweise hochgeladen");
                            break;
                        case UPLOAD_ERR_NO_FILE:
                            throw new \Exception("UPLOAD_ERR_NO_FILE: Es wurde keine Datei hochgeladen");
                            break;
                    }

                    if ($error == UPLOAD_ERR_OK) {

                        $extension = pathinfo($name, PATHINFO_EXTENSION);
                        $localfname = $db->singleValue('select uuid() u', [], 'u') . '.' . $extension;
                        $fulllocalfname = App::get('tempPath') . '/' . $localfname;

                        if (file_exists($fulllocalfname)) unlink($fulllocalfname);
                        move_uploaded_file($sfile, $fulllocalfname);

                        $spreadsheet = \PhpOffice\PhpSpreadsheet\IOFactory::load($fulllocalfname);
                        $sheets = $spreadsheet->getSheetNames();
                        if (count($sheets) == 0) throw new \Exception("No Sheets readed");
                        $index = 0;
                        foreach ($sheets as $sheetName) {
                            $sheet = $spreadsheet->getSheet($index);
                            $count = $sheet->getHighestDataRow();
                            $columnCount = $sheet->getHighestColumn();
                            $header = $sheet->rangeToArray(
                                'A1:' . $columnCount . '1',     // The worksheet range that we want to retrieve
                                NULL,        // Value that should be returned for empty cells
                                TRUE,        // Should formulas be calculated (the equivalent of getCalculatedValue() for each cell)
                                TRUE,        // Should values be formatted (the equivalent of getFormattedValue() for each cell)
                                TRUE         // Should the array be indexed by cell row and cell column
                            );

                            $lcolumns = json_decode(json_encode($columns), true);
                            $index = 0;
                            foreach ($lcolumns as &$column) {
                                foreach ($header[1] as $c => $v) {
                                    if ($column['label'] == $v) {
                                        $column['excel'] = $c;
                                        $column['excelindex'] = \PhpOffice\PhpSpreadsheet\Cell\Coordinate::columnIndexFromString($c) - 1;
                                    }
                                }
                            }


                            $data = $sheet->rangeToArray(
                                'A2' . ':' . $columnCount . ($count),     // The worksheet range that we want to retrieve
                                NULL,        // Value that should be returned for empty cells
                                TRUE,        // Should formulas be calculated (the equivalent of getCalculatedValue() for each cell)
                                TRUE,        // Should values be formatted (the equivalent of getFormattedValue() for each cell)
                                FALSE         // Should the array be indexed by cell row and cell column
                            );

                            $db->commit(false);
                            foreach ($data as $row) {
                                $updateOnDuplicate = true;
                                $dataset = [];
                                $dataset[$tablename . '__filename'] = $fname;
                                foreach ($lcolumns as $col) {
                                    if (isset($col['excelindex'])) {
                                        if (!is_null($row[$col['excelindex']])) {
                                            $dataset[$tablename . '__' . $col['column_name']] = $row[$col['excelindex']];
                                        }
                                    }
                                }
                                $dataset['__table_name'] = $tablename;
                                $db->execute('set @ds_insert_update_on_duplicate_key=true;');
                                $sql = $db->singleValue('select ds_insert({record}) x', ['record' => json_encode(['data' => $dataset])], 'x');
                                $db->execute($sql);
                            }
                        }
                    }
                }



                App::result('success', true);
                $db->commit(true);
            } catch (\Exception $e) {
                App::result('last_sql', $db->last_sql . '*');
                $db->rollback();

                App::result('current_filename', $current_filename);
                App::result('msg', $e->getMessage());
            }
            App::result('debug_files', $dfiles);
        }, array('get', 'post'), true, [], self::scope());
    }
}
