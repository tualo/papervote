select
    concat(
        'JSON_OBJECT(',
        group_concat(
            concat(
                '"',
                column_name,
                '",wahlberechtigte_anlage.',
                column_name
            ) separator ','
        ),
        ')'
    ) s
from
    ds_column
where
    table_name = 'wahlberechtigte_anlage'
    and existsreal = 1;



CREATE
OR REPLACE VIEW `view_voters_by_username_api` AS
select
    `q`.`username` AS `username`,
    `q`.`pwhash` AS `pwhash`,
    `q`.`id` AS `id`,
    concat(
        '[',
        group_concat(
            json_object(
                'state',
                `wahlschein`.`wahlscheinstatus`,
                'voter_id',
                `wahlschein`.`id`,
                'ballotpaper_id',
                `stimmzettel`.`id`,
                'canvote',
                if(
                    `wahlschein`.`wahlscheinstatus` in (
                        select
                            `wahlscheinstatus_online_erlaubt`.`wahlscheinstatus`
                        from
                            `wahlscheinstatus_online_erlaubt`
                    ),
                    1,
                    0
                ),
                'ballotpaper_name',
                `stimmzettel`.name,
                'voter_data',
                JSON_OBJECT(

                    "identnummer",
                    wahlberechtigte_anlage.identnummer,
                    "kombiniert",
                    wahlberechtigte_anlage.kombiniert,
                    "post_name1",
                    wahlberechtigte_anlage.post_name1,
                    "post_name2",
                    wahlberechtigte_anlage.post_name2,
                    "post_name3",
                    wahlberechtigte_anlage.post_name3,
                    "post_name4",
                    wahlberechtigte_anlage.post_name4,
                    "pwhash",
                    wahlschein.pwhash,
                    "stimmzettel",
                    wahlberechtigte_anlage.stimmzettel,
                    "username",
                    wahlschein.username,
                    "wahlscheinnummer",
                    wahlschein.wahlscheinnummer
                )
            ) separator ','
        ),
        ']'
    ) AS `possible_ballotpapers`
from
    (
        (
            `wahlschein`
            join `stimmzettel` on(
                `wahlschein`.`stimmzettel` = `stimmzettel`.`ridx`
            )
            join wahlberechtigte on wahlschein.wahlberechtigte = wahlberechtigte.ridx
            join wahlberechtigte_anlage on wahlberechtigte.identnummer = wahlberechtigte_anlage.identnummer
        )
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
group by
    `q`.`username`