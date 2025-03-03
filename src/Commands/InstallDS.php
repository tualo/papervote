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


class InstallDS extends CommandLineInstallSQL  implements ICommandline{
    public static function getDir():string {   return dirname(__DIR__,1); }
    public static $shortName  = 'papervote-ds';
    public static $files = [

        'install/ds/ds_class'                               => 'setup ds_class',
        'install/ds/wahltyp.ds'                             => 'setup wahltyp.ds',
        'install/ds/abgabetyp.ds'                           => 'setup abgabetyp.ds',
        'install/ds/wahlscheinstatus.ds'                    => 'setup wahlscheinstatus.ds',
        'install/ds/wahlscheinstatus_grund.ds'              => 'setup wahlscheinstatus_grund.ds',
        'install/ds/wahlberechtigte_anlage.ds'              => 'setup wahlberechtigte_anlage.ds', 
        'install/ds/wahlgruppe.ds'                          => 'setup wahlgruppe.ds',
        'install/ds/wahlbezirk.ds'                          => 'setup wahlbezirk.ds',
        'install/ds/stimmzettel.ds'                         => 'setup stimmzettel.ds',
        'install/ds/stimmzettelgruppen.ds'                  => 'setup stimmzettelgruppen.ds',
        'install/ds/kandidaten_bilder_typen.ds'             => 'setup kandidaten_bilder_typen.ds',
        'install/ds/kandidaten_bilder.ds'                   => 'setup kandidaten_bilder.ds',
        'install/ds/kandidaten.ds'                          => 'setup kandidaten.ds',



        'install/ds/onlinestimmzettel.ds'                   => 'setup onlinestimmzettel.ds',
        'install/ds/onlinekandidaten.ds'                    => 'setup onlinekandidaten.ds',


        'install/ds/ruecklauffelder.ds'                     => 'setup ruecklauffelder.ds',
        'install/ds/ruecklauffelder.ds'                     => 'setup ruecklauffelder.ds',
        
        'install/ds/wahlberechtigte.ds'                     => 'setup wahlberechtigte.ds',
        'install/ds/wahlzeichnungsberechtigter.ds'          => 'setup wahlzeichnungsberechtigter.ds',
        'install/ds/wahlschein.ds'                          => 'setup wahlschein.ds',
        'install/ds/wahlscheinstatus_online_erlaubt.ds'     => 'setup wahlscheinstatus_online_erlaubt.ds',
        'install/ds/wzbruecklauffelder.ds'                    => 'setup wzbruecklauffelder.ds',
        


        /*

        'install/ddl/wm_tanboegen'                  => 'setup wm_tanboegen',
        'install/ddl/wm_tannummer'                  => 'setup wm_tannummer',

        'install/ddl/wm_berichte'                   => 'setup wm_berichte',
        'install/ddl/wm_berichte.data'              => 'setup wm_berichte.data',

        'install/ddl/briefwahlkandidaten'           => 'setup briefwahlkandidaten',
        'install/proc/proc_briefwahlkandidaten'     => 'setup proc_briefwahlkandidaten',

        
        'install/view/view_kandidaten_stimmenanzahl'=> 'setup view_kandidaten_stimmenanzahl',

        'install/ddl/wzbruecklauffelder'            => 'setup wzbruecklauffelder',

        'install/ddl/view_ohne_wahlberechtigten'    => 'setup view_ohne_wahlberechtigten',

        'install/ddl/blocked_voters'                => 'setup blocked_voters',
        'install/ddl/view_voter_credentials'        => 'setup view_voter_credentials',
        

        */
        
        

    ];  
    
}
