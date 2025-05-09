DELIMITER ;
CREATE TABLE IF NOT EXISTS `abgabetyp` (
  `ridx` varchar(12) DEFAULT NULL,
  `id` int(11) NOT NULL DEFAULT 0,
  `kostenstelle` int(11) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `aktiv` int(11) DEFAULT 1,
  `insert_date` date NOT NULL,
  `update_date` date NOT NULL,
  `login` varchar(255) NOT NULL,
  `insert_time` time DEFAULT NULL,
  `update_time` time DEFAULT NULL,
  PRIMARY KEY (`id`,`kostenstelle`),
  UNIQUE KEY `idx_abgabetyp` (`ridx`),
  UNIQUE KEY `idx_abgabetyp_ridx` (`ridx`)
) ;
