DELIMITER ;

alter table wahlschein add kombiniert bigint default null;


create or replace view `view_voters_by_username_api` as 
select `q`.`username` AS `username`,`q`.`pwhash` AS `pwhash`,`q`.`id` AS `id`,
concat('[',group_concat(json_object('state',`wahlschein`.`wahlscheinstatus`,'voter_id',`wahlschein`.`id`,'ballotpaper_id',`stimmzettel`.`id`,'canvote',if(`wahlschein`.`wahlscheinstatus` = '1|0',1,0)) separator ','),']') AS `possible_ballotpapers` from ((`wahlschein` join `stimmzettel` on(`wahlschein`.`stimmzettel` = `stimmzettel`.`ridx`)) join (select `wahlschein`.`id` AS `id`,`wahlschein`.`pwhash` AS `pwhash`,`wahlschein`.`username` AS `username`,`wahlschein`.`kombiniert` AS `kombiniert` from `wahlschein`) `q` on(`q`.`kombiniert` = `wahlschein`.`kombiniert`)) 

group by `q`.`username`;
