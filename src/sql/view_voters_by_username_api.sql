CREATE OR REPLACE VIEW `view_voters_by_username_api` AS
select
    `q`.`username` AS `username`,
    `q`.`pwhash` AS `pwhash`,
    `q`.`id` AS `id`,
    -- `w`.`token` AS `secret_token`,
    concat(
        '[',
        group_concat(
            json_object(
                'state', `wahlschein`.`wahlscheinstatus`,
                'voter_id', `wahlschein`.`id`,
                'ballotpaper_id', `stimmzettel`.`id`,
                'canvote',
                if(
                    `wahlschein`.`wahlscheinstatus` in (select wahlscheinstatus from wahlscheinstatus_online_erlaubt),
                    1,
                    0
                )
            ) separator ','
        ),
        ']'
    ) AS `possible_ballotpapers`
from
    (
        (
            `wahlschein`
            join `stimmzettel` on `wahlschein`.`stimmzettel`=`stimmzettel`.`ridx`
            join (
                select
                    `wahlschein`.`id` AS `id`,
                    `wahlschein`.`pwhash` AS `pwhash`,
                    `wahlschein`.`username` AS `username`,
                    `wahlschein`.`kombiniert` AS `kombiniert` 
                from
                    `wahlschein`
                    
            ) `q` on(
                `q`.`kombiniert` = `wahlschein`.`kombiniert`
            )
        )
        -- left join `wm_wahlschein_register` `w` on(`w`.`id` = `q`.`id`)
    )
group by `q`.`username`