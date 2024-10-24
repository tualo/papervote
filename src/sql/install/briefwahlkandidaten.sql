DELIMITER;
create or replace view `briefwahlkandidaten_old` as
select `kandidaten`.`id` AS `id`,
    `kandidaten`.`stimmzettelgruppen` AS `stimmzettelgruppen`,
    count(0) AS `briefstimmen`,
    `kandidaten2`.`name` AS `zaehlung_barcode`,
    `stimmzettel2`.`stimmzettel` AS `zaehlung_stimmzettel`
from (
        (
            (
                (
                    (
                        `kandidaten2`
                        join `stimmzettel2` on(
                            `kandidaten2`.`stimmzettel2` = `stimmzettel2`.`ridx`
                        )
                    )
                    join `stapel2` on(
                        `stimmzettel2`.`stapel2` = `stapel2`.`ridx`
                        and `stapel2`.`abgebrochen` = 0
                    )
                )
                join `kisten2` on(`stapel2`.`kisten2` = `kisten2`.`ridx`)
            )
            join `kandidaten` on(`kandidaten`.`barcode` = `kandidaten2`.`name`)
        )
        join `stimmzettelgruppen` on(
            `kandidaten`.`stimmzettelgruppen` = `stimmzettelgruppen`.`ridx`
        )
    )
group by `kandidaten`.`id`;