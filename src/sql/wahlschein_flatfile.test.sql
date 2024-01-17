CREATE OR REPLACE VIEW `wahlschein_flatfile` AS
select
    `wahlberechtigte_anlage`.*,
    `wahlschein`.`wahlscheinnummer` AS `wahlschein_wahlscheinnummer`,
    cast(`wahlschein`.`ts` as date) AS `wahlschein_insert_date`,
    cast(`wahlschein`.`ts` as date) AS `wahlschein_update_date`,
    `wahlscheinstatus`.`name` AS `status_text`,
    `abgabetyp`.`name` AS `abgabetyp_text`,
    `stimmzettel`.`name` AS `stimmzettel_name`
from
    `wahlberechtigte_anlage`
    join `stimmzettel` on  `stimmzettel`.`ridx` = `wahlberechtigte_anlage`.`stimmzettel`
    join `wahlberechtigte` on `wahlberechtigte_anlage`.`identnummer` = `wahlberechtigte`.`identnummer`
    join `wahlschein` on  
        `wahlschein`.id = concat(`stimmzettel`.`id`,lpad(`wahlberechtigte_anlage`.`identnummer`,8,'0'))
        and `wahlberechtigte`.`ridx` = `wahlschein`.`wahlberechtigte`
    join `wahlscheinstatus` on
        `wahlscheinstatus`.`ridx` = `wahlschein`.`wahlscheinstatus`
    join `abgabetyp` on `abgabetyp`.`ridx` = `wahlschein`.`abgabetyp`