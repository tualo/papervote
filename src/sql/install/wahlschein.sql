DELIMITER ;
CREATE TABLE IF NOT EXISTS `wahlschein` (
  `ridx` varchar(12) DEFAULT NULL,
  `id` bigint(20) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `aktiv` tinyint DEFAULT 1,
  `insert_date` date NOT NULL,
  `insert_time` time DEFAULT NULL,
  `update_date` date NOT NULL,
  `update_time` time DEFAULT NULL,

  `login` varchar(255) NOT NULL,
  `stimmzettel` varchar(12) NOT NULL,
  `wahlscheinnummer` varchar(255) DEFAULT NULL,
  `wahlberechtigte` varchar(12) DEFAULT NULL,
  `wahlscheinstatus` varchar(12) DEFAULT NULL,
  `wahlscheinstatus_grund` varchar(255) DEFAULT NULL,
  `abgabetyp` varchar(255) DEFAULT NULL,
  `pwhash` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `abgabehash` varchar(255) DEFAULT NULL,
  `sendtotmg` tinyint(4) DEFAULT 0,
  `antrag` tinyint(4) DEFAULT 0,
  `blocknumber` varchar(30) DEFAULT '0',
  `kostenstelle` int(11) NOT NULL DEFAULT 0,
  `defered` tinyint(4) DEFAULT 0,
  `secret` varchar(500) DEFAULT NULL,
  `onlinecheck` tinyint(4) DEFAULT 0,
  `testdaten` tinyint(4) DEFAULT 0,
  `usedate` date DEFAULT NULL,
  PRIMARY KEY (`id`,`stimmzettel`),
  UNIQUE KEY `idx_wahlschein` (`ridx`),
  UNIQUE KEY `idx_wahlschein_ridx` (`ridx`),
  KEY `idx_wahlschein_wahlscheinstatus` (`wahlscheinstatus`),
  KEY `idx_wahlschein_wahlscheinstatus_grund` (`wahlscheinstatus_grund`),
  KEY `idx_wahlschein_wahlberechtigte` (`wahlberechtigte`),
  KEY `idx_wahlschein_wahlscheinnummer` (`wahlscheinnummer`),
  KEY `idx_wahlschein_name` (`name`),
  KEY `idx_wahlschein_abgabetyp` (`abgabetyp`),
  KEY `idx_wahlschein_sendtotmg` (`sendtotmg`),
  KEY `fk_wahlschein_stimmzettel` (`stimmzettel`),
  KEY `uidx_wahlschein_username` (`username`),
  KEY `idx_wahlschein_blocknumber` (`blocknumber`),
  CONSTRAINT `fk_wahlschein_stimmzettel` FOREIGN KEY (`stimmzettel`) REFERENCES `stimmzettel` (`ridx`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_wahlschein_wahlberechtigte` FOREIGN KEY (`wahlberechtigte`) REFERENCES `wahlberechtigte` (`ridx`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_wahlschein_wahlscheinstatus` FOREIGN KEY (`wahlscheinstatus`) REFERENCES `wahlscheinstatus` (`ridx`) ON DELETE CASCADE ON UPDATE CASCADE
);



call fill_ds('wahlschein');
call fill_ds_column('wahlschein');

