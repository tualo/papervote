DELIMITER ;

CREATE TABLE IF NOT EXISTS `onlinekandidaten` (
  `id` int(11) NOT NULL ,
  `anzahl` int(11) NOT NULL DEFAULT 0,
  `login` varchar(255) DEFAULT NULL,
  `createdatetime` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),

  CONSTRAINT `fk_onlinekandidaten_kandidaten_id`
  foreign key (`id`)
   
  references kandidaten(`id`)
  on delete cascade
  on update cascade,


  CONSTRAINT `fk_onlinekandidaten_kandidaten_ridx`
  foreign key (`id`)
   
  references kandidaten(`id`)
  on delete cascade
  on update cascade
)