
select 
concat('JSON_OBJECT(',group_concat( concat('"',column_name,'",wahlberechtigte_anlage.',column_name ) separator ',') ,')') s
from ds_column where table_name='wahlberechtigte_anlage' and existsreal=1

CREATE OR REPLACE VIEW `view_voters_by_username_api` AS
select
    `q`.`username` AS `username`,
    `q`.`pwhash` AS `pwhash`,
    `q`.`id` AS `id`,
    concat(
        '[',
        group_concat(
            json_object(
                'state',
                `bwkiel`.`wahlschein`.`wahlscheinstatus`,
                'voter_id',
                `bwkiel`.`wahlschein`.`id`,
                'ballotpaper_id',
                `bwkiel`.`stimmzettel`.`id`,
                'canvote',
                if(
                    `bwkiel`.`wahlschein`.`wahlscheinstatus` in (
                        select
                            `bwkiel`.`wahlscheinstatus_online_erlaubt`.`wahlscheinstatus`
                        from
                            `bwkiel`.`wahlscheinstatus_online_erlaubt`
                    ),
                    1,
                    0
                ),
                
                'ballotpaper_name', `bwkiel`.`stimmzettel`.name,

                'voter_data',
                    JSON_OBJECT("briefanrede",wahlberechtigte_anlage.briefanrede,"identnummer",wahlberechtigte_anlage.identnummer,"kombiniert",wahlberechtigte_anlage.kombiniert,"post_name0",wahlberechtigte_anlage.post_name0,"post_name1",wahlberechtigte_anlage.post_name1,"post_name2",wahlberechtigte_anlage.post_name2,"post_name3",wahlberechtigte_anlage.post_name3,"post_name4",wahlberechtigte_anlage.post_name4,"pwhash",wahlberechtigte_anlage.pwhash,"stimmzettel",wahlberechtigte_anlage.stimmzettel,"username",wahlberechtigte_anlage.username,"wahlb",wahlberechtigte_anlage.wahlb,"wahlg",wahlberechtigte_anlage.wahlg,"wahlscheinnummer",wahlberechtigte_anlage.wahlscheinnummer)


            ) separator ','
        ),
        ']'
    ) AS `possible_ballotpapers`
from
    (
        (
            `bwkiel`.`wahlschein`
            join `bwkiel`.`stimmzettel` on(
                `bwkiel`.`wahlschein`.`stimmzettel` = `bwkiel`.`stimmzettel`.`ridx`
            )
            join wahlberechtigte
            	on wahlschein.wahlberechtigte = wahlberechtigte.ridx
            join wahlberechtigte_anlage
            on wahlberechtigte.identnummer = wahlberechtigte_anlage.identnummer
            

        )
        join (
            select
                `bwkiel`.`wahlschein`.`id` AS `id`,
                `bwkiel`.`wahlschein`.`pwhash` AS `pwhash`,
                `bwkiel`.`wahlschein`.`username` AS `username`,
                `bwkiel`.`wahlschein`.`kombiniert` AS `kombiniert`
            from
                `bwkiel`.`wahlschein`
        ) `q` on(
            `q`.`kombiniert` = `bwkiel`.`wahlschein`.`kombiniert`
        )
    )
group by
    `q`.`username`