DELIMITER ;

 CREATE TABLE IF NOT EXISTS `onlinestimmzettel` (
  `stimmzettel` id NOT NULL,
  `anzahl` int(11) DEFAULT 0,
  `login` varchar(255) DEFAULT NULL,
  `createdatetime` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`stimmzettel`),
  CONSTRAINT `fk_onlinestimmzettel_stimmzettel`
  foreign key (stimmzettel)
  references stimmzettel(id)
  on delete cascade
  on update cascade
);