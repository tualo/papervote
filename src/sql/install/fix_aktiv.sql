delimiter ;

alter table abgabetyp modify aktiv tinyint default 1;
call fill_ds_column('abgabetyp');

alter table wahltyp modify aktiv tinyint default 1;
call fill_ds_column('wahltyp');

alter table wahlgruppe modify aktiv tinyint default 1;
call fill_ds_column('wahlgruppe');

alter table wahlbezirk modify aktiv tinyint default 1;
call fill_ds_column('wahlbezirk');

alter table kandidaten1 modify aktiv tinyint default 1;
call fill_ds_column('kandidaten1');
alter table kandidaten2 modify aktiv tinyint default 1;
call fill_ds_column('kandidaten2');
alter table kisten1 modify aktiv tinyint default 1;
call fill_ds_column('kisten1');
alter table kisten2 modify aktiv tinyint default 1;
call fill_ds_column('kisten2');
alter table stapel1 modify aktiv tinyint default 1;
call fill_ds_column('stapel1');
alter table stapel2 modify aktiv tinyint default 1;
call fill_ds_column('stapel2');
alter table stimmzettel modify aktiv tinyint default 1;
call fill_ds_column('stimmzettel');
alter table stimmzettel1 modify aktiv tinyint default 1;
call fill_ds_column('stimmzettel1');
alter table stimmzettel2 modify aktiv tinyint default 1;
call fill_ds_column('stimmzettel2');

alter table wahlschein modify aktiv tinyint default 1;
call fill_ds_column('wahlschein');
alter table wahlschein_hstr modify aktiv tinyint default 1;
call fill_ds_column('wahlschein_hstr');
alter table wm_tannummer modify aktiv tinyint default 1;
call fill_ds_column('wm_tannummer');

call fill_ds('');
