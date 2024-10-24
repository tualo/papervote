delimiter ;

CREATE OR REPLACE VIEW `view_stimmenanzahl` AS

with offline_count as
(
    select 
        kandidaten.id candidate_id,
        ifnull(briefwahlkandidaten.briefstimmen,0) offline_count
    from 
        kandidaten
        left join `briefwahlkandidaten` 
            on kandidaten.id = briefwahlkandidaten.id
            
), 


online_count as
(
    select 
            kandidaten.id candidate_id,
            ifnull(onlinekandidaten.anzahl,0) online_count
    from 
        kandidaten
        left join `onlinekandidaten` 
            on kandidaten.id = onlinekandidaten.id

),

ballotpaper_count as (
select
    `x`.`stimmzettel` AS `stimmzettel`,
    sum(`x`.`gezaehlte_stimmzettel`) AS `gezaehlte_stimmzettel`,
    sum(`x`.`offline_stimmzettel`) AS `offline_stimmzettel`
from
    (
        select
            `stimmzettelgruppen`.`stimmzettel` AS `stimmzettel`,
            count(distinct `stimmzettel2`.`ridx`) AS `gezaehlte_stimmzettel`,
            count(distinct `stimmzettel2`.`ridx`) AS `offline_stimmzettel`
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
            `onlinestimmzettel`.`anzahl` AS `gezaehlte_stimmzettel`,
            0  AS `offline_stimmzettel`
        from
            `onlinestimmzettel`
    ) `x`
group by
    `x`.`stimmzettel`
),

candidates as (
    select

        kandidaten.*,
        stimmzettelgruppen.name stimmzettelgruppen_name,
        stimmzettelgruppen.id stimmzettelgruppen_id,
        stimmzettelgruppen.ridx stimmzettelgruppen_ridx ,
        stimmzettelgruppen.sitze stimmzettelgruppen_sitze,
        stimmzettel.name stimmzettel_name,
        stimmzettel.id stimmzettel_id,
        stimmzettel.ridx stimmzettel_ridx,
        stimmzettel.sitze stimmzettel_sitze
    from

        kandidaten  
        join `stimmzettelgruppen` on(
            `kandidaten`.`stimmzettelgruppen` = `stimmzettelgruppen`.`ridx`
        )
        join `stimmzettel` on(
            `stimmzettelgruppen`.`stimmzettel` = `stimmzettel`.`ridx`
        )
)

select  

    candidates.stimmzettel_id id,

    candidates.barcode,
    concat(
        if(
            `candidates`.`titel` <> '',
            concat(`candidates`.`titel`, ' '),
            ''
        ),
        `candidates`.`nachname`,
        ', ',
        `candidates`.`vorname`
    )  anzeige_name,



    offline_count.offline_count offline,
    online_count.online_count online,
    offline_count.offline_count,
    online_count.online_count,
    offline_count.offline_count + online_count.online_count total_count,


        candidates.id kandidaten_id,
    `candidates`.`losung_verloren` AS `losung_verloren`,
    `candidates`.`nachruecker` AS `nachruecker`,

    candidates.`stimmzettel_ridx`,
    candidates.`stimmzettel_name`,
    candidates.stimmzettel_sitze stimmzettel_sitze,

    candidates.`stimmzettelgruppen_ridx`,
    candidates.`stimmzettelgruppen_name`,
    candidates.stimmzettelgruppen_sitze sitze,

    ballotpaper_count.gezaehlte_stimmzettel gezaehlte_stimmzettel,
    ballotpaper_count.offline_stimmzettel stimmzettelanzahl,
    offline_count.offline_count + online_count.online_count stimmenanzahl,
    `view_ddl_kandidaten_json`.`json_candidate`,

    'do not use' AS `kiste2`,
    'do not use' AS `stapel2`

from 
    candidates 
    join online_count on online_count.candidate_id = candidates.id
    join offline_count on offline_count.candidate_id = candidates.id
    join ballotpaper_count on ballotpaper_count.stimmzettel = candidates.stimmzettel_ridx
    join  `view_ddl_kandidaten_json` 
        on `view_ddl_kandidaten_json`.`id` = `candidates`.`id`
group by
    `candidates`.`barcode`
order by
    total_count desc


;