DELIMITER ;
CREATE TABLE IF NOT EXISTS `wahlberechtigte` (
  `id` bigint(20) NOT NULL,
  `kostenstelle` int(11) NOT NULL DEFAULT 0,
  `ridx` varchar(12) DEFAULT NULL,
  `insert_date` date DEFAULT NULL,
  `update_date` date DEFAULT NULL,
  `login` varchar(255) DEFAULT NULL,
  `insert_time` time DEFAULT NULL,
  `update_time` time DEFAULT NULL,
  `aktiv` tinyint DEFAULT 0,
  `identnummer` varchar(255) DEFAULT NULL,
  `identkurz` int(11) DEFAULT 0,
  PRIMARY KEY (`id`,`kostenstelle`),
  UNIQUE KEY `uidx_wahlberechtigte_ridx` (`ridx`),
  KEY `idx_wahlberechtigte_identnummer` (`identnummer`)
) ;

