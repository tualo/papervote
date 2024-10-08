delimiter ;
CREATE OR REPLACE VIEW `view_kandidaten_sitze_vergeben` AS
select
    `stimmzettelgruppen`.`ridx` AS `ridx`,
    count(distinct `kandidaten`.`ridx`) AS `vergeben`
from
    (
        `kandidaten`
        join `stimmzettelgruppen` on(
            `stimmzettelgruppen`.`ridx` = `kandidaten`.`stimmzettelgruppen`
        )
    );

CREATE VIEW IF NOT EXISTS `view_readtable_kandidaten` AS
select
    `stimmzettelgruppen`.`sitze` AS `sitze`,
    ifnull(`view_kandidaten_sitze_vergeben`.`vergeben`, 0) AS `vergeben`,
    `stimmzettelgruppen`.`name` AS `stimmzettelgruppen_text`,
    `kandidaten`.*,
    concat(
        if(
            `kandidaten`.`titel` <> '',
            concat(`kandidaten`.`titel`, ' '),
            ''
        ),
        `kandidaten`.`nachname`,
        ', ',
        `kandidaten`.`vorname`
    ) AS `anzeige_name`,
    
    
    concat(
    './dsfiles/kandidaten_bilder/',
    `kandidaten_bilder`.`file_id`
) AS `portrait_url`,
concat(
    './dsfiles/kandidaten_bilder/',
    `bc`.`file_id`
) AS `barcode_url`,
    stimmzettel.id AS stimmzettel_id


from
    (
        (
            `kandidaten`
            join `stimmzettelgruppen` on(
                `stimmzettelgruppen`.`ridx` = `kandidaten`.`stimmzettelgruppen`
            )
            join `stimmzettel` on(
                    `stimmzettelgruppen`.`stimmzettel` = `stimmzettel`.`ridx`
                )
        )
        left join `view_kandidaten_sitze_vergeben` on(
            `view_kandidaten_sitze_vergeben`.`ridx` = `stimmzettelgruppen`.`ridx`
        )

        
        left join `kandidaten_bilder` on(
            `kandidaten_bilder`.`kandidat` = `kandidaten`.`ridx`
            and kandidaten_bilder.typ=1
        )
        left join `kandidaten_bilder` bc on(
            `bc`.`kandidat` = `kandidaten`.`ridx`
            and kandidaten_bilder.typ=0
        )
    );