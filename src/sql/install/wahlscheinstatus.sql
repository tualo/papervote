DELIMITER ;
CREATE TABLE IF NOT EXISTS `wahlscheinstatus` (
  `ridx` varchar(12) DEFAULT NULL,
  `id` int(11) NOT NULL DEFAULT 0,
  `kostenstelle` int(11) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `aktiv` tinyint(4) DEFAULT 1,
  `insert_date` date NOT NULL,
  `update_date` date NOT NULL,
  `login` varchar(255) NOT NULL,
  `fibukonto` varchar(20) DEFAULT NULL,
  `steuerschluessel` varchar(20) DEFAULT NULL,
  `beschreibung` varchar(4000) DEFAULT NULL,
  `insert_time` time DEFAULT NULL,
  `update_time` time DEFAULT NULL,
  `barcode` varchar(255) DEFAULT NULL,
  `farbe` varchar(255) DEFAULT NULL,
  `ohne_wahlberechtigten` varchar(255) DEFAULT NULL,
  `sz_count` int(11) DEFAULT 0,
  PRIMARY KEY (`id`,`kostenstelle`),
  UNIQUE KEY `idx_wahlscheinstatus` (`ridx`),
  UNIQUE KEY `idx_wahlscheinstatus_ridx` (`ridx`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
