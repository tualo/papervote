DELIMITER;

create
or replace view `view_wm_wahlbeteiligungwahl_beteiligung_bericht_datenobject` as
select
    `a`.`stimmzettel` AS `stimmzettel`,
    `stimmzettel`.`id` AS `position`,
    `stimmzettel`.`wahltyp` AS `wahltyp`,
    `wahltyp`.`name` AS `wahltypname`,
    `stimmzettel`.`name` AS `name`,
    concat(
        `stimmzettel`.`typtitel`,
        ' - ',
        `wahlgruppe`.`name`
    ) AS `typtitel`,
    `view_wm_wahlbeteiligungwahl_beteiligung_bericht_config_object`.`config` AS `spaltenconfig`,
    `view_wm_wahlbeteiligungwahl_beteiligung_bericht_formel_object`.`config` AS `formelconfig`,
    `wtypo`.`o` AS `wahltypconfig`,
    json_object(
        'stimmzettel',
        `a`.`stimmzettel`,
        'spalten',
        json_merge_preserve(
            '[]',
            concat(
                '[',
                group_concat(
                    `a`.`data`
                    order by
                        json_value(`a`.`data`, '$.sortfield') ASC separator ','
                ),
                ']'
            )
        )
    ) AS `data`
from
    (
        (
            (
                (
                    (
                        (
                            (
                                select
                                    `view_wm_wahlbeteiligungwahl_beteiligung_bericht_datenliste`.`stimmzettel` AS `stimmzettel`,
                                    `view_wm_wahlbeteiligungwahl_beteiligung_bericht_datenliste`.`szwahltyp` AS `szwahltyp`,
                                    json_object(
                                        'stimmzettel',
                                        `view_wm_wahlbeteiligungwahl_beteiligung_bericht_datenliste`.`stimmzettel`,
                                        'name',
                                        `view_wm_wahlbeteiligungwahl_beteiligung_bericht_datenliste`.`name`,
                                        'werte',
                                        json_merge_preserve(
                                            '[]',
                                            concat(
                                                '[',
                                                group_concat(
                                                    json_object(
                                                        'abgabetyp',
                                                        `view_wm_wahlbeteiligungwahl_beteiligung_bericht_datenliste`.`abgabetyp`,
                                                        'szwahltyp',
                                                        `view_wm_wahlbeteiligungwahl_beteiligung_bericht_datenliste`.`szwahltyp`,
                                                        'wert',
                                                        `view_wm_wahlbeteiligungwahl_beteiligung_bericht_datenliste`.`wert`
                                                    )
                                                    order by
                                                        `view_wm_wahlbeteiligungwahl_beteiligung_bericht_datenliste`.`abgabetyp` ASC separator ','
                                                ),
                                                ']'
                                            )
                                        ),
                                        'sortfield',
                                        `view_wm_wahlbeteiligungwahl_beteiligung_bericht_datenliste`.`sortfield`,
                                        'field',
                                        concat(
                                            `view_wm_wahlbeteiligungwahl_beteiligung_bericht_datenliste`.`wahlbeteiligung_bericht_id`
                                        )
                                    ) AS `data`
                                from
                                    `view_wm_wahlbeteiligungwahl_beteiligung_bericht_datenliste`
                                group by
                                    `view_wm_wahlbeteiligungwahl_beteiligung_bericht_datenliste`.`stimmzettel`,
                                    `view_wm_wahlbeteiligungwahl_beteiligung_bericht_datenliste`.`szwahltyp`,
                                    `view_wm_wahlbeteiligungwahl_beteiligung_bericht_datenliste`.`wahlbeteiligung_bericht_id`
                            ) `a`
                            join `stimmzettel` on(`stimmzettel`.`ridx` = `a`.`stimmzettel`)
                        )
                        join `wahlgruppe` on(`stimmzettel`.`wahlgruppe` = `wahlgruppe`.`ridx`)
                    )
                    join `view_wm_wahlbeteiligungwahl_beteiligung_bericht_formel_object`
                )
                join `view_wm_wahlbeteiligungwahl_beteiligung_bericht_config_object`
            )
            join `wahltyp` on(`stimmzettel`.`wahltyp` = `wahltyp`.`id`)
        )
        join (
            select
                json_merge_preserve(
                    '[]',
                    concat(
                        '[',
                        group_concat(concat('"', `wahltyp`.`name`, '"') separator ','),
                        ']'
                    )
                ) AS `o`
            from
                `wahltyp`
            where
                `wahltyp`.`aktiv` = 1
        ) `wtypo`
    )
group by
    `stimmzettel`.`wahltyp`,
    `a`.`stimmzettel`;