DELIMITER ;


create  or replace view  `kandidaten_stimmenanzahl_rank` as select `kandidaten_stimmenanzahl`.`losnummer` AS `losnummer`,`kandidaten_stimmenanzahl`.`losnummer_stimmzettelgruppe` AS `losnummer_stimmzettelgruppe`,`kandidaten_stimmenanzahl`.`kooptiert` AS `kooptiert`,row_number() over ( partition by `kandidaten_stimmenanzahl`.`stimmzettelgruppen_ridx` order by `kandidaten_stimmenanzahl`.`kooptiert` desc,if(`kandidaten_stimmenanzahl`.`stimmzettelgruppen_rang` <= `kandidaten_stimmenanzahl`.`stimmzettelgruppen_mindestsitze`,1,0) desc,`kandidaten_stimmenanzahl`.`gesamtstimmen` desc,if(`kandidaten_stimmenanzahl`.`losnummer` = 0,100000,`kandidaten_stimmenanzahl`.`losnummer`)) AS `Xrank`,if(rank() over ( partition by `kandidaten_stimmenanzahl`.`stimmzettelgruppen_ridx` order by `kandidaten_stimmenanzahl`.`kooptiert` desc,if(`kandidaten_stimmenanzahl`.`stimmzettelgruppen_rang` <= `kandidaten_stimmenanzahl`.`stimmzettelgruppen_mindestsitze`,1,0) desc,`kandidaten_stimmenanzahl`.`gesamtstimmen` desc,if(`kandidaten_stimmenanzahl`.`losnummer` = 0,100000,`kandidaten_stimmenanzahl`.`losnummer`)) <= `kandidaten_stimmenanzahl`.`stimmzettelgruppen_sitze`,1,0) AS `gewaehlt`,dense_rank() over ( partition by `kandidaten_stimmenanzahl`.`stimmzettelgruppen_ridx` order by `kandidaten_stimmenanzahl`.`kooptiert` desc,if(`kandidaten_stimmenanzahl`.`stimmzettelgruppen_rang` <= `kandidaten_stimmenanzahl`.`stimmzettelgruppen_mindestsitze`,1,0) desc,`kandidaten_stimmenanzahl`.`gesamtstimmen` desc,if(`kandidaten_stimmenanzahl`.`losnummer` = 0,100000,`kandidaten_stimmenanzahl`.`losnummer`)) AS `rank`,`kandidaten_stimmenanzahl`.`stimmzettelgruppen_rang` AS `stimmzettelgruppen_rang`,if(`kandidaten_stimmenanzahl`.`stimmzettel_rang` <= `kandidaten_stimmenanzahl`.`stimmzettel_sitze`,1,0) AS `norm_vote`,if(`kandidaten_stimmenanzahl`.`stimmzettelgruppen_rang` <= `kandidaten_stimmenanzahl`.`stimmzettelgruppen_mindestsitze`,1,0) AS `up_vote`,`kandidaten_stimmenanzahl`.`stimmzettel_rang` AS `stimmzettel_rang`,`kandidaten_stimmenanzahl`.`id` AS `id`,`kandidaten_stimmenanzahl`.`stimmzettelgruppen` AS `stimmzettelgruppen`,`kandidaten_stimmenanzahl`.`stimmzettel_ridx` AS `stimmzettel_ridx`,`kandidaten_stimmenanzahl`.`stimmzettel_name` AS `stimmzettel_name`,`kandidaten_stimmenanzahl`.`stimmzettelgruppen_ridx` AS `stimmzettelgruppen_ridx`,`kandidaten_stimmenanzahl`.`stimmzettelgruppen_name` AS `stimmzettelgruppen_name`,`kandidaten_stimmenanzahl`.`stimmzettel_sitze` AS `stimmzettel_sitze`,`kandidaten_stimmenanzahl`.`stimmzettelgruppen_sitze` AS `stimmzettelgruppen_sitze`,`kandidaten_stimmenanzahl`.`stimmzettelgruppen_mindestsitze` AS `stimmzettelgruppen_mindestsitze`,`kandidaten_stimmenanzahl`.`onlinestimmen` AS `onlinestimmen`,`kandidaten_stimmenanzahl`.`offlinestimmen` AS `offlinestimmen`,`kandidaten_stimmenanzahl`.`gesamtstimmen` AS `gesamtstimmen`,`view_readtable_kandidaten`.`anzeige_name` AS `anzeige_name` from (`kandidaten_stimmenanzahl` join `view_readtable_kandidaten` on(`kandidaten_stimmenanzahl`.`id` = `view_readtable_kandidaten`.`id`));
