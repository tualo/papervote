DELIMITER;

create
or replace view `kandidaten_stimmenanzahl` as
select
    dense_rank() over (
        partition by `stimmzettel`.`ridx`,
        `stimmzettelgruppen`.`ridx`
        order by
            `kandidaten`.`kooptiert` desc,
            ifnull(`onlinekandidaten`.`anzahl`, 0) + ifnull(`briefwahlkandidaten`.`briefstimmen`, 0) desc,
            if(
                `kandidaten`.`losnummer_stimmzettelgruppe` = 0,
                1000000,
                `kandidaten`.`losnummer_stimmzettelgruppe`
            )
    ) AS `stimmzettelgruppen_rang`,
    dense_rank() over (
        partition by `stimmzettel`.`ridx`
        order by
            ifnull(`onlinekandidaten`.`anzahl`, 0) + ifnull(`briefwahlkandidaten`.`briefstimmen`, 0) desc
    ) AS `stimmzettel_rang`,
    `kandidaten`.`id` AS `id`,
    `kandidaten`.`losnummer` AS `losnummer`,
    `kandidaten`.`losnummer_stimmzettelgruppe` AS `losnummer_stimmzettelgruppe`,
    `kandidaten`.`kooptiert` AS `kooptiert`,
    `kandidaten`.`stimmzettelgruppen` AS `stimmzettelgruppen`,
    `stimmzettel`.`ridx` AS `stimmzettel_ridx`,
    `stimmzettel`.`name` AS `stimmzettel_name`,
    `stimmzettelgruppen`.`ridx` AS `stimmzettelgruppen_ridx`,
    `stimmzettelgruppen`.`name` AS `stimmzettelgruppen_name`,
    `stimmzettel`.`sitze` AS `stimmzettel_sitze`,
    `stimmzettelgruppen`.`sitze` AS `stimmzettelgruppen_sitze`,
    `stimmzettelgruppen`.`mindestsitze` AS `stimmzettelgruppen_mindestsitze`,
    ifnull(`onlinekandidaten`.`anzahl`, 0) AS `onlinestimmen`,
    ifnull(`briefwahlkandidaten`.`briefstimmen`, 0) AS `offlinestimmen`,
    ifnull(`onlinekandidaten`.`anzahl`, 0) + ifnull(`briefwahlkandidaten`.`briefstimmen`, 0) AS `gesamtstimmen`
from
    (
        (
            (
                (
                    `kandidaten`
                    join `stimmzettelgruppen` on(
                        `kandidaten`.`stimmzettelgruppen` = `stimmzettelgruppen`.`ridx`
                    )
                )
                join `stimmzettel` on(
                    `stimmzettelgruppen`.`stimmzettel` = `stimmzettel`.`ridx`
                )
            )
            left join `onlinekandidaten` on(
                `onlinekandidaten`.`name` = `kandidaten`.`barcode`
            )
        )
        left join `briefwahlkandidaten` on(
            `briefwahlkandidaten`.`zaehlung_barcode` = `kandidaten`.`barcode`
        )
    )
order by
    ifnull(`onlinekandidaten`.`anzahl`, 0) + ifnull(`briefwahlkandidaten`.`briefstimmen`, 0) desc;