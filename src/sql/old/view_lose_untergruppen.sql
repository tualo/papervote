delimiter //

CREATE OR REPLACE VIEW `view_lose_untergruppen` AS (
    select
        count(0) AS `c`,
        `kandidaten_stimmenanzahl_rank`.`stimmzettelgruppen_ridx` AS `stimmzettelgruppen_ridx`,
        `kandidaten_stimmenanzahl_rank`.`stimmzettelgruppen_rang` AS `stimmzettelgruppen_rang`,
        `kandidaten_stimmenanzahl_rank`.rank,
        `stimmzettelgruppen`.`name` AS `stimmzettelgruppe`,
        `kandidaten_stimmenanzahl_rank`.`stimmzettelgruppen_mindestsitze` AS `stimmzettelgruppen_mindestsitze`,
        `kandidaten_stimmenanzahl_rank`.`stimmzettel_sitze` AS `stimmzettel_sitze`,
        `kandidaten_stimmenanzahl_rank`.`stimmzettel_ridx` AS `stimmzettel_ridx`,
        `kandidaten_stimmenanzahl_rank`.`gesamtstimmen` AS `gesamtstimmen`,
        `stimmzettel`.`name` AS `stimmzettel`,
        group_concat(
            `kandidaten_stimmenanzahl_rank`.`id` separator ','
        ) AS `kandidaten`,
        group_concat(
            `view_readtable_kandidaten`.`anzeige_name` separator '; '
        ) AS `kandidaten_namen`,
        json_merge_preserve(
            '[]',
            concat(
                '[',
                group_concat(
                    json_object(
                        'name',
                        `view_readtable_kandidaten`.`anzeige_name`,
                        'barcode',
                        `view_readtable_kandidaten`.`barcode`,
                        'id',
                        `view_readtable_kandidaten`.`id`
                    )
                    order by
                        `view_readtable_kandidaten`.`barcode` ASC separator ','
                ),
                ']'
            )
        ) AS `kn`
    from
        (
            (
                (
                    `kandidaten_stimmenanzahl_rank`
                    join `view_readtable_kandidaten` on(
                        `kandidaten_stimmenanzahl_rank`.`id` = `view_readtable_kandidaten`.`id`
                    )
                )
                join `stimmzettelgruppen` on(
                    `kandidaten_stimmenanzahl_rank`.`stimmzettelgruppen_ridx` = `stimmzettelgruppen`.`ridx`
                )
            )
            join `stimmzettel` on(
                `kandidaten_stimmenanzahl_rank`.`stimmzettel_ridx` = `stimmzettel`.`ridx`
            )
        )
    group by
        `kandidaten_stimmenanzahl_rank`.`stimmzettelgruppen_ridx`,
        `kandidaten_stimmenanzahl_rank`.`gesamtstimmen`,
        `kandidaten_stimmenanzahl_rank`.`up_vote`,
        `kandidaten_stimmenanzahl_rank`.`losnummer`
    having
        `kandidaten_stimmenanzahl_rank`.`up_vote` > 0
        and `c` > 1
        and `kandidaten_stimmenanzahl_rank`.`losnummer` = 0
) //