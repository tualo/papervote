DELIMITER;

create
or replace view `view_wm_bekanntmachung_kandidaten_liste` as
select
    `view_stimmenanzahl_ranking_los_monitor`.`stimmzettelgruppen_ridx` AS `stimmzettelgruppen_ridx`,
    json_object(
        'stimmzettelgruppen_name',
        `view_stimmenanzahl_ranking_los_monitor`.`stimmzettelgruppen_name`,
        'stimmzettelgruppen_ridx',
        `view_stimmenanzahl_ranking_los_monitor`.`stimmzettelgruppen_ridx`,
        'sitze',
        `view_stimmenanzahl_ranking_los_monitor`.`sitze`,
        'stimmen',
        sum(
            `view_stimmenanzahl_ranking_los_monitor`.`stimmenanzahl`
        ),
        'stimmzettelanzahl',
        sum(
            `view_stimmenanzahl_ranking_los_monitor`.`stimmzettelanzahl`
        ),
        'gezaehlte_stimmzettel',
        `view_stimmenanzahl_ranking_los_monitor`.`gezaehlte_stimmzettel`,
        'kandidaten',
        json_merge_preserve(
            '[]',
            concat(
                '[',
                group_concat(
                    json_insert(
                        `view_stimmenanzahl_ranking_los_monitor`.`json_candidate`,
                        '$.rank',
                        `view_stimmenanzahl_ranking_los_monitor`.`rank`,
                        '$.listenplatz',
                        `view_stimmenanzahl_ranking_los_monitor`.`listenplatz`,
                        '$.gewaehlt',
                        `view_stimmenanzahl_ranking_los_monitor`.`gewaehlt`,
                        '$.nachruecker',
                        `view_stimmenanzahl_ranking_los_monitor`.`nachruecker`,
                        '$.stimmenanzahl',
                        `view_stimmenanzahl_ranking_los_monitor`.`stimmenanzahl`,
                        '$.offline',
                        `view_stimmenanzahl_ranking_los_monitor`.`offline`,
                        '$.online',
                        `view_stimmenanzahl_ranking_los_monitor`.`online`,
                        '$.gezaehlte_stimmzettel',
                        `view_stimmenanzahl_ranking_los_monitor`.`gezaehlte_stimmzettel`
                    )
                    order by
                        json_value(
                            `view_stimmenanzahl_ranking_los_monitor`.`json_candidate`,
                            '$.nachname'
                        ) ASC,
                        json_value(
                            `view_stimmenanzahl_ranking_los_monitor`.`json_candidate`,
                            '$.vorname'
                        ) ASC separator ','
                ),
                ']'
            )
        ),
        'kandidaten_ranking',
        json_merge_preserve(
            '[]',
            concat(
                '[',
                group_concat(
                    json_insert(
                        `view_stimmenanzahl_ranking_los_monitor`.`json_candidate`,
                        '$.rank',
                        `view_stimmenanzahl_ranking_los_monitor`.`rank`,
                        '$.listenplatz',
                        `view_stimmenanzahl_ranking_los_monitor`.`listenplatz`,
                        '$.gewaehlt',
                        `view_stimmenanzahl_ranking_los_monitor`.`gewaehlt`,
                        '$.nachruecker',
                        `view_stimmenanzahl_ranking_los_monitor`.`nachruecker`,
                        '$.stimmenanzahl',
                        `view_stimmenanzahl_ranking_los_monitor`.`stimmenanzahl`,
                        '$.offline',
                        `view_stimmenanzahl_ranking_los_monitor`.`offline`,
                        '$.online',
                        `view_stimmenanzahl_ranking_los_monitor`.`online`,
                        '$.gezaehlte_stimmzettel',
                        `view_stimmenanzahl_ranking_los_monitor`.`gezaehlte_stimmzettel`
                    )
                    order by
                        `view_stimmenanzahl_ranking_los_monitor`.`stimmenanzahl` DESC,
                        `view_stimmenanzahl_ranking_los_monitor`.`gewaehlt` DESC,
                        `view_stimmenanzahl_ranking_los_monitor`.`nachruecker` DESC separator ','
                ),
                ']'
            )
        )
    ) AS `o`
from
    `view_stimmenanzahl_ranking_los_monitor`
group by
    `view_stimmenanzahl_ranking_los_monitor`.`stimmzettelgruppen_ridx`
order by
    cast(
        substring_index(
            `view_stimmenanzahl_ranking_los_monitor`.`stimmzettelgruppen_ridx`,
            '|',
            1
        ) as signed
    );