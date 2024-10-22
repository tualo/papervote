DELIMITER ;
CREATE TABLE IF NOT EXISTS `log_class` (
`id` int NOT NULL,
`name` varchar(255) default '',
 PRIMARY KEY (`id`)
);
insert into `log_class` values (0,'System');
insert into `log_class` values (1,'Kandidaten');
insert into `log_class` values (2,'Sync');

CREATE TABLE IF NOT EXISTS `log_level` (
`id` int NOT NULL,
`name` varchar(255) default '',
 PRIMARY KEY (`id`)
);
insert into `log_level` values (0,'INFO');
insert into `log_level` values (1,'WARNING');
insert into `log_level` values (2,'ERROR');


CREATE TABLE IF NOT EXISTS `logging` (
`id` UUID NOT NULL DEFAULT UUID(),
`log_class_id` INT NOT NULL DEFAULT 0,
`timestamp` datetime DEFAULT NOW(),
`log_level_id` INT NOT NULL DEFAULT 0,
`session_user` varchar(255) default '',
`message` varchar(1000) default '',
 PRIMARY KEY (`id`),
 CONSTRAINT `fk_log_class` FOREIGN KEY (`log_class_id`) REFERENCES `log_class` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
 CONSTRAINT `fk_log_level` FOREIGN KEY (`log_level_id`) REFERENCES `log_level` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE OR REPLACE VIEW `view_kandidaten_logs` AS
    select  `logging`.`*`,
            `kandidaten`.`ridx`
    from `logging`
    join `kandidaten` on (`logging`.`session_user`=`kandidaten.email`);
