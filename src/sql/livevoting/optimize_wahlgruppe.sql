
DELIMITER ;
alter table stimmzettel drop constraint if exists fk_stimmzettel_wahlgruppe;
alter table stimmzettel drop key if exists fk_stimmzettel_wahlgruppe;

alter table stimmzettel modify wahlgruppe integer default 1;

alter table wahlgruppe drop primary key;
alter table wahlgruppe add primary key (id); 

alter table stimmzettel 
    ADD 
    CONSTRAINT `fk_stimmzettel_wahlgruppe` 
    FOREIGN KEY IF NOT EXISTS (`wahlgruppe`) REFERENCES `wahlgruppe` (`id`) 
ON DELETE CASCADE ON UPDATE CASCADE;


alter table wahlgruppe drop if exists insert_date;
alter table wahlgruppe drop if exists insert_time;
alter table wahlgruppe drop if exists update_date;
alter table wahlgruppe drop if exists update_time;

alter table wahlgruppe modify aktiv tinyint(1) default 1;


alter table wahlgruppe drop if exists ridx;

call fill_ds_column('wahlgruppe');

