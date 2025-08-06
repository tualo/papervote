DELIMITER ;

alter table stimmzettel drop if exists insert_date;
alter table stimmzettel drop if exists insert_time;
alter table stimmzettel drop if exists update_date;
alter table stimmzettel drop if exists update_time;
alter table stimmzettel drop if exists bh1;
alter table stimmzettel drop if exists bh2;



alter table stimmzettel drop if exists laufende_nummer_1_24__nach_zuordnung_wg_wb;
alter table stimmzettel drop if exists anzahl_notwendige_bewerber_je_kombinummer;
alter table stimmzettel modify aktiv tinyint(1) default 1;
alter table stimmzettel modify sitze integer default 1;


alter table wahlgruppe drop if exists ridx;


alter table stimmzettel drop if exists anzahl_10;
alter table stimmzettel drop if exists zaehlung_1;
alter table stimmzettel drop if exists zaehlung_2;
alter table stimmzettel drop if exists zaehlung_3;
alter table stimmzettel drop if exists zaehlung_4;
alter table stimmzettel drop if exists zaehlung_5;
alter table stimmzettel drop if exists zaehlung_6;
alter table stimmzettel drop if exists zaehlung_7;
alter table stimmzettel drop if exists zaehlung_8;
alter table stimmzettel drop if exists zaehlung_9;

alter table stimmzettel drop if exists ds_count;
alter table stimmzettel drop if exists ungueltig;

alter table stimmzettel drop if exists typtitel;
alter table stimmzettel drop if exists kandidat_text_einzel;
alter table stimmzettel drop if exists kandidat_text_mehr;

call fill_ds_column('stimmzettel');
