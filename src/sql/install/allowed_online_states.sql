delimiter ; 
create table wahlscheinstatus_online_erlaubt (
    wahlscheinstatus varchar(12) primary key,
    constraint fk_wahlscheinstatus_online_erlaubt_wahlscheinstatus
    foreign key (wahlscheinstatus)
    references wahlscheinstatus(ridx)
    on update cascade
    on delete cascade
);

insert ignore into wahlscheinstatus_online_erlaubt(wahlscheinstatus) values ('1|0');