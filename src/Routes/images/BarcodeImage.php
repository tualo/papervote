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
use Picqer\Barcode\BarcodeGeneratorPNG;
use Tualo\Office\PUG\Barcode;

use Ramsey\Uuid\Uuid;

class BarcodeImages implements IRoute
{

    public static function register()
    {
        BasicRoute::add('/papervote/images/createbarcodeimages', function () {
            $db = App::get('session')->getDB();
            try {

                $sql = 'select ridx id,barcode,concat("barcode_",barcode,".png") name from kandidaten ';
                $list = $db->direct($sql,[],'');
                foreach($list as $item){
                    list($type,$data) = explode(',',Barcode::get('i25',$item['barcode']));
                    $sql = 'insert ignore into kandidaten_bilder (id,
                    kandidat,
                    typ,
                    file_id) values (uuid(),{id},0,uuid())';
                    $db->direct($sql,['id'=>$item['id']],'');
                    $r = $db->singleRow('select file_id from kandidaten_bilder where kandidat={id} and typ=0',['id'=>$item['id']]);

                    $sql = '
                    insert into ds_files (
                        file_id,
                        name,
                        path,
                        size,
                        mtime,
                        ctime,
                        type,
                        hash,
                        login,
                        table_name
                    ) values (
                        {file_id},
                        {name},
                        {path},
                        {size},
                        now(),
                        now(),
                        {type},
                        {hash},
                        getSessionUser(),
                        {table_name}
                    )
                    on duplicate key update
                        name={name},
                        path={path},
                        size={size},
                        mtime=now(),
                        ctime=now(),
                        type={type},
                        hash={hash},
                        login=getSessionUser(),
                        table_name={table_name}
                    ';
                    $db->direct($sql,[
                        'file_id'=>$r['file_id'],
                        'name'=>$item['name'],
                        'path'=>'/kandidaten',
                        'size'=>strlen(base64_decode($data)),
                        'type'=>$type,
                        'hash'=>md5($data),
                        'table_name'=>'kandidaten_bilder'
                    ],'');
                    $sql = 'replace into ds_files_data (file_id,data) values ({file_id},{data})';
                    $db->direct($sql,[
                        'file_id'=>$r['file_id'],
                        'data'=>$type.','.$data
                    ],'');
                }
                
                 
                App::result('success', true);

            } catch (Exception $e) {
                App::result('msg', $e->getMessage());
            }
            App::contenttype('application/json');
        }, array('get', 'post'), true);
    }
}
