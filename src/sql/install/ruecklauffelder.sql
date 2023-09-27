delimiter ;
CREATE TABLE IF NOT EXISTS `ruecklauffelder` (
  `column_name` varchar(50) NOT NULL,
  `aktiv` tinyint(4) DEFAULT 1,
  `reihenfolge` int(11) DEFAULT 0,
  PRIMARY KEY (`column_name`)
);

INSERT IGNORE INTO `ruecklauffelder` VALUES
('displ_stimmzettel_name_bold',1,9),
('hstr',1,13),
('identnummer',1,0),
('last_state_text',1,12),
('leerzeile',1,8),
('leerzeile2',1,11),
('plz_ort',1,6),
('post_land',1,7),
('post_name1',1,1),
('post_name2',1,2),
('post_name3',1,3),
('post_name4',1,4),
('post_strasse',1,5);

