delimiter ;


CREATE TABLE IF NOT EXISTS `wzbruecklauffelder` (
  `table_name`	varchar(128) default 'wahlberechtigte_anlage',
  `column_name`	varchar(100),
  `aktiv` tinyint(4) DEFAULT 1,
  `reihenfolge` int(11) DEFAULT 0,
  PRIMARY KEY (`table_name`,`column_name`),

  CONSTRAINT `fk_wzbruecklauffelder_table_name_column_name`
  foreign key (`table_name`,`column_name`)
  references `ds_column`(`table_name`,`column_name`)
  on delete cascade
  on update cascade

)
;


-- ToDo view readtable anlegen cols aus wahlberechtigte_anlge join ds_column