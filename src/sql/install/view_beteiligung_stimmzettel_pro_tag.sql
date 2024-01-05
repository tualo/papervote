DELIMITER ;
CREATE OR REPLACE VIEW `view_beteiligung_stimmzettel` AS (
    select
        cast(`wahlschein`.`ts` as date) AS `datum`,
        `wahlschein`.`wahlscheinstatus` AS `wahlscheinstatus`,
        `wahlschein`.`stimmzettel` AS `stimmzettel`,
        `x`.`waehler` AS `ges_SZ`,
        `x`.`name` AS `SZ`,
        sum(if(`wahlschein`.`abgabetyp` = '1|0', 1, 0)) AS `briefwahl`,
        sum(if(`wahlschein`.`abgabetyp` = '1|0', 1, 0)) * 1000 / `x`.`waehler` AS `briefwahl_prozent`,
        0 AS `onlinewahl`,
        0 AS `onlinewahl_prozent`
    from
        (
            `wahlschein`
            join (
                select
                    `stimmzettel`.`name` AS `name`,
                    `stimmzettel`.`ridx` AS `ridx`,
                    count(
                        distinct concat(
                            `wahlschein`.`wahlscheinnummer`,
                            `wahlschein`.`wahlscheinstatus`
                        )
                    ) AS `waehler`
                from
                    (
                        `stimmzettel`
                        join `wahlschein` on(
                            `wahlschein`.`stimmzettel` = `stimmzettel`.`ridx`
                        )
                    )
                group by
                    `stimmzettel`.`ridx`
            ) `x` on(`wahlschein`.`stimmzettel` = `x`.`ridx`)
        )
    where
        `wahlschein`.`wahlscheinstatus` = '2|0'
    group by
        cast(`wahlschein`.`ts` as date),
        `wahlschein`.`wahlscheinstatus`,
        `wahlschein`.`stimmzettel`
);

CREATE
OR REPLACE VIEW `view_beteiligung_stimmzettel_pro_tag` AS (
    select
        distinct `view_beteiligung_stimmzettel`.`datum` AS `datum`
    from
        `view_beteiligung_stimmzettel`
);