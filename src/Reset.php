<?php

namespace Tualo\Office\PaperVote;

use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\DS\DSTable;
use Exception;

class Reset
{

    public static function Testdatenreset(){
        $sql = "select 

        concat(
            'delete from wahlschein where id = ',
            concat(stimmzettel.id,lpad(wahlberechtigte_anlage.identnummer,8,'0')),
            ' ',char(59),
            ' delete from wahlberechtigte where id = ',wahlberechtigte_anlage.identnummer, char(59),
            ' delete from wahlberechtigte_anlage where stimmzettel=\"',stimmzettel.ridx,'\" and  identnummer = \"',wahlberechtigte_anlage.identnummer,'\"', char(59)
        ) x
        
         from wahlberechtigte_anlage join stimmzettel on wahlberechtigte_anlage.stimmzettel = stimmzettel.ridx
        
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
            $sql = 'update wahlschein 
                set 
                    ' . $typ['feld'] . '=\'1|0\',
                    ' . $typ['feld'] . '_grund=\'\', 
                    blocknumber =0, 
                    abgabetyp="0|0", 
                    usedate=null 
                where ' . $typ['feld'] . '<>\'6|0\'';
            $db->execute($sql);
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

        $db->execute('delete from wahlschein');
        $db->execute('DELETE HISTORY FROM wahlschein');

        try {
            $db->execute('delete from wahlschein_hstr');
        } catch (\Exception $e) {
        }

        $db->execute('delete from wahlberechtigte');
        $db->execute('DELETE HISTORY FROM wahlberechtigte');
        try {
            $db->execute('delete from wahlberechtigte_hstr');
        } catch (\Exception $e) {
        }

        $db->execute('delete from wahlberechtigte_anlage');
        try {
            $db->execute('delete from wahlberechtigte_anlage_hstr');
        } catch (\Exception $e) {
        }
        try {
            $db->execute('delete from wahlberechtigte_anlage_hstr_last');
        } catch (\Exception $e) {
        }
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
        $sql = 'delete from onlinekandidaten_doc  ';
        $db->execute($sql);
        $sql = 'delete from onlinekandidaten_docdata  ';
        $db->execute($sql);
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

        $sql = 'CREATE TABLE IF NOT EXISTS `wahlberechtigte_anlage` (
            `identnummer` varchar(20) NOT NULL,
            `stimmzettel` varchar(12) NOT NULL,
            `wahlscheinnummer` varchar(12) DEFAULT NULL,
            `kombiniert` bigint(20) DEFAULT NULL,
            `testdaten` tinyint(4) DEFAULT 0,
            `username` varchar(10) DEFAULT NULL,
            `pwhash` varchar(100) DEFAULT NULL,
            PRIMARY KEY (`identnummer`,`stimmzettel`),
            KEY `idx_wahlberechtigte_anlage_wahlscheinnummer` (`wahlscheinnummer`),
            KEY `idx_wahlberechtigte_anlage_identnummer` (`identnummer`)
        )';
        $db->direct($sql);

        


        $sql = 'create or replace view wahlschein_flatfile as
        select
            wahlberechtigte_anlage.*,
            wahlschein.wahlscheinnummer wahlschein_wahlscheinnummer,
            wahlschein.insert_date wahlschein_insert_date,
            wahlschein.update_date wahlschein_update_date,
            wahlscheinstatus.name status_text,
            if(wahlschein.abgabetyp="2|0","Onlinewahl","Briefwahl") abgabetyp_text,
            stimmzettel.name stimmzettel_name
        from
            wahlschein
            join wahlberechtigte
            	on wahlschein.wahlberechtigte = wahlberechtigte.ridx
            join wahlberechtigte_anlage
            on  wahlberechtigte.identnummer = wahlberechtigte_anlage.identnummer
                and wahlberechtigte_anlage.stimmzettel = wahlschein.stimmzettel 
            join wahlscheinstatus
            on wahlscheinstatus.ridx = wahlschein.wahlscheinstatus
            join stimmzettel
            on stimmzettel.ridx = wahlschein.stimmzettel
        ';
        $db->execute($sql);


        $sql = 'CREATE OR REPLACE VIEW `view_pwgen_wahlberechtigte_anlage` AS 
        select 
            `wahlberechtigte_anlage`.*
        from 
            wahlschein
            join wahlberechtigte
                on wahlschein.wahlberechtigte = wahlberechtigte.ridx
                and `wahlschein`.`wahlscheinstatus` in ("16|0","17|0")
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


        $filename = (__DIR__) . '/sql/install/trigger.wahlberechtigte.anlage.sql';
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
