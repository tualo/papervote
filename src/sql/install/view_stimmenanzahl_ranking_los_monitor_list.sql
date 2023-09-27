DELIMITER ;

CREATE OR REPLACE VIEW `view_stimmenanzahl_ranking_los_monitor_list_gescannt` AS
select
    `stimmzettel2`.`stimmzettel` AS `stimmzettel`,
    max(
        concat(
            `stimmzettel2`.`update_date`,
            ' ',
            `stimmzettel2`.`update_time`
        )
    ) AS `mx`,
    count(0) AS `gescannt`
from
    (
        (
            `stimmzettel2`
            join `stapel2` on(
                `stimmzettel2`.`stapel2` = `stapel2`.`ridx`
                and `stapel2`.`abgebrochen` = 0
            )
        )
        join `kisten2` on(`stapel2`.`kisten2` = `kisten2`.`ridx`)
    )
group by
    `stimmzettel2`.`stimmzettel`;

CREATE OR REPLACE VIEW `view_stimmenanzahl_ranking_los_monitor_list_erwartet` AS
select
    `wahlschein`.`stimmzettel` AS `stimmzettel`,
    count(0) AS `erwartet`
from
    `wahlschein`
where
    `wahlschein`.`wahlscheinstatus` = '2|0'
    and `wahlschein`.`abgabetyp` = '1|0'
group by
    `wahlschein`.`stimmzettel`;

CREATE OR REPLACE VIEW `view_stimmenanzahl_ranking_los_monitor_list` AS
select
    `stimmzettel`.`name` AS `stimmzettel_name`,
    `stimmzettelgruppen`.`name` AS `stimmzettelgruppen_name`,
    `stimmzettelgruppen`.`id` AS `id`,
    `stimmzettel`.`ridx` AS `stimmzettel_ridx`,
    `stimmzettelgruppen`.`ridx` AS `stimmzettelgruppen_ridx`,
    ifnull(
        `view_stimmenanzahl_ranking_los_monitor_list_erwartet`.`erwartet`,
        0
    ) AS `erwartet`,
    ifnull(
        `view_stimmenanzahl_ranking_los_monitor_list_gescannt`.`gescannt`,
        0
    ) AS `gescannt`,
    ifnull(`stimmzettel`.`ungueltig`, 0) AS `ungueltig`,
    ifnull(
        `view_stimmenanzahl_ranking_los_monitor_list_erwartet`.`erwartet`,
        0
    ) - ifnull(
        `view_stimmenanzahl_ranking_los_monitor_list_gescannt`.`gescannt`,
        0
    ) - ifnull(`stimmzettel`.`ungueltig`, 0) AS `kontrolle`,
    (
        ifnull(
            `view_stimmenanzahl_ranking_los_monitor_list_gescannt`.`gescannt`,
            0
        ) + ifnull(`stimmzettel`.`ungueltig`, 0)
    ) / ifnull(
        `view_stimmenanzahl_ranking_los_monitor_list_erwartet`.`erwartet`,
        0.000000001
    ) AS `quote`
from
    (
        (
            (
                `stimmzettel`
                join `stimmzettelgruppen` on(
                    `stimmzettelgruppen`.`stimmzettel` = `stimmzettel`.`ridx`
                )
            )
            left join `view_stimmenanzahl_ranking_los_monitor_list_erwartet` on(
                `view_stimmenanzahl_ranking_los_monitor_list_erwartet`.`stimmzettel` = `stimmzettel`.`ridx`
            )
        )
        left join `view_stimmenanzahl_ranking_los_monitor_list_gescannt` on(
            `view_stimmenanzahl_ranking_los_monitor_list_gescannt`.`stimmzettel` = `stimmzettel`.`ridx`
        )
    )
group by
    `stimmzettel`.`ridx`;