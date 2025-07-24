DELIMITER ;

CREATE TABLE IF NOT EXISTS `reportfiles_typen` (
  `id` varchar(12) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
);

insert ignore into `reportfiles_typen` (`id`, `name`) values ('unkown', 'Unbekannter Typ') ;
