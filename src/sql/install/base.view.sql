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

CREATE OR REPLACE VIEW `view_readtable_kandidaten` AS
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
    ) AS `anzeige_name`
from
    (
        (
            `kandidaten`
            join `stimmzettelgruppen` on(
                `stimmzettelgruppen`.`ridx` = `kandidaten`.`stimmzettelgruppen`
            )
        )
        left join `view_kandidaten_sitze_vergeben` on(
            `view_kandidaten_sitze_vergeben`.`ridx` = `stimmzettelgruppen`.`ridx`
        )
    )