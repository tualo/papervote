DELIMITER ;

CREATE TABLE  IF NOT EXISTS `wahlbeteiligung_bericht_formel_teiler` (
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
  PRIMARY KEY (`id`),
  KEY `fk_wahlbeteiligung_bericht_formel_teiler` (`wahlbeteiligung_bericht`),
  KEY `idx_wahlbeteiligung_bericht_formel_teiler_wbf` (`wahlbeteiligung_bericht_formel`),
  CONSTRAINT `fk_wahlbeteiligung_bericht_formel_teiler` FOREIGN KEY (`wahlbeteiligung_bericht`) REFERENCES `wahlbeteiligung_bericht` (`ridx`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_wahlbeteiligung_bf_teiler_wbb_formel` FOREIGN KEY (`wahlbeteiligung_bericht_formel`) REFERENCES `wahlbeteiligung_bericht_formel` (`ridx`) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT IGNORE INTO `wahlbeteiligung_bericht_formel_teiler` VALUES
(1,0,'1','2014-01-20','2014-01-20','admin','08:57:43','08:57:51','1','','1','1'),
(2,0,'2','2014-01-20','2014-01-20','admin','08:58:06','08:58:18','1','','2','3'),
(3,0,'3','2015-11-05','2015-11-05','admin','12:25:51','12:26:02','1','','3','3'),
(4,0,'4','2015-11-18','2015-11-18','admin','16:52:26','16:52:34','1','','4','15');


