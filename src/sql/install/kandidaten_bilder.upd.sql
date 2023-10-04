DELIMITER ;

alter table kandidaten_bilder modify file_id varchar(36) default null;
alter table kandidaten_bilder modify id varchar(36);
