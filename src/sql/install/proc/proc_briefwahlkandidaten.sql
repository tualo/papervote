DELIMITER //



CREATE OR REPLACE PROCEDURE `proc_briefwahlkandidaten`()
BEGIN

    if 
        exists(select * from  briefwahlkandidaten where updated_at < now() + interval - 1 minute) 
        or  
        exists(select count(*) c  from  briefwahlkandidaten having c=0) 
    then

        for rec in (
                with x as (
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
                                                `kandidaten2`.`stimmzettel2` = `stimmzettel2`.`id`
                                            )
                                        )
                                        join `stapel2` on(
                                            `stimmzettel2`.`stapel2` = `stapel2`.`id`
                                            and `stapel2`.`abgebrochen` = 0
                                        )
                                    )
                                    join `kisten2` on(`stapel2`.`kisten2` = `kisten2`.`id`)
                                )
                                join `kandidaten` on(`kandidaten`.`barcode` = `kandidaten2`.`name`)
                            )
                            join `stimmzettelgruppen` on(
                                `kandidaten`.`stimmzettelgruppen` = `stimmzettelgruppen`.`id`
                            )
                        )
                    group by `kandidaten`.`id`
                )
                select 
                    `kandidaten`.`id`,
                    `kandidaten`.`stimmzettelgruppen` AS `stimmzettelgruppen`,

                    ifnull(x.briefstimmen,0) briefstimmen,
                    ifnull(x.zaehlung_barcode,`kandidaten`.`barcode`)  AS `zaehlung_barcode`,
                    ifnull(x.zaehlung_stimmzettel,stimmzettelgruppen.`stimmzettel`) AS `zaehlung_stimmzettel`

                from 
                    kandidaten
                    join `stimmzettelgruppen` on(
                        `kandidaten`.`stimmzettelgruppen` = `stimmzettelgruppen`.`id`
                    )
                    left join x on kandidaten.id = x.id
        ) do
            insert into `briefwahlkandidaten`  (
                `id`,
                `stimmzettelgruppen`,
                `briefstimmen`
            ) values 
            (
                rec.id,
                rec.stimmzettelgruppen,
                rec.briefstimmen
            )
            on duplicate key update `briefstimmen`=values(`briefstimmen`)
            ;
        end for;

    end if;

end //