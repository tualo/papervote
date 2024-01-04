delimiter //

CREATE OR REPLACE PROCEDURE `check_wahlscheinstatus_online_erlaubt`( )
BEGIN
  if not exists(select * from ds_column where table_name = 'wahlscheinstatus_online_erlaubt' and column_name='abgabetyp') then
    drop table if exists wahlscheinstatus_online_erlaubt;
  end if;
END //
call check_wahlscheinstatus_online_erlaubt() //
CREATE TABLE IF NOT EXISTS `wahlscheinstatus_online_erlaubt` (

  `wahlscheinstatus` varchar(12) NOT NULL,
  abgabetyp varchar(12),
  primary key(wahlscheinstatus, abgabetyp),

  CONSTRAINT `fk_wahlscheinstatus_online_erlaubt_wahlscheinstatus` FOREIGN KEY (`wahlscheinstatus`) REFERENCES `wahlscheinstatus` (`ridx`) ON DELETE CASCADE ON UPDATE CASCADE,

  constraint fk_wahlscheinstatus_online_erlaubt_abgabetyp
  foreign key (abgabetyp)
  references abgabetyp(ridx)
  on update cascade
  on delete cascade

)
//

insert ignore into wahlscheinstatus_online_erlaubt (wahlscheinstatus,abgabetyp) values ('1|0','0|0')//

drop procedure if exists check_wahlscheinstatus_online_erlaubt //