delimiter ;

alter table abgabetyp modify aktiv tinyint default 1;

alter table kandidaten1 modify aktiv tinyint default 1;
alter table kandidaten2 modify aktiv tinyint default 1;
alter table kisten1 modify aktiv tinyint default 1;
alter table kisten2 modify aktiv tinyint default 1;
alter table stapel1 modify aktiv tinyint default 1;
alter table stapel2 modify aktiv tinyint default 1;
alter table stimmzettel modify aktiv tinyint default 1;
alter table stimmzettel1 modify aktiv tinyint default 1;
alter table stimmzettel2 modify aktiv tinyint default 1;

alter table wahlschein modify aktiv tinyint default 1;
alter table wahlschein_hstr modify aktiv tinyint default 1;
alter table wm_tannummer modify aktiv tinyint default 1;

call fill_ds('');