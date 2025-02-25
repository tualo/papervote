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


class InstallDDL extends CommandLineInstallSQL  implements ICommandline{
    public static function getDir():string {   return dirname(__DIR__,1); }
    public static $shortName  = 'papervote-ddl';
    public static $files = [

        'install/ddl/wahltyp'                       => 'setup wahltyp',
        'install/ddl/wahltyp.data'                  => 'setup wahltyp.data',

        'install/ddl/abgabetyp'                     => 'setup abgabetyp',
        'install/ddl/abgabetyp.data'                => 'setup abgabetyp.data',

        'install/ddl/wahlscheinstatus'              => 'setup wahlscheinstatus',
        'install/ddl/wahlscheinstatus.data'         => 'setup wahlscheinstatus.data',

        'install/ddl/wahlscheinstatus_grund'        => 'setup wahlscheinstatus_grund',
        'install/ddl/wahlscheinstatus_grund.data'   => 'setup wahlscheinstatus_grund.data',

        'install/ddl/wahlgruppe'                    => 'setup wahlgruppe',
        'install/ddl/wahlbezirk'                    => 'setup wahlbezirk',
        'install/ddl/stimmzettel'                   => 'setup stimmzettel',
        'install/ddl/stimmzettelgruppen'            => 'setup stimmzettelgruppen',
        'install/ddl/kandidaten'                    => 'setup kandidaten',

        'install/ddl/kandidaten_bilder_typen'       => 'setup kandidaten_bilder_typen',
        'install/ddl/kandidaten_bilder'             => 'setup kandidaten_bilder',
        'install/ddl/counting.ddl'                  => 'setup counting.ddl',
        'install/ddl/counting.ddl.trigger'          => 'setup counting.ddl.trigger',

        'install/ddl/onlinestimmzettel'             => 'setup onlinestimmzettel',
        'install/ddl/onlinekandidaten'              => 'setup onlinekandidaten',     

        'install/ddl/ruecklauffelder'               => 'setup ruecklauffelder',

        'install/ddl/wahlberechtigte'               => 'setup wahlberechtigte',
        'install/ddl/wahlzeichnungsberechtigter'    => 'setup wahlzeichnungsberechtigter',

        'install/ddl/wm_tanboegen'                  => 'setup wm_tanboegen',
        'install/ddl/wm_tannummer'                  => 'setup wm_tannummer',

        'install/ddl/wm_berichte'                   => 'setup wm_berichte',
        'install/ddl/wm_berichte.data'              => 'setup wm_berichte.data',

        'install/ddl/wahlschein'                    => 'setup wahlschein',

        'install/ddl/briefwahlkandidaten'           => 'setup briefwahlkandidaten',
        'install/proc/proc_briefwahlkandidaten'     => 'setup proc_briefwahlkandidaten',

        
        'install/view/view_kandidaten_stimmenanzahl'=> 'setup view_kandidaten_stimmenanzahl',

        'install/ddl/wzbruecklauffelder'           => 'setup wzbruecklauffelder',
        'install/ddl/wzbruecklauffelder.data'      => 'setup wzbruecklauffelder.data',
        

    ];  
    
}

/*
class InstallDDLX implements ICommandline{


    public static function run(Args $args){

        $files = [

            'wahlscheinstatus' => 'setup wahlscheinstatus ',
            // 'wahlscheinstatus.ds' => 'setup wahlscheinstatus.ds ',

            'wahlgruppe' => 'setup wahlgruppe ',
            // 'wahlgruppe.ds' => 'setup wahlgruppe.ds ',


            'wahlbezirk' => 'setup wahlbezirk ',
            'wahlbezirk.ds' => 'setup wahlbezirk.ds ',

            'stimmzettel' => 'setup stimmzettel ',
            'stimmzettel.ds' => 'setup stimmzettel.ds ',

            'stimmzettelgruppen' => 'setup stimmzettelgruppen ',
            'stimmzettelgruppen.ds' => 'setup stimmzettelgruppen.ds ',


            'view_beteiligung_stimmzettel_pro_tag' => 'setup view_beteiligung_stimmzettel_pro_tag ',
            'view_beteiligung_stimmzettel_pro_tag.ds' => 'setup view_beteiligung_stimmzettel_pro_tag.ds ',

            'kandidaten' => 'setup kandidaten ',
            'kandidaten.preview' => 'setup kandidaten.preview ',
            'kandidaten.ridx.trigger' => 'setup kandidaten.ridx.trigger ',

            'kandidaten.ds' => 'setup kandidaten.ds ',

            'kandidaten_bilder' => 'setup kandidaten_bilder ',
            'kandidaten_bilder.ds' => 'setup kandidaten_bilder.ds ',

            'kandidaten_bilder_typen' => 'setup kandidaten_bilder_typen ',
            'kandidaten_bilder_typen.ds' => 'setup kandidaten_bilder_typen.ds ',
            


            'wb_wg.fix.aktiv' => 'setup wb_wg.fix.aktiv ',
            
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

            'wahlberechtigte' => 'setup wahlberechtigte',
            'wahlberechtigte.ds' => 'setup wahlberechtigte.ds',


            'wm_tanboegen' => 'setup wm_tanboegen',
            'wm_tanboegen.ds' => 'setup wm_tanboegen.ds',

            'wm_tannummer' => 'setup wm_tannummer',
            'wm_tannummer.ds' => 'setup wm_tannummer.ds',


            'wm_berichte' => 'setup wm_berichte',
            'wm_berichte.ds' => 'setup wm_berichte.ds',

            'wahlschein' => 'setup wahlschein',
            'wahlschein.ds' => 'setup wahlschein.ds',

            'wahlschein.versioned' => 'setup wahlschein.versioned',
            

            'view_stimmenanzahl_ranking_los_monitor_list_stand' => 'setup view_stimmenanzahl_ranking_los_monitor_list_stand',
            'view_stimmenanzahl_ranking_los_monitor_list_stand.ds' => 'setup view_stimmenanzahl_ranking_los_monitor_list_stand.ds',

            'briefwahlkandidaten' => 'setup briefwahlkandidaten',
            'briefwahlkandidaten.ds' => 'setup briefwahlkandidaten.ds',

            'kandidaten_stimmenanzahl' => 'setup kandidaten_stimmenanzahl',
            'kandidaten_stimmenanzahl.ds' => 'setup kandidaten_stimmenanzahl.ds',


            'kandidaten_stimmenanzahl_rank' => 'setup kandidaten_stimmenanzahl_rank',
            'kandidaten_stimmenanzahl_rank.ds' => 'setup kandidaten_stimmenanzahl_rank.ds',

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
            'view_gezaehlte_stimmzettel' => 'setup stimmzettel view',

            

            'view_wm_bekanntmachung_kandidaten_liste' => 'setup view_wm_bekanntmachung_kandidaten_liste',
            'view_wm_bekanntmachung_kandidaten_liste.ds' => 'setup view_wm_bekanntmachung_kandidaten_liste.ds',

            'view_wm_bekanntmachung_kandidaten_liste_wm_bekanntmachung' => 'setup view_wm_bekanntmachung_kandidaten_liste_wm_bekanntmachung',
            'view_wm_bekanntmachung_kandidaten_liste_wm_bekanntmachung.ds' => 'setup view_wm_bekanntmachung_kandidaten_liste_wm_bekanntmachung.ds',

            'view_wm_bekanntmachung' => 'setup view_wm_bekanntmachung',
            'view_wm_bekanntmachung.ds' => 'setup view_wm_bekanntmachung.ds',

            
            'view_wm_wahlbeteiligungwahl_beteiligung_bericht_config' => 'setup view_wm_wahlbeteiligungwahl_beteiligung_bericht_config',
            'view_wm_wahlbeteiligungwahl_beteiligung_bericht_config.ds' => 'setup view_wm_wahlbeteiligungwahl_beteiligung_bericht_config.ds',

            'view_wm_wahlbeteiligungwahl_beteiligung_bericht_formel' => 'setup view_wm_wahlbeteiligungwahl_beteiligung_bericht_formel',
            'view_wm_wahlbeteiligungwahl_beteiligung_bericht_formel.ds' => 'setup view_wm_wahlbeteiligungwahl_beteiligung_bericht_formel.ds',
            
            'view_wm_wahlbeteiligungwahl_beteiligung_bericht' => 'setup view_wm_wahlbeteiligungwahl_beteiligung_bericht',
            'view_wm_wahlbeteiligungwahl_beteiligung_bericht.ds' => 'setup view_wm_wahlbeteiligungwahl_beteiligung_bericht.ds',
            

            'view_wm_wahlbeteiligungwahl_beteiligung_bericht_datenliste' => 'setup view_wm_wahlbeteiligungwahl_beteiligung_bericht_datenliste',
            'view_wm_wahlbeteiligungwahl_beteiligung_bericht_datenliste.ds' => 'setup view_wm_wahlbeteiligungwahl_beteiligung_bericht_datenliste.ds',

            'view_wm_wahlbeteiligungwahl_beteiligung_bericht_formel_object' => 'setup view_wm_wahlbeteiligungwahl_beteiligung_bericht_formel_object',
            'view_wm_wahlbeteiligungwahl_beteiligung_bericht_formel_object.ds' => 'setup view_wm_wahlbeteiligungwahl_beteiligung_bericht_formel_object.ds',

            'view_wm_wahlbeteiligungwahl_beteiligung_bericht_config_object' => 'setup view_wm_wahlbeteiligungwahl_beteiligung_bericht_config_object',
            'view_wm_wahlbeteiligungwahl_beteiligung_bericht_config_object.ds' => 'setup view_wm_wahlbeteiligungwahl_beteiligung_bericht_config_object.ds',

            'view_wm_wahlbeteiligungwahl_beteiligung_bericht_datenobject' => 'setup view_wm_wahlbeteiligungwahl_beteiligung_bericht_datenobject',
            'view_wm_wahlbeteiligungwahl_beteiligung_bericht_datenobject.ds' => 'setup view_wm_wahlbeteiligungwahl_beteiligung_bericht_datenobject.ds',

            
            'view_stimmenanzahl_ranking_los' => 'setup view_stimmenanzahl_ranking_los',
            'view_stimmenanzahl_ranking_los.ds' => 'setup view_stimmenanzahl_ranking_los.ds',
            
            'pug_tan' => 'setup pug_tan',
            'pug_css' => 'setup pug_css',
            'pug_css_assign' => 'setup pug_css',
            
            'reporting/wm_berichte.pug' => 'setup wm_berichte.pug' ,
            'reporting/wm_berichte.ds_renderer_stylesheet_groups_assign' => 'setup wm_berichte.ds_renderer_stylesheet_groups_assign' ,
            
            'wm_berichte.data' => 'setup wm_berichte.data' ,

            'kandidaten_bilder.upd'=> 'setup kandidaten_bilder.upd' ,

            'addcommand'=> 'setup addcommand',


            // 'fix_aktiv'=> 'patch active column types',

            'randomString'=> 'randomString',



            'canChangeValue'    => 'setup canChangeValue',
            'system_settings_suggestion'    => 'setup system_settings_suggestion',
            'system_settings_suggestion.ds'    => 'setup system_settings_suggestion.ds',

            'system_settings'    => 'setup system_settings',
            'system_settings.ds'    => 'setup system_settings.ds',

            'system_settings_user_access'    => 'setup system_settings_user_access',
            'system_settings_user_access.ds'    => 'setup system_settings_user_access.ds',
            

            'stimmzettel_fusstexte'    => 'setup stimmzettel_fusstexte',
            'stimmzettel_fusstexte.ds'    => 'setup stimmzettel_fusstexte.ds',
            
            'stimmzettel_stimmzettel_fusstexte'    => 'setup stimmzettel_stimmzettel_fusstexte',
            'stimmzettel_stimmzettel_fusstexte.ds'    => 'setup stimmzettel_stimmzettel_fusstexte.ds',
            

            'ds_files'    => 'setup ds_files',
            'ds_files.ds'    => 'setup ds_files.ds',

            
            'ds_files_data'    => 'setup ds_files_data',
            'ds_files_data.ds'    => 'setup ds_files_data.ds',

            'voterCredential'    => 'setup voterCredential',
            
            'wm_wahlschein_register'=> 'setup wm_wahlschein_register',
            'wm_wahlschein_register.ds'=> 'setup wm_wahlschein_register.ds',

            // 'allowed_online_states'=> 'setup allowed_online_states',

            'wahlscheinstatus_online_erlaubt'=> 'setup wahlscheinstatus_online_erlaubt',
            'wahlscheinstatus_online_erlaubt.ds'=> 'setup wahlscheinstatus_online_erlaubt.ds',

            'view_ruecklauffelder_columns'=> 'setup view_ruecklauffelder_columns',
            'view_ruecklauffelder_columns.ds'=> 'setup view_ruecklauffelder_columns.ds',

            'view_voters_by_username_api'=> 'setup view_voters_by_username_api',
            
            'getBallotPaper'=> 'setup getBallotpaper',

            'blocked_voters'=> 'setup blocked_voters',

            'reportfiles_typen'=> 'setup reportfiles_typen',
            'reportfiles'=> 'setup reportfiles',

            'view_blocksystem_status'=> 'setup view_blocksystem_status',
            'view_blocksystem_status.ds'=> 'setup view_blocksystem_status.ds',
            
            'wahlschein_status_import'=> 'setup wahlschein_status_import',
            'wahlschein_status_import.ds'=> 'setup wahlschein_status_import.ds',


            'view_double_voter'=> 'setup view_double_voter',
            'view_double_voter.ds'=> 'setup view_double_voter.ds',            

            'function_getzero'=> 'setup function_getzero',
            'fix_testdaten_flag'=> 'setup fix_testdaten_flag',
            'view_readtable_wahlzeichnungsberechtigter'=> 'setup view_readtable_wahlzeichnungsberechtigter',

            'kandidaten_stimmenanzahl_losentscheid_stimmzettel'=> 'setup kandidaten_stimmenanzahl_losentscheid_stimmzettel',
            'kandidaten_stimmenanzahl_losentscheid_stimmzettel.ds'=> 'setup kandidaten_stimmenanzahl_losentscheid_stimmzettel.ds',

            'kandidaten_stimmenanzahl_liste'    => 'setup kandidaten_stimmenanzahl_liste',
            'kandidaten_stimmenanzahl_liste.ds'    => 'setup kandidaten_stimmenanzahl_liste.ds',

            'view_stimmenanzahl_ranking_los_monitor_list_gruppen.ds'    => 'setup view_stimmenanzahl_ranking_los_monitor_list_gruppen.ds',

            'view_lose_untergruppen'=> 'setup view_lose_untergruppen',
            'view_lose_untergruppen.ds'=> 'setup view_lose_untergruppen.ds',

            
            'ballotbox_decrypted_sum'=> 'setup ballotbox_decrypted_sum',
            'ballotbox_decrypted_sum.ds'=> 'setup ballotbox_decrypted_sum.ds',

            'wm_auswertungen'=> 'setup wm_auswertungen',
            'wm_auswertungen.ds'=> 'setup wm_auswertungen.ds',
            'view_protokoll_online_erwartet'=> 'setup view_protokoll_online_erwartet',
            'dashboard'=> 'setup dashboard',

            'kandidaten_stimmenanzahl_liste_szg'=>'setup kandidaten_stimmenanzahl_liste_szg',
            'kandidaten_stimmenanzahl_liste_szg.ds'=>'setup kandidaten_stimmenanzahl_liste_szg.ds',

            'wahlbeteiligung_bericht.data'=> 'setup wahlbeteiligung_bericht.data',
            
            'print_page.pug'=> 'setup print_page.pug',

            'update_ws_id'=>'setup update_ws_id',


            'wahlberechtigte_anlage'=> 'setup wahlberechtigte_anlage',
            'wahlberechtigte_anlage.ds'=> 'setup wahlberechtigte_anlage.ds',

            'wahlschein.trigger.fix'=>'setup wahlschein.trigger.fix',

            'proc_briefwahlkandidaten'=>'setup proc_briefwahlkandidaten',
            'proc_briefwahlkandidaten_triggers'=>'setup proc_briefwahlkandidaten_triggers',
            
            'view_stimmenanzahl.extended' => 'setup view_stimmenanzahl.extended'
        ];





    }
}
*/