DELIMITER ;
CREATE TABLE IF NOT EXISTS `wahlscheinstatus_grund` (
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
  `barcode` varchar(255) DEFAULT NULL,
  `wahlscheinstatus` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`,`kostenstelle`),
  KEY `idx_wahlscheinstatus_grund_wahlscheinstatus` (`wahlscheinstatus`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
