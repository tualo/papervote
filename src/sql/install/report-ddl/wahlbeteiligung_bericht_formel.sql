DELIMITER ;

CREATE TABLE IF NOT EXISTS `wahlbeteiligung_bericht_formel` (
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
  PRIMARY KEY (`id`,`kostenstelle`),
  KEY `idx_wahlbeteiligung_bericht_formel` (`ridx`)
) ;
