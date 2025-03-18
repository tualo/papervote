DELIMITER;

create
or replace view `view_wm_wahlbeteiligungwahl_beteiligung_bericht_config` as
select
    `wahlbeteiligung_bericht`.`id` AS `id`,
    `wahlbeteiligung_bericht`.`id` + 1000000 AS `sortfield`,
    `wahlbeteiligung_bericht`.`name` AS `name`,
    `wahlbeteiligung_bericht`.`abgabetyp` AS `abgabetyp`,
    `wahlbeteiligung_bericht`.`checktyp` AS `checktyp`,
    `s`.`statusliste` AS `statusliste`,
    `s`.`statusliste_json` AS `statusliste_json`
from
    (
        `wahlbeteiligung_bericht`
        join (
            select
                `wahlbeteiligung_bericht_status`.`wahlbeteiligung_bericht` AS `wahlbeteiligung_bericht`,
                group_concat(
                    quote(
                        `wahlbeteiligung_bericht_status`.`wahlscheinstatus`
                    ) separator ','
                ) AS `statusliste`,
                json_merge_preserve(
                    '[]',
                    concat(
                        '[',
                        group_concat(
                            concat(
                                '"',
                                `wahlbeteiligung_bericht_status`.`wahlscheinstatus`,
                                '"'
                            ) separator ','
                        ),
                        ']'
                    )
                ) AS `statusliste_json`
            from
                `wahlbeteiligung_bericht_status`
            group by
                `wahlbeteiligung_bericht_status`.`wahlbeteiligung_bericht`
        ) `s` on(
            `s`.`wahlbeteiligung_bericht` = `wahlbeteiligung_bericht`.`id`
        )
    )
where
    `wahlbeteiligung_bericht`.`aktiv` = 1
order by
    `wahlbeteiligung_bericht`.`id`;