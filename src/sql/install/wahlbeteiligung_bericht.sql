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
  `abgabetyp` longtext DEFAULT '{"abgabetyp0":true,"abgabetyp1":true,"abgabetyp2":true}',
  PRIMARY KEY (`id`),
  KEY `idx_wahlbeteiligung_bericht_ridx` (`ridx`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
