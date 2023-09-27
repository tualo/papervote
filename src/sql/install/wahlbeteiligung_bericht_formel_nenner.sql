DELIMITER ;


CREATE TABLE IF NOT EXISTS `wahlbeteiligung_bericht_formel_nenner` (
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
  KEY `fk_wahlbeteiligung_bericht_formel_nenner` (`wahlbeteiligung_bericht`),
  KEY `idx_wahlbeteiligung_bericht_formel_nenner_wbf` (`wahlbeteiligung_bericht_formel`),
  CONSTRAINT `fk_wahlbeteiligung_bericht_formel_nenner` FOREIGN KEY (`wahlbeteiligung_bericht`) REFERENCES `wahlbeteiligung_bericht` (`ridx`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_wahlbeteiligung_bf_nenner_wbb_formel` FOREIGN KEY (`wahlbeteiligung_bericht_formel`) REFERENCES `wahlbeteiligung_bericht_formel` (`ridx`) ON DELETE CASCADE ON UPDATE CASCADE
);


INSERT IGNORE INTO `wahlbeteiligung_bericht_formel_nenner` VALUES
(1,0,'1','2014-01-20','2014-01-20','admin','08:57:30','08:57:38','1','','1','4'),
(2,0,'2','2014-01-20','2014-01-20','admin','08:58:22','08:58:31','1','','2','4'),
(3,0,'3','2014-02-19','2014-02-19','admin','09:25:23','09:25:35','1','','2','5'),
(4,0,'4','2014-02-19','2014-02-19','admin','09:25:38','09:25:46','1','','2','7'),
(5,0,'5','2014-02-19','2014-02-19','admin','09:26:47','09:26:55','1','','1','5'),
(6,0,'6','2014-02-19','2014-02-19','admin','09:26:49','09:27:03','1','','1','7'),
(7,0,'7','2015-11-05','2015-11-05','admin','12:23:37','12:23:56','1','','3','5'),
(8,0,'8','2015-11-05','2015-11-05','admin','12:23:40','12:24:09','1','','3','4'),
(9,0,'9','2015-11-05','2015-11-05','admin','12:23:42','12:24:24','1','','3','6'),
(10,0,'10','2015-11-05','2015-11-05','admin','12:24:45','12:25:01','1','','3','7'),
(11,0,'11','2015-11-18','2015-11-18','admin','16:52:06','16:52:21','1','','4','16'),
(12,0,'12','2022-02-03','2022-02-03','admin','11:12:50','11:12:50','1','12','1','8'),
(13,0,'13','2022-02-03','2022-02-03','admin','11:16:37','11:16:37','1','13','2','8'),
(14,0,'14','2022-02-03','2022-02-03','admin','11:16:50','11:16:50','1','14','3','8');
