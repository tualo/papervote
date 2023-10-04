DELIMITER ;
REPLACE INTO `ds` (`table_name`, `title`, `reorderfield`, `use_history`, `searchfield`, `displayfield`, `sortfield`, `searchany`, `hint`, `overview_tpl`, `sync_table`, `writetable`, `globalsearch`, `listselectionmodel`, `sync_view`, `syncable`, `cssstyle`, `alternativeformxtype`, `read_table`, `class_name`, `special_add_panel`, `existsreal`, `character_set_name`, `read_filter`, `listxtypeprefix`, `phpexporter`, `phpexporterfilename`, `combined`, `default_pagesize`, `allowForm`, `listviewbaseclass`, `showactionbtn`, `modelbaseclass`) VALUES ('wahlgruppe','Wahlgruppe','',0,'name','name','zuweisungsschluessel',1,'','','','',1,'','',0,'','','','Wahlsystem','',1,'','','listview','XlsxWriter','wahlgruppe',0,1000,0,'Tualo.DataSets.ListView',1,'Tualo.DataSets.model.Basic');

INSERT  IGNORE INTO `ds_column` (`table_name`, `column_name`, `default_value`, `default_max_value`, `default_min_value`, `update_value`, `is_primary`, `syncable`, `referenced_table`, `referenced_column_name`, `is_nullable`, `is_referenced`, `writeable`, `note`, `data_type`, `column_key`, `column_type`, `character_maximum_length`, `numeric_precision`, `numeric_scale`, `character_set_name`, `privileges`, `existsreal`, `deferedload`, `hint`, `fieldtype`) VALUES ('wahlgruppe','aktiv','1',0,0,'',0,0,NULL,NULL,'YES','NO',1,'','int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,'',''),
('wahlgruppe','id','{#serial}',1000,1,'',1,0,NULL,NULL,'NO','NO',1,'','int','PRI','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,'',''),
('wahlgruppe','insert_date','{DATE}',0,0,'',0,0,'','','NO','NO',1,'','date','','date',NULL,NULL,NULL,NULL,'select,insert,update,references',1,0,'',''),
('wahlgruppe','insert_time','{TIME}',0,0,'',0,0,'','','YES','NO',1,'','time','','time',NULL,NULL,NULL,NULL,'select,insert,update,references',1,0,'',''),
('wahlgruppe','kostenstelle','0',0,0,'',1,0,NULL,NULL,'NO','NO',1,'','int','PRI','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,'',''),
('wahlgruppe','kurzbezeichnung','',0,0,'',0,0,NULL,NULL,'YES','NO',1,'','varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('wahlgruppe','login','{:getSessionUser()}',0,0,'',0,0,'','','NO','NO',1,'','varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('wahlgruppe','name','',0,0,'',0,0,NULL,NULL,'YES','NO',1,'','varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('wahlgruppe','ridx','{RIDX}',0,0,'null|null',0,0,'','','YES','NO',1,'','varchar','UNI','varchar(12)',12,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('wahlgruppe','update_date','{DATE}',0,0,'null',0,0,'','','NO','NO',1,'','date','','date',NULL,NULL,NULL,NULL,'select,insert,update,references',1,0,'',''),
('wahlgruppe','update_time','{TIME}',0,0,'null',0,0,'','','YES','NO',1,'','time','','time',NULL,NULL,NULL,NULL,'select,insert,update,references',1,0,'',''),
('wahlgruppe','zuweisungsschluessel','0',0,0,'',0,0,NULL,NULL,'YES','NO',1,'','varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'','');
INSERT  IGNORE INTO `ds_column_list_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `editor`, `position`, `summaryrenderer`, `renderer`, `summarytype`, `hidden`, `active`, `filterstore`, `grouped`, `flex`, `direction`, `align`, `listfiltertype`, `hint`) VALUES ('wahlgruppe','aktiv','DE','Aktiv','booleancolumn','',999,NULL,'',NULL,0,1,'',0,1.00,'ASC','left','',''),
('wahlgruppe','id','DE','ID','gridcolumn','',999,NULL,'',NULL,0,1,'',0,1.00,'ASC','left','',''),
('wahlgruppe','kostenstelle','DE','kostenstelle','gridcolumn','',999,'','','',1,1,'',0,1.00,'ASC','left','',''),
('wahlgruppe','name','DE','Name','gridcolumn','',999,NULL,'',NULL,0,1,'',0,1.00,'ASC','left','',''),
('wahlgruppe','ridx','DE','RIDX','gridcolumn','',999,'','','',1,1,'',0,1.00,'ASC','left','','');
INSERT  IGNORE INTO `ds_column_form_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `field_path`, `position`, `hidden`, `active`, `allowempty`, `fieldgroup`, `flex`, `hint`) VALUES ('wahlgruppe','aktiv','DE','Aktiv','checkbox','Allgemein',3,0,1,1,'',1.00,''),
('wahlgruppe','id','DE','ID','numberfield','Allgemein',0,0,1,1,'',1.00,''),
('wahlgruppe','insert_date','DE','insert_date','displayfield','Allgemein',8,1,1,1,'',1.00,''),
('wahlgruppe','insert_time','DE','insert_time','displayfield','Allgemein',11,1,1,1,'',1.00,''),
('wahlgruppe','kostenstelle','DE','Unternummer','numberfield','Allgemein',1,0,1,1,'',1.00,''),
('wahlgruppe','kurzbezeichnung','DE','Kurz','textfield','Allgemein',6,0,1,1,'',1.00,''),
('wahlgruppe','login','DE','login','displayfield','Allgemein',9,1,1,1,'',1.00,''),
('wahlgruppe','name','DE','Name','textfield','Allgemein',5,0,1,1,'',1.00,''),
('wahlgruppe','ridx','DE','RIDX','displayfield','Allgemein',2,1,0,1,'',1.00,''),
('wahlgruppe','update_date','DE','update_date','displayfield','Allgemein',7,1,1,1,'',1.00,''),
('wahlgruppe','update_time','DE','update_time','displayfield','Allgemein',10,1,1,1,'',1.00,''),
('wahlgruppe','zuweisungsschluessel','DE','Schlüssel','textfield','Allgemein',4,0,1,1,'',1.00,'');
INSERT  IGNORE INTO `ds_dropdownfields` (`table_name`, `name`, `idfield`, `displayfield`, `filterconfig`) VALUES ('wahlgruppe','RIDX','ridx','name',NULL);
INSERT  IGNORE INTO `ds_access` (`role`, `table_name`, `read`, `write`, `delete`, `append`, `existsreal`) VALUES ('administration','wahlgruppe',1,1,1,1,1);
