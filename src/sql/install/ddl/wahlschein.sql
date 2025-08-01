DELIMITER;

CREATE TABLE
  IF NOT EXISTS `wahlschein` (
    `id` bigint (20) NOT NULL,
    `stimmzettel` integer NOT NULL,
    `wahlscheinnummer` varchar(14) NOT NULL,
    `wahlberechtigte` bigint (20) NOT NULL,
    `wahlscheinstatus` integer DEFAULT 1,
    `wahlscheinstatus_grund` integer DEFAULT 0,
    `abgabetyp` integer DEFAULT 0,
    `pwhash` varchar(255) DEFAULT NULL,
    `username` varchar(255) DEFAULT NULL,
    `blocknumber` varchar(30) DEFAULT '0',
    `defered` tinyint (4) DEFAULT 0,
    `secret` varchar(500) DEFAULT NULL,
    `onlinecheck` tinyint (4) DEFAULT 0,
    `testdaten` tinyint (4) DEFAULT 0,
    `kombiniert` bigint (20) DEFAULT NULL,
    `usedate` date DEFAULT NULL,
    PRIMARY KEY (`id`, `stimmzettel`),
    KEY `idx_wahlschein_wahlscheinstatus` (`wahlscheinstatus`),
    KEY `idx_wahlschein_wahlscheinstatus_grund` (`wahlscheinstatus_grund`),
    KEY `idx_wahlschein_wahlberechtigte` (`wahlberechtigte`),
    KEY `idx_wahlschein_wahlscheinnummer` (`wahlscheinnummer`),
    KEY `idx_wahlschein_abgabetyp` (`abgabetyp`),
    KEY `fk_wahlschein_stimmzettel` (`stimmzettel`),
    KEY `uidx_wahlschein_username` (`username`),
    KEY `idx_wahlschein_blocknumber` (`blocknumber`),
    CONSTRAINT `fk_wahlschein_stimmzettel` FOREIGN KEY (`stimmzettel`) REFERENCES `stimmzettel` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_wahlschein_wahlberechtigte` FOREIGN KEY (`wahlberechtigte`) REFERENCES `wahlberechtigte` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_wahlschein_wahlscheinstatus` FOREIGN KEY (`wahlscheinstatus`) REFERENCES `wahlscheinstatus` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_wahlschein_abgabetyp` FOREIGN KEY (`abgabetyp`) REFERENCES `abgabetyp` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    `login` varchar(255) NOT NULL,
    `created_at` timestamp not null default current_timestamp,
    `updated_at` timestamp not null default current_timestamp on update current_timestamp
  )
WITH
  SYSTEM VERSIONING;

DELIMITER // 

CREATE
OR REPLACE TRIGGER `trigger_wahlschein_bi_defaults` BEFORE INSERT ON `wahlschein` FOR EACH ROW BEGIN IF NEW.login IS NULL THEN
SET
  NEW.login = getSessionUser ();

END IF;

IF NEW.created_at IS NULL THEN
SET
  NEW.created_at = CURRENT_TIMESTAMP;

END IF;

END // 

CREATE
OR REPLACE TRIGGER `trigger_wahlschein_bu_defaults` BEFORE
UPDATE ON `wahlschein` FOR EACH ROW BEGIN IF NEW.login IS NULL THEN
SET
  NEW.login = getSessionUser ();

END IF;

IF NEW.created_at IS NULL THEN
SET
  NEW.updated_at = CURRENT_TIMESTAMP;

END IF;

END //