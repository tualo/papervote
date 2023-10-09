DELIMITER ;
CREATE TABLE IF NOT EXISTS `wahlschein_hstr` (
  `hstr_sessionuser` varchar(150) DEFAULT '',
  `hstr_action` varchar(8) NOT NULL DEFAULT 'insert',
  `hstr_revision` varchar(36) NOT NULL,
  `hstr_datetime` timestamp NOT NULL DEFAULT current_timestamp(),
  `abgabehash` varchar(255) DEFAULT NULL,
  `abgabetyp` varchar(255) DEFAULT NULL,
  `aktiv` int(11) DEFAULT NULL,
  `antrag` tinyint(4) DEFAULT NULL,
  `blocknumber` varchar(30) DEFAULT NULL,
  `defered` tinyint(4) DEFAULT NULL,
  `id` bigint(20) DEFAULT NULL,
  `insert_date` date DEFAULT NULL,
  `insert_time` time DEFAULT NULL,
  `kostenstelle` int(11) DEFAULT NULL,
  `login` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `onlinecheck` tinyint(4) DEFAULT NULL,
  `pwhash` varchar(255) DEFAULT NULL,
  `ridx` varchar(12) DEFAULT NULL,
  `secret` varchar(500) DEFAULT NULL,
  `sendtotmg` tinyint(4) DEFAULT NULL,
  `stimmzettel` varchar(12) DEFAULT NULL,
  `testdaten` tinyint(4) DEFAULT NULL,
  `update_date` date DEFAULT NULL,
  `update_time` time DEFAULT NULL,
  `usedate` date DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `wahlberechtigte` varchar(12) DEFAULT NULL,
  `wahlscheinnummer` varchar(255) DEFAULT NULL,
  `wahlscheinstatus` varchar(12) DEFAULT NULL,
  `wahlscheinstatus_grund` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`hstr_revision`),
  KEY `idx_pri_wahlschein_hstr` (`id`,`stimmzettel`)
);

call create_or_upgrade_hstr_table('wahlschein');

