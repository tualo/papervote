delimiter ;


UNLOCK TABLES;
LOCK TABLES `ds_column` WRITE;
INSERT IGNORE INTO `ds_column` (`table_name`, `column_name`, `default_value`, `default_max_value`, `default_min_value`, `is_primary`, `update_value`, `is_nullable`, `is_referenced`, `referenced_table`, `referenced_column_name`, `data_type`, `column_key`, `column_type`, `character_maximum_length`, `numeric_precision`, `numeric_scale`, `character_set_name`, `privileges`, `existsreal`, `deferedload`, `writeable`, `note`, `hint`) VALUES ('wahlscheinstatus_grund','aktiv','1',0,0,0,'','YES','NO',NULL,NULL,'varchar','','varchar(255)',255,NULL,NULL,'utf8mb3','select,insert,update,references',1,0,1,'',''),
('wahlscheinstatus_grund','barcode','',0,0,0,'','YES','NO',NULL,NULL,'varchar','','varchar(255)',255,NULL,NULL,'utf8mb3','select,insert,update,references',1,0,1,'',''),
('wahlscheinstatus_grund','id','{#serial}',0,0,1,'','NO','NO',NULL,NULL,'int','PRI','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,1,'',''),
('wahlscheinstatus_grund','insert_date','{DATE}',0,0,0,'','YES','NO',NULL,NULL,'date','','date',NULL,NULL,NULL,NULL,'select,insert,update,references',1,0,1,'',''),
('wahlscheinstatus_grund','insert_time','{TIME}',0,0,0,'','YES','NO',NULL,NULL,'time','','time',NULL,NULL,NULL,NULL,'select,insert,update,references',1,0,1,'',''),
('wahlscheinstatus_grund','kostenstelle','0',0,0,1,'','NO','NO',NULL,NULL,'int','PRI','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,1,'',''),
('wahlscheinstatus_grund','login','{login}',0,0,0,'','YES','NO',NULL,NULL,'varchar','','varchar(255)',255,NULL,NULL,'utf8mb3','select,insert,update,references',1,0,1,'',''),
('wahlscheinstatus_grund','name','',0,0,0,'','YES','NO',NULL,NULL,'varchar','','varchar(255)',255,NULL,NULL,'utf8mb3','select,insert,update,references',1,0,1,'',''),
('wahlscheinstatus_grund','ridx','{id}',0,0,0,'','YES','NO',NULL,NULL,'varchar','','varchar(255)',255,NULL,NULL,'utf8mb3','select,insert,update,references',1,0,1,'',''),
('wahlscheinstatus_grund','update_date','{DATE}',0,0,0,'{DATE}','YES','NO',NULL,NULL,'date','','date',NULL,NULL,NULL,NULL,'select,insert,update,references',1,0,1,'',''),
('wahlscheinstatus_grund','update_time','{TIME}',0,0,0,'{TIME}','YES','NO',NULL,NULL,'time','','time',NULL,NULL,NULL,NULL,'select,insert,update,references',1,0,1,'',''),
('wahlscheinstatus_grund','wahlscheinstatus','',0,0,0,'','YES','NO',NULL,NULL,'varchar','MUL','varchar(255)',255,NULL,NULL,'utf8mb3','select,insert,update,references',1,0,1,'','');
UNLOCK TABLES;
LOCK TABLES `ds_column_list_label` WRITE;
INSERT IGNORE INTO `ds_column_list_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `editor`, `position`, `summaryrenderer`, `summarytype`, `hidden`, `active`, `renderer`, `filterstore`, `flex`, `direction`, `align`, `grouped`, `listfiltertype`, `hint`) VALUES ('wahlscheinstatus_grund','id','DE','id','gridcolumn','',0,'','',0,1,'','',1.00,'ASC','left',0,'',''),
('wahlscheinstatus_grund','kostenstelle','DE','kostenstelle','gridcolumn','',0,'','',0,1,'','',1.00,'ASC','left',0,'','');
UNLOCK TABLES;
LOCK TABLES `ds_column_form_label` WRITE;
INSERT IGNORE INTO `ds_column_form_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `field_path`, `position`, `hidden`, `active`, `allowempty`, `fieldgroup`) VALUES ('wahlscheinstatus_grund','id','DE','id','displayfield','Allgemein',0,0,1,1,''),
('wahlscheinstatus_grund','kostenstelle','DE','kostenstelle','displayfield','Allgemein',0,0,1,1,'');
UNLOCK TABLES;
LOCK TABLES `ds_dropdownfields` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_reference_tables` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_addcommands` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_access` WRITE;
INSERT IGNORE INTO `ds_access` (`role`, `table_name`, `read`, `write`, `delete`, `append`, `existsreal`) VALUES ('administration','wahlscheinstatus_grund',0,1,1,1,1);
UNLOCK TABLES;