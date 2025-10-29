<?php

namespace Tualo\Office\PaperVote\Routes;

use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\Basic\Route as BasicRoute;
use Tualo\Office\Basic\IRoute;

class Query extends \Tualo\Office\Basic\RouteWrapper
{
    public static $querySQL = "
select
    wahlberechtigte_anlage.*,


    wahlberechtigte.id wahlberechtigte_id,
    wahlschein.id wahlschein_id, 
    wahlschein.kombiniert wahlschein_kombiniert, 
    wahlschein.wahlscheinnummer wahlschein_wahlscheinnummer,
    wahlschein.blocknumber,  					



    stimmzettel.name `stimmzettel_name`,  -- RLF
    stimmzettel.typtitel `stimmzettel_typtitel`,  -- RLF

    wahlgruppe.name `wahlgruppe_name`, -- RLF
    wahlbezirk.name `wahlbezirk_name`, -- RLF
    wahlschein.id `wahlschein_id`, -- RLF

    '' `leerzeile`,  -- RLF
    '' `leerzeile2`, -- RLF
    '' `leerzeile3`,  -- RLF

    concat('<br/><h4>Historie</h4><br/>',
        group_concat(
            concat(substring(hstr.ROW_START,1,19),' - ',hstr.wahlscheinstatus_name,' - ',hstr.login)
            order by hstr.ROW_START

            separator '<br/>'
        )
    ) hstr,

    concat('<b>Status: ',wahlscheinstatus.name ,'</b>') last_state_text,

    wahlschein.stimmzettel,
    wahlschein.abgabetyp,
    wahlschein.wahlscheinstatus,
    wahltyp.id wahltyp_id,

    getBallotpaper(wahlschein.stimmzettel) displ_stimmzettel_name,
    concat('<b>',getBallotpaper(wahlschein.stimmzettel) ,'</b>') displ_stimmzettel_name_bold,
    concat('<b>',stimmzettel.typtitel ,'</b>') stimmzettel_typtitel_bold

from

    wahlschein
    join wahlberechtigte 
        on wahlberechtigte.id = wahlschein.wahlberechtigte
    join wahlberechtigte_anlage  
        on wahlberechtigte.identnummer = wahlberechtigte_anlage.identnummer
        and wahlschein.stimmzettel = wahlberechtigte_anlage.stimmzettel
    join stimmzettel 
        on stimmzettel.id = wahlschein.stimmzettel
    join wahltyp 
        on wahltyp.id = stimmzettel.wahltyp
    join wahlgruppe on wahlgruppe.id = stimmzettel.wahlgruppe
    join wahlbezirk on wahlbezirk.id = stimmzettel.wahlbezirk
    join wahlscheinstatus 
                on wahlschein.wahlscheinstatus = wahlscheinstatus.id
    join (
        select 
            hstr.ROW_START,
            hstr.login,
            hstr.id,
            hstr.stimmzettel,
            wahlscheinstatus.name wahlscheinstatus_name
        from 
            wahlschein  FOR SYSTEM_TIME ALL  hstr
            join wahlscheinstatus 
                on hstr.wahlscheinstatus = wahlscheinstatus.id
    ) hstr 
        on hstr.id = wahlschein.id
        and hstr.stimmzettel = wahlschein.stimmzettel

where 
    #search_field={barcode}
group by
    wahlschein.id, 
    wahlschein.stimmzettel";

    public static function prepareQuerySQL($db)
    {
        $fld = $db->singleValue('select group_concat(concat(table_name,".`",column_name,"`") separator ",") fld from ds_column where table_name="wahlberechtigte_anlage" 
        and existsreal=1
        
         and column_name not in (
                "stimmzettel",
                "wahlscheinnummer",
                "pwhash",
                "username",
                "password",
                "passwort",
                "wahlberechtigte_id",
                "wahlschein_id",
                "wahlschein_wahlscheinnummer",
                "leerzeile",
                "leerzeile2",
                "leerzeile3",
                "blocknumber",
                "stimmzettel_name",
                "stimmzettel_typtitel",
                "wahlgruppe_name",
                "wahlbezirk_name",
                "abgabetyp",
                "wahlscheinstatus",
                "hstr",
                "displ_stimmzettel_name",
                "wahltyp_id",
                "last_state_text",
                "displ_stimmzettel_name_bold",
                "stimmzettel_typtitel_bold"

        ) ', [], 'fld');
        return str_replace('wahlberechtigte_anlage.*', $fld, Query::$querySQL);
    }

    public static function get(string $type, string $id): array
    {
        $db = App::get('session')->getDB();
        $sql = str_replace(
            '#search_field',
            ($type == 'identnummer') ? 'wahlberechtigte_anlage.identnummer' : 'wahlschein.wahlscheinnummer',
            Query::prepareQuerySQL($db)
        );
        $data = Query::wzb($db, $db->direct($sql, ['barcode' => $id]));
        return $data;
    }

    public static function wzb($db, $data)
    {
        foreach ($data as &$item) {
            $item['wahlzeichnungsberechtigter'] = $db->direct('select * from wahlzeichnungsberechtigter  where wahlberechtigte = {wahlberechtigte_id}', $item);
        }
        return $data;
    }

    public static function register()
    {
        BasicRoute::add('/papervote/(?P<type>(identnummer|wahlschein))/(?P<barcode>[\w\-\_\d]+)', function ($matches) {
            try {
                $db = App::get('session')->getDB();
                App::contenttype('application/json');

                $data = Query::get($matches['type'], $matches['barcode']);
                App::result('data',  $data);
                App::result('last_sql', $db->last_sql);
                App::result('success', count($data) > 0);
                App::result('msg', (count($data) == 0) ? 'Der Wähler wurde nicht gefunden.' : '');
            } catch (\Exception $e) {

                App::result('last_sql', $db->last_sql);
                App::result('msg', $e->getMessage());
            }
        }, ['get', 'post'], true);
    }
}
