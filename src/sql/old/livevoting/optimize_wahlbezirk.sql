
DELIMITER ;

alter table stimmzettel drop constraint if exists fk_stimmzettel_wahlbezirk;
alter table stimmzettel drop key if exists fk_stimmzettel_wahlbezirk;

alter table stimmzettel modify wahlbezirk integer default 1;

alter table wahlbezirk drop primary key;
alter table wahlbezirk add primary key (id);

alter table stimmzettel 
    ADD 
    CONSTRAINT `fk_stimmzettel_wahlbezirk` 
    FOREIGN KEY IF NOT EXISTS (`wahlbezirk`) REFERENCES `wahlbezirk` (`id`) 
ON DELETE CASCADE ON UPDATE CASCADE;



alter table wahlbezirk drop if exists insert_date;
alter table wahlbezirk drop if exists insert_time;
alter table wahlbezirk drop if exists update_date;
alter table wahlbezirk drop if exists update_time;

alter table wahlbezirk modify aktiv tinyint(1) default 1;


alter table wahlbezirk drop if exists ridx;

call fill_ds_column('wahlbezirk');

