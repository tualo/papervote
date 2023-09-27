DELIMITER ;

CREATE OR REPLACE VIEW `ohne_wahlberechtigten` AS 
select `wahlscheinstatus`.`id` AS `id`,`wahlscheinstatus`.`ridx` AS `ridx`,`wahlscheinstatus`.`name` AS `name` from `wahlscheinstatus` where `wahlscheinstatus`.`aktiv` = 1 and `wahlscheinstatus`.`ohne_wahlberechtigten` = 1 
;

