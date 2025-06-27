DELIMITER ;

CREATE TABLE IF NOT EXISTS `onlinestimmzettel` (
  `stimmzettel` integer NOT NULL,
  
  `anzahl` int(11) DEFAULT 0,
  `erwartet` int(11) DEFAULT 0,


  `enthaltung` int(11) DEFAULT 0,
  `ungueltig` int(11) DEFAULT 0,  

  `login` varchar(255) DEFAULT NULL,
  `createdatetime` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`stimmzettel`),
  CONSTRAINT `fk_onlinestimmzettel_stimmzettel`
  foreign key (stimmzettel)
  references stimmzettel(id)
  on delete cascade
  on update cascade
);



alter table `onlinestimmzettel` add column if not exists `erwartet` int(11) DEFAULT 0;
alter table `onlinestimmzettel` add column if not exists `enthaltung` int(11) DEFAULT 0;
alter table `onlinestimmzettel` add column if not exists `ungueltig` int(11) DEFAULT 0;
alter table `onlinestimmzettel` add column if not exists  `login` varchar(255) DEFAULT NULL;
alter table `onlinestimmzettel` add column if not exists  `createdatetime` datetime DEFAULT CURRENT_TIMESTAMP;

DELIMITER //
CREATE OR REPLACE TRIGGER `trigger_stimmzettel_ai_onlinestimmzettel`
AFTER INSERT ON `stimmzettel` FOR EACH ROW
BEGIN
  insert ignore into onlinestimmzettel(stimmzettel) values (new.id) ;
END //

