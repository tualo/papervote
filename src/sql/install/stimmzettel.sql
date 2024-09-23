DELIMITER ;
CREATE TABLE IF NOT EXISTS `stimmzettel` (
  `ridx` varchar(12) DEFAULT NULL,
  `id` int(11) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `aktiv` tinyint DEFAULT 1,
  `insert_date` date NOT NULL,
  `insert_time` time DEFAULT NULL,
  `update_date` date NOT NULL,
  `update_time` time DEFAULT NULL,
  `login` varchar(255) NOT NULL,
  `wahlgruppe` varchar(255) DEFAULT '0',
  `wahlbezirk` varchar(255) DEFAULT '0',
  `wahltyp` varchar(255) DEFAULT '0',
  `sitze` varchar(255) DEFAULT '0',
  `anzahl_10` int(11) DEFAULT 0,
  `zaehlung_1` int(11) DEFAULT 0,
  `zaehlung_2` int(11) DEFAULT 0,
  `zaehlung_3` int(11) DEFAULT 0,
  `zaehlung_4` int(11) DEFAULT 0,
  `zaehlung_5` int(11) DEFAULT 0,
  `zaehlung_6` int(11) DEFAULT 0,
  `zaehlung_7` int(11) DEFAULT 0,
  `zaehlung_8` int(11) DEFAULT 0,
  `zaehlung_9` int(11) DEFAULT 0,
  `sitzbindung` varchar(255) DEFAULT NULL,
  `laufende_nummer_1_24__nach_zuordnung_wg_wb` varchar(255) DEFAULT NULL,
  `anzahl_notwendige_bewerber_je_kombinummer` varchar(255) DEFAULT NULL,
  `ds_count` int(11) DEFAULT 0,
  `ungueltig` int(11) DEFAULT 0,
  `farbe` varchar(100) DEFAULT 'rgb(159, 80, 152)',
  `typtitel` varchar(100) DEFAULT 'Vollversammlungswahl',
  `kandidat_text_einzel` varchar(50) DEFAULT NULL,
  `kandidat_text_mehr` varchar(50) DEFAULT NULL,
  `bh1` int(11) DEFAULT 120,
  `bh2` int(11) DEFAULT 120,
  `xlink` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_stimmzettel_ridx` (`ridx`),
  KEY `fk_stimmzettel_wahlgruppe` (`wahlgruppe`),
  KEY `fk_stimmzettel_wahlbezirk` (`wahlbezirk`),
  CONSTRAINT `fk_stimmzettel_wahlbezirk` FOREIGN KEY (`wahlbezirk`) REFERENCES `wahlbezirk` (`ridx`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_stimmzettel_wahlgruppe` FOREIGN KEY (`wahlgruppe`) REFERENCES `wahlgruppe` (`ridx`) ON DELETE CASCADE ON UPDATE CASCADE
)
;


alter table `stimmzettel`  add column if not exists `ocr_name` varchar(255) default null;
alter table `stimmzettel`  add column if not exists `onlinebezeichnung` varchar(255) default null;



create view if not exists view_readtable_stimmzettel as
select
  *
from stimmzettel
;