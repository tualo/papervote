delimiter //



CREATE OR REPLACE VIEW `kandidaten_stimmenanzahl_losentscheid_stimmzettel` AS
select
    if(
        `x`.`min_xrank` <= `x`.`stimmzettel_sitze`
        and `x`.`max_xrank` > `x`.`stimmzettel_sitze`,
        'Einzugslosung',
        if(
            `x`.`min_xrank` > `x`.`stimmzettel_sitze`
            and `x`.`max_xrank` > `x`.`stimmzettel_sitze`,
            'Nachrückerlosung',
            'Rangfolgelosung'
        )
    ) AS `msg`,
    `x`.`stimmzettel_ridx` AS `stimmzettel_ridx`,
    `x`.`rank` AS `rank`,
    `x`.`stimmzettelgruppen_mindestsitze` AS `stimmzettelgruppen_mindestsitze`,
    `x`.`stimmzettel_name` AS `stimmzettel_name`,
    `x`.`gesamtstimmen` AS `gesamtstimmen`,
    `x`.`stimmzettelgruppen_name` AS `stimmzettelgruppen_name`,
    `x`.`ids` AS `ids`,
    sort_field,
    `x`.`kandidaten_namen` AS `kandidaten_namen`,
    `x`.`max_xrank` AS `max_xrank`,
    `x`.`min_xrank` AS `min_xrank`,
    `x`.`stimmzettel_sitze` AS `stimmzettel_sitze`,
    `x`.`c` AS `c`,
    `x`.`kn` AS `kn`
from
    (
        select
            `kandidaten_stimmenanzahl_rank`.`stimmzettel_ridx` AS `stimmzettel_ridx`,
            `kandidaten_stimmenanzahl_rank`.`rank` AS `rank`,
            `kandidaten_stimmenanzahl_rank`.`stimmzettelgruppen_mindestsitze` AS `stimmzettelgruppen_mindestsitze`,
            `kandidaten_stimmenanzahl_rank`.`stimmzettel_name` AS `stimmzettel_name`,
            `kandidaten_stimmenanzahl_rank`.`gesamtstimmen` AS `gesamtstimmen`,
            `kandidaten_stimmenanzahl_rank`.`stimmzettelgruppen_name` AS `stimmzettelgruppen_name`,
            group_concat(
                `kandidaten_stimmenanzahl_rank`.`id` separator ','
            ) AS `ids`,
            group_concat(
                `view_readtable_kandidaten`.`anzeige_name` separator '; '
            ) AS `kandidaten_namen`,
            max(`kandidaten_stimmenanzahl_rank`.`Xrank`) AS `max_xrank`,
            min(`kandidaten_stimmenanzahl_rank`.`Xrank`) AS `min_xrank`,
            max(view_readtable_kandidaten.barcode) as sort_field,
            `kandidaten_stimmenanzahl_rank`.`stimmzettel_sitze` AS `stimmzettel_sitze`,
            count(0) AS `c`,
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
                            `view_readtable_kandidaten`.`id`,
                            'stimmzettelgruppen_text',
                            `view_readtable_kandidaten`.`stimmzettelgruppen_text`
                        )
                        order by
                            `view_readtable_kandidaten`.`barcode` ASC separator ','
                    ),
                    ']'
                )
            ) AS `kn`
        from
            (
                `kandidaten_stimmenanzahl_rank`
                join `view_readtable_kandidaten` on(
                    `kandidaten_stimmenanzahl_rank`.`id` = `view_readtable_kandidaten`.`id`
                )
            )
        group by
            `kandidaten_stimmenanzahl_rank`.`stimmzettel_ridx`,
            `kandidaten_stimmenanzahl_rank`.`rank`
        having
            `c` > 1
    ) `x` //


