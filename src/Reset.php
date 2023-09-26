<?php
namespace Tualo\Office\PaperVote;

use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\DS\DSTable;

class Reset {

    public static function Ruecklauf(){
        $db = App::get('session')->getDB();

        $typen = DSTable::instance("wahltyp")->filter('aktiv','eq',1)->limit(1000);
        if ($typen->empty()) return;
        $typen_liste = $typen->get();
        foreach($typen_liste as $typ){
            $sql='update wahlschein 
                set 
                    '.$typ['feld'].'=\'1|0\',
                    '.$typ['feld'].'_grund=\'\', 
                    blocknumber =0, 
                    abgabetyp="1|0", 
                    usedate=null 
                where '.$typ['feld'].'<>\'6|0\'';
            $db->execute($sql);
        }
    }

    public static function Tan(){
        $db = App::get('session')->getDB();
        $db->execute('update wm_tannummer set aktiv=1');
    }

    public static function Wahlzeichnungsberechtigter(){
        $db = App::get('session')->getDB();
        $db->execute('delete from wahlzeichnungsberechtigter');
        try{ $db->execute('delete from wahlzeichnungsberechtigter_hstr'); }catch(\Exception $e){}
    }


    public static function Wahlberechtigte(){
        $db = App::get('session')->getDB();

        $db->direct('delete from wahlschein');
        try{ $db->direct('delete from wahlschein_hstr'); }catch(\Exception $e){}

        $db->direct('delete from wahlberechtigte');
        try{ $db->direct('delete from wahlberechtigte_hstr'); }catch(\Exception $e){}

        $db->direct('delete from wahlberechtigte_anlage');
        try{ $db->direct('delete from wahlberechtigte_anlage_hstr'); }catch(\Exception $e){}
        try{ $db->direct('delete from wahlberechtigte_anlage_hstr_last'); }catch(\Exception $e){}
    }


    public static function WahlberechtigteCleanDS(){
        $db = App::get('session')->getDB();
        $db->direct('drop table if exists wahlberechtigte_anlage_hstr');
        $db->direct('drop table if exists wahlberechtigte_anlage_hstr_last');

        $db->direct('drop trigger if exists wahlberechtigte_anlage__ai');
        $db->direct('drop trigger if exists wahlberechtigte_anlage__au');
        $db->direct('drop trigger if exists wahlberechtigte_anlage__bd');
        $db->direct('drop trigger if exists before_insert_wahlberechtigte_anlage');
        
        
        $db->direct('drop table if exists wahlberechtigte_anlage');



    }

    public static function WahlberechtigteAnlageCreateDS(){
        $db = App::get('session')->getDB();
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

        $db->direct("call create_or_upgrade_hstr_table('wahlberechtigte_anlage')");
        $db->moreResults();


        $sql='create or replace view wahlschein_flatfile as
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


        $sql='CREATE OR REPLACE VIEW `view_pwgen_wahlberechtigte_anlage` AS 
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


        $filename = (__DIR__).'/sql/install/trigger.wahlberechtigte.anlage.sql';
        $sql = file_get_contents($filename);
        $sql = preg_replace('!/\*.*?\*/!s', '', $sql);
        $sql = preg_replace('#^\s*\-\-.+$#m', '', $sql);

        $sinlgeStatements = $db->explode_by_delimiter($sql);
        foreach($sinlgeStatements as $commandIndex => $statement){
            $db->direct($statement);
            $db->moreResults();
        }
    }

    

}