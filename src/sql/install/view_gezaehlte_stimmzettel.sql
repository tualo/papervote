DELIMITER ;

CREATE OR REPLACE VIEW `view_gezaehlte_stimmzettel` AS
select
    `x`.`stimmzettel` AS `stimmzettel`,
    sum(`x`.`gezaehlte_stimmzettel`) AS `gezaehlte_stimmzettel`
from
    (
        select
            `stimmzettelgruppen`.`stimmzettel` AS `stimmzettel`,
            count(distinct `stimmzettel2`.`ridx`) AS `gezaehlte_stimmzettel`
        from
            (
                (
                    (
                        (
                            `kandidaten2`
                            join `kandidaten` on(`kandidaten2`.`name` = `kandidaten`.`barcode`)
                        )
                        join `stimmzettelgruppen` on(
                            `stimmzettelgruppen`.`ridx` = `kandidaten`.`stimmzettelgruppen`
                        )
                    )
                    join `stimmzettel2` on(
                        `kandidaten2`.`stimmzettel2` = `stimmzettel2`.`ridx`
                    )
                )
                join `stapel2` on(
                    `stimmzettel2`.`stapel2` = `stapel2`.`ridx`
                    and `stapel2`.`abgebrochen` = 0
                )
            )
        group by
            `stimmzettelgruppen`.`stimmzettel`
        union all
        select
            `onlinestimmzettel`.`stimmzettel` AS `stimmzettel`,
            `onlinestimmzettel`.`anzahl` AS `gezaehlte_stimmzettel`
        from
            `onlinestimmzettel`
    ) `x`
group by
    `x`.`stimmzettel`