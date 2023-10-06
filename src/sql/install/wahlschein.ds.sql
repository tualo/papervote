DELIMITER ;
INSERT INTO `ds` (`table_name`, `title`, `reorderfield`, `use_history`, `searchfield`, `displayfield`, `sortfield`, `searchany`, `hint`, `overview_tpl`, `sync_table`, `writetable`, `globalsearch`, `listselectionmodel`, `sync_view`, `syncable`, `cssstyle`, `alternativeformxtype`, `read_table`, `class_name`, `special_add_panel`, `existsreal`, `character_set_name`, `read_filter`, `listxtypeprefix`, `phpexporter`, `phpexporterfilename`, `combined`, `default_pagesize`, `allowForm`, `listviewbaseclass`, `showactionbtn`, `modelbaseclass`) VALUES ('wahlschein','Wahlschein','',0,'name','name','',1,'','','','',0,'','',0,'','','','Wahlsystem','',1,'','','listview','XlsxWriter','wahlschein',0,1000,0,'Tualo.DataSets.ListView',1,'Tualo.DataSets.model.Basic') ON DUPLICATE KEY UPDATE title=VALUES(title), reorderfield=VALUES(reorderfield), use_history=VALUES(use_history), searchfield=VALUES(searchfield), displayfield=VALUES(displayfield), sortfield=VALUES(sortfield), searchany=VALUES(searchany), hint=VALUES(hint), overview_tpl=VALUES(overview_tpl), sync_table=VALUES(sync_table), writetable=VALUES(writetable), globalsearch=VALUES(globalsearch), listselectionmodel=VALUES(listselectionmodel), sync_view=VALUES(sync_view), syncable=VALUES(syncable), cssstyle=VALUES(cssstyle), alternativeformxtype=VALUES(alternativeformxtype), read_table=   VALUES(read_table), class_name=VALUES(class_name), special_add_panel=VALUES(special_add_panel), existsreal=VALUES(existsreal), character_set_name=VALUES(character_set_name), read_filter=VALUES(read_filter), listxtypeprefix=VALUES(listxtypeprefix), phpexporter=VALUES(phpexporter), phpexporterfilename=VALUES(phpexporterfilename), combined=VALUES(combined), default_pagesize=VALUES(default_pagesize), allowForm=VALUES(allowForm), listviewbaseclass=VALUES(listviewbaseclass), showactionbtn=VALUES(showactionbtn), modelbaseclass=VALUES(modelbaseclass);
REPLACE INTO `ds_column` (`table_name`, `column_name`, `default_value`, `default_max_value`, `default_min_value`, `update_value`, `is_primary`, `syncable`, `referenced_table`, `referenced_column_name`, `is_nullable`, `is_referenced`, `writeable`, `note`, `data_type`, `column_key`, `column_type`, `character_maximum_length`, `numeric_precision`, `numeric_scale`, `character_set_name`, `privileges`, `existsreal`, `deferedload`, `hint`, `fieldtype`) VALUES ('wahlschein','abgabehash','',0,0,'',0,0,NULL,NULL,'YES','NO',1,'','varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('wahlschein','abgabetyp','',100000,0,'',0,0,NULL,NULL,'YES','NO',1,'','varchar','MUL','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('wahlschein','aktiv','1',100000,0,'',0,0,NULL,NULL,'YES','NO',1,'','int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,'',''),
('wahlschein','antrag','',10000000,0,NULL,0,0,NULL,NULL,'YES','NO',1,'','tinyint','','tinyint(4)',NULL,3,0,NULL,'select,insert,update,references',1,0,'',''),
('wahlschein','blocknumber','',10000000,0,NULL,0,0,NULL,NULL,'YES','NO',1,'','varchar','MUL','varchar(30)',30,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('wahlschein','defered','',10000000,0,NULL,0,0,NULL,NULL,'YES','NO',1,'','tinyint','','tinyint(4)',NULL,3,0,NULL,'select,insert,update,references',1,0,'',''),
('wahlschein','id','',100000,0,'',1,0,NULL,NULL,'NO','NO',1,'','bigint','PRI','bigint(20)',NULL,19,0,NULL,'select,insert,update,references',1,0,'',''),
('wahlschein','insert_date','{DATE}',100000,0,'',0,0,'','','NO','NO',1,'','date','','date',0,0,0,'','select,insert,update,references',1,0,'',''),
('wahlschein','insert_time','{TIME}',100000,0,'',0,0,'','','YES','NO',1,'','time','','time',0,0,0,'','select,insert,update,references',1,0,'',''),
('wahlschein','kostenstelle','',10000000,0,NULL,0,0,NULL,NULL,'NO','NO',1,'','int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,'',''),
('wahlschein','login','{:getSessionUser()}',100000,0,'',0,0,'','','NO','NO',1,'','varchar','','varchar(255)',255,0,0,'utf8mb4','select,insert,update,references',1,0,'',''),
('wahlschein','name','',100000,0,'',0,0,NULL,NULL,'YES','NO',1,'','varchar','MUL','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('wahlschein','onlinecheck','',10000000,0,NULL,0,0,NULL,NULL,'YES','NO',1,'','tinyint','','tinyint(4)',NULL,3,0,NULL,'select,insert,update,references',1,0,'',''),
('wahlschein','pwhash','',0,0,'',0,0,NULL,NULL,'YES','NO',1,'','varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('wahlschein','ridx','',100000,0,'',0,0,NULL,NULL,'YES','NO',1,'','varchar','UNI','varchar(12)',12,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('wahlschein','secret','',10000000,0,NULL,0,0,NULL,NULL,'YES','NO',1,'','varchar','','varchar(500)',500,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('wahlschein','sendtotmg','0',0,0,'',0,0,NULL,NULL,'YES','NO',1,'','tinyint','MUL','tinyint(4)',NULL,3,0,NULL,'select,insert,update,references',1,0,'',''),
('wahlschein','stimmzettel','',100000,0,'',1,0,NULL,NULL,'NO','NO',1,'','varchar','PRI','varchar(12)',12,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('wahlschein','testdaten','',10000000,0,NULL,0,0,NULL,NULL,'YES',NULL,1,'','tinyint','','tinyint(4)',NULL,3,0,NULL,'select,insert,update,references',1,0,'',''),
('wahlschein','update_date','{DATE}',100000,0,'null',0,0,'','','NO','NO',1,'','date','','date',0,0,0,'','select,insert,update,references',1,0,'',''),
('wahlschein','update_time','{TIME}',100000,0,'null',0,0,'','','YES','NO',1,'','time','','time',0,0,0,'','select,insert,update,references',1,0,'',''),
('wahlschein','usedate',NULL,10000000,0,NULL,0,0,NULL,NULL,'YES',NULL,1,'','date','','date',NULL,NULL,NULL,NULL,'select,insert,update,references',1,0,'',''),
('wahlschein','username','',0,0,'',0,0,NULL,NULL,'YES','NO',1,'','varchar','MUL','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('wahlschein','wahlberechtigte','',100000,0,'',0,0,NULL,NULL,'YES','NO',1,'','varchar','MUL','varchar(12)',12,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('wahlschein','wahlscheinnummer','',100000,0,'',0,0,NULL,NULL,'YES','NO',1,'','varchar','MUL','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('wahlschein','wahlscheinstatus','1|0',100000,0,'',0,0,NULL,NULL,'YES','NO',1,'','varchar','MUL','varchar(12)',12,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('wahlschein','wahlscheinstatus_grund','',100000,0,'',0,0,NULL,NULL,'YES','NO',1,'','varchar','MUL','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('wahlschein','xwn','NULL',0,0,'',0,0,'','','YES','NO',1,'','varchar','','varchar(10)',10,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'','');
REPLACE INTO `ds_column_list_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `editor`, `position`, `summaryrenderer`, `renderer`, `summarytype`, `hidden`, `active`, `filterstore`, `grouped`, `flex`, `direction`, `align`, `listfiltertype`, `hint`) VALUES ('wahlschein','abgabetyp','DE','Abgabetyp','column_abgabetyp_ridx','',13,'','','',0,1,'',0,1.00,'ASC','left','',''),
('wahlschein','aktiv','DE','Aktiv','gridcolumn','',3,'','','',0,1,'',0,1.00,'ASC','left','',''),
('wahlschein','blocknumber','DE','blocknumber','gridcolumn','',999,'','','',1,1,'',0,0.00,'','','','\'\''),
('wahlschein','id','DE','ID','gridcolumn','',5,'','','',0,1,'',0,1.00,'ASC','left','',''),
('wahlschein','insert_date','DE','Anlagedatum','gridcolumn','',14,'','','',0,1,'',0,1.00,'ASC','left','',''),
('wahlschein','insert_time','DE','Anlagezeit','gridcolumn','',1,'','','',0,1,'',0,1.00,'ASC','left','',''),
('wahlschein','login','DE','Login','gridcolumn','',16,'','','',0,1,'',0,1.00,'ASC','left','',''),
('wahlschein','name','DE','Name','gridcolumn','',4,'','','',0,1,'',0,1.00,'ASC','left','',''),
('wahlschein','pwhash','DE','BCRYPT','gridcolumn','',17,'','','',0,1,'',0,1.00,'ASC','left','',''),
('wahlschein','ridx','DE','RIDX','gridcolumn','',10,'','','',0,1,'',0,1.00,'ASC','left','',''),
('wahlschein','stimmzettel','DE','Stimmzettel Vollversammlungswahl','column_stimmzettel_ridx','',11,'','','',0,1,'',0,1.00,'ASC','left','',''),
('wahlschein','update_date','DE','Änderungsdatum','gridcolumn','',15,'','','',0,1,'',0,1.00,'ASC','left','',''),
('wahlschein','update_time','DE','Änderungszeit','gridcolumn','',2,'','','',0,1,'',0,1.00,'ASC','left','',''),
('wahlschein','username','DE','Online-Benutzer','gridcolumn','',18,'','','',0,1,'',0,1.00,'ASC','left','',''),
('wahlschein','wahlberechtigte','DE','Berechtigte','column_wahlberechtigte_ridx','',7,'','','',0,1,'',0,1.00,'ASC','left','',''),
('wahlschein','wahlscheinnummer','DE','Wahlscheinnummer','gridcolumn','',6,'','','',0,1,'',0,1.00,'ASC','left','',''),
('wahlschein','wahlscheinstatus','DE','Status Vollversammlungswahl','column_wahlscheinstatus_ridx','',12,'','','',0,1,'',0,1.00,'ASC','left','',''),
('wahlschein','wahlscheinstatus_grund','DE','Grund Vollversammlungswahl','column_wahlscheinstatus_grund_ridx','',9,'','','',0,1,'',0,1.00,'ASC','left','','');
REPLACE INTO `ds_column_form_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `field_path`, `position`, `hidden`, `active`, `allowempty`, `fieldgroup`, `flex`, `hint`) VALUES ('wahlschein','abgabetyp','DE','Abgabetyp','combobox_abgabetyp_ridx','Allgemein',13,0,1,1,'',1.00,''),
('wahlschein','aktiv','DE','Aktiv','textfield','Allgemein',3,0,1,1,'',1.00,''),
('wahlschein','id','DE','ID','textfield','Allgemein',5,0,1,1,'',1.00,''),
('wahlschein','insert_date','DE','Anlagedatum','textfield','Allgemein',14,0,1,1,'',1.00,''),
('wahlschein','insert_time','DE','Anlagezeit','textfield','Allgemein',1,0,1,1,'',1.00,''),
('wahlschein','login','DE','Login','textfield','Allgemein',16,0,1,1,'',1.00,''),
('wahlschein','name','DE','Name','textfield','Allgemein',4,0,1,1,'',1.00,''),
('wahlschein','ridx','DE','RIDX','textfield','Allgemein',10,0,1,1,'',1.00,''),
('wahlschein','stimmzettel','DE','Stimmzettel Vollversammlungswahl','combobox_stimmzettel_ridx','Allgemein',11,0,1,1,'',1.00,''),
('wahlschein','update_date','DE','Änderungsdatum','textfield','Allgemein',15,0,1,1,'',1.00,''),
('wahlschein','update_time','DE','Änderungszeit','textfield','Allgemein',2,0,1,1,'',1.00,''),
('wahlschein','wahlberechtigte','DE','Berechtigte','combobox_wahlberechtigte_ridx','Allgemein',7,0,1,1,'',1.00,'\'\''),
('wahlschein','wahlscheinnummer','DE','Wahlscheinnummer','textfield','Allgemein',6,0,1,1,'',1.00,''),
('wahlschein','wahlscheinstatus','DE','Status Vollversammlungswahl','combobox_wahlscheinstatus_ridx','Allgemein',12,0,1,1,'',1.00,''),
('wahlschein','wahlscheinstatus_grund','DE','Grund Vollversammlungswahl','combobox_wahlscheinstatus_grund_ridx','Allgemein',9,0,1,1,'',1.00,'');
INSERT  IGNORE INTO `ds_dropdownfields` (`table_name`, `name`, `idfield`, `displayfield`, `filterconfig`) VALUES ('wahlschein','RIDX','ridx','name',NULL);
INSERT  IGNORE INTO `ds_reference_tables` (`table_name`, `reference_table_name`, `columnsdef`, `constraint_name`, `active`, `searchable`, `autosync`, `position`, `path`, `existsreal`, `tabtitle`) VALUES ('wahlschein','stimmzettel','{\"stimmzettel\":\"ridx\"}','fk_wahlschein_stimmzettel',1,0,0,999,'',1,''),
('wahlschein','wahlberechtigte','{\"wahlberechtigte\":\"ridx\"}','fk_wahlschein_wahlberechtigte',0,0,1,99999,'',1,''),
('wahlschein','wahlscheinstatus','{\"wahlscheinstatus\":\"ridx\"}','fk_wahlschein_wahlscheinstatus',0,0,1,99999,'',1,'');
INSERT  IGNORE INTO `ds_access` (`role`, `table_name`, `read`, `write`, `delete`, `append`, `existsreal`) VALUES ('administration','wahlschein',1,1,1,1,1);
