DELIMITER ;
REPLACE INTO `ds` (`table_name`, `title`, `reorderfield`, `use_history`, `searchfield`, `displayfield`, `sortfield`, `searchany`, `hint`, `overview_tpl`, `sync_table`, `writetable`, `globalsearch`, `listselectionmodel`, `sync_view`, `syncable`, `cssstyle`, `alternativeformxtype`, `read_table`, `class_name`, `special_add_panel`, `existsreal`, `character_set_name`, `read_filter`, `listxtypeprefix`, `phpexporter`, `phpexporterfilename`, `combined`, `default_pagesize`, `allowForm`, `listviewbaseclass`, `showactionbtn`, `modelbaseclass`) VALUES ('stimmzettelgruppen','Stimmzettelgruppen','',0,'name','name','id',1,'','','','',0,'tualomultirowmodel','',0,'','','','Wahlsystem','',1,'','','listview','XlsxWriter','stimmzettelgruppen',0,1000,0,'Tualo.DataSets.ListView',1,'Tualo.DataSets.model.Basic');

REPLACE INTO `ds_column` (`table_name`, `column_name`, `default_value`, `default_max_value`, `default_min_value`, `update_value`, `is_primary`, `syncable`, `referenced_table`, `referenced_column_name`, `is_nullable`, `is_referenced`, `writeable`, `note`, `data_type`, `column_key`, `column_type`, `character_maximum_length`, `numeric_precision`, `numeric_scale`, `character_set_name`, `privileges`, `existsreal`, `deferedload`, `hint`, `fieldtype`) VALUES ('stimmzettelgruppen','id','',10000000,0,NULL,1,0,NULL,NULL,'NO','NO',1,'','int','PRI','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,'',''),
('stimmzettelgruppen','kostenstelle','0',10000000,0,'',0,0,'','','NO','NO',1,'','int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,'',''),
('stimmzettelgruppen','mindestsitze','0',10000000,0,'',0,0,'','','YES','',1,'','int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,'',''),
('stimmzettelgruppen','name','',10000000,0,'',0,0,'','','YES','NO',1,'\'\'','varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('stimmzettelgruppen','ridx','{RIDX}',10000000,0,'',0,0,'','','YES','NO',1,'','varchar','UNI','varchar(12)',12,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('stimmzettelgruppen','sitze','0',10000000,0,'',0,0,'','','YES','NO',1,'','int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,'',''),
('stimmzettelgruppen','stimmzettel','',10000000,0,NULL,0,0,NULL,NULL,'NO','NO',1,'','varchar','MUL','varchar(12)',12,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'','');
INSERT  IGNORE INTO `ds_column_list_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `editor`, `position`, `summaryrenderer`, `renderer`, `summarytype`, `hidden`, `active`, `filterstore`, `grouped`, `flex`, `direction`, `align`, `listfiltertype`, `hint`) VALUES ('stimmzettelgruppen','id','DE','ID','gridcolumn','',0,'','','',1,1,'',0,1.00,'ASC','left','',''),
('stimmzettelgruppen','kostenstelle','DE','KST','gridcolumn','',1,'','','',1,1,'',0,1.00,'ASC','left','',''),
('stimmzettelgruppen','mindestsitze','DE','Mindestsitze','gridcolumn','',2,'','','',0,1,'',0,1.00,'','','','NULL'),
('stimmzettelgruppen','name','DE','Name','gridcolumn','',3,'','','',0,1,'',0,1.00,'ASC','left','',''),
('stimmzettelgruppen','ridx','DE','RIDX','gridcolumn','',4,'','','',1,1,'',0,1.00,'','','','NULL'),
('stimmzettelgruppen','sitze','DE','Sitze','gridcolumn','',5,'','','',0,1,'',0,1.00,'','','','NULL'),
('stimmzettelgruppen','stimmzettel','DE','Stimmzettel','gridcolumn','',6,'','','',0,1,'',0,1.00,'','','','NULL');
INSERT  IGNORE INTO `ds_column_form_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `field_path`, `position`, `hidden`, `active`, `allowempty`, `fieldgroup`, `flex`, `hint`) VALUES ('stimmzettelgruppen','id','DE','ID','displayfield','Allgemein',0,0,1,0,'',1.00,''),
('stimmzettelgruppen','kostenstelle','DE','KST','displayfield','Allgemein',1,1,1,0,'',1.00,''),
('stimmzettelgruppen','mindestsitze','DE','Mindestsitze','number0','Allgemein',6,0,1,0,'',1.00,''),
('stimmzettelgruppen','name','DE','Name','textfield','Allgemein',3,0,1,0,'',1.00,''),
('stimmzettelgruppen','ridx','DE','RIDX','textfield','Allgemein',2,0,1,0,'',1.00,''),
('stimmzettelgruppen','sitze','DE','Sitze','number0','Allgemein',5,0,1,0,'',1.00,''),
('stimmzettelgruppen','stimmzettel','DE','Stimmzettel','combobox_stimmzettel_ridx','Allgemein',4,0,1,0,'',1.00,'');
INSERT  IGNORE INTO `ds_dropdownfields` (`table_name`, `name`, `idfield`, `displayfield`, `filterconfig`) VALUES ('stimmzettelgruppen','ridx','ridx','name',NULL);
INSERT  IGNORE INTO `ds_reference_tables` (`table_name`, `reference_table_name`, `columnsdef`, `constraint_name`, `active`, `searchable`, `autosync`, `position`, `path`, `existsreal`, `tabtitle`) VALUES ('stimmzettelgruppen','stimmzettel','{\"stimmzettel\":\"ridx\"}','fk_stimmzettelgruppen_stimmzettel',1,0,0,999,'',1,'');
INSERT  IGNORE INTO `ds_access` (`role`, `table_name`, `read`, `write`, `delete`, `append`, `existsreal`) VALUES ('administration','stimmzettelgruppen',1,1,1,1,1);
