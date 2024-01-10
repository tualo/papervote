delimiter //

create or replace view kandidaten_stimmenanzahl_liste as
select
    `kandidaten_stimmenanzahl_rank`.`stimmzettel_ridx` AS `stimmzettel_ridx`,
    `kandidaten_stimmenanzahl_rank`.`rank` AS `rank`,
    `kandidaten_stimmenanzahl_rank`.`stimmzettelgruppen_mindestsitze` AS `stimmzettelgruppen_mindestsitze`,
    `kandidaten_stimmenanzahl_rank`.`stimmzettel_name` AS `stimmzettel_name`,
    `kandidaten_stimmenanzahl_rank`.`gesamtstimmen` AS `gesamtstimmen`,
    `kandidaten_stimmenanzahl_rank`.`stimmzettelgruppen_name` AS `stimmzettelgruppen_name`,
    `kandidaten_stimmenanzahl_rank`.`id`,
    `kandidaten_stimmenanzahl_rank`.`Xrank`,
    `kandidaten_stimmenanzahl_rank`.`stimmzettel_sitze` AS `stimmzettel_sitze`,
    `view_readtable_kandidaten`.`barcode`,
    `view_readtable_kandidaten`.`anzeige_name`,
    `view_readtable_kandidaten`.`stimmzettelgruppen_text`,
    `view_readtable_kandidaten`.losnummer_stimmzettelgruppe,
    `view_readtable_kandidaten`.losnummer

from
    (
        `kandidaten_stimmenanzahl_rank`
        join `view_readtable_kandidaten` on(
            `kandidaten_stimmenanzahl_rank`.`id` = `view_readtable_kandidaten`.`id`
        )
    ) //

INSERT INTO `ds_referenced_manual` VALUES
('kandidaten_stimmenanzahl_liste','kandidaten_stimmenanzahl_losentscheid_stimmzettel'),
('kandidaten_stimmenanzahl_losentscheid_stimmzettel','kandidaten_stimmenanzahl_liste')//


INSERT INTO `ds_referenced_manual_columns` VALUES
('kandidaten_stimmenanzahl_losentscheid_stimmzettel','kandidaten_stimmenanzahl_liste','rank','rank'),
('kandidaten_stimmenanzahl_losentscheid_stimmzettel','kandidaten_stimmenanzahl_liste','stimmzettel_ridx','stimmzettel_ridx'),
('kandidaten_stimmenanzahl_liste','kandidaten_stimmenanzahl_losentscheid_stimmzettel','rank','rank'),
('kandidaten_stimmenanzahl_liste','kandidaten_stimmenanzahl_losentscheid_stimmzettel','stimmzettel_ridx','stimmzettel_ridx')//