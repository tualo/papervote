<?php
namespace Tualo\Office\PaperVote\Commands;
use Tualo\Office\Basic\ICommandline;
use Tualo\Office\Basic\CommandLineInstallSQL;


class InstallReportDDL extends CommandLineInstallSQL  implements ICommandline{
    public static function getDir():string {   return dirname(__DIR__,1); }
    public static $shortName  = 'papervote-report-ddl';
    public static $files = [

        'install/report-ddl/wahlbeteiligung_bericht'                       => 'setup wahlbeteiligung_bericht',
        'install/report-ddl/wahlbeteiligung_bericht.data'                  => 'setup wahlbeteiligung_bericht.data',
        
        'install/report-ddl/wahlbeteiligung_bericht_status'                => 'setup wahlbeteiligung_bericht_status',
        'install/report-ddl/wahlbeteiligung_bericht_status.data'          => 'setup wahlbeteiligung_bericht_status.data'
        

    ];  
    
}
