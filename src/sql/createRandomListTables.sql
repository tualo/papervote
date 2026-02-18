


CREATE TRIGGER IF NOT EXISTS wahlschein_passwords_stop
BEFORE UPDATE  
ON wahlschein_passwords FOR EACH ROW
BEGIN
    SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=30001, MESSAGE_TEXT='Object Type is not allowed as value';
END //


create table if not exists wahlschein_passwords (
    id bigint primary key,
    wahlscheinnummer varchar(12),
    `username` varchar(12),
    `password` varchar(12),
    `pwhash` varchar(100)
);
alter table wahlschein_passwords add copied tinyint default 0;

create index idx_wahlschein_passwords_wahlscheinnummer on wahlschein_passwords (wahlscheinnummer);
create index idx_wahlschein_passwords_pwhash on wahlschein_passwords (pwhash);

insert ignore into wahlschein_passwords (id) 
select id from wahlschein 




CREATE OR REPLACE PROCEDURE `createRandomListTables`(
    in randomLength SMALLINT(3),
    in allowedChars varchar(255), 
    in listLength int(11),
    in fieldToUnique varchar(255)
)
begin

    declare sql_command longtext;
    declare c int;

    set sql_command = concat('create table if not exists random_list_',fieldToUnique,' (seq bigint , val varchar(',randomLength,') primary key,used tinyint default 0)');
    PREPARE stmt FROM sql_command;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;


    set c=0;
    while (c < listLength) DO
        set sql_command = concat('insert ignore into random_list_',fieldToUnique,' (seq  , val )  select seq,randomString(',randomLength,',"',allowedChars,'") val from seq_1_to_1000');
        PREPARE stmt FROM sql_command;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
        SET c = c+1000;
    END WHILE;

end //

call createRandomListTables(8,"1234567890",1200000,"wahlscheinnummer");
call createRandomListTables(8,"ABCDEFGHJKLMNPRSTUVXYZabcdefghijkmpstuvxyz123456789",1200000,"username");
call createRandomListTables(8,"ABCDEFGHJKLMNPRSTUVXYZabcdefghijkmpstuvxyz123456789",1200000,"password");
 
alter table wahlschein_passwords add copied tinyint default 0;

CREATE OR REPLACE PROCEDURE `copyPasswords`()
begin

    update wahlschein w
    join wahlschein_passwords p
    on w.id = p.id
    and w.wusername=''
    set w.wahlscheinnummer = p.wahlscheinnummer, w.username = p.username, w.password = p.password
    limit 10000;

end //


CREATE OR REPLACE PROCEDURE `doPasswords`()
begin

    for record in (select seq from seq_1_to_100) do
    drop table if exists tmp_temp_random_list;
    create table tmp_temp_random_list as 
    with ws as (
        select rank() over (order by r) x , val from 
        (select rand() r,val from random_list_wahlscheinnummer where used = 0 order by rand() limit 1000) x
    ),un as (
        select rank() over (order by r) x , val from 
        (select rand() r,val from random_list_username where used = 0  order by rand() limit 1000) x
    ),
    pw as (
        select rank() over (order by r) x , val from 
        (select rand() r,val from random_list_password where used = 0  order by rand() limit 1000) x
    ),
    wp as
    (
        select rank() over (order by id) x,id,wahlscheinnummer from wahlschein_passwords where wahlscheinnummer is null limit 1000
    )
    select 
        ws.val wn,
        un.val un,
        pw.val pw,
        wp.*
    from 
        wp
        join ws 
        on wp.x = ws.x
        join un
        on wp.x = un.x
        join pw
        on wp.x = pw.x
    ;

    update wahlschein_passwords w
    join tmp_temp_random_list t
    on w.id = t.id
    set w.wahlscheinnummer = t.wn, w.username = t.un, w.password = t.pw;

    update random_list_wahlscheinnummer 
    join tmp_temp_random_list t
    on random_list_wahlscheinnummer.val = t.wn
    set used =1 ;

    update random_list_username 
    join tmp_temp_random_list t
    on random_list_username.val = t.un
    set used =1 ;

    update random_list_password 
    join tmp_temp_random_list t
    on random_list_password.val = t.pw
    set used =1 ;
    
    end for;
    
    /*
    drop table if exists tmp_temp_random_list_wahlscheinnummer;
    drop table if exists tmp_temp_random_list_username;
    drop table if exists tmp_temp_random_list_password;
    

    create temporary table tmp_temp_random_list_wahlscheinnummer as
    select * from random_list_wahlscheinnummer where used = 0 order by rand() limit 100000;
    

    create temporary table tmp_temp_random_list_username as
    select * from random_list_username where used = 0  order by rand() limit 100000;
    
    create temporary table tmp_temp_random_list_password as
    select * from random_list_password where used = 0  order by rand() limit 100000;
    
    
    for rec in (select * from wahlschein_passwords where wahlscheinnummer is null limit 100000) do
        
        select tmp_temp_random_list_wahlscheinnummer.val into @wahlscheinnummer from tmp_temp_random_list_wahlscheinnummer where used=0 limit 1;
        select tmp_temp_random_list_username.val into @username from tmp_temp_random_list_username where used=0 limit 1;
        select tmp_temp_random_list_password.val into @password from tmp_temp_random_list_password where used=0 limit 1;

        update random_list_wahlscheinnummer set used =1 where val = @wahlscheinnummer;
        update random_list_username set used =1 where val = @username;
        update random_list_password set used =1 where val = @password;

        update tmp_temp_random_list_wahlscheinnummer set used =1 where val = @wahlscheinnummer;
        update tmp_temp_random_list_username set used =1 where val = @username;
        update tmp_temp_random_list_password set used =1 where val = @password;

        select @wahlscheinnummer,rec.id;

        update wahlschein_passwords set wahlscheinnummer = @wahlscheinnummer, username = @username, password = @password where id = rec.id;
        -- select now();
    end for;

    */



end //