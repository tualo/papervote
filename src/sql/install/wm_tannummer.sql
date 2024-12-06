DELIMITER ;
CREATE TABLE IF NOT EXISTS `wm_tannummer` (
  `tannummer` varchar(25) NOT NULL,
  `aktiv` int(11) DEFAULT 0,
  `bogen` int(11) NOT NULL,
  PRIMARY KEY (`tannummer`),
  KEY `idx_wm_tanboegen_bogen` (`bogen`),
  CONSTRAINT `fk_wm_tanboegen_bogen` FOREIGN KEY (`bogen`) REFERENCES `wm_tanboegen` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ;
