delimiter ;


CREATE TABLE IF NOT EXISTS `wzbruecklauffelder` (
  `column_name` varchar(50) NOT NULL,
  `aktiv` tinyint(4) DEFAULT 1,
  `reihenfolge` int(11) DEFAULT 0,
  PRIMARY KEY (`column_name`)
)
;
/*!40101 SET character_set_client = @saved_cs_client */;

INSERT IGNORE INTO `wzbruecklauffelder` VALUES
('anzeige_name',1,5),
('funktion',1,2),
('name',1,1),
('personenident',1,0);
--
-- Dumping data for table `wzbruecklauffelder`
--
