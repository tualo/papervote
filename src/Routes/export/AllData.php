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


class AllData implements IRoute
{

    public static function register()
    {
        BasicRoute::add('/papervote/export/all', function () {
            $db = App::get('session')->getDB();
            try {

                set_time_limit(3000);
                ini_set('memory_limit','8G');
                
                $db->direct('SET SESSION group_concat_max_len = 4294967295;');
                $temporary_folder = App::get("tempPath") . '/';
                if (isset($_REQUEST['usename'])&&(strlen($_REQUEST['usename'])>0)){
                    $fname = basename($_REQUEST['usename']);
                }else{
                    $fname = '';
                }

                $zip = new ZipArchive;
                $zipName = $temporary_folder.'/'.Uuid::uuid4()->toString().'.zip';
                if ($zip->open($zipName,ZipArchive::CREATE | ZipArchive::OVERWRITE) !== TRUE) throw new \Exception('Could not create zip file');

                $tablename = 'kandidaten';

                $_REQUEST['start'] = 0;
                $_REQUEST['limit'] = 1650000;
                $hcolumns = DSExporterHelper::getExportColumns($db,$tablename);
                
                $read = DSReadRoute::read($db,$tablename,$_REQUEST);
                DSExporterHelper::exportDataToXSLX($db,$tablename,$hcolumns,$read['data'],$temporary_folder,$fname,$hcolumns);

                $zip->addFile($temporary_folder.'/'.$fname, 'daten.xlsx');



                $sql = '
                select 
                    kandidaten.ridx,
                    if(kandidaten.barcode is null or trim(kandidaten.barcode) = "",lpad(kandidaten.id,8,"X") ,kandidaten.barcode) barcode,
                    kandidaten_bilder_typen.name typ_name,
                    SUBSTRING_INDEX(ds_files.name,".",-1) extension,
                    ds_files_data.data 
                from 
                    kandidaten
                    join kandidaten_bilder
                        on kandidaten.ridx = kandidaten_bilder.kandidat
                    join kandidaten_bilder_typen
                        on kandidaten_bilder.typ = kandidaten_bilder_typen.id
                    join ds_files
                        on ds_files.file_id = kandidaten_bilder.file_id 
                    join ds_files_data
                        on kandidaten_bilder.file_id = ds_files_data.file_id
                ';
                $list = $db->direct($sql,[],'');
                foreach($list as $item){
                    list($type,$data) = explode(',',$item['data']);
                    $type = $item['typ_name'];
                    $barcode = $item['barcode'];
                    $fname = $type.'_'.$barcode.'.'.$item['extension'];
                    $fpath = App::get("tempPath") . '/'.$fname;
                    file_put_contents($fpath,base64_decode($data));
                    $zip->addFile( App::get("tempPath") . '/'.$fname, basename( App::get("tempPath") . '/'.$fname ));

                }

                $zip->close();

                App::result('success', true);
                App::result('file', basename($zipName));
                


            } catch (Exception $e) {
                App::result('msg', $e->getMessage());
            }
            App::contenttype('application/json');
        }, array('get', 'post'), true);
    }
}
