delimiter //

CREATE OR REPLACE PROCEDURE `check_wahlscheinstatus_online_erlaubt`( )
BEGIN
  if not exists(select * from ds_column where table_name = 'wahlscheinstatus_online_erlaubt' and column_name='abgabetyp') then
    drop table if exists wahlscheinstatus_online_erlaubt;
  end if;
END //
call check_wahlscheinstatus_online_erlaubt() //
