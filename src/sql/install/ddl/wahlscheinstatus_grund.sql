DELIMITER ;
CREATE TABLE IF NOT EXISTS `wahlscheinstatus_grund` (
  `id` int(11) NOT NULL,
  `aktiv` tinyint DEFAULT 0,
  `name` varchar(255) not NULL,
  `barcode` varchar(36) DEFAULT uuid(),
  `wahlscheinstatus` integer not null,
  PRIMARY KEY (`id`),
  KEY `idx_wahlscheinstatus_grund_wahlscheinstatus` (`wahlscheinstatus`),


  CONSTRAINT `fk_wahlscheinstatus_grund_wahlscheinstatus` FOREIGN KEY (`wahlscheinstatus`) REFERENCES `wahlscheinstatus` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,



  `login` varchar(255) NOT NULL,
  `created_at` timestamp not null default current_timestamp,
  `updated_at` timestamp not null default current_timestamp on update current_timestamp

);

DELIMITER //

CREATE OR REPLACE TRIGGER `trigger_wahlscheinstatus_grund_bi_defaults`
BEFORE INSERT ON `wahlscheinstatus_grund` FOR EACH ROW
BEGIN
  IF NEW.login IS NULL THEN
    SET NEW.login = getSessionUser();
  END IF;
  IF NEW.created_at IS NULL THEN
    SET NEW.created_at = CURRENT_TIMESTAMP;
  END IF;
END //

CREATE OR REPLACE TRIGGER `trigger_wahlscheinstatus_grund_bu_defaults`
BEFORE UPDATE ON `wahlscheinstatus_grund` FOR EACH ROW
BEGIN
  IF NEW.login IS NULL THEN
    SET NEW.login = getSessionUser();
  END IF;
  IF NEW.created_at IS NULL THEN
    SET NEW.updated_at = CURRENT_TIMESTAMP;
  END IF;
END //
