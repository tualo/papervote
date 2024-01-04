DELIMITER;

create
or replace view `view_wm_wahlbeteiligungwahl_beteiligung_bericht_config_object` as
select
    json_merge_preserve(
        '[]',
        concat(
            '[',
            group_concat(
                json_object(
                    'id',
                    `view_wm_wahlbeteiligungwahl_beteiligung_bericht_config`.`id`,
                    'name',
                    `view_wm_wahlbeteiligungwahl_beteiligung_bericht_config`.`name`,
                    'checktyp',
                    if(
                        `view_wm_wahlbeteiligungwahl_beteiligung_bericht_config`.`checktyp` = 1,
                        1,
                        0
                    ),
                    'abgabetyp',
                    json_merge_preserve(
                        '{}',
                        `view_wm_wahlbeteiligungwahl_beteiligung_bericht_config`.`abgabetyp`
                    ),
                    'statusliste_json',
                    json_merge_preserve(
                        '[]',
                        `view_wm_wahlbeteiligungwahl_beteiligung_bericht_config`.`statusliste_json`
                    )
                )
                order by
                    `view_wm_wahlbeteiligungwahl_beteiligung_bericht_config`.`sortfield` ASC separator ','
            ),
            ']'
        )
    ) AS `config`
from
    `view_wm_wahlbeteiligungwahl_beteiligung_bericht_config`;