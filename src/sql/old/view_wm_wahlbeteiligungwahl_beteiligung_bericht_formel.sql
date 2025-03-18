DELIMITER;

create
or replace view `view_wm_wahlbeteiligungwahl_beteiligung_bericht_formel` as
select
    `wahlbeteiligung_bericht_formel`.`id` AS `id`,
    `wahlbeteiligung_bericht_formel`.`id` AS `sortfield`,
    `wahlbeteiligung_bericht_formel`.`name` AS `name`,
    `s`.`nennerliste` AS `nennerliste`,
    `s`.`nennerliste_json` AS `nennerliste_json`,
    `t`.`teilerliste` AS `teilerliste`,
    `t`.`teilerliste_json` AS `teilerliste_json`
from
    (
        (
            `wahlbeteiligung_bericht_formel`
            join (
                select
                    `wahlbeteiligung_bericht_formel_nenner`.`wahlbeteiligung_bericht_formel` AS `wahlbeteiligung_bericht_formel`,
                    group_concat(
                        quote(
                            `wahlbeteiligung_bericht_formel_nenner`.`wahlbeteiligung_bericht`
                        ) separator ','
                    ) AS `nennerliste`,
                    json_merge_preserve(
                        '[]',
                        concat(
                            '[',
                            group_concat(
                                concat(
                                    '"',
                                    `wahlbeteiligung_bericht_formel_nenner`.`wahlbeteiligung_bericht`,
                                    '"'
                                ) separator ','
                            ),
                            ']'
                        )
                    ) AS `nennerliste_json`
                from
                    `wahlbeteiligung_bericht_formel_nenner`
                group by
                    `wahlbeteiligung_bericht_formel_nenner`.`wahlbeteiligung_bericht_formel`
            ) `s` on(
                `s`.`wahlbeteiligung_bericht_formel` = `wahlbeteiligung_bericht_formel`.`id`
            )
        )
        join (
            select
                `wahlbeteiligung_bericht_formel_teiler`.`wahlbeteiligung_bericht_formel` AS `wahlbeteiligung_bericht_formel`,
                group_concat(
                    quote(
                        `wahlbeteiligung_bericht_formel_teiler`.`wahlbeteiligung_bericht`
                    ) separator ','
                ) AS `teilerliste`,
                json_merge_preserve(
                    '[]',
                    concat(
                        '[',
                        group_concat(
                            concat(
                                '"',
                                `wahlbeteiligung_bericht_formel_teiler`.`wahlbeteiligung_bericht`,
                                '"'
                            ) separator ','
                        ),
                        ']'
                    )
                ) AS `teilerliste_json`
            from
                `wahlbeteiligung_bericht_formel_teiler`
            group by
                `wahlbeteiligung_bericht_formel_teiler`.`wahlbeteiligung_bericht_formel`
        ) `t` on(
            `t`.`wahlbeteiligung_bericht_formel` = `wahlbeteiligung_bericht_formel`.`id`
        )
    )
where
    `wahlbeteiligung_bericht_formel`.`aktiv` = 1
order by
    `wahlbeteiligung_bericht_formel`.`id`;