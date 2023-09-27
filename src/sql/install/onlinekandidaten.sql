DELIMITER ;

CREATE TABLE IF NOT EXISTS `onlinekandidaten` (
  `ridx` varchar(12) DEFAULT NULL,
  `id` int(11) NOT NULL DEFAULT 0,
  `kostenstelle` int(11) NOT NULL DEFAULT 0,
  `anzahl` int(11) DEFAULT NULL,
  `insert_time` time DEFAULT NULL,
  `update_time` time DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `insert_date` varchar(255) DEFAULT NULL,
  `login` varchar(255) DEFAULT NULL,
  `update_date` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),

  CONSTRAINT `fk_onlinekandidaten_kandidaten_id`
  foreign key (`id`)
   
  references kandidaten(`id`)
  on delete cascade
  on update cascade,

unique key `uidx_fk_onlinekandidaten_ridx` (`ridx`),

  CONSTRAINT `fk_onlinekandidaten_kandidaten_ridx`
  foreign key (`ridx`)
   
  references kandidaten(`ridx`)
  on delete cascade
  on update cascade
)