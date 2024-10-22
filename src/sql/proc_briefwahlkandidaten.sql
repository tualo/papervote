DELIMITER //

drop view if exists briefwahlkandidaten //
create table if not exists briefwahlkandidaten (
    id	int(11) primary key,
    stimmzettelgruppen	varchar(12),
    briefstimmen	bigint(21),
    zaehlung_barcode	varchar(255),
    zaehlung_stimmzettel	varchar(12)
) //



CREATE OR REPLACE PROCEDURE `proc_briefwahlkandidaten`()
BEGIN

    for rec in (
            select 
                `kandidaten`.`id` AS `id`,
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
            group by `kandidaten`.`id`
    ) do
        insert into briefwahlkandidaten  (
            id,
            stimmzettelgruppen,
            briefstimmen,
            zaehlung_barcode,
            zaehlung_stimmzettel
        ) values 
        (
            rec.id,
            rec.stimmzettelgruppen,
            rec.briefstimmen,
            rec.zaehlung_barcode,
            rec.zaehlung_stimmzettel
        )
        on duplicate key update briefstimmen=values(briefstimmen)
        ;
    end for;
end //