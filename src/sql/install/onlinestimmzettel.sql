DELIMITER ;

 CREATE TABLE IF NOT EXISTS `onlinestimmzettel` (
  `stimmzettel` varchar(12) NOT NULL,
  `anzahl` int(11) DEFAULT 0,
  PRIMARY KEY (`stimmzettel`),
  CONSTRAINT `fk_onlinestimmzettel_stimmzettel`
  foreign key (stimmzettel)
  references stimmzettel(ridx)
  on delete cascade
  on update cascade
);