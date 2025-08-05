<?php

namespace Tualo\Office\PaperVote\Commands;

use Garden\Cli\Cli;
use Garden\Cli\Args;
use phpseclib3\Math\BigInteger\Engines\PHP;
use Tualo\Office\Basic\ICommandline;
use Tualo\Office\ExtJSCompiler\Helper;
use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\Basic\PostCheck;
use Tualo\Office\Basic\CommandLineInstallSQL;


class InstallDS extends CommandLineInstallSQL  implements ICommandline
{
    public static function getDir(): string
    {
        return dirname(__DIR__, 1);
    }
    public static $shortName  = 'papervote-ds';
    public static $files = [

        'install/ds/ds_class'                               => 'setup ds_class',
        'install/ds/votemanager_setup.ds'                   => 'setup votemanager_setup.ds',

        'install/ds/reportfiles_typen.ds'                   => 'setup reportfiles_typen.ds',
        'install/ds/reportfiles.ds'                         => 'setup reportfiles.ds',

        'install/ds/ballotbox_decrypted_sum.ds'                        => 'setup ballotbox_decrypted_sum.ds',





    ];
}
