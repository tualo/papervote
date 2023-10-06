DELIMITER ;
INSERT INTO `ds` (`table_name`, `title`, `reorderfield`, `use_history`, `searchfield`, `displayfield`, `sortfield`, `searchany`, `hint`, `overview_tpl`, `sync_table`, `writetable`, `globalsearch`, `listselectionmodel`, `sync_view`, `syncable`, `cssstyle`, `alternativeformxtype`, `read_table`, `class_name`, `special_add_panel`, `existsreal`, `character_set_name`, `read_filter`, `listxtypeprefix`, `phpexporter`, `phpexporterfilename`, `combined`, `default_pagesize`, `allowForm`, `listviewbaseclass`, `showactionbtn`, `modelbaseclass`) VALUES ('wahlbeteiligung_bericht_formel','Wahlbeteiligungsbericht Formeln',NULL,0,'name','name',NULL,1,'',NULL,NULL,'',0,NULL,NULL,0,NULL,'','','Wahlsystem',NULL,1,'',NULL,'listview','XlsxWriter','null',0,100,1,'Tualo.DataSets.ListView',1,'Tualo.DataSets.model.Basic') ON DUPLICATE KEY UPDATE title=VALUES(title), reorderfield=VALUES(reorderfield), use_history=VALUES(use_history), searchfield=VALUES(searchfield), displayfield=VALUES(displayfield), sortfield=VALUES(sortfield), searchany=VALUES(searchany), hint=VALUES(hint), overview_tpl=VALUES(overview_tpl), sync_table=VALUES(sync_table), writetable=VALUES(writetable), globalsearch=VALUES(globalsearch), listselectionmodel=VALUES(listselectionmodel), sync_view=VALUES(sync_view), syncable=VALUES(syncable), cssstyle=VALUES(cssstyle), alternativeformxtype=VALUES(alternativeformxtype), read_table=   VALUES(read_table), class_name=VALUES(class_name), special_add_panel=VALUES(special_add_panel), existsreal=VALUES(existsreal), character_set_name=VALUES(character_set_name), read_filter=VALUES(read_filter), listxtypeprefix=VALUES(listxtypeprefix), phpexporter=VALUES(phpexporter), phpexporterfilename=VALUES(phpexporterfilename), combined=VALUES(combined), default_pagesize=VALUES(default_pagesize), allowForm=VALUES(allowForm), listviewbaseclass=VALUES(listviewbaseclass), showactionbtn=VALUES(showactionbtn), modelbaseclass=VALUES(modelbaseclass);
REPLACE INTO `ds_column` (`table_name`, `column_name`, `default_value`, `default_max_value`, `default_min_value`, `update_value`, `is_primary`, `syncable`, `referenced_table`, `referenced_column_name`, `is_nullable`, `is_referenced`, `writeable`, `note`, `data_type`, `column_key`, `column_type`, `character_maximum_length`, `numeric_precision`, `numeric_scale`, `character_set_name`, `privileges`, `existsreal`, `deferedload`, `hint`, `fieldtype`) VALUES ('wahlbeteiligung_bericht_formel','aktiv','1',0,0,'',0,0,NULL,NULL,'YES','NO',1,'','varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('wahlbeteiligung_bericht_formel','id','{#serial}',1000,1,'',1,0,NULL,NULL,'NO','NO',1,'','int','PRI','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,'',''),
('wahlbeteiligung_bericht_formel','insert_date','{DATE}',0,0,'',0,0,'','','YES','NO',1,'','date','','date',0,0,0,'','select,insert,update,references',1,0,'',''),
('wahlbeteiligung_bericht_formel','insert_time','{TIME}',0,0,'',0,0,'','','YES','NO',1,'','time','','time',0,0,0,'','select,insert,update,references',1,0,'',''),
('wahlbeteiligung_bericht_formel','kostenstelle','0',0,0,'',1,0,NULL,NULL,'NO','NO',1,'','int','PRI','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,'',''),
('wahlbeteiligung_bericht_formel','login','{:getSessionUser()}',0,0,'null',0,0,'','','YES','NO',1,'','varchar','','varchar(255)',255,0,0,'utf8mb4','select,insert,update,references',1,0,'',''),
('wahlbeteiligung_bericht_formel','name','',0,0,'',0,0,NULL,NULL,'YES','NO',1,'','varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('wahlbeteiligung_bericht_formel','ridx','',0,0,'',0,0,'','','YES','NO',1,'','varchar','MUL','varchar(255)',255,0,0,'utf8mb4','select,insert,update,references',1,0,'',''),
('wahlbeteiligung_bericht_formel','update_date','{DATE}',0,0,'null',0,0,'','','YES','NO',1,'','date','','date',0,0,0,'','select,insert,update,references',1,0,'',''),
('wahlbeteiligung_bericht_formel','update_time','{TIME}',0,0,'null',0,0,'','','YES','NO',1,'','time','','time',0,0,0,'','select,insert,update,references',1,0,'','');
INSERT  IGNORE INTO `ds_column_list_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `editor`, `position`, `summaryrenderer`, `renderer`, `summarytype`, `hidden`, `active`, `filterstore`, `grouped`, `flex`, `direction`, `align`, `listfiltertype`, `hint`) VALUES ('wahlbeteiligung_bericht_formel','id','DE','ID','gridcolumn','',10,'','','',0,1,'',0,1.00,'ASC','left','',''),
('wahlbeteiligung_bericht_formel','kostenstelle','DE','kostenstelle','gridcolumn','',0,'','','',0,1,'',0,1.00,'ASC','left','',''),
('wahlbeteiligung_bericht_formel','name','DE','Name','gridcolumn','',4,'','','',0,1,'',0,1.00,'ASC','left','','');
INSERT  IGNORE INTO `ds_column_form_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `field_path`, `position`, `hidden`, `active`, `allowempty`, `fieldgroup`, `flex`, `hint`) VALUES ('wahlbeteiligung_bericht_formel','id','DE','id','displayfield','Allgemein',0,0,1,1,'',1.00,''),
('wahlbeteiligung_bericht_formel','kostenstelle','DE','kostenstelle','displayfield','Allgemein',0,0,1,1,'',1.00,''),
('wahlbeteiligung_bericht_formel','name','DE','Name','textfield','Allgemein',999,0,1,1,'',1.00,'');
