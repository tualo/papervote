<?php

namespace Tualo\Office\PaperVote\Routes\export;

use Exception;
use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\Basic\Route as BasicRoute;
use Tualo\Office\Basic\IRoute;
use Tualo\Office\TualoPGP\TualoApplicationPGP;
use phpseclib\Net\SFTP;
use \PhpOffice\PhpSpreadsheet\Spreadsheet;
use \PhpOffice\PhpSpreadsheet\IOFactory;
use Picqer\Barcode\BarcodeGeneratorPNG;
use Tualo\Office\PUG\Barcode;

use Ramsey\Uuid\Uuid;
use \ZipArchive;

use Tualo\Office\DS\DSReadRoute;
use Tualo\Office\DS\DSExporterHelper;

use Tualo\Office\DS\DSTable;

use Tualo\Office\DS\DataRenderer;


class AllData extends \Tualo\Office\Basic\RouteWrapper
{
    public static function scope(): string
    {
        return 'papervote.candidates.export';
    }
    public static function register()
    {
        BasicRoute::add('/papervote/export/all', function () {
            $db = App::get('session')->getDB();
            try {

                set_time_limit(3000);
                ini_set('memory_limit', '8G');

                $db->direct('SET SESSION group_concat_max_len = 4294967295;');
                $temporary_folder = App::get("tempPath") . '/';
                if (isset($_REQUEST['usename']) && is_string($_REQUEST['usename']) && (strlen($_REQUEST['usename']) > 0)) {
                    $fname = basename($_REQUEST['usename']);
                    $fname = preg_replace('/[^0-9a-zA-Z]/', '', $fname);
                } else {
                    $fname = '';
                }

                $zip = new ZipArchive;
                $zipName = $temporary_folder . '/' . Uuid::uuid4()->toString() . '.zip';
                if ($zip->open($zipName, ZipArchive::CREATE | ZipArchive::OVERWRITE) !== TRUE) throw new \Exception('Could not create zip file');

                $tablename = 'kandidaten';

                $_REQUEST['start'] = 0;
                $_REQUEST['limit'] = 1650000;
                $hcolumns = DSExporterHelper::getExportColumns($db, $tablename);

                $read = DSReadRoute::read($db, $tablename, $_REQUEST);
                DSExporterHelper::exportDataToXSLX($db, $tablename, $hcolumns, $read['data'], $temporary_folder, $fname, $hcolumns);

                $zip->addFile($temporary_folder . '/' . $fname, 'daten.xlsx');


                //$wm_image_export_template = DSTable::instance('votemanager_setup')->f('id', 'eq', 'wm_image_export_include_type')->getSingleValue('val');

                $sql = '
                select 
                    kandidaten.id,
                    kandidaten.vorname,
                    kandidaten.nachname,
                    if(kandidaten.barcode is null or trim(kandidaten.barcode) = "",lpad(kandidaten.id,8,"X") ,kandidaten.barcode) barcode,
                    kandidaten_bilder_typen.name typ_name,
                    SUBSTRING_INDEX(ds_files.name,".",-1) extension,
                    kandidaten_bilder_typen.export_name_template,
                    ds_files_data.data 
                from 
                    kandidaten
                    join kandidaten_bilder
                        on kandidaten.id = kandidaten_bilder.kandidat
                    join kandidaten_bilder_typen
                        on kandidaten_bilder.typ = kandidaten_bilder_typen.id
                        and kandidaten_bilder_typen.include_in_export = 1
                    join ds_files
                        on ds_files.file_id = kandidaten_bilder.file_id 
                    join ds_files_data
                        on kandidaten_bilder.file_id = ds_files_data.file_id
                ';
                $list = $db->direct($sql, [], '');
                foreach ($list as $item) {
                    list($type, $data) = explode(',', $item['data']);
                    $type = $item['typ_name'];
                    $barcode = $item['barcode'];
                    $fname = $type . '_' . $barcode . '.' . $item['extension'];

                    // <NACHNAME:ASCII>_<VORNAME:ASCII>_<KANDIDATEN_ID>
                    // "{nachname:ansii}_{vorname:ansii}_{id}"

                    $fname = DataRenderer::renderTemplate($item['export_name_template'], $item) . '.' . $item['extension'];


                    $fpath = App::get("tempPath") . '/' . $fname;
                    file_put_contents($fpath, base64_decode($data));
                    $zip->addFile(App::get("tempPath") . '/' . $fname, basename(App::get("tempPath") . '/' . $fname));
                }

                $zip->close();

                App::result('success', true);
                App::result('file', basename($zipName));
            } catch (Exception $e) {
                App::result('msg', $e->getMessage());
            }
            App::contenttype('application/json');
        }, array('get', 'post'), true, [], self::scope());
    }
}
