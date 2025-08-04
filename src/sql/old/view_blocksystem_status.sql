DELIMITER ;

CREATE OR REPLACE VIEW `view_blocksystem_status_blocks_wahlscheine` AS (
    select
        `wahlschein`.`id` AS `id`,
        concat(
            `wahlschein`.`blocknumber`,
            `wahlschein`.`wahlscheinstatus`
        ) AS `blocks_id`,
        cast(`wahlschein`.`row_start` as date) AS `letzte_aenderung`,
        `wahlschein`.`wahlscheinstatus` AS `wahlscheinstatus`,
        `wahlschein`.`wahlscheinnummer` AS `wahlscheinnummer`,
        `wahlberechtigte`.`identnummer` AS `identnummer`,
        `wahlschein`.`blocknumber` AS `blocknumber`,
        `wahlscheinstatus`.`name` AS `name`,
        `stimmzettel`.`name` AS `stimmzettel`
    from
        (
            (
                (
                    `wahlschein`
                    join `wahlscheinstatus` on(
                        `wahlschein`.`wahlscheinstatus` = `wahlscheinstatus`.`ridx`
                    )
                )
                join `wahlberechtigte` on(
                    `wahlschein`.`wahlberechtigte` = `wahlberechtigte`.`ridx`
                )
            )
            join `stimmzettel` on(
                `wahlschein`.`stimmzettel` = `stimmzettel`.`ridx`
            )
        )
    where
        `wahlschein`.`blocknumber` <> '0'
);

CREATE oR replace VIEW `view_blocksystem_status_blocks` AS (
    select
        concat(
            `wahlschein`.`blocknumber`,
            `wahlschein`.`wahlscheinstatus`
        ) AS `id`,
        `wahlschein`.`wahlscheinstatus` AS `wahlscheinstatus`,
        `wahlschein`.`blocknumber` AS `blocknumber`,
        `wahlscheinstatus`.`name` AS `name`,
        max(
            cast(`wahlschein`.`row_start` as date)
        ) AS `letzte_aenderung`,
        count(distinct `wahlschein`.`id`) AS `anzahl_wahlscheine`
    from
        (
            `wahlschein`
            join `wahlscheinstatus` on(
                `wahlschein`.`wahlscheinstatus` = `wahlscheinstatus`.`ridx`
            )
        )
    where
        `wahlschein`.`blocknumber` <> '0'
    group by
        `wahlschein`.`wahlscheinstatus`,
        `wahlschein`.`blocknumber`
);

CREATE OR REPLACE VIEW `view_blocksystem_status` AS (
    select
        `wahlschein`.`wahlscheinstatus` AS `wahlscheinstatus`,
        `wahlscheinstatus`.`name` AS `name`,
        cast(`wahlschein`.`row_start` as date) AS `letzte_aenderung`,
        count(distinct `wahlschein`.`id`) AS `anzahl_wahlscheine`,
        count(distinct `wahlschein`.`blocknumber`) AS `anzahl_blocknumber`
    from
        (
            `wahlschein`
            join `wahlscheinstatus` on(
                `wahlschein`.`wahlscheinstatus` = `wahlscheinstatus`.`ridx`
            )
        )
    where
        `wahlschein`.`blocknumber` <> '0'
    group by
        `wahlschein`.`wahlscheinstatus`
);
