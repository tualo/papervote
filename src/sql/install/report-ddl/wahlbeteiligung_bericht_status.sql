DELIMITER ;


CREATE TABLE IF NOT EXISTS `wahlbeteiligung_bericht_status` (
  `wahlbeteiligung_bericht` integer NOT NULL,
  `wahlscheinstatus` integer NOT NULL,
  `aktiv` tinyint DEFAULT 0,
  PRIMARY KEY (`wahlbeteiligung_bericht`,`wahlscheinstatus`),

  KEY `idx_wahlbeteiligung_bericht_status_wahlbeteiligung_bericht` (`wahlbeteiligung_bericht`),
  KEY `idx_wahlbeteiligung_bericht_status_wahlscheinstatus` (`wahlscheinstatus`),

  CONSTRAINT `fk_wahlbeteiligung_bericht_status_wahlbeteiligung_bericht` FOREIGN KEY (`wahlbeteiligung_bericht`) REFERENCES `wahlbeteiligung_bericht` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_wahlbeteiligung_bericht_status_wahlscheinstatus` FOREIGN KEY (`wahlbeteiligung_bericht`) REFERENCES `wahlscheinstatus` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ;

