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
);


LOCK TABLES `wahlbeteiligung_bericht_formel` WRITE;
/*!40000 ALTER TABLE `wahlbeteiligung_bericht_formel` DISABLE KEYS */;
INSERT IGNORE INTO `wahlbeteiligung_bericht_formel` VALUES
(1,0,'1','2014-01-20','2014-01-20','admin','08:57:25','08:57:27','1','Absolut'),
(2,0,'2','2014-01-20','2014-01-20','admin','08:58:04','08:58:46','1','Bereinigt'),
(3,0,'3','2015-11-05','2015-11-05','admin','12:23:24','12:26:06','1','Bereinigt mit Klärung')
;

UNLOCK TABLES;


