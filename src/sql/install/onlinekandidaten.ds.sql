DELIMITER ;


LOCK TABLES `ds` WRITE;
INSERT INTO `ds` (`table_name`, `title`, `reorderfield`, `use_history`, `searchfield`, `displayfield`, `sortfield`, `searchany`, `hint`, `overview_tpl`, `sync_table`, `writetable`, `globalsearch`, `listselectionmodel`, `sync_view`, `syncable`, `cssstyle`, `alternativeformxtype`, `read_table`, `class_name`, `special_add_panel`, `existsreal`, `character_set_name`, `read_filter`, `listxtypeprefix`, `phpexporter`, `phpexporterfilename`, `combined`, `default_pagesize`, `allowForm`, `listviewbaseclass`, `showactionbtn`, `modelbaseclass`) VALUES ('onlinekandidaten','Kandidatenstimmen: Online','',0,'name','name','name',1,'','','','',0,'rowmodel','',0,'','','','Wahlsystem','',1,'','','','XlsxWriter','onlinekandidaten-{DATE}',0,1000,0,'Tualo.DataSets.ListView',1,'Tualo.DataSets.model.Basic')

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
                    `read_table`=   values(`read_table`),
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
INSERT IGNORE INTO `ds_column` (`table_name`, `column_name`, `default_value`, `default_max_value`, `default_min_value`, `update_value`, `is_primary`, `syncable`, `referenced_table`, `referenced_column_name`, `is_nullable`, `is_referenced`, `writeable`, `note`, `data_type`, `column_key`, `column_type`, `character_maximum_length`, `numeric_precision`, `numeric_scale`, `character_set_name`, `privileges`, `existsreal`, `deferedload`, `hint`, `fieldtype`) VALUES ('onlinekandidaten','anzahl',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'YES',NULL,1,NULL,'int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,NULL,NULL,''),
('onlinekandidaten','id',NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,'NO',NULL,1,NULL,'int','PRI','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,NULL,NULL,''),
('onlinekandidaten','insert_date',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'YES',NULL,1,NULL,'varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL,''),
('onlinekandidaten','insert_time',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'YES',NULL,1,NULL,'time','','time',NULL,NULL,NULL,NULL,'select,insert,update,references',1,NULL,NULL,''),
('onlinekandidaten','kostenstelle',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'NO',NULL,1,NULL,'int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,NULL,NULL,''),
('onlinekandidaten','login',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'YES',NULL,1,NULL,'varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL,''),
('onlinekandidaten','name',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'YES',NULL,1,NULL,'varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL,''),
('onlinekandidaten','ridx',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'YES',NULL,1,NULL,'varchar','UNI','varchar(12)',12,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL,''),
('onlinekandidaten','update_date',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'YES',NULL,1,NULL,'varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL,''),
('onlinekandidaten','update_time',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'YES',NULL,1,NULL,'time','','time',NULL,NULL,NULL,NULL,'select,insert,update,references',1,NULL,NULL,'');
UNLOCK TABLES;
LOCK TABLES `ds_column_list_label` WRITE;
INSERT IGNORE INTO `ds_column_list_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `editor`, `position`, `summaryrenderer`, `renderer`, `summarytype`, `hidden`, `active`, `filterstore`, `grouped`, `flex`, `direction`, `align`, `listfiltertype`, `hint`) VALUES ('onlinekandidaten','anzahl','DE','Anzahl','gridcolumn','',3,'','','',0,1,'',0,1.00,'','end','','NULL'),
('onlinekandidaten','id','DE','ID','gridcolumn',NULL,1,'','','',0,1,'',0,1.00,'ASC','left','',NULL),
('onlinekandidaten','insert_date','DE','insert_date','gridcolumn','',5,'','','',1,1,'',0,1.00,'','left','','NULL'),
('onlinekandidaten','insert_time','DE','insert_time','gridcolumn','',4,'','','',1,1,'',0,1.00,'','left','','NULL'),
('onlinekandidaten','kostenstelle','DE','kostenstelle','gridcolumn','',9,'','','',1,1,'',0,1.00,'','left','','NULL'),
('onlinekandidaten','login','DE','login','gridcolumn','',7,'','','',1,1,'',0,1.00,'','left','','NULL'),
('onlinekandidaten','name','DE','Name','gridcolumn',NULL,2,'','','',0,1,'',0,1.00,'ASC','left','',NULL),
('onlinekandidaten','ridx','DE','ridx','gridcolumn','',0,'','','',1,1,'',0,1.00,'','left','','NULL'),
('onlinekandidaten','update_date','DE','update_date','gridcolumn','',8,'','','',1,1,'',0,1.00,'','left','','NULL'),
('onlinekandidaten','update_time','DE','update_time','gridcolumn','',6,'','','',1,1,'',0,1.00,'','left','','NULL');
UNLOCK TABLES;
LOCK TABLES `ds_column_form_label` WRITE;
INSERT IGNORE INTO `ds_column_form_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `field_path`, `position`, `hidden`, `active`, `allowempty`, `fieldgroup`, `flex`, `hint`) VALUES ('onlinekandidaten','anzahl','DE','anzahl','displayfield','Allgemein/Angaben',3,0,1,0,'1',1.00,'\'\''),
('onlinekandidaten','id','DE','ID','displayfield','Allgemein/Angaben',1,0,1,0,'1',1.00,'\'\''),
('onlinekandidaten','insert_date','DE','insert_date','displayfield','Allgemein/Angaben',5,1,1,0,'1',1.00,'\'\''),
('onlinekandidaten','insert_time','DE','insert_time','displayfield','Allgemein/Angaben',4,1,1,0,'1',1.00,'\'\''),
('onlinekandidaten','kostenstelle','DE','kostenstelle','displayfield','Allgemein/Angaben',9,1,1,0,'1',1.00,'\'\''),
('onlinekandidaten','login','DE','login','displayfield','Allgemein/Angaben',7,1,1,0,'1',1.00,'\'\''),
('onlinekandidaten','name','DE','Name','displayfield','Allgemein/Angaben',2,0,1,0,'1',1.00,'\'\''),
('onlinekandidaten','ridx','DE','ridx','displayfield','Allgemein/Angaben',0,1,1,0,'1',1.00,'\'\''),
('onlinekandidaten','update_date','DE','update_date','displayfield','Allgemein/Angaben',8,1,1,0,'1',1.00,'\'\''),
('onlinekandidaten','update_time','DE','update_time','displayfield','Allgemein/Angaben',6,1,1,0,'1',1.00,'\'\'');
UNLOCK TABLES;
LOCK TABLES `ds_dropdownfields` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_reference_tables` WRITE;
INSERT IGNORE INTO `ds_reference_tables` (`table_name`, `reference_table_name`, `columnsdef`, `constraint_name`, `active`, `searchable`, `autosync`, `position`, `path`, `existsreal`, `tabtitle`) VALUES ('onlinekandidaten','kandidaten','{\"id\":\"id\"}','fk_onlinekandidaten_kandidaten_id',0,0,0,999,'',1,''),
('onlinekandidaten','kandidaten','{\"ridx\":\"ridx\"}','fk_onlinekandidaten_kandidaten_ridx',0,0,0,999,'',1,'');
UNLOCK TABLES;
LOCK TABLES `ds_addcommands` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_access` WRITE;
INSERT IGNORE INTO `ds_access` (`role`, `table_name`, `read`, `write`, `delete`, `append`) VALUES ('wahl_administration','onlinekandidaten',1,1,1,1);
UNLOCK TABLES;
