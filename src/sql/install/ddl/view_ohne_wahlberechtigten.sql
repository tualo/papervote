DELIMITER;

CREATE OR REPLACE VIEW `view_ohne_wahlberechtigten` AS
select
    `wahlscheinstatus`.`id` AS `id`,
    `wahlscheinstatus`.`name` AS `name`
from
    `wahlscheinstatus`
where
    `wahlscheinstatus`.`aktiv` = 1
    and `wahlscheinstatus`.`ohne_wahlberechtigten` = 1;