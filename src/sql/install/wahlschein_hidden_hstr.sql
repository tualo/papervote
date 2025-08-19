create table if not exists `wahlschein_hidden_hstr` (
    `id` integer NOT NULL,
    `start`  datetime DEFAULT CURRENT_TIMESTAMP,
    `end`  datetime DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`)
);

replace into  wahlschein_hidden_hstr (id, start, end) values (1, '2025-08-12 00:00:00', '2025-08-19 10:32:00')


CREATE OR REPLACE PROCEDURE `fix_wahlschein_backup_history`()
BEGIN


drop table if exists wahlschein_backup_history;
create table wahlschein_backup_history as 
select 
    row_number() over (partition by id order by ts) rn, 
    cast(ts as datetime) min_ts,
    wahlschein.*
from wahlschein for SYSTEM_TIME all ;


DELETE HISTORY FROM wahlschein;

for rec in (  
 select * from wahlschein_backup_history where rn <= 2 and wahlscheinstatus in ('17|0','1|0') order by rn, min_ts
)
do
if exists(select id from wahlberechtigte where ridx=rec.wahlberechtigte) then 
select rec.id;
insert into wahlschein (
    ridx,
    id,
    name,
    aktiv,
    insert_date,
    insert_time,
    update_date,
    update_time,
    login,
    stimmzettel,
    wahlscheinnummer,
    wahlberechtigte,
    wahlscheinstatus,
    wahlscheinstatus_grund,
    abgabetyp,
    pwhash,
    username,
    abgabehash,
    sendtotmg,
    antrag,
    blocknumber,
    kostenstelle,
    defered,
    secret,
    onlinecheck,
    testdaten,
    kombiniert,
    usedate/*,
    ts,
    te*/
) values (
    rec.ridx,
    rec.id,
    rec.name,
    rec.aktiv,
    rec.insert_date,
    rec.insert_time,
    rec.update_date,
    rec.update_time,
    rec.login,
    rec.stimmzettel,
    rec.wahlscheinnummer,
    rec.wahlberechtigte,
    rec.wahlscheinstatus,
    rec.wahlscheinstatus_grund,
    rec.abgabetyp,
    rec.pwhash,
    rec.username,
    rec.abgabehash,
    rec.sendtotmg,
    rec.antrag,
    rec.blocknumber,
    rec.kostenstelle,
    rec.defered,
    rec.secret,
    rec.onlinecheck,
    rec.testdaten,
    rec.kombiniert,
    rec.usedate/*,
    rec.min_ts*/
)
on duplicate key update
    name = rec.name,
    aktiv = rec.aktiv,
    insert_date = rec.insert_date,
    insert_time = rec.insert_time,
    update_date = rec.update_date,
    update_time = rec.update_time,
    login = rec.login,
    stimmzettel = rec.stimmzettel,
    wahlscheinnummer = rec.wahlscheinnummer,
    wahlberechtigte = rec.wahlberechtigte,
    wahlscheinstatus = rec.wahlscheinstatus,
    wahlscheinstatus_grund = rec.wahlscheinstatus_grund,
    abgabetyp = rec.abgabetyp,
    pwhash = rec.pwhash,
    username = rec.username,
    abgabehash = rec.abgabehash,
    sendtotmg = rec.sendtotmg,
    antrag = rec.antrag,
    blocknumber = rec.blocknumber,
    kostenstelle = rec.kostenstelle,
    defered = rec.defered,
    secret = rec.secret,
    onlinecheck = rec.onlinecheck,
    testdaten = rec.testdaten,
    kombiniert = rec.kombiniert;
end if;
end for;

END //