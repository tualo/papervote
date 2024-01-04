DELIMITER;

create
or replace view `view_wm_bekanntmachung` as
select
    `a`.`id` AS `id`,
    format(`a`.`wahlberechtigte`, 0, 'de_DE') AS `wahlberechtigte`,
    format(`b`.`zugelassen`, 0, 'de_DE') AS `zugelassen`,
    format(`c`.`zurueckgewiesen`, 0, 'de_DE') AS `zurueckgewiesen`,
    format(`d`.`zugelassen_ra`, 0, 'de_DE') AS `zugelassen_ra`,
    format(`e`.`zugelassen_vv`, 0, 'de_DE') AS `zugelassen_vv`,
    '25. April' AS `von_txt`,
    '07. Mai 2020, 14Uhr' AS `bis_txt`,
    `view_wm_bekanntmachung_kandidaten_liste_wm_bekanntmachung`.`o` AS `liste`
from
    (
        (
            (
                (
                    (
                        `view_wm_bekanntmachung_kandidaten_liste_wm_bekanntmachung`
                        join (
                            select
                                1 AS `id`,
                                count(distinct `wahlschein`.`wahlberechtigte`) AS `wahlberechtigte`
                            from
                                `wahlschein`
                        ) `a`
                    )
                    join (
                        select
                            1 AS `id`,
                            count(distinct `wahlschein`.`wahlberechtigte`) AS `zugelassen`
                        from
                            `wahlschein`
                        where
                            `wahlschein`.`wahlscheinstatus` = '2|0'
                    ) `b`
                )
                join (
                    select
                        1 AS `id`,
                        count(distinct `wahlschein`.`wahlberechtigte`) AS `zurueckgewiesen`
                    from
                        `wahlschein`
                    where
                        `wahlschein`.`wahlscheinstatus` = '3|0'
                ) `c`
            )
            join (
                select
                    1 AS `id`,
                    count(distinct `wahlschein`.`wahlberechtigte`) AS `zugelassen_ra`
                from
                    (
                        `wahlschein`
                        join `stimmzettel` on(
                            `wahlschein`.`stimmzettel` = `stimmzettel`.`ridx`
                            and `wahlschein`.`stimmzettel` >= 4
                        )
                    )
                where
                    `wahlschein`.`wahlscheinstatus` = '2|0'
            ) `d`
        )
        join (
            select
                1 AS `id`,
                count(distinct `wahlschein`.`wahlberechtigte`) AS `zugelassen_vv`
            from
                (
                    `wahlschein`
                    join `stimmzettel` on(
                        `wahlschein`.`stimmzettel` = `stimmzettel`.`ridx`
                        and `wahlschein`.`stimmzettel` < 4
                    )
                )
            where
                `wahlschein`.`wahlscheinstatus` = '2|0'
        ) `e`
    );