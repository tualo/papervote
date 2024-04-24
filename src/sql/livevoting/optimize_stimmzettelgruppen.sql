DELIMITER ;

alter table kandidaten drop constraint if exists fk_kandidaten_stimmzettelgruppen;

alter table kandidaten drop index if exists `fk_kandidaten_stimmzettelgruppen`;
alter table kandidaten modify stimmzettelgruppen integer default 0;
create index if not exists `fk_kandidaten_stimmzettelgruppen` on kandidaten (stimmzettelgruppen);



alter table stimmzettelgruppen modify stimmzettel integer default 0;
alter table stimmzettelgruppen drop constraint if exists fk_stimmzettelgruppen_stimmzettel;
alter table stimmzettelgruppen drop if exists ridx;
alter table stimmzettelgruppen drop if exists kostenstelle;
alter table stimmzettelgruppen modify stimmzettel integer default 0;
alter table stimmzettelgruppen modify sitze integer default 0;
alter table stimmzettelgruppen modify mindestsitze integer default 0;

alter table stimmzettelgruppen 
    ADD 
    CONSTRAINT `fk_stimmzettelgruppen_stimmzettel` 
    FOREIGN KEY IF NOT EXISTS (`stimmzettel`) REFERENCES `stimmzettel` (`id`) 
ON DELETE CASCADE ON UPDATE CASCADE;

alter table kandidaten
    ADD 
    CONSTRAINT `fk_kandidaten_stimmzettelgruppen` 
    FOREIGN KEY IF NOT EXISTS (`stimmzettelgruppen`) REFERENCES `stimmzettelgruppen` (`id`) 
ON DELETE CASCADE ON UPDATE CASCADE;

call fill_ds_column('stimmzettelgruppen');