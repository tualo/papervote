delimiter ;

 
alter table abgabetyp modify aktiv tinyint default 1;

alter table kandidaten modify aktiv tinyint default 1;
alter table kandidaten1 modify aktiv tinyint default 1;
alter table kandidaten2 modify aktiv tinyint default 1;
alter table kisten1 modify aktiv tinyint default 1;
alter table kisten2 modify aktiv tinyint default 1;
alter table ruecklauffelder modify aktiv tinyint default 1;
alter table stapel1 modify aktiv tinyint default 1;
alter table stapel2 modify aktiv tinyint default 1;
alter table stimmzettel modify aktiv tinyint default 1;
alter table stimmzettel1 modify aktiv tinyint default 1;
alter table stimmzettel2 modify aktiv tinyint default 1;


alter table wahlbeteiligung_bericht modify aktiv tinyint default 1;
alter table wahlbeteiligung_bericht_formel modify aktiv tinyint default 1;
alter table wahlbeteiligung_bericht_formel_nenner modify aktiv tinyint default 1;
alter table wahlbeteiligung_bericht_formel_teiler modify aktiv tinyint default 1;
alter table wahlbeteiligung_bericht_status modify aktiv tinyint default 1;
alter table wahlbezirk modify aktiv tinyint default 1;
alter table wahlgruppe modify aktiv tinyint default 1;
alter table wahlruecklauf_felder modify aktiv tinyint default 1;

alter table wahlscheinstatus modify aktiv tinyint default 1;
alter table wahlscheinstatus_grund modify aktiv tinyint default 1;

alter table wahltyp modify aktiv tinyint default 1;
alter table wahlzeichnungsberechtigter modify aktiv tinyint default 1;
alter table wm_tannummer modify aktiv tinyint default 1;
alter table wzbruecklauffelder modify aktiv tinyint default 1;

call fill_ds('');

call fill_ds_column('abgabetyp');

call fill_ds_column('kandidaten');
call fill_ds_column('kandidaten1');
call fill_ds_column('kandidaten2');
call fill_ds_column('kisten1');
call fill_ds_column('kisten2');
call fill_ds_column('ruecklauffelder');
call fill_ds_column('stapel1');
call fill_ds_column('stapel2');
call fill_ds_column('stimmzettel');
call fill_ds_column('stimmzettel1');
call fill_ds_column('stimmzettel2');
call fill_ds_column('stimmzettel_default');
call fill_ds_column('view_readtable_kandidaten');
call fill_ds_column('wahlberechtigte');
call fill_ds_column('wahlbeteiligung_bericht');
call fill_ds_column('wahlbeteiligung_bericht_formel');
call fill_ds_column('wahlbeteiligung_bericht_formel_nenner');
call fill_ds_column('wahlbeteiligung_bericht_formel_teiler');
call fill_ds_column('wahlbeteiligung_bericht_status');
call fill_ds_column('wahlbezirk');
call fill_ds_column('wahlgruppe');
call fill_ds_column('wahlruecklauf_felder');
call fill_ds_column('wahlschein');
call fill_ds_column('wahlscheinstatus');
call fill_ds_column('wahlscheinstatus_grund');


call fill_ds_column('wahltyp');
call fill_ds_column('wahlzeichnungsberechtigter');
call fill_ds_column('wm_tannummer');
call fill_ds_column('wzbruecklauffelder');

