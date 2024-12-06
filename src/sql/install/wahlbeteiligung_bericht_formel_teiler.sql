DELIMITER ;
CREATE TABLE IF NOT EXISTS `wahlbeteiligung_bericht_formel_teiler` (
  `id` int(11) NOT NULL,
  `kostenstelle` int(11) NOT NULL DEFAULT 0,
  `ridx` varchar(255) DEFAULT NULL,
  `insert_date` date DEFAULT NULL,
  `update_date` date DEFAULT NULL,
  `login` varchar(255) DEFAULT NULL,
  `insert_time` time DEFAULT NULL,
  `update_time` time DEFAULT NULL,
  `aktiv` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `wahlbeteiligung_bericht_formel` varchar(255) DEFAULT NULL,
  `wahlbeteiligung_bericht` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`,`kostenstelle`),
  KEY `fk_wahlbeteiligung_bericht_formel_teiler` (`wahlbeteiligung_bericht`),
  KEY `idx_wahlbeteiligung_bericht_formel_teiler_wbf` (`wahlbeteiligung_bericht_formel`),
  CONSTRAINT `fk_wahlbeteiligung_bericht_formel_teiler` FOREIGN KEY (`wahlbeteiligung_bericht`) REFERENCES `wahlbeteiligung_bericht` (`ridx`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_wahlbeteiligung_bf_teiler_wbb_formel` FOREIGN KEY (`wahlbeteiligung_bericht_formel`) REFERENCES `wahlbeteiligung_bericht_formel` (`ridx`) ON DELETE CASCADE ON UPDATE CASCADE
) ;
