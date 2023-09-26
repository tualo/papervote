<?php

namespace Tualo\Office\PaperVote\Routes\wbimport;

use Exception;
use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\Basic\Route as BasicRoute;
use Tualo\Office\Basic\IRoute;
use Tualo\Office\TualoPGP\TualoApplicationPGP;
use phpseclib\Net\SFTP;
use \PhpOffice\PhpSpreadsheet\Spreadsheet;
use \PhpOffice\PhpSpreadsheet\IOFactory;

use Ramsey\Uuid\Uuid;

class Upload implements IRoute
{

    public static function register()
    {
        BasicRoute::add('/papervote/wahlberechtigte/upload', function () {
            $db = App::get('session')->getDB();
            try {

                $success = false;
                if (!function_exists("error2txt")) {
                    function error2txt($error)
                    {
                        switch ($error) {
                            case UPLOAD_ERR_INI_SIZE:
                                return "UPLOAD_ERR_INI_SIZE: Die Datei ist zu gro&szlig";
                                break;
                            case UPLOAD_ERR_FORM_SIZE:
                                return "UPLOAD_ERR_FORM_SIZE: Die Datei ist zu gro&szlig";
                                break;
                            case UPLOAD_ERR_PARTIAL:
                                return "UPLOAD_ERR_PARTIAL: Die Datei wurde nur teilweise hochgeladen";
                                break;
                            case UPLOAD_ERR_NO_FILE:
                                return "UPLOAD_ERR_NO_FILE: Es wurde keine Datei hochgeladen";
                                break;
                            case 0:
                                return " ";
                                break;
                            default:
                                return "Unbekannter Fehler";
                                break;
                        }
                    }
                }
                $error = "";
                if (isset($_FILES['userfile'])) {
                    $sfile = $_FILES['userfile']['tmp_name'];
                    $name = $_FILES['userfile']['name'];
                    $extension = pathinfo($name, PATHINFO_EXTENSION);
                    $type = $_FILES['userfile']['type'];
                    $error = $_FILES['userfile']['error'];
                    if ($error == UPLOAD_ERR_OK) {
                        if (file_exists(App::get('tempPath') . '/.ht_wahlberechtigte_daten.' . $extension)) {
                            unlink(App::get('tempPath') . '/.ht_wahlberechtigte_daten.' . $extension);
                        }
                        move_uploaded_file($sfile, App::get('tempPath') . '/.ht_wahlberechtigte_daten.' . $extension);

                        @session_start();
                        $_SESSION['wahlberechtigte_file'] = App::get('tempPath') . '/.ht_wahlberechtigte_daten.' . $extension;
                        $spreadsheet = IOFactory::load($_SESSION['wahlberechtigte_file']);
                        $sheets = $spreadsheet->getSheetNames();
                        $index = 0;
                        foreach ($sheets as $sheetName) {

                            $result['data'][] = array(
                                'id' => $index,
                                'name' => $sheetName
                            );
                            $index++;
                        }
                        App::result('data', $result['data']);
                        session_commit();

                        $success = true;
                    }
                }
                App::result('success', $success);
                App::result('msg', error2txt($error));
            } catch (Exception $e) {
                App::result('msg', $e->getMessage());
            }
            App::contenttype('application/json');
        }, array('get', 'post'), true);
    }
}
