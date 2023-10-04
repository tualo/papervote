DELIMITER ;
REPLACE INTO `ds` (`table_name`, `title`, `reorderfield`, `use_history`, `searchfield`, `displayfield`, `sortfield`, `searchany`, `hint`, `overview_tpl`, `sync_table`, `writetable`, `globalsearch`, `listselectionmodel`, `sync_view`, `syncable`, `cssstyle`, `alternativeformxtype`, `read_table`, `class_name`, `special_add_panel`, `existsreal`, `character_set_name`, `read_filter`, `listxtypeprefix`, `phpexporter`, `phpexporterfilename`, `combined`, `default_pagesize`, `allowForm`, `listviewbaseclass`, `showactionbtn`, `modelbaseclass`) VALUES ('abgabetyp','Abgabetyp','',0,'name','name','id',1,'Mit dem Abgabetyp wird festgelegt, auf welchem Weg der Wähler an der Wahl teilgenommen hat.','','','',1,'','',0,'','','','Wahlsystem','',1,'','','listview','XlsxWriter','abgabetyp',0,100,0,'Tualo.DataSets.ListView',1,'Tualo.DataSets.model.Basic') 
;
INSERT  IGNORE INTO `ds_column` (`table_name`, `column_name`, `default_value`, `default_max_value`, `default_min_value`, `update_value`, `is_primary`, `syncable`, `referenced_table`, `referenced_column_name`, `is_nullable`, `is_referenced`, `writeable`, `note`, `data_type`, `column_key`, `column_type`, `character_maximum_length`, `numeric_precision`, `numeric_scale`, `character_set_name`, `privileges`, `existsreal`, `deferedload`, `hint`, `fieldtype`) VALUES ('abgabetyp','aktiv','1',0,0,'',0,0,NULL,NULL,'YES','NO',1,'','int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,'',''),
('abgabetyp','id','{#serial}',1000,1,'',1,0,NULL,NULL,'NO','NO',1,'','int','PRI','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,'',''),
('abgabetyp','insert_date','null',0,0,'',0,0,NULL,NULL,'NO','NO',1,'','date','','date',NULL,NULL,NULL,NULL,'select,insert,update,references',1,0,'',''),
('abgabetyp','insert_time','null',0,0,'',0,0,NULL,NULL,'YES','NO',1,'','time','','time',NULL,NULL,NULL,NULL,'select,insert,update,references',1,0,'',''),
('abgabetyp','kostenstelle','0',0,0,'',1,0,NULL,NULL,'NO','NO',1,'','int','PRI','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,'',''),
('abgabetyp','login','null',0,0,'',0,0,NULL,NULL,'NO','NO',1,'','varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('abgabetyp','name','',0,0,'',0,0,NULL,NULL,'YES','NO',1,'','varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('abgabetyp','ridx','null|null',0,0,'null|null',0,0,NULL,NULL,'YES','NO',1,'','varchar','UNI','varchar(12)',12,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('abgabetyp','update_date','null',0,0,'null',0,0,NULL,NULL,'NO','NO',1,'','date','','date',NULL,NULL,NULL,NULL,'select,insert,update,references',1,0,'',''),
('abgabetyp','update_time','null',0,0,'null',0,0,NULL,NULL,'YES','NO',1,'','time','','time',NULL,NULL,NULL,NULL,'select,insert,update,references',1,0,'','');
INSERT  IGNORE INTO `ds_column_list_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `editor`, `position`, `summaryrenderer`, `renderer`, `summarytype`, `hidden`, `active`, `filterstore`, `grouped`, `flex`, `direction`, `align`, `listfiltertype`, `hint`) VALUES ('abgabetyp','id','DE','ID','gridcolumn','',999,NULL,'',NULL,0,1,'',0,1.00,'ASC','left','',''),
('abgabetyp','kostenstelle','DE','kostenstelle','gridcolumn','',0,'','','',0,1,'',0,1.00,'ASC','left','',''),
('abgabetyp','name','DE','Name','gridcolumn','',999,NULL,'',NULL,0,1,'',0,1.00,'ASC','left','',''),
('abgabetyp','ridx','DE','RIDX','gridcolumn','',999,NULL,'',NULL,0,1,'',0,1.00,'ASC','left','','');
INSERT  IGNORE INTO `ds_column_form_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `field_path`, `position`, `hidden`, `active`, `allowempty`, `fieldgroup`, `flex`, `hint`) VALUES ('abgabetyp','aktiv','DE','Aktiv','checkbox','Allgemein',2,0,1,1,'',1.00,''),
('abgabetyp','id','DE','ID','displayfield','Allgemein',0,0,1,1,'',1.00,''),
('abgabetyp','kostenstelle','DE','kostenstelle','displayfield','Allgemein',0,1,1,1,'',1.00,'\'\''),
('abgabetyp','name','DE','Name','textfield','Allgemein',1,0,1,1,'',1.00,'');
INSERT  IGNORE INTO `ds_dropdownfields` (`table_name`, `name`, `idfield`, `displayfield`, `filterconfig`) VALUES ('abgabetyp','RIDX','ridx','name',NULL);
INSERT  IGNORE INTO `ds_access` (`role`, `table_name`, `read`, `write`, `delete`, `append`, `existsreal`) VALUES ('administration','abgabetyp',1,1,1,1,1);
