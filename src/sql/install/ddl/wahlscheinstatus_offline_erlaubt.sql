delimiter ;

CREATE TABLE IF NOT EXISTS `wahlscheinstatus_offline_erlaubt` (

  `wahlscheinstatus` integer NOT NULL,
  `abgabetyp` integer NOT NULL,
  primary key(wahlscheinstatus, abgabetyp),

  CONSTRAINT `fk_wahlscheinstatus_offline_erlaubt_wahlscheinstatus` FOREIGN KEY (`wahlscheinstatus`) REFERENCES `wahlscheinstatus` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_wahlscheinstatus_offline_erlaubt_abgabetyp` FOREIGN KEY (`abgabetyp`) REFERENCES `abgabetyp` (`id`) ON DELETE CASCADE ON UPDATE CASCADE



);


insert ignore into wahlscheinstatus_offline_erlaubt (wahlscheinstatus,abgabetyp) values (1,0),(1,1),(-1,0);

