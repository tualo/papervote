DELIMITER ;
INSERT INTO `ds` (`table_name`, `title`, `reorderfield`, `use_history`, `searchfield`, `displayfield`, `sortfield`, `searchany`, `hint`, `overview_tpl`, `sync_table`, `writetable`, `globalsearch`, `listselectionmodel`, `sync_view`, `syncable`, `cssstyle`, `alternativeformxtype`, `read_table`, `class_name`, `special_add_panel`, `existsreal`, `character_set_name`, `read_filter`, `listxtypeprefix`, `phpexporter`, `phpexporterfilename`, `combined`, `default_pagesize`, `allowForm`, `listviewbaseclass`, `showactionbtn`, `modelbaseclass`) VALUES ('sz_titel_regions','SZ-Titel','',NULL,'name','name','name',NULL,NULL,NULL,NULL,NULL,NULL,'tualomultirowmodel',NULL,NULL,NULL,NULL,NULL,'Wahlsystem',NULL,1,NULL,NULL,NULL,'XlsxWriter','sz_titel_regions {DATE} {TIME}',0,1000,1,'Tualo.DataSets.ListView',1,'Tualo.DataSets.model.Basic') ON DUPLICATE KEY UPDATE title=VALUES(title), reorderfield=VALUES(reorderfield), use_history=VALUES(use_history), searchfield=VALUES(searchfield), displayfield=VALUES(displayfield), sortfield=VALUES(sortfield), searchany=VALUES(searchany), hint=VALUES(hint), overview_tpl=VALUES(overview_tpl), sync_table=VALUES(sync_table), writetable=VALUES(writetable), globalsearch=VALUES(globalsearch), listselectionmodel=VALUES(listselectionmodel), sync_view=VALUES(sync_view), syncable=VALUES(syncable), cssstyle=VALUES(cssstyle), alternativeformxtype=VALUES(alternativeformxtype), read_table=   VALUES(read_table), class_name=VALUES(class_name), special_add_panel=VALUES(special_add_panel), existsreal=VALUES(existsreal), character_set_name=VALUES(character_set_name), read_filter=VALUES(read_filter), listxtypeprefix=VALUES(listxtypeprefix), phpexporter=VALUES(phpexporter), phpexporterfilename=VALUES(phpexporterfilename), combined=VALUES(combined), default_pagesize=VALUES(default_pagesize), allowForm=VALUES(allowForm), listviewbaseclass=VALUES(listviewbaseclass), showactionbtn=VALUES(showactionbtn), modelbaseclass=VALUES(modelbaseclass);
INSERT  IGNORE INTO `ds_column` (`table_name`, `column_name`, `default_value`, `default_max_value`, `default_min_value`, `update_value`, `is_primary`, `syncable`, `referenced_table`, `referenced_column_name`, `is_nullable`, `is_referenced`, `writeable`, `note`, `data_type`, `column_key`, `column_type`, `character_maximum_length`, `numeric_precision`, `numeric_scale`, `character_set_name`, `privileges`, `existsreal`, `deferedload`, `hint`, `fieldtype`) VALUES ('sz_titel_regions','height',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'NO',NULL,1,NULL,'int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,NULL,NULL,''),('sz_titel_regions','id',NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,'NO',NULL,1,NULL,'varchar','PRI','varchar(36)',36,NULL,NULL,'utf8mb3','select,insert,update,references',1,NULL,NULL,''),('sz_titel_regions','name',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'YES',NULL,1,NULL,'varchar','UNI','varchar(50)',50,NULL,NULL,'utf8mb3','select,insert,update,references',1,NULL,NULL,''),('sz_titel_regions','width',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'NO',NULL,1,NULL,'int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,NULL,NULL,''),('sz_titel_regions','x',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'NO',NULL,1,NULL,'int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,NULL,NULL,''),('sz_titel_regions','y',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'NO',NULL,1,NULL,'int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,NULL,NULL,'');
INSERT  IGNORE INTO `ds_column_list_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `editor`, `position`, `summaryrenderer`, `renderer`, `summarytype`, `hidden`, `active`, `filterstore`, `grouped`, `flex`, `direction`, `align`, `listfiltertype`, `hint`) VALUES ('sz_titel_regions','height','DE','Höhe','gridcolumn',NULL,4,NULL,NULL,NULL,0,1,NULL,0,NULL,NULL,NULL,NULL,'NULL'),('sz_titel_regions','id','DE','UUID','gridcolumn',NULL,5,NULL,NULL,NULL,0,1,NULL,0,NULL,NULL,NULL,NULL,'NULL'),('sz_titel_regions','name','DE','Name','gridcolumn',NULL,0,NULL,NULL,NULL,0,1,NULL,0,NULL,NULL,NULL,NULL,'NULL'),('sz_titel_regions','width','DE','Breite','gridcolumn',NULL,3,NULL,NULL,NULL,0,1,NULL,0,NULL,NULL,NULL,NULL,'NULL'),('sz_titel_regions','x','DE','Startpunkt (X)','gridcolumn',NULL,2,NULL,NULL,NULL,0,1,NULL,0,NULL,NULL,NULL,NULL,'NULL'),('sz_titel_regions','y','DE','Startpunkt (Y)','gridcolumn',NULL,1,NULL,NULL,NULL,0,1,NULL,0,NULL,NULL,NULL,NULL,'NULL');
INSERT  IGNORE INTO `ds_column_form_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `field_path`, `position`, `hidden`, `active`, `allowempty`, `fieldgroup`, `flex`, `hint`) VALUES ('sz_titel_regions','height','DE','Höhe','numberfield','Allgemein',5,0,1,NULL,NULL,NULL,'\'\''),('sz_titel_regions','id','DE','UUID','displayfield','Allgemein',0,0,1,NULL,NULL,NULL,'\'\''),('sz_titel_regions','name','DE','Bezeichnung','textfield','Allgemein',1,0,1,NULL,NULL,NULL,'\'\''),('sz_titel_regions','width','DE','Breite','numberfield','Allgemein',4,0,1,NULL,NULL,NULL,'\'\''),('sz_titel_regions','x','DE','Startpunkt (X)','numberfield','Allgemein',2,0,1,NULL,NULL,NULL,'\'\''),('sz_titel_regions','y','DE','Startpunkt (X)','numberfield','Allgemein',3,0,1,NULL,NULL,NULL,'\'\'');
INSERT  IGNORE INTO `ds_dropdownfields` (`table_name`, `name`, `idfield`, `displayfield`, `filterconfig`) VALUES ('sz_titel_regions','SZ-Titelregionen','id','name','');
INSERT  IGNORE INTO `ds_access` (`role`, `table_name`, `read`, `write`, `delete`, `append`, `existsreal`) VALUES ('administration','sz_titel_regions',1,1,1,1,NULL),('_default_','sz_titel_regions',1,NULL,NULL,NULL,NULL);