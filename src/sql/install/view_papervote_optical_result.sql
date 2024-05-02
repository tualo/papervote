delimiter ;
create or replace view view_papervote_optical_result as

select
 -- 

    pagination_id,
    `stimmzettel`.id stimmzettel_id,
    `stimmzettel`.name stimmzettel_name,
    kandidaten.anzeige_name,
    kandidaten.bp_column,
    RANK() OVER (
        PARTITION BY pagination_id,stimmzettel.id,kandidaten.bp_column
        ORDER BY kandidaten.barcode 
    ) bp_pos, 
    RANK() OVER (
        PARTITION BY pagination_id,stimmzettel.id 
        ORDER BY kandidaten.barcode 
    ) pos, 
    -- papervote_optical.marks,
    JSON_VALUE(papervote_optical.marks, concat('$[',RANK() OVER (
        PARTITION BY pagination_id,stimmzettel.id 
        ORDER BY kandidaten.barcode 
    )-1,']')) marked
from
    view_readtable_kandidaten as `kandidaten`
    join `stimmzettelgruppen` on `kandidaten`.`stimmzettelgruppen` = `stimmzettelgruppen`.`ridx`
    join `stimmzettel` on `stimmzettelgruppen`.`stimmzettel` = `stimmzettel`.`ridx`
    join papervote_optical
        on papervote_optical.ballotpaper_id = stimmzettel.id
;