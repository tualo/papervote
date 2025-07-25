DELIMITER //

CREATE OR REPLACE PROCEDURE `rebuild_view_voters_by_username_api`()
    MODIFIES SQL DATA
BEGIN

    call fill_ds('wahlberechtigte_anlage');
    call fill_ds_column('wahlberechtigte_anlage');
    
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
    INTO @FLDS
    from
        ds_column
    where
        table_name = 'wahlberechtigte_anlage'
        and existsreal = 1;


    if @FLDS is not null then
        SET @SQL = concat('
        CREATE OR REPLACE VIEW `view_voters_by_username_api` AS
        select
            `q`.`username` AS `username`,
            `q`.`pwhash` AS `pwhash`,
            `q`.`id` AS `id`,
            `wahlberechtigte`.`id` as `wahlberechtigte_id`,
            wahlschein.wahlscheinstatus as `last_wahlscheinstatus`,
            concat(
                "[",
                group_concat(
                    json_object(
                        "state",
                        `wahlschein`.`wahlscheinstatus`,
                        
                        "ts",
                        cast(wahlschein.row_start as datetime),
                        "row_start",
                        cast(wahlschein.row_start as datetime),

                        "voter_id",
                        `wahlschein`.`id`,
                        "ballotpaper_id",
                        `stimmzettel`.`id`,
                        "canvote",
                        if(
                            (
                                `wahlschein`.`wahlscheinstatus`,
                                `wahlschein`.`abgabetyp`
                            ) 
                                in 
                            (
                                select
                                    `wahlscheinstatus_online_erlaubt`.`wahlscheinstatus`,
                                    `wahlscheinstatus_online_erlaubt`.`abgabetyp`
                                from
                                    `wahlscheinstatus_online_erlaubt`
                            ),
                            1,
                            0
                        ),
                        "ballotpaper_name",
                        `stimmzettel`.name,
                        "voter_data",',@FLDS,'
                    ) separator ","
                ),
                "]"
            ) AS `possible_ballotpapers`
        from
            (
                (
                    `wahlschein`
                    join `stimmzettel` on(
                        `wahlschein`.`stimmzettel` = `stimmzettel`.`id`
                    )
                    join wahlberechtigte on wahlschein.wahlberechtigte = wahlberechtigte.id
                    join wahlberechtigte_anlage on 
                        wahlberechtigte.identnummer = wahlberechtigte_anlage.identnummer
                        and wahlberechtigte_anlage.stimmzettel = stimmzettel.id
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
        ');
        PREPARE stmt1 FROM @SQL;
        execute stmt1;
        DEALLOCATE PREPARE stmt1;
    end if;

END //


call rebuild_view_voters_by_username_api() //