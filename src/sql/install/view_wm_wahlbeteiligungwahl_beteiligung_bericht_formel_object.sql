DELIMITER;

create
or replace view `view_wm_wahlbeteiligungwahl_beteiligung_bericht_formel_object` as
select
    json_merge_preserve(
        '[]',
        concat(
            '[',
            group_concat(
                json_object(
                    'id',
                    `view_wm_wahlbeteiligungwahl_beteiligung_bericht_formel`.`id`,
                    'name',
                    `view_wm_wahlbeteiligungwahl_beteiligung_bericht_formel`.`name`,
                    'nennerliste_json',
                    json_merge_preserve(
                        '[]',
                        `view_wm_wahlbeteiligungwahl_beteiligung_bericht_formel`.`nennerliste_json`
                    ),
                    'teilerliste_json',
                    json_merge_preserve(
                        '[]',
                        `view_wm_wahlbeteiligungwahl_beteiligung_bericht_formel`.`teilerliste_json`
                    )
                )
                order by
                    `view_wm_wahlbeteiligungwahl_beteiligung_bericht_formel`.`sortfield` ASC separator ','
            ),
            ']'
        )
    ) AS `config`
from
    `view_wm_wahlbeteiligungwahl_beteiligung_bericht_formel`;