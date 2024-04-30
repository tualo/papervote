delimiter ;

create table if not exists sz_rois (
    id integer primary key,
    name varchar(255) not null,
    x integer not null,
    y integer not null
    width integer not null,
    height integer not null
);

insert
    ignore into sz_rois (id, name, x, y)
values
    (1, 'Kreuz-Spalte-1-Spaltiger SZ', 0, 0);
