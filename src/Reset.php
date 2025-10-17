<?php

namespace Tualo\Office\PaperVote;

use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\DS\DSTable;
use Exception;

use Tualo\Office\Basic\Path;

class Reset
{

    public static function Testdatenreset()
    {
        $sql = "select 

        concat(
            'delete from wahlschein where id = ',
            concat(stimmzettel.id,lpad(wahlberechtigte_anlage.identnummer,8,'0')),
            ' ',char(59),
            ' delete from wahlberechtigte where id = ',wahlberechtigte_anlage.identnummer, char(59),
            ' delete from wahlberechtigte_anlage where stimmzettel=\"',stimmzettel.id,'\" and  identnummer = \"',wahlberechtigte_anlage.identnummer,'\"', char(59)
        ) x
        
         from wahlberechtigte_anlage join stimmzettel on wahlberechtigte_anlage.stimmzettel = stimmzettel.id
        
        where wahlberechtigte_anlage.testdaten=1";
        $db = App::get('session')->getDB();
        $db->execute($sql);
    }

    public static function Ruecklauf()
    {
        $db = App::get('session')->getDB();
        $typen = DSTable::instance("wahltyp")->filter('aktiv', 'eq', 1)->limit(1000);
        $typen_liste = $typen->get();
        if ($typen->empty()) return;
        foreach ($typen_liste as $typ) {
            if ($typ['feld'] == '') $typ['feld'] = 'wahlscheinstatus';
            $sql = 'update wahlschein 
                set 
                    ' . $typ['feld'] . '=1,
                    ' . $typ['feld'] . '_grund=0, 
                    blocknumber =0, 
                    abgabetyp=0, 
                    login=getSessionUser(),
                    usedate=null 
                where ' . $typ['feld'] . '<> 6';
            $db->execute($sql);
        }
        if (App::configuration('papervote', 'delete_history_on_reset', '0') == '1') {
            $db->execute('DELETE HISTORY FROM wahlschein');
        }
    }

    public static function Tan()
    {
        $db = App::get('session')->getDB();
        $db->execute('update wm_tannummer set aktiv=1');
    }

    public static function Wahlzeichnungsberechtigter()
    {
        $db = App::get('session')->getDB();
        $db->execute('delete from wahlzeichnungsberechtigter');
        try {
            $db->execute('delete from wahlzeichnungsberechtigter_hstr');
        } catch (\Exception $e) {
        }
    }


    public static function Wahlberechtigte()
    {
        $db = App::get('session')->getDB();

        $db->execute('delete from wahlschein ');
        if (App::configuration('papervote', 'delete_history_on_reset', '0') == '1') {
            $db->execute('DELETE HISTORY FROM wahlschein');
        }

        $db->execute('delete from wahlberechtigte');
        if (App::configuration('papervote', 'delete_history_on_reset', '0') == '1') {
            $db->execute('DELETE HISTORY FROM wahlberechtigte');
        }
        $db->execute('truncate wahlberechtigte_anlage');
    }


    public static function WahlberechtigteCleanDS()
    {
        $db = App::get('session')->getDB();
        $db->execute('drop table if exists wahlberechtigte_anlage_hstr');
        $db->execute('drop table if exists wahlberechtigte_anlage_hstr_last');

        $db->execute('drop trigger if exists wahlberechtigte_anlage__ai');
        $db->execute('drop trigger if exists wahlberechtigte_anlage__au');
        $db->execute('drop trigger if exists wahlberechtigte_anlage__bd');
        //$db->execute('drop trigger if exists before_insert_wahlberechtigte_anlage');


        $db->execute('drop table if exists wahlberechtigte_anlage');
    }


    public static function Zaehldaten()
    {
        $db = App::get('session')->getDB();
        $sql = 'delete from kandidaten1';
        $db->execute($sql);
        $sql = 'delete from stimmzettel1';
        $db->execute($sql);
        $sql = 'delete from stapel1';
        $db->execute($sql);
        $sql = 'delete from kisten1';
        $db->execute($sql);

        $sql = 'delete from kandidaten2';
        $db->execute($sql);
        $sql = 'delete from stimmzettel2';
        $db->execute($sql);
        $sql = 'delete from stapel2';
        $db->execute($sql);

        $sql = 'delete from kisten2';
        $db->execute($sql);

        try {
            $sql = 'delete from detected_codes';
            $db->execute($sql);
            $sql = 'delete from papervote_optical';
            $db->execute($sql);
        } catch (Exception $e) {
        }

        try {
            $sql = 'delete from briefwahlkandidaten';
            $db->execute($sql);
        } catch (Exception $e) {
        }


        try {
            $sql = 'update  kandidaten set losnummer=0, losnummer_stimmzettelgruppe=0, kooptiert=0';
            $db->execute($sql);
        } catch (Exception $e) {
        }
    }

    public static function Kandidaten()
    {
        $db = App::get('session')->getDB();


        $sql = 'delete from kandidaten  ';
        $db->execute($sql);
        try {
            $sql = 'delete from kandidaten_bilder  ';
            $db->execute($sql);
        } catch (Exception $e) {
        }

        try {
            $sql = 'delete from kandidaten_doc  ';
            $db->execute($sql);
        } catch (Exception $e) {
        }
        try {
            $sql = 'delete from kandidaten_docdata  ';
            $db->execute($sql);
        } catch (Exception $e) {
        }
        try {
            $sql = 'delete from kandidaten_hstr  ';
            $db->execute($sql);
        } catch (Exception $e) {
        }

        try {
            $sql = 'delete from kandidaten_anlage  ';
            $db->execute($sql);
        } catch (Exception $e) {
        }
        try {
            $sql = 'delete from kandidaten_anlage_doc  ';
            $db->execute($sql);
        } catch (Exception $e) {
        }
        try {
            $sql = 'delete from kandidaten_anlage_docdata  ';
            $db->execute($sql);
        } catch (Exception $e) {
        }
        try {
            $sql = 'delete from kandidaten_anlage_stimmzettel  ';
            $db->execute($sql);
        } catch (Exception $e) {
        }
        try {
            $sql = 'delete from kandidaten_anlage_stimmzettel_doc  ';
            $db->execute($sql);
        } catch (Exception $e) {
        }
        try {
            $sql = 'delete from kandidaten_anlage_stimmzettel_docdata  ';
            $db->execute($sql);
        } catch (Exception $e) {
        }
    }

    public static function Onlinekandidaten()
    {
        $db = App::get('session')->getDB();
        $sql = 'delete from onlinekandidaten  ';
        $db->execute($sql);
        try {
            $sql = 'delete from onlinekandidaten_doc  ';
            $db->execute($sql);
            $sql = 'delete from onlinekandidaten_docdata  ';
            $db->execute($sql);
        } catch (\Exception $e) {
        }
    }

    public static function Onlinestimmzettel()
    {
        $db = App::get('session')->getDB();
        $sql = 'delete from onlinestimmzettel  ';
        $db->execute($sql);

        $sql = 'delete from ballotbox_decrypted_sum  ';
        $db->execute($sql);

        try {

            $sql = 'delete from onlinestimmzettel_doc  ';
            $db->execute($sql);
            $sql = 'delete from onlinestimmzettel_docdata  ';
            $db->execute($sql);
        } catch (\Exception $e) {
        }
    }


    public static function WahlgruppenWahlbezirke()
    {
        $db = App::get('session')->getDB();

        try {
            $sql = 'delete from wahlgruppe  ';
            $db->execute($sql);
        } catch (Exception $e) {
        }
        try {
            $sql = 'delete from wahlgruppe_doc  ';
            $db->execute($sql);
        } catch (Exception $e) {
        }
        try {
            $sql = 'delete from wahlgruppe_docdata  ';
            $db->execute($sql);
        } catch (Exception $e) {
        }


        try {
            $sql = 'delete from wahlbezirk  ';
            $db->execute($sql);
        } catch (Exception $e) {
        }
        try {
            $sql = 'delete from wahlbezirk_doc  ';
            $db->execute($sql);
        } catch (Exception $e) {
        }
        try {
            $sql = 'delete from wahlbezirk_docdata  ';
            $db->execute($sql);
        } catch (Exception $e) {
        }
        try {
            $sql = 'delete from stimmzettel  ';
            $db->execute($sql);
        } catch (Exception $e) {
        }
        try {
            $sql = 'delete from stimmzettel_doc  ';
            $db->execute($sql);
        } catch (Exception $e) {
        }
        try {
            $sql = 'delete from stimmzettel_docdata  ';
            $db->execute($sql);
        } catch (Exception $e) {
        }
    }

    public static function WahlberechtigteAnlageCreateDS()
    {
        $db = App::get('session')->getDB();
        $db->direct("drop table if exists wahlberechtigte_anlage");


        $filename = Path::join(App::get('basePath'), 'votemanager', 'src', 'sql', 'install', 'ddl', 'wahlberechtigte_anlage.sql');

        $sql = file_get_contents($filename);
        $sql = preg_replace('!/\*.*?\*/!s', '', $sql);
        $sql = preg_replace('#^\s*\-\-.+$#m', '', $sql);

        $sinlgeStatements = $db->explode_by_delimiter($sql);
        foreach ($sinlgeStatements as $commandIndex => $statement) {
            $db->direct($statement);
            $db->moreResults();
        }




        $db->execute('call fill_ds("wahlberechtigte_anlage")');
        $db->execute('call fill_ds_column("wahlberechtigte_anlage")');


        $sql = '
        CREATE OR REPLACE VIEW `wahlschein_flatfile` AS
        select
            `wahlberechtigte_anlage`.*,
            `wahlschein`.`wahlscheinnummer` AS `wahlschein_wahlscheinnummer`,
            cast(`wahlschein`.`row_start` as date) AS `wahlschein_insert_date`,
            cast(`wahlschein`.`row_start` as date) AS `wahlschein_update_date`,
            `wahlscheinstatus`.`name` AS `status_text`,
            `abgabetyp`.`name` AS `abgabetyp_text`,
            `stimmzettel`.`name` AS `stimmzettel_name`
        from
            `wahlberechtigte_anlage`
            join `stimmzettel` on  `stimmzettel`.`id` = `wahlberechtigte_anlage`.`stimmzettel`
            join `wahlberechtigte` on `wahlberechtigte_anlage`.`identnummer` = `wahlberechtigte`.`identnummer`
            join `wahlschein`  on  
                `wahlschein`.id = concat(`stimmzettel`.`id`,lpad(`wahlberechtigte_anlage`.`identnummer`,12,"0"))
                and `wahlberechtigte`.`id` = `wahlschein`.`wahlberechtigte`
            join `wahlscheinstatus` on
                `wahlscheinstatus`.`id` = `wahlschein`.`wahlscheinstatus`
            join `abgabetyp` on `abgabetyp`.`id` = `wahlschein`.`abgabetyp`
        ';
        $db->execute($sql);


        $sql = 'CREATE OR REPLACE VIEW `view_pwgen_wahlberechtigte_anlage` AS 
        select 
            `wahlberechtigte_anlage`.*
        from 
            wahlschein
            join wahlberechtigte
                on wahlschein.wahlberechtigte = wahlberechtigte.id
                and `wahlschein`.`wahlscheinstatus` in (16,17)
            join wahlberechtigte_anlage
            on 
                wahlberechtigte.identnummer = wahlberechtigte_anlage.identnummer
                and wahlberechtigte_anlage.stimmzettel = wahlschein.stimmzettel 
                    
        ';
        $db->execute($sql);

        $db->execute('call fill_ds("")');
        $db->moreResults();
        $db->execute('delete from ds_column where existsreal=0');

        $db->direct('INSERT IGNORE INTO `ds_addcommands` (`table_name`, `xtype`, `location`, `position`, `label`, `iconCls`) VALUES ("wahlberechtigte_anlage","wm_wb_importcmd","toolbar",1,"Importieren",NULL);');



        $filename = Path::join(App::get('basePath'), 'votemanager', 'src', 'sql', 'install', 'ddl', 'before_insert_wahlberechtigte_anlage.sql');
        // $filename = (__DIR__) . '/sql/install/ddl/before_insert_wahlberechtigte_anlage.sql';
        $sql = file_get_contents($filename);
        $sql = preg_replace('!/\*.*?\*/!s', '', $sql);
        $sql = preg_replace('#^\s*\-\-.+$#m', '', $sql);

        $sinlgeStatements = $db->explode_by_delimiter($sql);
        foreach ($sinlgeStatements as $commandIndex => $statement) {
            $db->direct($statement);
            $db->moreResults();
        }
    }
}
