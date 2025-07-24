delimiter ;

CREATE VIEW IF NOT EXISTS `view_readtable_wahlzeichnungsberechtigter` AS
select
    `wahlzeichnungsberechtigter`.`id` AS `id`,
    `wahlzeichnungsberechtigter`.`kostenstelle` AS `kostenstelle`,
    `wahlzeichnungsberechtigter`.`ridx` AS `ridx`,
    `wahlzeichnungsberechtigter`.`insert_date` AS `insert_date`,
    `wahlzeichnungsberechtigter`.`update_date` AS `update_date`,
    `wahlzeichnungsberechtigter`.`login` AS `login`,
    `wahlzeichnungsberechtigter`.`insert_time` AS `insert_time`,
    `wahlzeichnungsberechtigter`.`update_time` AS `update_time`,
    `wahlzeichnungsberechtigter`.`aktiv` AS `aktiv`,
    `wahlzeichnungsberechtigter`.`name` AS `name`,
    `wahlzeichnungsberechtigter`.`funktion` AS `funktion`,
    `wahlzeichnungsberechtigter`.`personenident` AS `personenident`,
    `wahlzeichnungsberechtigter`.`wahlberechtigte` AS `wahlberechtigte`,
    `wahlzeichnungsberechtigter`.`geburtsdatum` AS `geburtsdatum`,
    `wahlzeichnungsberechtigter`.`vorname` AS `vorname`,
    `wahlzeichnungsberechtigter`.`nachname` AS `nachname`,
    `wahlzeichnungsberechtigter`.`namenstitel` AS `namenstitel`,
    `wahlzeichnungsberechtigter`.`nachtitel` AS `nachtitel`,
    concat(
        `wahlzeichnungsberechtigter`.`nachname`,
        ', ',
        `wahlzeichnungsberechtigter`.`vorname`,
        '',
        if(
            ifnull(`wahlzeichnungsberechtigter`.`nachtitel`, '') <> '',
            concat(', ', `wahlzeichnungsberechtigter`.`nachtitel`),
            ''
        ),
        if(
            ifnull(`wahlzeichnungsberechtigter`.`namenstitel`, '') <> '',
            concat(', ', `wahlzeichnungsberechtigter`.`namenstitel`),
            ''
        )
    ) AS `anzeige_name`
from
    `wahlzeichnungsberechtigter`;