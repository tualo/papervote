delimiter ;

CREATE TABLE IF NOT EXISTS `abgabetyp_offline_erlaubt` (

  `abgabetyp` integer NOT NULL,
  primary key( abgabetyp),

  CONSTRAINT `fk_abgabetyp_offline_erlaubt_abgabetyp` FOREIGN KEY (`abgabetyp`) REFERENCES `abgabetyp` (`id`) ON DELETE CASCADE ON UPDATE CASCADE



);


insert ignore into abgabetyp_offline_erlaubt (abgabetyp) values (0),(1);

