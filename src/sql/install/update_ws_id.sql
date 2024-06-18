delimiter //

alter table wahlberechtigte_anlage add ws_id bigint //
create index idx_wahlberechtigte_anlage_ws_id on wahlberechtigte_anlage(ws_id) //

CREATE OR REPLACE PROCEDURE `update_ws_id`()
BEGIN
DECLARE prefix integer;
DECLARE new_ws_id bigint;

for rec_sz in (
    SELECT id,ridx   FROM stimmzettel 
) do
     update wahlberechtigte_anlage set ws_id = concat(rec_sz.id,lpad(wahlberechtigte_anlage.identnummer,12,'0'))   where ws_id is null and stimmzettel=rec_sz.ridx;
end for;
END //