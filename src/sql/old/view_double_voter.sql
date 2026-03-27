delimiter ;
CREATE OR REPLACE VIEW `view_double_voter` AS
select
    `x`.`c` AS `c`,
    `x`.`wn` AS `wn`,
    `x`.`typen` AS `typen`,
    `wahlschein`.`id` AS `id`,
    `wahlschein`.`created_at` AS `insert_date`,
    `wahlschein`.`updated_at` AS `update_date`,
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
    `wahlschein`.`blocknumber` AS `blocknumber`,
    `wahlschein`.`defered` AS `defered`,
    `wahlschein`.`secret` AS `secret`,
    `wahlschein`.`onlinecheck` AS `onlinecheck`
from
    (
        (
            (
                `wahlschein`
                join `wahlberechtigte` on(
                    `wahlschein`.`wahlberechtigte` = `wahlberechtigte`.`id`
                )
            )
            join (
                select
                    `wahlschein_history`.`wahlberechtigte` AS `wahlberechtigte`,
                    `wahlschein_history`.`stimmzettel` AS `stimmzettel`,
                    count(distinct `wahlschein_history`.`abgabetyp`) AS `count_abgabe`,
                    group_concat(
                        distinct `wahlschein_history`.`wahlscheinnummer`
                        order by
                            `wahlschein_history`.`updated_at` ASC separator ','
                    ) AS `wn`,
                    group_concat(
                        distinct `wahlscheinstatus`.`name`
                        order by
                            `wahlschein_history`.`updated_at` ASC separator ','
                    ) AS `c`,
                    group_concat(
                        distinct `abgabetyp`.`name`
                        order by
                            `wahlschein_history`.`updated_at` ASC separator ','
                    ) AS `typen`
                from
                    (
                        (
                            `wahlschein_history`
                            join `wahlscheinstatus` on(
                                `wahlscheinstatus`.`id` = `wahlschein_history`.`wahlscheinstatus`
                            )
                        )
                        join `abgabetyp` on(
                            `abgabetyp`.`id` = `wahlschein_history`.`abgabetyp`
                        )
                    )
                where
                    `wahlschein_history`.`abgabetyp` in (1, 2)
                    and `wahlschein_history`.`wahlscheinstatus` <> 1
                group by
                    `wahlschein_history`.`wahlberechtigte`,
                    `wahlschein_history`.`stimmzettel`
                having
                    `count_abgabe` > 1
            ) `x` on(
                `wahlschein`.`wahlberechtigte` = `x`.`wahlberechtigte`
                and `wahlschein`.`abgabetyp` = 2
            )
        )
        join `wahlscheinstatus` on(
            `wahlscheinstatus`.`id` = `wahlschein`.`wahlscheinstatus`
        )
    )
 ;