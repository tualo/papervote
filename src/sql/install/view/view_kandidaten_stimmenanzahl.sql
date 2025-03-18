DELIMITER;


create or replace view `view_kandidaten_stimmenanzahl` as


with basedata as (
select
    dense_rank() over (
        partition by 
            `stimmzettel`.`id`,
            `stimmzettelgruppen`.`id`
        order by
            
            ifnull(`kandidaten`.`kooptiert`,0) desc,

            ifnull(`onlinekandidaten`.`anzahl`, 0) 
            + ifnull(`briefwahlkandidaten`.`briefstimmen`, 0) desc,
            
            if(
                `kandidaten`.`losnummer_stimmzettelgruppe` = 0,
                1000000,
                `kandidaten`.`losnummer_stimmzettelgruppe`
            )
    ) AS `stimmzettelgruppen_rang`,

    dense_rank() over (
        partition by 

            `stimmzettel`.`id`
        
        order by

            ifnull(`kandidaten`.`kooptiert`,0) desc,
            ifnull(`onlinekandidaten`.`anzahl`, 0) + ifnull(`briefwahlkandidaten`.`briefstimmen`, 0) desc

    ) AS `stimmzettel_rang`,

    `kandidaten`.`id` AS `id`,
    
    `kandidaten`.`losnummer` AS `losnummer`,
    `kandidaten`.`losnummer_stimmzettelgruppe` AS `losnummer_stimmzettelgruppe`,
    `kandidaten`.`kooptiert` AS `kooptiert`,

    `kandidaten`.`stimmzettelgruppen` AS `stimmzettelgruppen`,
    `stimmzettel`.`name` AS `stimmzettel_name`,
    `stimmzettelgruppen`.`id` AS `stimmzettelgruppen_id`,
    `stimmzettel`.`id` AS `stimmzettel_id`,
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
                        `kandidaten`.`stimmzettelgruppen` = `stimmzettelgruppen`.`id`
                    )
                )
                join `stimmzettel` on(
                    `stimmzettelgruppen`.`stimmzettel` = `stimmzettel`.`id`
                )
            )
            left join `onlinekandidaten` on(
                `onlinekandidaten`.`id` = `kandidaten`.`id`
            )
        )
        left join `briefwahlkandidaten` on(
            `briefwahlkandidaten`.`id` = `kandidaten`.`id`
        )
    )
order by
    ifnull(`onlinekandidaten`.`anzahl`, 0) + ifnull(`briefwahlkandidaten`.`briefstimmen`, 0) desc
), setup as (
    select * from votemanager_setup where id='view_kandidaten_stimmenanzahl_basis'
)
select 
setup.val,
    row_number() over (partition by stimmzettel_id order by stimmzettel_rang,id) rn,
    row_number() over (partition by stimmzettel_id order by stimmzettel_rang,id)<=stimmzettel_sitze as gewaehlt,
    basedata.*
from basedata join setup on basedata.stimmzettel_id = setup.id='view_kandidaten_stimmenanzahl_basis' and setup.val='stimmzettel'

    union all 
select 
setup.val,
    row_number() over (partition by stimmzettelgruppen_id order by stimmzettelgruppen_rang,id) rn,
    row_number() over (partition by stimmzettelgruppen_id order by stimmzettelgruppen_rang,id)<=stimmzettelgruppen_sitze as gewaehlt,
    basedata.*
from basedata join setup on basedata.stimmzettel_id = setup.id='view_kandidaten_stimmenanzahl_basis' and setup.val='stimmzettelgruppen'
    
;