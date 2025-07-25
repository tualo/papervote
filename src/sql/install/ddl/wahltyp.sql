DELIMITER ;
CREATE TABLE IF NOT EXISTS `wahltyp` (
  `id` int(11) NOT NULL DEFAULT 1,
  `name` varchar(255) DEFAULT NULL,
  `feld` varchar(255) DEFAULT '',
  `aktiv` tinyint(4) DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `idx_wahltyp_name` (`name`),

  `login` varchar(255) NOT NULL,
  `created_at` timestamp not null default current_timestamp,
  `updated_at` timestamp not null default current_timestamp on update current_timestamp

);



DELIMITER //

CREATE OR REPLACE TRIGGER `trigger_wahltyp_bi_defaults`
BEFORE INSERT ON `wahltyp` FOR EACH ROW
BEGIN
  IF NEW.login IS NULL THEN
    SET NEW.login = getSessionUser();
  END IF;
  IF NEW.created_at IS NULL THEN
    SET NEW.created_at = CURRENT_TIMESTAMP;
  END IF;
END //

CREATE OR REPLACE TRIGGER `trigger_wahltyp_bu_defaults`
BEFORE UPDATE ON `wahltyp` FOR EACH ROW
BEGIN
  IF NEW.login IS NULL THEN
    SET NEW.login = getSessionUser();
  END IF;
  IF NEW.created_at IS NULL THEN
    SET NEW.updated_at = CURRENT_TIMESTAMP;
  END IF;
END //
