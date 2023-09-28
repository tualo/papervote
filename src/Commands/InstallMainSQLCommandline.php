<?php
namespace Tualo\Office\PaperVote\Commands;
use Garden\Cli\Cli;
use Garden\Cli\Args;
use phpseclib3\Math\BigInteger\Engines\PHP;
use Tualo\Office\Basic\ICommandline;
use Tualo\Office\ExtJSCompiler\Helper;
use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\Basic\PostCheck;

class InstallMainSQLCommandline implements ICommandline{

    public static function getCommandName():string { return 'install-sql-papervote';}

    public static function setup(Cli $cli){
        $cli->command(self::getCommandName())
            ->description('installs needed sql procedures for papervote module')
            ->opt('client', 'only use this client', false, 'string');
            
    }

   
    public static function setupClients(string $msg,string $clientName,string $file,callable $callback){
        $_SERVER['REQUEST_URI']='';
        $_SERVER['REQUEST_METHOD']='none';
        App::run();

        $session = App::get('session');
        $sessiondb = $session->db;
        $dbs = $sessiondb->direct('select username dbuser, password dbpass, id dbname, host dbhost, port dbport from macc_clients ');
        foreach($dbs as $db){
            if (($clientName!='') && ($clientName!=$db['dbname'])){ 
                continue;
            }else{
                App::set('clientDB',$session->newDBByRow($db));
                PostCheck::formatPrint(['blue'],$msg.'('.$db['dbname'].'):  ');
                $callback($file);
                PostCheck::formatPrintLn(['green'],"\t".' done');

            }
        }
    }

    public static function run(Args $args){

        $files = [
            'base.tanboegen' => 'setup tanboegen ddl ',
            'base.ddl' => 'setup base ddl ',
            'base.view' => 'setup base view ',
            'ds.base' => 'setup base ds definition ',
            'trigger.wahlberechtigte.anlage' => 'setup trigger wahlberechtigte anlage',

            'counting.ddl' => 'setup counting base ddl',

            'onlinestimmzettel' => 'setup onlinestimmzettel',
            'onlinestimmzettel.ds' => 'setup onlinestimmzettel.ds',

            'onlinekandidaten' => 'setup onlinekandidaten',
            'onlinekandidaten.ds' => 'setup onlinekandidaten.ds',

            'ruecklauffelder' => 'setup ruecklauffelder',
            'ruecklauffelder.ds' => 'setup ruecklauffelder.ds',

            'wahlscheinstatus_grund' => 'setup wahlscheinstatus_grund',
            'wahlscheinstatus_grund.ds' => 'setup wahlscheinstatus_grund.ds',

            'wzbruecklauffelder' => 'setup wzbruecklauffelder',
            'wzbruecklauffelder.ds' => 'setup wzbruecklauffelder.ds',

            'wahlbeteiligung_bericht'=> 'setup wahlbeteiligung_bericht',
            'wahlbeteiligung_bericht.ds'=> 'setup wahlbeteiligung_bericht.ds',

            'wahlbeteiligung_bericht_status'=> 'setup wahlbeteiligung_bericht_status',
            'wahlbeteiligung_bericht_status.ds'=> 'setup wahlbeteiligung_bericht_status.ds',
            
            'wahlbeteiligung_bericht_formel'=> 'setup wahlbeteiligung_bericht_formel',
            'wahlbeteiligung_bericht_formel.ds'=> 'setup wahlbeteiligung_bericht_formel.ds',

            'wahlbeteiligung_bericht_formel_nenner'=> 'setup wahlbeteiligung_bericht_formel_nenner',
            'wahlbeteiligung_bericht_formel_nenner.ds'=> 'setup wahlbeteiligung_bericht_formel_nenner.ds',

            'wahlbeteiligung_bericht_formel_teiler'=> 'setup wahlbeteiligung_bericht_formel_teiler',
            'wahlbeteiligung_bericht_formel_teiler.ds'=> 'setup wahlbeteiligung_bericht_formel_teiler.ds',

            'ohne_wahlberechtigten'=> 'setup ohne_wahlberechtigten',
            'ohne_wahlberechtigten.ds'=> 'setup ohne_wahlberechtigten.ds',

            'view_stimmenanzahl_ranking_los_monitor_list' => 'setup monitor list',
            'view_stimmenanzahl_ranking_los_monitor_list.ds' => 'setup monitor list ds',
            'view_stimmenanzahl_ranking_los_monitor' => 'setup monitor',
            'view_stimmenanzahl_ranking_los_monitor.ds' => 'setup monitor ds',
            'view_gezaehlte_stimmzettel' => 'setup stimmzettel view'
        ];


        foreach($files as $file=>$msg){
            $installSQL = function(string $file){

                $filename = dirname(__DIR__).'/sql/install/'.$file.'.sql';
                $sql = file_get_contents($filename);
                $sql = preg_replace('!/\*.*?\*/!s', '', $sql);
                $sql = preg_replace('#^\s*\-\-.+$#m', '', $sql);

                $sinlgeStatements = App::get('clientDB')->explode_by_delimiter($sql);
                foreach($sinlgeStatements as $commandIndex => $statement){
                    try{
                        App::get('clientDB')->direct($statement);
                        App::get('clientDB')->moreResults();
                    }catch(\Exception $e){
                        echo PHP_EOL;
                        PostCheck::formatPrintLn(['red'], $e->getMessage().': commandIndex => '.$commandIndex);
                    }
                }
            };
            $clientName = $args->getOpt('client');
            if( is_null($clientName) ) $clientName = '';
            self::setupClients($msg,$clientName,$file,$installSQL);
        }


    }
}
