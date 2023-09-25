<?php
namespace Tualo\Office\Papervote;
use Garden\Cli\Cli;
use Garden\Cli\Args;
use phpseclib3\Math\BigInteger\Engines\PHP;
use Tualo\Office\Basic\ICommandline;
use Tualo\Office\ExtJSCompiler\Helper;
use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\Basic\PostCheck;

class InstallMenuSQLCommandline implements ICommandline{

    public static function getCommandName():string { return 'install-sql-papervote-menu';}

    public static function setup(Cli $cli){
        $cli->command(self::getCommandName())
            ->description('installs needed menu items ')
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
            'menu.base' => 'setup menu base '
        ];

        foreach($files as $file=>$msg){
            $installSQL = function(string $file){

                $filename = __DIR__.'/sql/'.$file.'.sql';


                exec('cat '.$filename.' | sed -E \'s#SESSIONDB#'.App::get('session')->db->dbname.'#g\' | sed -E \'s#DBNAME#'.App::get('clientDB')->dbname.'#g\' | mysql --force=true -D '.App::get('clientDB')->dbname.' ',$res,$err);
                
                if ($err!=0){
                    PostCheck::formatPrintLn(['red'],'failed');
                    PostCheck::formatPrintLn(['red'],implode("\n",$res));
                    exit();
                }else{
                    PostCheck::formatPrintLn(['green'],'done');
                }
            };
            $clientName = $args->getOpt('client');
            if( is_null($clientName) ) $clientName = '';
            self::setupClients($msg,$clientName,$file,$installSQL);
        }



    }
}
