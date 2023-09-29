DELIMITER ;
create  or replace view  `view_wm_bekanntmachung_kandidaten_liste_wm_bekanntmachung` as select json_merge_preserve('[]',concat('[',group_concat(`view_wm_bekanntmachung_kandidaten_liste`.`o` separator ','),']')) AS `o` from `view_wm_bekanntmachung_kandidaten_liste`;
