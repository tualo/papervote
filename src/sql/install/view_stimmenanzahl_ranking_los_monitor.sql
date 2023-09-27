DELIMITER ;

CREATE OR REPLACE VIEW `view_gezaehlte_stimmzettel` AS
select
    `x`.`stimmzettel` AS `stimmzettel`,
    sum(`x`.`gezaehlte_stimmzettel`) AS `gezaehlte_stimmzettel`
from
    (
        select
            `stimmzettelgruppen`.`stimmzettel` AS `stimmzettel`,
            count(distinct `stimmzettel2`.`ridx`) AS `gezaehlte_stimmzettel`
        from
            (
                (
                    (
                        (
                            `kandidaten2`
                            join `kandidaten` on(`kandidaten2`.`name` = `kandidaten`.`barcode`)
                        )
                        join `stimmzettelgruppen` on(
                            `stimmzettelgruppen`.`ridx` = `kandidaten`.`stimmzettelgruppen`
                        )
                    )
                    join `stimmzettel2` on(
                        `kandidaten2`.`stimmzettel2` = `stimmzettel2`.`ridx`
                    )
                )
                join `stapel2` on(
                    `stimmzettel2`.`stapel2` = `stapel2`.`ridx`
                    and `stapel2`.`abgebrochen` = 0
                )
            )
        group by
            `stimmzettelgruppen`.`stimmzettel`
        union
        select
            `onlinestimmzettel`.`stimmzettel` AS `stimmzettel`,
            `onlinestimmzettel`.`anzahl` AS `gezaehlte_stimmzettel`
        from
            `onlinestimmzettel`
    ) `x`
group by
    `x`.`stimmzettel`;

CREATE OR REPLACE VIEW `view_ddl_kandidaten_json` AS
select
    `kandidaten`.`id` AS `id`,
    `kandidaten`.`ridx` AS `ridx`,
    `kandidaten`.`barcode` AS `barcode`,
    json_object(
        'aktiv',
        `kandidaten`.`aktiv`,
        'andrede',
        `kandidaten`.`andrede`,
        'barcode',
        `kandidaten`.`barcode`,
        'branche',
        `kandidaten`.`branche`,
        'firma1',
        `kandidaten`.`firma1`,
        'firma2',
        `kandidaten`.`firma2`,
        'firma3',
        `kandidaten`.`firma3`,
        'firma4',
        `kandidaten`.`firma4`,
        'firma_ort',
        `kandidaten`.`firma_ort`,
        'funktion1',
        `kandidaten`.`funktion1`,
        'funktion2',
        `kandidaten`.`funktion2`,
        'geburtsjahr',
        `kandidaten`.`geburtsjahr`,
        'id',
        `kandidaten`.`id`,
        'kostenstelle',
        `kandidaten`.`kostenstelle`,
        'losung_verloren',
        `kandidaten`.`losung_verloren`,
        'nachname',
        `kandidaten`.`nachname`,
        'nachruecker',
        `kandidaten`.`nachruecker`,
        'ridx',
        `kandidaten`.`ridx`,
        'stimmzettelgruppen',
        `kandidaten`.`stimmzettelgruppen`,
        'titel',
        `kandidaten`.`titel`,
        'vorname',
        `kandidaten`.`vorname`
    ) AS `json_candidate`
from
    `kandidaten`;

CREATE OR REPLACE VIEW `view_stimmenanzahl` AS
select
    `view_readtable_kandidaten`.`barcode` AS `barcode`,
    `view_readtable_kandidaten`.`anzeige_name` AS `anzeige_name`,
    `view_readtable_kandidaten`.`losung_verloren` AS `losung_verloren`,
    `view_readtable_kandidaten`.`nachruecker` AS `nachruecker`,
    `view_readtable_kandidaten`.`id` AS `kandidaten_id`,
    `stimmzettelgruppen`.`ridx` AS `stimmzettelgruppen_ridx`,
    `stimmzettelgruppen`.`name` AS `stimmzettelgruppen_name`,
    `stimmzettelgruppen`.`sitze` AS `sitze`,
    `stimmzettel`.`ridx` AS `stimmzettel_ridx`,
    `stimmzettel`.`id` AS `id`,
    `stimmzettel`.`name` AS `stimmzettel_name`,
    group_concat(distinct `kisten2`.`name` separator ', ') AS `kiste2`,
    group_concat(distinct `stapel2`.`name` separator ', ') AS `stapel2`,
    ifnull(
        `view_gezaehlte_stimmzettel`.`gezaehlte_stimmzettel`,
        0
    ) AS `gezaehlte_stimmzettel`,
    count(distinct `stimmzettel2`.`ridx`) AS `stimmzettelanzahl`,
    count(distinct `kandidaten2`.`ridx`) AS `offline`,
    ifnull(`onlinekandidaten`.`anzahl`, 0) AS `online`,
    count(distinct `kandidaten2`.`ridx`) + ifnull(`onlinekandidaten`.`anzahl`, 0) AS `stimmenanzahl`,
    `view_ddl_kandidaten_json`.`json_candidate` AS `json_candidate`
from
    (
        (
            (
                (
                    (
                        (
                            (
                                (
                                    (
                                        `view_readtable_kandidaten`
                                        join `stimmzettelgruppen` on(
                                            `view_readtable_kandidaten`.`stimmzettelgruppen` = `stimmzettelgruppen`.`ridx`
                                        )
                                    )
                                    join `view_ddl_kandidaten_json` on(
                                        `view_ddl_kandidaten_json`.`barcode` = `view_readtable_kandidaten`.`barcode`
                                    )
                                )
                                join `stimmzettel` on(
                                    `stimmzettelgruppen`.`stimmzettel` = `stimmzettel`.`ridx`
                                )
                            )
                            left join `view_gezaehlte_stimmzettel` on(
                                `view_gezaehlte_stimmzettel`.`stimmzettel` = `stimmzettel`.`ridx`
                            )
                        )
                        left join `kandidaten2` on(
                            `kandidaten2`.`name` = `view_readtable_kandidaten`.`barcode`
                        )
                    )
                    left join `stimmzettel2` on(
                        `kandidaten2`.`stimmzettel2` = `stimmzettel2`.`ridx`
                    )
                )
                left join `stapel2` on(
                    `stimmzettel2`.`stapel2` = `stapel2`.`ridx`
                    and `stapel2`.`abgebrochen` = 0
                )
            )
            left join `kisten2` on(`stapel2`.`kisten2` = `kisten2`.`ridx`)
        )
        left join `onlinekandidaten` on(
            `view_readtable_kandidaten`.`barcode` = `onlinekandidaten`.`name`
        )
    )
group by
    `view_readtable_kandidaten`.`barcode`
order by
    count(distinct `kandidaten2`.`ridx`) + ifnull(`onlinekandidaten`.`anzahl`, 0) desc;

CREATE OR REPLACE VIEW `view_stimmenanzahl_ranking` AS
select
    `view_stimmenanzahl`.`barcode` AS `barcode`,
    `view_stimmenanzahl`.`anzeige_name` AS `anzeige_name`,
    `view_stimmenanzahl`.`id` AS `id`,
    `view_stimmenanzahl`.`stimmzettelgruppen_ridx` AS `stimmzettelgruppen_ridx`,
    `view_stimmenanzahl`.`stimmzettelgruppen_name` AS `stimmzettelgruppen_name`,
    `view_stimmenanzahl`.`sitze` AS `sitze`,
    `view_stimmenanzahl`.`stimmzettel_ridx` AS `stimmzettel_ridx`,
    `view_stimmenanzahl`.`stimmzettel_name` AS `stimmzettel_name`,
    `view_stimmenanzahl`.`kiste2` AS `kiste2`,
    `view_stimmenanzahl`.`stapel2` AS `stapel2`,
    `view_stimmenanzahl`.`gezaehlte_stimmzettel` AS `gezaehlte_stimmzettel`,
    `view_stimmenanzahl`.`losung_verloren` AS `losung_verloren`,
    `view_stimmenanzahl`.`nachruecker` AS `nachruecker`,
    `view_stimmenanzahl`.`json_candidate` AS `json_candidate`,
    rank() over (
        partition by `view_stimmenanzahl`.`stimmzettelgruppen_ridx`
        order by
            `view_stimmenanzahl`.`stimmenanzahl` desc
    ) AS `rank`,
    rank() over (
        partition by json_value(
            `view_stimmenanzahl`.`json_candidate`,
            '$.stimmzettelgruppen'
        )
        order by
            json_value(
                `view_stimmenanzahl`.`json_candidate`,
                '$.barcode'
            )
    ) AS `listenplatz`,
    dense_rank() over (
        partition by `view_stimmenanzahl`.`stimmzettelgruppen_ridx`
        order by
            `view_stimmenanzahl`.`stimmenanzahl` desc
    ) AS `dense_rank`,
    row_number() over (
        partition by `view_stimmenanzahl`.`stimmzettelgruppen_ridx`
        order by
            `view_stimmenanzahl`.`stimmenanzahl` desc
    ) AS `row_num`,
    `view_stimmenanzahl`.`stimmzettelanzahl` AS `stimmzettelanzahl`,
    `view_stimmenanzahl`.`stimmenanzahl` AS `stimmenanzahl`,
    `view_stimmenanzahl`.`offline` AS `offline`,
    `view_stimmenanzahl`.`online` AS `online`
from
    `view_stimmenanzahl`;

CREATE OR REPLACE VIEW `view_stimmenanzahl_ranking_los` AS
select
    `view_stimmenanzahl_ranking`.`barcode` AS `barcode`,
    `view_stimmenanzahl_ranking`.`anzeige_name` AS `anzeige_name`,
    `view_stimmenanzahl_ranking`.`id` AS `id`,
    `view_stimmenanzahl_ranking`.`stimmzettelgruppen_ridx` AS `stimmzettelgruppen_ridx`,
    `view_stimmenanzahl_ranking`.`stimmzettelgruppen_name` AS `stimmzettelgruppen_name`,
    `view_stimmenanzahl_ranking`.`sitze` AS `sitze`,
    `view_stimmenanzahl_ranking`.`stimmzettel_ridx` AS `stimmzettel_ridx`,
    `view_stimmenanzahl_ranking`.`stimmzettel_name` AS `stimmzettel_name`,
    `view_stimmenanzahl_ranking`.`kiste2` AS `kiste2`,
    `view_stimmenanzahl_ranking`.`stapel2` AS `stapel2`,
    `view_stimmenanzahl_ranking`.`rank` AS `rank`,
    `view_stimmenanzahl_ranking`.`dense_rank` AS `dense_rank`,
    `view_stimmenanzahl_ranking`.`row_num` AS `row_num`,
    `view_stimmenanzahl_ranking`.`listenplatz` AS `listenplatz`,
    `view_stimmenanzahl_ranking`.`gezaehlte_stimmzettel` AS `gezaehlte_stimmzettel`,
    `view_stimmenanzahl_ranking`.`json_candidate` AS `json_candidate`,
    if(
        `view_stimmenanzahl_ranking`.`rank` <= `view_stimmenanzahl_ranking`.`sitze`,
        if(
            `view_stimmenanzahl_ranking`.`losung_verloren` = 1,
            0,
            1
        ),
        0
    ) AS `gewaehlt`,
    `view_stimmenanzahl_ranking`.`nachruecker` AS `nachruecker`,
    `view_stimmenanzahl_ranking`.`stimmzettelanzahl` AS `stimmzettelanzahl`,
    `view_stimmenanzahl_ranking`.`stimmenanzahl` AS `stimmenanzahl`,
    `view_stimmenanzahl_ranking`.`offline` AS `offline`,
    `view_stimmenanzahl_ranking`.`online` AS `online`
from
    `view_stimmenanzahl_ranking`;

CREATE OR REPLACE VIEW `view_stimmenanzahl_ranking_los_monitor` AS
select
    `view_stimmenanzahl_ranking_los`.`barcode` AS `barcode`,
    `view_stimmenanzahl_ranking_los`.`anzeige_name` AS `anzeige_name`,
    `view_stimmenanzahl_ranking_los`.`id` AS `id`,
    `view_stimmenanzahl_ranking_los`.`stimmzettelgruppen_ridx` AS `stimmzettelgruppen_ridx`,
    `view_stimmenanzahl_ranking_los`.`stimmzettelgruppen_name` AS `stimmzettelgruppen_name`,
    `view_stimmenanzahl_ranking_los`.`sitze` AS `sitze`,
    `view_stimmenanzahl_ranking_los`.`stimmzettel_ridx` AS `stimmzettel_ridx`,
    `view_stimmenanzahl_ranking_los`.`stimmzettel_name` AS `stimmzettel_name`,
    `view_stimmenanzahl_ranking_los`.`kiste2` AS `kiste2`,
    `view_stimmenanzahl_ranking_los`.`stapel2` AS `stapel2`,
    `view_stimmenanzahl_ranking_los`.`rank` AS `rank`,
    `view_stimmenanzahl_ranking_los`.`dense_rank` AS `dense_rank`,
    `view_stimmenanzahl_ranking_los`.`row_num` AS `row_num`,
    `view_stimmenanzahl_ranking_los`.`listenplatz` AS `listenplatz`,
    `view_stimmenanzahl_ranking_los`.`gewaehlt` AS `gewaehlt`,
    `view_stimmenanzahl_ranking_los`.`nachruecker` AS `nachruecker`,
    `view_stimmenanzahl_ranking_los`.`stimmzettelanzahl` AS `stimmzettelanzahl`,
    `view_stimmenanzahl_ranking_los`.`stimmenanzahl` AS `stimmenanzahl`,
    `view_stimmenanzahl_ranking_los`.`offline` AS `offline`,
    `view_stimmenanzahl_ranking_los`.`online` AS `online`,
    `view_stimmenanzahl_ranking_los`.`gezaehlte_stimmzettel` AS `gezaehlte_stimmzettel`,
    `view_stimmenanzahl_ranking_los`.`json_candidate` AS `json_candidate`
from
    `view_stimmenanzahl_ranking_los`;