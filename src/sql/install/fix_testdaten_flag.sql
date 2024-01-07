delimiter //
create or replace procedure `fix_testdaten_flag`() begin
    for rec in (
        select concat(stimmzettel.id,lpad(wahlberechtigte_anlage.identnummer,8,'0')) x from wahlberechtigte_anlage  join stimmzettel on wahlberechtigte_anlage.stimmzettel = stimmzettel.ridx where testdaten=1
    ) do
        set @sql = concat('update wahlschein set testdaten=1 where id=',rec.x);
        prepare stmt from @sql;
        execute stmt;
        deallocate prepare stmt;
    end for;

end //
