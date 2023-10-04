DELIMITER ;

CREATE TABLE IF NOT EXISTS `wahlbeteiligung_bericht_status` (
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
  `wahlbeteiligung_bericht` varchar(255) DEFAULT NULL,
  `wahlscheinstatus` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_wahlbeteiligung_bericht_status_wahlbeteiligung_bericht` (`wahlbeteiligung_bericht`),
  KEY `idx_wahlbeteiligung_bericht_status_wahlscheinstatus` (`wahlscheinstatus`),
  CONSTRAINT `fk_wahlbeteiligung_bericht_status` FOREIGN KEY (`wahlbeteiligung_bericht`) REFERENCES `wahlbeteiligung_bericht` (`ridx`) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT IGNORE INTO `wahlbeteiligung_bericht_status` VALUES
(1,0,'1','2014-01-20','2014-01-20','admin','08:27:32','08:27:44','1','','1','1|0'),
(2,0,'2','2014-01-20','2014-01-20','admin','08:27:47','08:28:00','1','','1','2|0'),
(4,0,'4','2014-01-20','2014-01-20','admin','08:27:49','08:28:20','1','','1','3|0'),
(5,0,'5','2014-01-20','2014-01-20','admin','08:27:51','08:28:38','1','','1','5|0'),
(6,0,'6','2014-01-20','2014-01-20','admin','08:28:42','08:30:45','1','','1','4|0'),
(7,0,'7','2014-01-20','2014-01-20','admin','08:30:50','08:31:08','1','','1','8|0'),
(8,0,'8','2014-01-20','2014-01-20','admin','08:31:50','08:31:58','1','','3','2|0'),
(10,0,'10','2014-01-20','2014-01-20','admin','08:32:18','08:38:42','1','','5','3|0'),
(11,0,'11','2014-01-20','2014-01-20','admin','08:32:33','08:35:57','1','','2','5|0'),
(12,0,'12','2014-01-20','2014-01-20','admin','08:36:14','08:38:08','1','','4','2|0'),
(13,0,'13','2014-01-20','2014-01-20','admin','08:36:46','08:37:03','1','','3','8|0'),
(14,0,'14','2014-01-20','2014-01-20','admin','08:36:47','08:37:18','1','','3','1|0'),
(15,0,'15','2014-01-20','2014-01-20','admin','08:36:49','08:37:26','1','','3','3|0'),
(16,0,'16','2014-01-20','2014-01-20','admin','08:36:53','08:37:35','1','','3','4|0'),
(18,0,'18','2014-01-20','2014-01-20','admin','08:38:44','08:38:52','1','','5','4|0'),
(19,0,'19','2014-01-20','2014-01-20','admin','08:42:54','08:43:02','1','','6','8|0'),
(20,0,'20','2014-02-10','2014-02-10','admin','14:11:02','14:11:16','1','','1','9|0'),
(22,0,'22','2014-02-12','2014-02-12','admin','08:39:42','08:40:26','1','','3','9|0'),
(23,0,'23','2014-02-18','2014-02-18','admin','13:22:11','13:22:18','1','','7','10|0'),
(25,0,'25','2014-02-19','2014-02-19','admin','08:57:37','08:57:47','1','','8','12|0'),
(26,0,'26','2014-07-16','2014-07-16','admin','17:48:45','17:52:09','1','','1','13|0'),
(27,0,'27','2014-07-16','2015-06-17','admin','17:53:55','09:05:54','1','','9','6|0'),
(28,0,'28','2014-07-28','2014-07-28','admin','08:52:01','08:52:09','1','','1','14|0'),
(29,0,'29','2014-07-28','2014-07-28','admin','08:52:32','08:52:39','1','','10','14|0'),
(30,0,'30','2014-07-28','2014-07-28','admin','09:06:08','09:06:16','1','','4','15|0'),
(31,0,'31','2014-07-28','2014-07-28','admin','09:06:50','09:06:57','1','','11','2|0'),
(32,0,'32','2014-07-28','2014-07-28','admin','09:07:33','09:07:39','1','','3','15|0'),
(33,0,'33','2014-07-28','2014-07-28','admin','09:41:51','09:41:57','1','','1','15|0'),
(34,0,'34','2014-07-28','2014-07-28','admin','09:42:15','09:42:21','1','','12','15|0'),
(35,0,'35','2015-06-17','2015-06-17','admin','14:38:09','14:38:17','1','','1','6|0'),
(36,0,'36','2015-11-18','2015-11-18','admin','16:42:48','16:43:02','1','','13','2|0'),
(37,0,'37','2015-11-18','2015-11-18','admin','16:42:49','16:43:21','1','','13','4|0'),
(38,0,'38','2015-11-18','2015-11-18','admin','16:42:50','16:44:00','1','','13','8|0'),
(39,0,'39','2015-11-18','2015-11-18','admin','16:44:03','16:44:11','1','','13','5|0'),
(40,0,'40','2015-11-18','2015-11-18','admin','16:44:47','16:44:57','1','','14','5|0'),
(41,0,'41','2015-11-18','2015-11-18','admin','16:45:22','16:45:35','1','','15','2|0'),
(42,0,'42','2015-11-18','2015-11-18','admin','16:45:23','16:45:44','1','','15','4|0'),
(43,0,'43','2015-11-18','2015-11-18','admin','16:45:25','16:46:02','1','','15','8|0'),
(44,0,'44','2015-11-18','2015-11-18','admin','16:47:08','16:47:18','1','','16','2|0'),
(45,0,'45','2015-11-18','2015-11-18','admin','16:47:10','16:47:29','1','','16','4|0'),
(46,0,'46','2015-11-18','2015-11-18','admin','16:47:32','16:47:41','1','','16','10|0'),
(47,0,'47','2015-11-18','2015-11-18','admin','16:47:50','16:48:09','1','','16','8|0'),
(48,0,'48','2015-11-18','2015-11-18','admin','16:48:47','16:48:56','1','','17','4|0'),
(49,0,'49','2015-11-18','2015-11-18','admin','16:49:26','16:49:33','1','','18','10|0'),
(50,0,'50','2015-11-18','2015-11-18','admin','16:50:30','16:50:39','1','','13','1|0'),
(51,0,'51','2015-11-18','2015-11-18','admin','16:50:45','16:50:52','1','','15','1|0'),
(52,0,'1','2014-01-20','2014-07-16','admin','08:26:27','17:50:14','1','Wähler','1','7|0'),
(53,0,'1','2014-01-20','2014-07-16','admin','08:26:27','17:50:14','1','Wähler','1','16|0'),
(54,0,'1','2014-01-20','2014-07-16','admin','08:26:27','17:50:14','1','Wähler','1','17|0'),
(55,0,'55','2021-03-31','2021-03-31','admin','15:09:06','15:09:06','1','','1','-1|0'),
(56,0,'56','2021-03-31','2021-03-31','admin','15:10:25','15:10:25','1','','3','-1|0'),
(57,0,'57','2021-04-08','2021-04-08','admin','14:03:34','14:03:34','1','','19','13|0'),
(58,0,'58','2022-02-03','2022-02-03','admin','11:23:48','11:23:48','1','','1','12|0'),
(59,0,'59','2022-02-03','2022-02-03','admin','11:24:13','11:24:13','1','','3','12|0');