<?php

namespace Tualo\Office\PaperVote\Commands;

use Tualo\Office\Basic\ICommandline;
use Tualo\Office\Basic\CommandLineInstallSQL;


class InstallReportDDL extends CommandLineInstallSQL  implements ICommandline
{
    public static function getDir(): string
    {
        return dirname(__DIR__, 1);
    }
    public static $shortName  = 'papervote-report-ddl';
    public static $files = [

        'install/report-ddl/wahlbeteiligung_bericht'                       => 'setup wahlbeteiligung_bericht',
        'install/report-ddl/wahlbeteiligung_bericht.data'                  => 'setup wahlbeteiligung_bericht.data',

        'install/report-ddl/wahlbeteiligung_bericht_status'                => 'setup wahlbeteiligung_bericht_status',
        'install/report-ddl/wahlbeteiligung_bericht_status.data'          => 'setup wahlbeteiligung_bericht_status.data',

        'install/report-ddl/wahlbeteiligung_bericht.ds'                       => 'setup wahlbeteiligung_bericht.ds',
        'install/report-ddl/wahlbeteiligung_bericht_status.ds'                       => 'setup wahlbeteiligung_bericht_status.ds',

        'install/report-ddl/view_ohne_wahlberechtigten'                    => 'setup view_ohne_wahlberechtigten',
        'install/report-ddl/view_ohne_wahlberechtigten.ds'               => 'setup view_ohne_wahlberechtigten.ds',


        'install/report-ddl/wahlbeteiligung_bericht_formel'                => 'setup wahlbeteiligung_bericht_formel',
        //        'install/report-ddl/wahlbeteiligung_bericht_formel.data'           => 'setup wahlbeteiligung_bericht_formel.data',
        'install/report-ddl/wahlbeteiligung_bericht_formel.ds'             => 'setup wahlbeteiligung_bericht_formel.ds',

        'install/report-ddl/wahlbeteiligung_bericht_formel_nenner'                => 'setup wahlbeteiligung_bericht_formel_nenner',
        //        'install/report-ddl/wahlbeteiligung_bericht_formel_nenner.data'           => 'setup wahlbeteiligung_bericht_formel_nenner.data',
        'install/report-ddl/wahlbeteiligung_bericht_formel_nenner.ds'             => 'setup wahlbeteiligung_bericht_formel_nenner.ds',

        'install/report-ddl/wahlbeteiligung_bericht_formel_teiler'                => 'setup wahlbeteiligung_bericht_formel_teilerr',
        //        'install/report-ddl/wahlbeteiligung_bericht_formel_teiler.data'           => 'setup wahlbeteiligung_bericht_formel_teiler.data',
        'install/report-ddl/wahlbeteiligung_bericht_formel_teiler.ds'             => 'setup wahlbeteiligung_bericht_formel_teiler.ds',
    ];
}
