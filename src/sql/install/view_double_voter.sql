delimiter ;
CREATE OR REPLACE VIEW `view_double_voter` AS 


    select
        `x`.`c` AS `c`,
        `x`.`wn` AS `wn`,
        `x`.`typen` AS `typen`,
        `wahlschein`.`ridx` AS `ridx`,
        `wahlschein`.`id` AS `id`,
        `wahlschein`.`name` AS `name`,
        `wahlschein`.`aktiv` AS `aktiv`,
        `wahlschein`.`insert_date` AS `insert_date`,
        `wahlschein`.`insert_time` AS `insert_time`,
        `wahlschein`.`update_date` AS `update_date`,
        `wahlschein`.`update_time` AS `update_time`,
        `wahlschein`.`login` AS `login`,
        `wahlschein`.`stimmzettel` AS `stimmzettel`,
        `wahlschein`.`wahlscheinnummer` AS `wahlscheinnummer`,
        `wahlberechtigte`.`identnummer` AS `identnummer`,
        `wahlschein`.`wahlberechtigte` AS `wahlberechtigte`,
        `wahlschein`.`wahlscheinstatus` AS `wahlscheinstatus`,
        `wahlscheinstatus`.`name` AS `wahlscheinstatus_name`,
        `wahlschein`.`wahlscheinstatus_grund` AS `wahlscheinstatus_grund`,
        `wahlschein`.`abgabetyp` AS `abgabetyp`,
        `wahlschein`.`pwhash` AS `pwhash`,
        `wahlschein`.`username` AS `username`,
        `wahlschein`.`abgabehash` AS `abgabehash`,
        `wahlschein`.`sendtotmg` AS `sendtotmg`,
        `wahlschein`.`antrag` AS `antrag`,
        `wahlschein`.`blocknumber` AS `blocknumber`,
        `wahlschein`.`kostenstelle` AS `kostenstelle`,
        `wahlschein`.`defered` AS `defered`,
        `wahlschein`.`secret` AS `secret`,
        `wahlschein`.`onlinecheck` AS `onlinecheck`
    from
        (
            (
                (
                    `wahlschein`
                    join `wahlberechtigte` on(
                        `wahlschein`.`wahlberechtigte` = `wahlberechtigte`.`ridx`
                    )
                )
                join (
                    select
                        `wahlschein_hstr`.`wahlberechtigte` AS `wahlberechtigte`,
                        `wahlschein_hstr`.`stimmzettel` AS `stimmzettel`,
                        count(distinct `wahlschein_hstr`.`abgabetyp`) AS `count_abgabe`,
                        group_concat(
                            distinct `wahlschein_hstr`.`wahlscheinnummer`
                            order by
                                `wahlschein_hstr`.`te` ASC separator ','
                        ) AS `wn`,
                        group_concat(
                            distinct `wahlscheinstatus`.`name`
                            order by
                                `wahlschein_hstr`.`te` ASC separator ','
                        ) AS `c`,
                        group_concat(
                            distinct `abgabetyp`.`name`
                            order by
                                `wahlschein_hstr`.`te` ASC separator ','
                        ) AS `typen`
                    from
                        (
                            (
                                wahlschein for system_time all `wahlschein_hstr`
                                join `wahlscheinstatus` on(
                                    `wahlscheinstatus`.`ridx` = `wahlschein_hstr`.`wahlscheinstatus`
                                )
                            )
                            join `abgabetyp` on(
                                `abgabetyp`.`ridx` = `wahlschein_hstr`.`abgabetyp`
                            )
                        )
                    where
                        (
                            `wahlschein_hstr`.`abgabetyp` is not null
                            or `wahlschein_hstr`.`abgabetyp` = '0|0'
                        )
                        and `wahlschein_hstr`.`wahlscheinstatus` <> '1|0'
                    group by
                        `wahlschein_hstr`.`wahlberechtigte`,
                        `wahlschein_hstr`.`stimmzettel`
                    having
                        `count_abgabe` > 1
                ) `x` on(
                    `wahlschein`.`wahlberechtigte` = `x`.`wahlberechtigte`
                    and `wahlschein`.`abgabetyp` = '2|0'
                )
            )
            join `wahlscheinstatus` on(
                `wahlscheinstatus`.`ridx` = `wahlschein`.`wahlscheinstatus`
            )
        )
