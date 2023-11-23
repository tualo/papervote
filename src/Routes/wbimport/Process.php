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

class Process implements IRoute
{

    public static function register()
    {
        BasicRoute::add('/papervote/wahlberechtigte/process', function () {
            $db = App::get('session')->getDB();
            try{
                @session_start();
                $db->direct('set session innodb_strict_mode=0');
                        
                $spreadsheet = IOFactory::load($_SESSION['wahlberechtigte_file']);
                $sheet = $spreadsheet->getSheet($_REQUEST['sheetname']);
        
                $count          =   $sheet->getHighestDataRow();
                $columnCount    =   $sheet->getHighestColumn();
        
                $header=$sheet->rangeToArray(
                    'A1:'.$columnCount.'1',     // The worksheet range that we want to retrieve
                    NULL,        // Value that should be returned for empty cells
                    TRUE,        // Should formulas be calculated (the equivalent of getCalculatedValue() for each cell)
                    TRUE,        // Should values be formatted (the equivalent of getFormattedValue() for each cell)
                    TRUE         // Should the array be indexed by cell row and cell column
                );
        
                $coulumndata = $db->direct('explain wahlberechtigte_anlage',[],'');
        
                $data = $sheet->rangeToArray(
                    'A2:'.$columnCount.''.$count,     // The worksheet range that we want to retrieve
                    NULL,        // Value that should be returned for empty cells
                    FALSE,        // Should formulas be calculated (the equivalent of getCalculatedValue() for each cell)
                    FALSE,        // Should values be formatted (the equivalent of getFormattedValue() for each cell)
                    FALSE         // Should the array be indexed by cell row and cell column
                );
        
                $newfields = [];
                $allfields = [];
                $headerLabels = [];
                foreach($header[1] as $index=>$val){
                    $isnew = true;
                    $cname = strtolower( preg_replace('/[[:^ascii:]]|\s/', '_', $val) );
        
                    foreach($coulumndata as $col){
                        if (strtolower($col['field'])==$cname){
                            $isnew = false;
                        }
                    }
                    if ($isnew==true){
                        $newfields[] = $cname;
                    }
                    $headerLabels[] = [
                        'column_name'=>$cname,
                        'label'=>$val
                    ];
                    $allfields[] = $cname;
                }
        
                foreach($newfields as $fld){
                    $db->direct('alter table wahlberechtigte_anlage add `'.$fld.'` varchar(50) default null');
                }
        
                $range = range(0,count($allfields)-1);
                $sqls = 'insert ignore into wahlberechtigte_anlage (`'.implode('`,`',$allfields).'`) values ';
        
                $vals = '({'.implode('},{',$range).'}) ';
                
                $send = [];
                foreach( $data as $row){
                    if (count($send)==10){
                        $sql = $sqls.implode(',',$send);
                        $db->direct($sql);
                        $send = [];
                    }
                    $send[] = $db->replace_hash($vals,$row);
                }
        
                if (count($send)>0){
                    $sql = $sqls.implode(',',$send);
                    $db->direct($sql);
                    $send = [];
                }
        
        
                $sql='create or replace view wahlschein_flatfile as
                select
                    wahlberechtigte_anlage.*,
                    wahlschein.wahlscheinnummer wahlschein_wahlscheinnummer,
                    wahlschein.insert_date wahlschein_insert_date,
                    wahlschein.update_date wahlschein_update_date,
                    wahlscheinstatus.name status_text,
                    if(wahlschein.abgabetyp=\'2|0\',\'Onlinewahl\',\'Briefwahl\') abgabetyp_text,
                    stimmzettel.name stimmzettel_name
                from
                    wahlschein
                    join wahlberechtigte 
                    on wahlschein.wahlberechtigte = wahlberechtigte.ridx
                    join wahlberechtigte_anlage
                    on wahlberechtigte.identnummer = wahlberechtigte_anlage.identnummer
                    join wahlscheinstatus
                    on wahlscheinstatus.ridx = wahlschein.wahlscheinstatus
                    join stimmzettel
                    on stimmzettel.ridx = wahlschein.stimmzettel
                ';
                $db->execute($sql);
        
                $wahlberechtigte_anlage=[];
                
                $exclude =[ 'id','password','username','wahlscheinnummer','pwhash','wahlscheinstatus','password'];
                foreach($allfields as $c){
                    if (!in_array($c,$exclude)){
                        $wahlberechtigte_anlage[]='`wahlberechtigte_anlage`.`'.$c.'`';
                    }
                }
                
                $sql='CREATE OR REPLACE VIEW `view_pwgen_wahlberechtigte_anlage` AS 
                select 
                    '. implode(',',$wahlberechtigte_anlage).',

                    `wahlschein`.`id`,
                    `wahlschein`.`username`,
                    `wahlschein`.`wahlscheinnummer`,
                    `wahlschein`.`wahlscheinstatus`,
                    `wahlschein`.`pwhash`,
                    "" `password`
                from 
                (
                    `wahlberechtigte_anlage`
                      join `wahlberechtigte`
                          on `wahlberechtigte`.`identnummer` = `wahlberechtigte_anlage`.`identnummer`
                    join `wahlschein` on(
                        `wahlberechtigte`.`ridx` = `wahlschein`.`wahlberechtigte`
                        and `wahlschein`.`wahlscheinstatus` in ("16|0", "17|0")
                        and wahlberechtigte_anlage.stimmzettel = `wahlschein`.stimmzettel
                    )
                )
                ';
                $db->execute($sql);
        
                App::result('pwgen_sql', $sql);
                App::result('header', $header);

                sleep(10);
                
                $db->direct('call rebuild_view_voters_by_username_api()');
                $db->moreResults();

                $db->direct('call fill_ds("view_pwgen_wahlberechtigte_anlage")');
                $db->moreResults();
                $db->direct('call fill_ds_column("view_pwgen_wahlberechtigte_anlage")');
                $db->moreResults();
        
                $g = glob(App::get('basePath').'/cache/'.$db->dbname.'*');
                foreach($g as $filename){
                    if (!is_dir($filename)) unlink($filename);
                }

                $db->direct('
                INSERT INTO
                    `ds` (
                        `table_name`,
                        `title`,
                        `reorderfield`,
                        `use_history`,
                        `searchfield`,
                        `displayfield`,
                        `sortfield`,
                        `searchany`,
                        `hint`,
                        `overview_tpl`,
                        `sync_table`,
                        `writetable`,
                        `globalsearch`,
                        `listselectionmodel`,
                        `sync_view`,
                        `syncable`,
                        `cssstyle`,
                        `alternativeformxtype`,
                        `read_table`,
                        `class_name`,
                        `special_add_panel`,
                        `existsreal`,
                        `character_set_name`,
                        `read_filter`,
                        `listxtypeprefix`,
                        `phpexporter`,
                        `phpexporterfilename`,
                        `combined`,
                        `default_pagesize`,
                        `allowForm`,
                        `listviewbaseclass`,
                        `showactionbtn`,
                        `modelbaseclass`
                    )
                VALUES
                    (
                        "view_pwgen_wahlberechtigte_anlage",
                        "PWGEN: Wahlberechtigte Anlage",
                        "",
                        0,
                        "identnummer",
                        "identnummer",
                        "identnummer",
                        1,
                        "",
                        "",
                        "",
                        "wahlschein",
                        0,
                        "rowmodel",
                        "",
                        0,
                        "",
                        "",
                        "",
                        "Wahlsystem",
                        "",
                        1,
                        "",
                        "",
                        "",
                        "XlsxWriter",
                        "view_pwgen_wahlberechtigte_anlage-{DATE}",
                        0,
                        1000000,
                        0,
                        "Tualo.DataSets.ListView",
                        1,
                        "Tualo.DataSets.model.Basic"
                    ) 
                ON DUPLICATE KEY UPDATE
                    `title`=VALUES(`title`),
                    `reorderfield`=VALUES(`reorderfield`),
                    `use_history`=VALUES(`use_history`),
                    `searchfield`=VALUES(`searchfield`),
                    `displayfield`=VALUES(`displayfield`),
                    `sortfield`=VALUES(`sortfield`),
                    `searchany`=VALUES(`searchany`),
                    `hint`=VALUES(`hint`),
                    `overview_tpl`=VALUES(`overview_tpl`),
                    `sync_table`=VALUES(`sync_table`),
                    `writetable`=VALUES(`writetable`),
                    `globalsearch`=VALUES(`globalsearch`),
                    `listselectionmodel`=VALUES(`listselectionmodel`),
                    `sync_view`=VALUES(`sync_view`),
                    `syncable`=VALUES(`syncable`),
                    `cssstyle`=VALUES(`cssstyle`),
                    `alternativeformxtype`=VALUES(`alternativeformxtype`),
                    `read_table`=   "view_pwgen_wahlberechtigte_anlage",
                    `class_name`=VALUES(`class_name`),
                    `special_add_panel`=VALUES(`special_add_panel`),
                    `existsreal`=VALUES(`existsreal`),
                    `character_set_name`=VALUES(`character_set_name`),
                    `read_filter`=VALUES(`read_filter`),
                    `listxtypeprefix`=VALUES(`listxtypeprefix`),
                    `phpexporter`=VALUES(`phpexporter`),
                    `phpexporterfilename`=VALUES(`phpexporterfilename`),
                    `combined`=VALUES(`combined`),
                    `default_pagesize`=VALUES(`default_pagesize`),
                    `allowForm`=VALUES(`allowForm`),
                    `listviewbaseclass`=VALUES(`listviewbaseclass`),
                    `showactionbtn`=VALUES(`showactionbtn`),
                    `modelbaseclass`=VALUES(`modelbaseclass`)
                ');

                $db->direct('
                    insert  into ds_column_list_label ( 
                        table_name,
                        column_name,
                        language,
                        label,
                        xtype,
                        editor,
                        position,
                        summaryrenderer,
                        summarytype,
                        hidden,
                        active,
                        renderer,
                        filterstore,
                        flex
                    ) 
                    select 
                
                        table_name,
                        column_name,
                        language,
                        label,
                        xtype,
                        editor,
                        position,
                        summaryrenderer,
                        summarytype,
                        0 hidden,
                        1 active,
                        renderer,
                        filterstore,
                        flex
                    from 
                        view_readtable_ds_column_list_label_all 
                    where 
                        table_name in ( "wahlberechtigte_anlage", "view_pwgen_wahlberechtigte_anlage" )
                    on duplicate key update active=values(active), hidden=values(hidden)
                ');
        
                
                $db->direct('INSERT IGNORE INTO `ds_listplugins` (`table_name`, `ptype`, `placement`) VALUES ("view_pwgen_wahlberechtigte_anlage","gridexporter","view");');
                
                $db->direct('update ds_column_form_label set active=1 where table_name="view_pwgen_wahlberechtigte_anlage"');
                $db->direct('INSERT IGNORE INTO `ds_addcommands` (`table_name`, `xtype`, `location`, `position`, `label`, `iconCls`) VALUES ("view_pwgen_wahlberechtigte_anlage","pwgen_pw_command","toolbar",1,"Passwortgenerator",NULL);');
                $db->direct('REPLACE INTO `ds_access` (`role`, `table_name`, `read`, `write`, `delete`, `append`, `existsreal`) VALUES ("wahl_administration","view_pwgen_wahlberechtigte_anlage",1,1,0,0,0);');

                $db->direct("call fill_ds('')");
                $db->moreResults();
                $db->direct('call create_or_upgrade_hstr_table("wahlschein")');
                $db->moreResults();
                
                    
                foreach($headerLabels as $headerLabelsRows){
                    $db->direct('update ds_column_list_label set label={label} where column_name={column_name} and table_name="view_pwgen_wahlberechtigte_anlage"',$headerLabelsRows);
                    $db->direct('update ds_column_list_label set label={label} where column_name={column_name} and table_name="wahlberechtigte_anlage"',$headerLabelsRows);
                }
                $db->direct("update ds_column set is_primary=0 where table_name='view_pwgen_wahlberechtigte_anlage'   ");
                $db->direct("update ds_column set is_primary=1 where table_name='view_pwgen_wahlberechtigte_anlage' and column_name in ('id','stimmzettel') ");


                $db->direct("call create_index(database(),'wahlschein_hstr','idx_wahlschein_hstr_username','username');");
                $db->moreResults();
                $db->direct("call create_index(database(),'wahlschein_hstr','idx_wahlschein_hstr_wahlscheinnummer','wahlscheinnummer');");
                $db->moreResults();


                /*
                drop trigger if exists wahlschein__ai;
                drop trigger if exists wahlschein__au;
                drop trigger if exists wahlschein__bd;

                ALTER TABLE wahlschein ADD COLUMN ts TIMESTAMP(6) GENERATED ALWAYS AS ROW START,
              ADD COLUMN te TIMESTAMP(6) GENERATED ALWAYS AS ROW END,
              ADD PERIOD FOR SYSTEM_TIME(ts, te),
              ADD SYSTEM VERSIONING;
                */
                App::result('success', true);
        
                App::result('newfields', $newfields);
                App::result('allfields', $allfields);
            
            }catch(Exception $e){
                App::result('msg', $e->getMessage());
            }
            App::contenttype('application/json');
        }, array('get', 'post'), true);
    }
}
