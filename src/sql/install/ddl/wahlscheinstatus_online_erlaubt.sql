delimiter ;

CREATE TABLE IF NOT EXISTS `wahlscheinstatus_online_erlaubt` (

  `wahlscheinstatus` integer NOT NULL,
  `abgabetyp` integer NOT NULL,
  primary key(wahlscheinstatus, abgabetyp),

  CONSTRAINT `fk_wahlscheinstatus_online_erlaubt_wahlscheinstatus` FOREIGN KEY (`wahlscheinstatus`) REFERENCES `wahlscheinstatus` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_wahlscheinstatus_online_erlaubt_abgabetyp` FOREIGN KEY (`abgabetyp`) REFERENCES `abgabetyp` (`id`) ON DELETE CASCADE ON UPDATE CASCADE



);

select
                                    `wahlscheinstatus_online_erlaubt`.`wahlscheinstatus`,
                                    `wahlscheinstatus_online_erlaubt`.`abgabetyp`
                                from
                                    `wahlscheinstatus_online_erlaubt`;

insert ignore into wahlscheinstatus_online_erlaubt (wahlscheinstatus,abgabetyp) values (1,0);
update wahlschein set abgabetyp = 0 where abgabetyp is null ;
