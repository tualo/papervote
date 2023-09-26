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

class CreateColumns implements IRoute
{

    public static function register()
    {
        BasicRoute::add('/pwgen/createcolumns', function () {


            $db = App::get('session')->getDB();
            try {

                $list = json_decode($_REQUEST['data'], true);
                App::result('list', $list);
                foreach ($list as $item) {
                    if ($item['is_new'] == true) {
                        if ($item['fktable'] == true) {
                            $sql = 'create table if not exists `pwgen_import_column_fktablename` (
                                `id` MEDIUMINT NOT NULL AUTO_INCREMENT,
                                `name` varchar(255),
                                unique key `udix_pic_fktablename_name` (`name`),
                                primary key (`id`)
                            )';
                            $db->execute(str_replace('fktablename', $item['column_name'], $sql));
                            $sql = "call addFieldIfNotExists('pwgen_import',{column_name},'MEDIUMINT');";
                            $db->direct($sql, $item);

                            $sql = "call addForeignKeyIfNotExists ('pwgen_import','pwgen_import_column_fktablename','fk_pic_fktablename',{column_name},'id','cascade','set null');";
                            $sql = str_replace('fktablename', $item['column_name'], $sql);
                            $db->direct($sql, $item);
                            if (($item['data_type'] == 'varchar') || ($item['data_type'] == 's')) $item['data_type'] = 'varchar(255)';
                            if (($item['data_type'] == 'fixed')) $item['data_type'] = 'fixed(15,6)';
                        } else {
                            $sql = "call addFieldIfNotExists('pwgen_import',{column_name},{data_type});";
                            if (($item['data_type'] == 'varchar') || ($item['data_type'] == 's')) $item['data_type'] = 'varchar(255)';
                            if (($item['data_type'] == 'fixed')) $item['data_type'] = 'fixed(15,6)';
                            $db->direct($sql, $item);
                        }
                        App::result('citem', $item);

                        $sql="call addFieldIfNotExists('wahlberechtigte_anlage','" . $item['column_name'] . "','" . $item['data_type'] . "')";
                        $db->direct($sql, $item);
                    }


                    /*
            $sql1 = '="insert into wahlberechtigte_anlage (';
            $sql2 = '="(';
            foreach($list as $item){
                $sql1 .= "`".$item['column_name']."`,";
                $sql2 .= '\'"& wechseln(wechseln($'.$item['excel_column'].'2;";";" ");"\'";" ") &"\',';
            }
            $sql1 .= ') values "';
            $sql2 .= ');"';
            echo  $sql1.PHP_EOL;
            echo  $sql2.PHP_EOL;
            */
                }

                //$db->direct("call UPDATE_DS_SETUP()");

                App::result('success', true);
            } catch (Exception $e) {
                App::result('sql', $db->last_sql);
                App::result('msg', $e->getMessage());
            }
            App::contenttype('application/json');
        }, ['get', 'post'], true);
    }
}
