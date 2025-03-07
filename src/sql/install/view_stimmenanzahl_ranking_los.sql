DELIMITER;
create or replace view `view_stimmenanzahl_ranking_los` as
select `view_stimmenanzahl_ranking`.`barcode` AS `barcode`,
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
from `view_stimmenanzahl_ranking`;