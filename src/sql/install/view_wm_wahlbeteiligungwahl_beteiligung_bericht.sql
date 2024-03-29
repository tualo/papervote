DELIMITER;

create
or replace view `view_wm_wahlbeteiligungwahl_beteiligung_bericht` as
select
    `config`.`id` AS `wahlbeteiligung_bericht_id`,
    `config`.`sortfield` AS `sortfield`,
    `wahlschein`.`stimmzettel` AS `stimmzettel`,
    `wahlschein`.`abgabetyp` AS `abgabetyp`,
    `stimmzettel`.`wahltyp` AS `szwahltyp`,
    'Vollversammlungswahl' AS `wahltypname`,
    `config`.`name` AS `name`,
    count(0) AS `c`
from
    (
        (
            `view_wm_wahlbeteiligungwahl_beteiligung_bericht_config` `config`
            join `wahlschein` on(
                json_search(
                    `config`.`statusliste_json`,
                    'one',
                    `wahlschein`.`wahlscheinstatus`
                ) is not null
                and (
                    (
                        `wahlschein`.`abgabetyp` = '1|0'
                        and json_value(`config`.`abgabetyp`, '$.abgabetyp1') = 1
                    )
                    
                    or (
                        `wahlschein`.`abgabetyp` = '2|0'
                        and json_value(`config`.`abgabetyp`, '$.abgabetyp2') = 1
                    )
                    or `wahlschein`.`abgabetyp` is null
                    or `wahlschein`.`abgabetyp`= '0|0'
                )
                and `wahlschein`.`testdaten` = 0
            )
        )
        join `stimmzettel` on(
            `stimmzettel`.`ridx` = `wahlschein`.`stimmzettel`
        )
    )
group by
    `config`.`name`,
    `stimmzettel`.`wahltyp`,
    `wahlschein`.`abgabetyp`,
    `wahlschein`.`stimmzettel`;