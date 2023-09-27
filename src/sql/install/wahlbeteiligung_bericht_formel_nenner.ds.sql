DELIMITER ;

LOCK TABLES `ds` WRITE;
INSERT INTO `ds` (`table_name`, `title`, `reorderfield`, `use_history`, `searchfield`, `displayfield`, `sortfield`, `searchany`, `hint`, `overview_tpl`, `sync_table`, `writetable`, `globalsearch`, `listselectionmodel`, `sync_view`, `syncable`, `cssstyle`, `read_table`, `existsreal`, `class_name`, `special_add_panel`, `read_filter`, `listxtypeprefix`, `phpexporter`, `phpexporterfilename`, `combined`, `allowForm`, `alternativeformxtype`, `character_set_name`, `default_pagesize`, `listviewbaseclass`, `showactionbtn`) 
VALUES ('wahlbeteiligung_bericht_formel_nenner','Nenner',NULL,0,'name','name','id',1,'',NULL,NULL,'',1,NULL,NULL,0,NULL,'',1,'Wahlsystem',NULL,NULL,'listview','XlsxWriter','{GUID}',0,1,'','',100,'Tualo.DataSets.ListView',1)

ON DUPLICATE KEY UPDATE
                    `title`=VALUES(`title`),
                    `reorderfield`=VALUES(`reorderfield`),
                    `use_history`=VALUES(`use_history`),
                    `searchfield`=VALUES(`searchfield`),
                    `displayfield`=VALUES(`displayfield`),
                    `sortfield`=VALUES(`sortfield`),
                    `searchany`=VALUES(`searchany`),
                    `hint`=VALUES(`hint`),
                    `overview_tpl`=VALUES(`overview_tpl`),
                    `sync_table`=VALUES(`sync_table`),
                    `writetable`=VALUES(`writetable`),
                    `globalsearch`=VALUES(`globalsearch`),
                    `listselectionmodel`=VALUES(`listselectionmodel`),
                    `sync_view`=VALUES(`sync_view`),
                    `syncable`=VALUES(`syncable`),
                    `cssstyle`=VALUES(`cssstyle`),
                    `alternativeformxtype`=VALUES(`alternativeformxtype`),
                    `read_table`=   VALUES(read_table),
                    `class_name`=VALUES(`class_name`),
                    `special_add_panel`=VALUES(`special_add_panel`),
                    `existsreal`=VALUES(`existsreal`),
                    `character_set_name`=VALUES(`character_set_name`),
                    `read_filter`=VALUES(`read_filter`),
                    `listxtypeprefix`=VALUES(`listxtypeprefix`),
                    `phpexporter`=VALUES(`phpexporter`),
                    `phpexporterfilename`=VALUES(`phpexporterfilename`),
                    `combined`=VALUES(`combined`),
                    `default_pagesize`=VALUES(`default_pagesize`),
                    `allowForm`=VALUES(`allowForm`),
                    `listviewbaseclass`=VALUES(`listviewbaseclass`),
                    `showactionbtn`=VALUES(`showactionbtn`),
                    `modelbaseclass`=VALUES(`modelbaseclass`)
;

UNLOCK TABLES;
LOCK TABLES `ds_column` WRITE;
INSERT IGNORE INTO `ds_column` (`table_name`, `column_name`, `default_value`, `default_max_value`, `default_min_value`, `is_primary`, `update_value`, `is_nullable`, `is_referenced`, `referenced_table`, `referenced_column_name`, `data_type`, `column_key`, `column_type`, `character_maximum_length`, `numeric_precision`, `numeric_scale`, `character_set_name`, `privileges`, `existsreal`, `deferedload`, `writeable`, `note`, `hint`) VALUES ('wahlbeteiligung_bericht_formel_nenner','aktiv','1',0,0,0,'','YES','NO',NULL,NULL,'varchar','','varchar(255)',255,NULL,NULL,'utf8mb3','select,insert,update,references',1,0,1,'',''),
('wahlbeteiligung_bericht_formel_nenner','id','{#serial}',50000,0,1,'','NO','NO','','','int','PRI','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,1,'\'\'','\'\''),
('wahlbeteiligung_bericht_formel_nenner','insert_date','{DATE}',0,0,0,'','YES','NO',NULL,NULL,'date','','date',NULL,NULL,NULL,NULL,'select,insert,update,references',1,0,1,'',''),
('wahlbeteiligung_bericht_formel_nenner','insert_time','{TIME}',0,0,0,'','YES','NO',NULL,NULL,'time','','time',NULL,NULL,NULL,NULL,'select,insert,update,references',1,0,1,'',''),
('wahlbeteiligung_bericht_formel_nenner','kostenstelle','0',0,0,1,'','NO','NO',NULL,NULL,'int','PRI','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,1,'',''),
('wahlbeteiligung_bericht_formel_nenner','login','{login}',0,0,0,'{login}','YES','NO',NULL,NULL,'varchar','','varchar(255)',255,NULL,NULL,'utf8mb3','select,insert,update,references',1,0,1,'',''),
('wahlbeteiligung_bericht_formel_nenner','name','{id}',0,0,0,'','YES','NO',NULL,NULL,'varchar','','varchar(255)',255,NULL,NULL,'utf8mb3','select,insert,update,references',1,0,1,'',''),
('wahlbeteiligung_bericht_formel_nenner','ridx','{id}',0,0,0,'','YES','NO',NULL,NULL,'varchar','','varchar(255)',255,NULL,NULL,'utf8mb3','select,insert,update,references',1,0,1,'',''),
('wahlbeteiligung_bericht_formel_nenner','update_date','{DATE}',0,0,0,'{DATE}','YES','NO',NULL,NULL,'date','','date',NULL,NULL,NULL,NULL,'select,insert,update,references',1,0,1,'',''),
('wahlbeteiligung_bericht_formel_nenner','update_time','{TIME}',0,0,0,'{TIME}','YES','NO',NULL,NULL,'time','','time',NULL,NULL,NULL,NULL,'select,insert,update,references',1,0,1,'',''),
('wahlbeteiligung_bericht_formel_nenner','wahlbeteiligung_bericht','',0,0,0,'','YES','NO',NULL,NULL,'varchar','MUL','varchar(255)',255,NULL,NULL,'utf8mb3','select,insert,update,references',1,0,1,'',''),
('wahlbeteiligung_bericht_formel_nenner','wahlbeteiligung_bericht_formel','',0,0,0,'','YES','NO',NULL,NULL,'varchar','MUL','varchar(255)',255,NULL,NULL,'utf8mb3','select,insert,update,references',1,0,1,'','');
UNLOCK TABLES;
LOCK TABLES `ds_column_list_label` WRITE;
INSERT IGNORE INTO `ds_column_list_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `editor`, `position`, `summaryrenderer`, `summarytype`, `hidden`, `active`, `renderer`, `filterstore`, `flex`, `direction`, `align`, `grouped`, `listfiltertype`, `hint`) VALUES ('wahlbeteiligung_bericht_formel_nenner','aktiv','DE','aktiv','gridcolumn','',999,'','',1,1,'','',1.00,'','',0,'','NULL'),
('wahlbeteiligung_bericht_formel_nenner','id','DE','id','gridcolumn','',0,'','',0,1,'','',1.00,'ASC','left',0,'',''),
('wahlbeteiligung_bericht_formel_nenner','kostenstelle','DE','kostenstelle','gridcolumn','',0,'','',0,1,'','',1.00,'ASC','left',0,'',''),
('wahlbeteiligung_bericht_formel_nenner','wahlbeteiligung_bericht','DE','Bericht','column_wahlbeteiligung_bericht_ridx','',999,NULL,NULL,0,1,'','',1.00,'ASC','left',0,'','');
UNLOCK TABLES;
LOCK TABLES `ds_column_form_label` WRITE;
INSERT IGNORE INTO `ds_column_form_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `field_path`, `position`, `hidden`, `active`, `allowempty`, `fieldgroup`) VALUES ('wahlbeteiligung_bericht_formel_nenner','id','DE','id','displayfield','Allgemein',0,0,1,1,''),
('wahlbeteiligung_bericht_formel_nenner','kostenstelle','DE','kostenstelle','displayfield','Allgemein',0,0,1,1,''),
('wahlbeteiligung_bericht_formel_nenner','wahlbeteiligung_bericht','DE','Bericht','combobox_wahlbeteiligung_bericht_ridx','Allgemein',999,0,1,1,''),
('wahlbeteiligung_bericht_formel_nenner','wahlbeteiligung_bericht_formel','DE','Formel','displayfield','Allgemein',999,0,1,1,'');
UNLOCK TABLES;
LOCK TABLES `ds_dropdownfields` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_reference_tables` WRITE;
INSERT IGNORE INTO `ds_reference_tables` (`table_name`, `reference_table_name`, `columnsdef`, `active`, `constraint_name`, `searchable`, `autosync`, `position`, `path`) VALUES ('wahlbeteiligung_bericht_formel_nenner','wahlbeteiligung_bericht','{\"wahlbeteiligung_bericht_formel_nenner__wahlbeteiligung_bericht\":\"wahlbeteiligung_bericht__ridx\",\"wahlbeteiligung_bericht_formel_nenner__wahlbeteiligung_bericht\":\"wahlbeteiligung_bericht__ridx\",\"wahlbeteiligung_bericht_formel_nenner__wahlbeteiligung_bericht\":\"wahlbeteiligung_bericht__ridx\",\"wahlbeteiligung_bericht_formel_nenner__wahlbeteiligung_bericht\":\"wahlbeteiligung_bericht__ridx\"}',0,'',0,1,99999,''),
('wahlbeteiligung_bericht_formel_nenner','wahlbeteiligung_bericht','{\"wahlbeteiligung_bericht_formel_nenner__wahlbeteiligung_bericht\":\"wahlbeteiligung_bericht__ridx\"}',0,'fk_wahlbeteiligung_bericht_formel_nenner',0,1,99999,''),
('wahlbeteiligung_bericht_formel_nenner','wahlbeteiligung_bericht_formel','{\"wahlbeteiligung_bericht_formel_nenner__wahlbeteiligung_bericht_formel\":\"wahlbeteiligung_bericht_formel__ridx\",\"wahlbeteiligung_bericht_formel_nenner__wahlbeteiligung_bericht_formel\":\"wahlbeteiligung_bericht_formel__ridx\",\"wahlbeteiligung_bericht_formel_nenner__wahlbeteiligung_bericht_formel\":\"wahlbeteiligung_bericht_formel__ridx\",\"wahlbeteiligung_bericht_formel_nenner__wahlbeteiligung_bericht_formel\":\"wahlbeteiligung_bericht_formel__ridx\"}',0,'',0,1,99999,''),
('wahlbeteiligung_bericht_formel_nenner','wahlbeteiligung_bericht_formel','{\"wahlbeteiligung_bericht_formel_nenner__wahlbeteiligung_bericht_formel\":\"wahlbeteiligung_bericht_formel__ridx\"}',1,'fk_wahlbeteiligung_bf_nenner_wbb_formel',0,1,99999,'');
UNLOCK TABLES;
LOCK TABLES `ds_addcommands` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_access` WRITE;
INSERT IGNORE INTO `ds_access` (`role`, `table_name`, `read`, `write`, `delete`, `append` ) 
VALUES ('wahl_administration','wahlbeteiligung_bericht_formel_nenner',1,1,1,1);
UNLOCK TABLES;
