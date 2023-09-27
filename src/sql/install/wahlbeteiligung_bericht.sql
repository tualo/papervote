DELIMITER ;

CREATE TABLE IF NOT EXISTS `wahlbeteiligung_bericht` (
  `id` int(11) NOT NULL,
  `kostenstelle` int(11) NOT NULL DEFAULT 0,
  `ridx` varchar(255) DEFAULT NULL,
  `insert_date` date DEFAULT NULL,
  `update_date` date DEFAULT NULL,
  `login` varchar(255) DEFAULT NULL,
  `insert_time` time DEFAULT NULL,
  `update_time` time DEFAULT NULL,
  `aktiv` tinyint(4) DEFAULT 1,
  `name` varchar(255) DEFAULT NULL,
  `checktyp` tinyint(4) DEFAULT 0,
  `abgabetyp` longtext DEFAULT '{"abgabetyp1":true,"abgabetyp2":true}',
  PRIMARY KEY (`id`),
  KEY `idx_wahlbeteiligung_bericht_ridx` (`ridx`)
);

INSERT IGNORE INTO `wahlbeteiligung_bericht` VALUES
(1,0,'1','2014-01-20','2014-07-16','admin','08:26:27','17:50:14',1,'Wähler',0,'{\"abgabetyp1\":true,\"abgabetyp2\":true}'),
(2,0,'2','2014-01-20','2014-01-20','admin','08:26:44','08:26:47',1,'Unzustellbar',0,'{\"abgabetyp1\":true,\"abgabetyp2\":true}'),
(3,0,'3','2014-01-20','2014-07-16','admin','08:26:55','17:55:22',1,'Bereinigt',0,'{\"abgabetyp1\":true,\"abgabetyp2\":true}'),
(4,0,'4','2014-01-20','2014-01-20','admin','08:27:06','08:37:57',1,'Angenommen',1,'{\"abgabetyp1\":true,\"abgabetyp2\":true}'),
(5,0,'5','2014-01-20','2015-11-05','admin','08:27:20','12:26:55',1,'Abgewiesen',0,'{\"abgabetyp1\":true,\"abgabetyp2\":false}'),
(6,0,'6','2014-01-20','2014-02-18','admin','08:42:52','13:06:34',1,'Klärungen',0,'{\"abgabetyp1\":true,\"abgabetyp2\":false}'),
(7,0,'7','2014-02-18','2014-02-18','admin','13:22:09','13:22:25',1,'ohne Wahlschein',0,'{\"abgabetyp1\":true,\"abgabetyp2\":false}'),
(8,0,'8','2014-02-19','2015-06-17','admin','08:57:31','09:07:14',1,'verspätet',0,'{\"abgabetyp1\":true,\"abgabetyp2\":true}'),
(9,0,'9','2014-07-16','2016-01-28','admin','17:53:48','08:16:37',0,'abgemeldet',0,'{\"abgabetyp1\":true,\"abgabetyp2\":true}'),
(10,0,'10','2014-07-28','2015-06-17','admin','08:52:25','09:07:07',0,'E-Aktiv',0,'{\"abgabetyp1\":true,\"abgabetyp2\":true}'),
(11,0,'11','2014-07-28','2015-11-05','admin','09:06:48','12:28:32',0,'Gültig',0,'{\"abgabetyp1\":true,\"abgabetyp2\":true}'),
(12,0,'12','2014-07-28','2015-06-17','admin','09:42:12','09:06:29',0,'Gülitig Online',0,'{\"abgabetyp1\":true,\"abgabetyp2\":true}'),
(13,0,'13','2015-11-18','2016-01-28','admin','16:42:42','08:13:08',0,'Wahlberechtigte',0,'{\"abgabetyp1\":true,\"abgabetyp2\":true}'),
(14,0,'14','2015-11-18','2016-01-28','admin','16:44:42','08:13:41',0,'nicht zustellbar',0,'{\"abgabetyp1\":true,\"abgabetyp2\":true}'),
(15,0,'15','2015-11-18','2016-01-28','admin','16:45:17','08:14:12',0,'Wahlberechtigte (bereinigt)',0,'{\"abgabetyp1\":true,\"abgabetyp2\":true}'),
(16,0,'16','2015-11-18','2016-01-28','admin','16:47:01','08:13:58',0,'eingegangene Wahlunterlagen',0,'{\"abgabetyp1\":true,\"abgabetyp2\":true}'),
(17,0,'17','2015-11-18','2016-01-28','admin','16:48:46','08:14:34',0,'davon zurückgewiesen',0,'{\"abgabetyp1\":true,\"abgabetyp2\":true}'),
(18,0,'18','2015-11-18','2016-01-28','admin','16:49:17','08:14:41',0,'davon zurückgewiesen ohne Wahlschein',0,'{\"abgabetyp1\":true,\"abgabetyp2\":true}'),
(19,0,'19','2021-04-08','2021-04-08','admin','14:03:26','14:03:26',1,'Inaktiv',0,'\'{\"abgabetyp1\":true,\"abgabetyp2\":true}\'');
