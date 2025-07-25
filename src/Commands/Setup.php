<?php
namespace Tualo\Office\PaperVote\Commands;
use Garden\Cli\Cli;
use Garden\Cli\Args;
use phpseclib3\Math\BigInteger\Engines\PHP;
use Tualo\Office\Basic\ISetupCommandline;
use Tualo\Office\ExtJSCompiler\Helper;
use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\Basic\PostCheck;
use Tualo\Office\Basic\CommandLineInstallSessionSQL;
use Tualo\Office\Basic\BaseSetupCommand as BaseSetup;

class Setup extends BaseSetup implements ISetupCommandline{

    public static function getCommandName(): string { return 'papervote'; }
    public static function getCommandDescription(): string { return 'perform a complete papervote setup'; }
    public static function setup(Cli $cli){
        $cli->command(self::getCommandName())
            ->description(self::getCommandDescription())
            ->opt('client', 'only use this client', true, 'string');
    }
    public static function run(Args $args) { 
        $clientName = $args->getOpt('client');
        if( is_null($clientName) ) $clientName = '';
        
        PostCheck::formatPrintLn(['blue'], "Installing complete setup for papervote module");
        PostCheck::formatPrintLn(['blue'], "==========================================================");

        $installCommands = [
            'install-sessionsql-bsc-main',
            'install-sql-sessionviews',
            'install-sql-bsc-main-ds',
            'install-sql-bsc-menu',
            'install-sql-ds-main',
            'install-sql-ds',
            'install-sql-ds-dsx',
            'install-sql-ds-privacy',
            'install-sql-ds-docsystem',
            'install-sql-tualojs',
            'install-sql-monaco',
            'install-sql-dashboard',
            'install-sql-bootstrap',
            'install-sql-papervote-menu',
            'install-sql-papervote-ddl',
            'install-sql-papervote-report-ddl',
            'install-sql-papervote-ds',
            // 'compile'
        ];
 
        foreach($installCommands as $cmdString){
            self::performInstall($cmdString,$clientName);
        }

    }
}
