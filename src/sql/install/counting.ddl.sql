DELIMITER ;

CREATE TABLE IF NOT EXISTS `kisten1` (
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
  UNIQUE KEY `idx_kisten1` (`ridx`),
  KEY `idx_kisten1_name` (`name`)
);

CREATE TABLE IF NOT EXISTS `stapel1` (
  `ridx` varchar(12) DEFAULT NULL,
  `id` int(11) NOT NULL DEFAULT 0,
  `kostenstelle` int(11) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `aktiv` int(11) DEFAULT 1,
  `insert_date` date NOT NULL,
  `update_date` date NOT NULL,
  `login` varchar(255) NOT NULL,
  `kisten1` varchar(12) DEFAULT NULL,
  `insert_time` time DEFAULT NULL,
  `update_time` time DEFAULT NULL,
  `abgebrochen` int(11) DEFAULT 0,
  PRIMARY KEY (`id`,`kostenstelle`),
  UNIQUE KEY `idx_stapel1` (`ridx`),
  KEY `idx_stapel1_kisten1` (`kisten1`),
  KEY `idx_stapel1_name` (`name`),
  CONSTRAINT `fk_stapel1_kisten1` FOREIGN KEY (`kisten1`) REFERENCES `kisten1` (`ridx`) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE IF NOT EXISTS `stimmzettel1` (
  `ridx` varchar(12) DEFAULT NULL,
  `id` int(11) NOT NULL DEFAULT 0,
  `kostenstelle` int(11) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `aktiv` int(11) DEFAULT 1,
  `insert_date` date NOT NULL,
  `update_date` date NOT NULL,
  `login` varchar(255) NOT NULL,
  `stapel1` varchar(12) DEFAULT NULL,
  `stimmzettel` varchar(12) DEFAULT NULL,
  `insert_time` time DEFAULT NULL,
  `update_time` time DEFAULT NULL,
  PRIMARY KEY (`id`,`kostenstelle`),
  UNIQUE KEY `idx_stimmzettel1` (`ridx`),
  UNIQUE KEY `idx_stimmzettel1_ridx` (`ridx`),
  KEY `idx_stimmzettel1_stimmzettel` (`stimmzettel`),
  KEY `idx_stimmzettel1_stapel1` (`stapel1`),
  KEY `idx_stimmzettel1_name` (`name`),
  CONSTRAINT `fk_stimmzettel1_stapel1` FOREIGN KEY (`stapel1`) REFERENCES `stapel1` (`ridx`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_stimmzettel1_stimmzettel` FOREIGN KEY (`stimmzettel`) REFERENCES `stimmzettel` (`ridx`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS `kandidaten1` (
  `ridx` varchar(12) DEFAULT NULL,
  `id` int(11) NOT NULL DEFAULT 0,
  `kostenstelle` int(11) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `aktiv` int(11) DEFAULT 1,
  `insert_date` date NOT NULL,
  `update_date` date NOT NULL,
  `login` varchar(255) NOT NULL,
  `kandidaten` varchar(12) DEFAULT NULL,
  `stimmzettel1` varchar(12) DEFAULT NULL,
  `insert_time` time DEFAULT NULL,
  `update_time` time DEFAULT NULL,
  PRIMARY KEY (`id`,`kostenstelle`),
  UNIQUE KEY `idx_kandidaten1` (`ridx`),
  UNIQUE KEY `idx_kandidaten1_ridx` (`ridx`),
  KEY `idx_kandidaten1_kandidaten` (`kandidaten`),
  KEY `idx_kandidaten1_name` (`name`),
  KEY `idx_kandidaten1_stimmzettel1` (`stimmzettel1`),
  CONSTRAINT `fk_kandidaten1_stimmzettel1` FOREIGN KEY (`stimmzettel1`) REFERENCES `stimmzettel1` (`ridx`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_kandidaten1_kandidaten` FOREIGN KEY (`kandidaten`) REFERENCES `kandidaten` (`ridx`) ON DELETE CASCADE ON UPDATE CASCADE
  
);


CREATE TABLE IF NOT EXISTS `kisten2` (
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
  UNIQUE KEY `idx_kisten2` (`ridx`),
  KEY `idx_kisten2_name` (`name`)
);

CREATE TABLE IF NOT EXISTS `stapel2` (
  `ridx` varchar(12) DEFAULT NULL,
  `id` int(11) NOT NULL DEFAULT 0,
  `kostenstelle` int(11) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `aktiv` int(11) DEFAULT 1,
  `insert_date` date NOT NULL,
  `update_date` date NOT NULL,
  `login` varchar(255) NOT NULL,
  `kisten2` varchar(12) DEFAULT NULL,
  `insert_time` time DEFAULT NULL,
  `update_time` time DEFAULT NULL,
  `abgebrochen` int(11) DEFAULT 0,
  PRIMARY KEY (`id`,`kostenstelle`),
  UNIQUE KEY `idx_stapel2` (`ridx`),
  KEY `idx_stapel2_name` (`name`),
  KEY `idx_stapel2_kisten2` (`kisten2`),
    CONSTRAINT `fk_stapel2_kisten2` FOREIGN KEY (`kisten2`) REFERENCES `kisten2` (`ridx`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS `stimmzettel2` (
  `ridx` varchar(12) DEFAULT NULL,
  `id` int(11) NOT NULL DEFAULT 0,
  `kostenstelle` int(11) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `aktiv` int(11) DEFAULT 1,
  `insert_date` date NOT NULL,
  `update_date` date NOT NULL,
  `login` varchar(255) NOT NULL,
  `stapel2` varchar(12) DEFAULT NULL,
  `stimmzettel` varchar(12) DEFAULT NULL,
  `insert_time` time DEFAULT NULL,
  `update_time` time DEFAULT NULL,
  PRIMARY KEY (`id`,`kostenstelle`),
  UNIQUE KEY `idx_stimmzettel2` (`ridx`),
  UNIQUE KEY `idx_stimmzettel2_ridx` (`ridx`),
  KEY `idx_stimmzettel2_stimmzettel` (`stimmzettel`),
  KEY `idx_stimmzettel2_stapel2` (`stapel2`),
  KEY `idx_stimmzettel2_name` (`name`),
    CONSTRAINT `fk_stimmzettel2_stapel2` FOREIGN KEY (`stapel2`) REFERENCES `stapel2` (`ridx`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_stimmzettel2_stimmzettel` FOREIGN KEY (`stimmzettel`) REFERENCES `stimmzettel` (`ridx`) ON DELETE CASCADE ON UPDATE CASCADE

);

CREATE TABLE IF NOT EXISTS `kandidaten2` (
  `ridx` varchar(12) DEFAULT NULL,
  `id` int(11) NOT NULL DEFAULT 0,
  `kostenstelle` int(11) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `aktiv` int(11) DEFAULT 1,
  `insert_date` date NOT NULL,
  `update_date` date NOT NULL,
  `login` varchar(255) NOT NULL,
  `stimmzettel2` varchar(12) DEFAULT NULL,
  `kandidaten` varchar(12) DEFAULT NULL,
  `insert_time` time DEFAULT NULL,
  `update_time` time DEFAULT NULL,
  PRIMARY KEY (`id`,`kostenstelle`),
  UNIQUE KEY `idx_kandidaten2` (`ridx`),
  UNIQUE KEY `idx_kandidaten2_ridx` (`ridx`),
  KEY `idx_kandidaten2_name` (`name`),
  KEY `idx_kandidaten2_stimmzettel2` (`stimmzettel2`),
  KEY `idx_kandidaten2_kandidaten` (`kandidaten`),
    CONSTRAINT `fk_kandidaten2_stimmzettel2` FOREIGN KEY (`stimmzettel2`) REFERENCES `stimmzettel2` (`ridx`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_kandidaten2_kandidaten` FOREIGN KEY (`kandidaten`) REFERENCES `kandidaten` (`ridx`) ON DELETE CASCADE ON UPDATE CASCADE
);

alter table stimmzettel2 modify id bigint;
alter table kandidaten2 modify id bigint;
alter table kandidaten2 modify `ridx` varchar(25);

 