DELIMITER ;
INSERT INTO `ds` (`table_name`, `title`, `reorderfield`, `use_history`, `searchfield`, `displayfield`, `sortfield`, `searchany`, `hint`, `overview_tpl`, `sync_table`, `writetable`, `globalsearch`, `listselectionmodel`, `sync_view`, `syncable`, `cssstyle`, `alternativeformxtype`, `read_table`, `class_name`, `special_add_panel`, `existsreal`, `character_set_name`, `read_filter`, `listxtypeprefix`, `phpexporter`, `phpexporterfilename`, `combined`, `default_pagesize`, `allowForm`, `listviewbaseclass`, `showactionbtn`, `modelbaseclass`) VALUES ('kandidaten_stimmenanzahl_losentscheid_stimmzettel','Losentscheid Stimmzettel','',0,'','stimmzettel_name','stimmzettel_name',1,'','','','',0,'cellmodel','',0,'','','','Unklassifiziert','',1,'','','listview','XlsxWriter','{GUID}',0,100,1,'Tualo.DataSets.ListView',1,'Tualo.DataSets.model.Basic') ON DUPLICATE KEY UPDATE title=VALUES(title), reorderfield=VALUES(reorderfield), use_history=VALUES(use_history), searchfield=VALUES(searchfield), displayfield=VALUES(displayfield), sortfield=VALUES(sortfield), searchany=VALUES(searchany), hint=VALUES(hint), overview_tpl=VALUES(overview_tpl), sync_table=VALUES(sync_table), writetable=VALUES(writetable), globalsearch=VALUES(globalsearch), listselectionmodel=VALUES(listselectionmodel), sync_view=VALUES(sync_view), syncable=VALUES(syncable), cssstyle=VALUES(cssstyle), alternativeformxtype=VALUES(alternativeformxtype), read_table=   VALUES(read_table), class_name=VALUES(class_name), special_add_panel=VALUES(special_add_panel), existsreal=VALUES(existsreal), character_set_name=VALUES(character_set_name), read_filter=VALUES(read_filter), listxtypeprefix=VALUES(listxtypeprefix), phpexporter=VALUES(phpexporter), phpexporterfilename=VALUES(phpexporterfilename), combined=VALUES(combined), default_pagesize=VALUES(default_pagesize), allowForm=VALUES(allowForm), listviewbaseclass=VALUES(listviewbaseclass), showactionbtn=VALUES(showactionbtn), modelbaseclass=VALUES(modelbaseclass);
INSERT  IGNORE INTO `ds_column` (`table_name`, `column_name`, `default_value`, `default_max_value`, `default_min_value`, `update_value`, `is_primary`, `syncable`, `referenced_table`, `referenced_column_name`, `is_nullable`, `is_referenced`, `writeable`, `note`, `data_type`, `column_key`, `column_type`, `character_maximum_length`, `numeric_precision`, `numeric_scale`, `character_set_name`, `privileges`, `existsreal`, `deferedload`, `hint`, `fieldtype`) VALUES ('kandidaten_stimmenanzahl_losentscheid_stimmzettel','c','',10000000,0,'',0,0,'','','NO','',1,'','bigint','','bigint(21)',NULL,19,0,NULL,'select,insert,update,references',1,0,'',''),('kandidaten_stimmenanzahl_losentscheid_stimmzettel','gesamtstimmen','',10000000,0,'',0,0,'','','NO','',1,'','bigint','','bigint(22)',NULL,19,0,NULL,'select,insert,update,references',1,0,'',''),('kandidaten_stimmenanzahl_losentscheid_stimmzettel','ids','',10000000,0,'',0,0,'','','YES','',1,'','longtext','','longtext',4294967295,NULL,NULL,'utf8mb3','select,insert,update,references',1,0,'',''),('kandidaten_stimmenanzahl_losentscheid_stimmzettel','kandidaten_namen','',10000000,0,'',0,0,'','','YES','',1,'','longtext','','longtext',4294967295,NULL,NULL,'utf8mb3','select,insert,update,references',1,0,'',''),('kandidaten_stimmenanzahl_losentscheid_stimmzettel','kn','',10000000,0,'',0,0,'','','YES','',1,'','longtext','','longtext',4294967295,NULL,NULL,'utf8mb3','select,insert,update,references',1,0,'',''),('kandidaten_stimmenanzahl_losentscheid_stimmzettel','max_xrank','',10000000,0,'',0,0,'','','YES','',1,'','bigint','','bigint(21)',NULL,19,0,NULL,'select,insert,update,references',1,0,'',''),('kandidaten_stimmenanzahl_losentscheid_stimmzettel','min_xrank','',10000000,0,'',0,0,'','','YES','',1,'','bigint','','bigint(21)',NULL,19,0,NULL,'select,insert,update,references',1,0,'',''),('kandidaten_stimmenanzahl_losentscheid_stimmzettel','msg','',10000000,0,'',0,0,'','','YES','',1,'','varchar','','varchar(16)',16,NULL,NULL,'utf8mb3','select,insert,update,references',1,0,'',''),('kandidaten_stimmenanzahl_losentscheid_stimmzettel','rank','',10000000,0,'',0,0,'','','NO','',1,'','bigint','','bigint(21)',NULL,19,0,NULL,'select,insert,update,references',1,0,'',''),('kandidaten_stimmenanzahl_losentscheid_stimmzettel','stimmzettelgruppen_mindestsitze','',10000000,0,'',0,0,'','','YES','',1,'','int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,'',''),('kandidaten_stimmenanzahl_losentscheid_stimmzettel','stimmzettelgruppen_name','',10000000,0,'',0,0,'','','YES','',1,'','varchar','','varchar(255)',255,NULL,NULL,'utf8mb3','select,insert,update,references',1,0,'',''),('kandidaten_stimmenanzahl_losentscheid_stimmzettel','stimmzettel_name','',10000000,0,'',0,0,'','','YES','',1,'','varchar','','varchar(255)',255,NULL,NULL,'utf8mb3','select,insert,update,references',1,0,'',''),('kandidaten_stimmenanzahl_losentscheid_stimmzettel','stimmzettel_ridx','',10000000,0,'',1,0,'','','YES','',1,'','varchar','','varchar(12)',12,NULL,NULL,'utf8mb3','select,insert,update,references',1,0,'',''),('kandidaten_stimmenanzahl_losentscheid_stimmzettel','stimmzettel_sitze','',10000000,0,'',0,0,'','','YES','',1,'','varchar','','varchar(255)',255,NULL,NULL,'utf8mb3','select,insert,update,references',1,0,'','');
INSERT  IGNORE INTO `ds_column_list_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `editor`, `position`, `summaryrenderer`, `renderer`, `summarytype`, `hidden`, `active`, `filterstore`, `grouped`, `flex`, `direction`, `align`, `listfiltertype`, `hint`) VALUES ('kandidaten_stimmenanzahl_losentscheid_stimmzettel','c','DE','Anzahl','gridcolumn','',0,'','','',0,1,'',0,1.00,'','','','NULL'),('kandidaten_stimmenanzahl_losentscheid_stimmzettel','gesamtstimmen','DE','Gesamtstimmen','gridcolumn','',1,'','','',0,1,'',0,1.00,'','','','NULL'),('kandidaten_stimmenanzahl_losentscheid_stimmzettel','ids','DE','IDs','gridcolumn','',2,'','','',0,1,'',0,1.00,'','','','NULL'),('kandidaten_stimmenanzahl_losentscheid_stimmzettel','kandidaten_namen','DE','Kandidaten','gridcolumn','',3,'','','',0,1,'',0,1.00,'','','','NULL'),('kandidaten_stimmenanzahl_losentscheid_stimmzettel','kn','DE','kn','gridcolumn','',4,'','','',1,1,'',0,1.00,'','','','NULL'),('kandidaten_stimmenanzahl_losentscheid_stimmzettel','max_xrank','DE','max_xrank','gridcolumn','',999,'','','',0,1,'',0,1.00,'','','','NULL'),('kandidaten_stimmenanzahl_losentscheid_stimmzettel','min_xrank','DE','min_xrank','gridcolumn','',999,'','','',0,1,'',0,1.00,'','','','NULL'),('kandidaten_stimmenanzahl_losentscheid_stimmzettel','msg','DE','msg','gridcolumn','',999,'','','',0,1,'',0,1.00,'','','','NULL'),('kandidaten_stimmenanzahl_losentscheid_stimmzettel','rank','DE','Rang','gridcolumn','',5,'','','',0,1,'',0,1.00,'','','','NULL'),('kandidaten_stimmenanzahl_losentscheid_stimmzettel','stimmzettelgruppen_mindestsitze','DE','stimmzettelgruppen_mindestsitze','gridcolumn','',999,'','','',0,1,'',0,1.00,'','','','NULL'),('kandidaten_stimmenanzahl_losentscheid_stimmzettel','stimmzettelgruppen_name','DE','stimmzettelgruppen_name','gridcolumn','',999,'','','',0,1,'',0,1.00,'','','','NULL'),('kandidaten_stimmenanzahl_losentscheid_stimmzettel','stimmzettel_name','DE','Stimmzettel','gridcolumn','',6,'','','',0,1,'',0,1.00,'','','','NULL'),('kandidaten_stimmenanzahl_losentscheid_stimmzettel','stimmzettel_ridx','DE','stimmzettel_ridx','gridcolumn','',7,'','','',0,1,'',0,1.00,'','','','NULL'),('kandidaten_stimmenanzahl_losentscheid_stimmzettel','stimmzettel_sitze','DE','stimmzettel_sitze','gridcolumn','',999,'','','',0,1,'',0,1.00,'','','','NULL');
INSERT  IGNORE INTO `ds_column_form_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `field_path`, `position`, `hidden`, `active`, `allowempty`, `fieldgroup`, `flex`, `hint`) VALUES ('kandidaten_stimmenanzahl_losentscheid_stimmzettel','c','DE','c','displayfield','Allgemein',11,1,1,NULL,NULL,NULL,'\'\''),('kandidaten_stimmenanzahl_losentscheid_stimmzettel','gesamtstimmen','DE','gesamtstimmen','displayfield','Allgemein',5,1,1,NULL,NULL,NULL,'\'\''),('kandidaten_stimmenanzahl_losentscheid_stimmzettel','ids','DE','ids','displayfield','Allgemein',7,1,1,NULL,NULL,NULL,'\'\''),('kandidaten_stimmenanzahl_losentscheid_stimmzettel','kandidaten_namen','DE','Kandidaten','displayfield','Allgemein/Information',1,0,1,NULL,NULL,NULL,'\'\''),('kandidaten_stimmenanzahl_losentscheid_stimmzettel','kn','DE','kn','displayfield','Allgemein',4,1,1,NULL,NULL,NULL,'\'\''),('kandidaten_stimmenanzahl_losentscheid_stimmzettel','max_xrank','DE','max_rank','displayfield','Allgemein',6,1,1,NULL,NULL,NULL,'\'\''),('kandidaten_stimmenanzahl_losentscheid_stimmzettel','min_xrank','DE','min_xrank','displayfield','Allgemein',10,1,1,NULL,NULL,NULL,'\'\''),('kandidaten_stimmenanzahl_losentscheid_stimmzettel','msg','DE','msg','displayfield','Allgemein',3,1,1,NULL,NULL,NULL,'\'\''),('kandidaten_stimmenanzahl_losentscheid_stimmzettel','rank','DE','Rang','displayfield','Allgemein/Information',2,0,1,NULL,NULL,NULL,'\'\''),('kandidaten_stimmenanzahl_losentscheid_stimmzettel','stimmzettelgruppen_mindestsitze','DE','stimmzettel_mindestsitze','displayfield','Allgemein',9,1,1,NULL,NULL,NULL,'\'\''),('kandidaten_stimmenanzahl_losentscheid_stimmzettel','stimmzettelgruppen_name','DE','stimmzettelgruppe_name','displayfield','Allgemein',13,1,1,NULL,NULL,NULL,'\'\''),('kandidaten_stimmenanzahl_losentscheid_stimmzettel','stimmzettel_name','DE','Name','displayfield','Allgemein/Information',0,0,1,NULL,NULL,NULL,'\'\''),('kandidaten_stimmenanzahl_losentscheid_stimmzettel','stimmzettel_ridx','DE','stimmzettel_ridx','displayfield','Allgemein',8,1,1,NULL,NULL,NULL,'\'\''),('kandidaten_stimmenanzahl_losentscheid_stimmzettel','stimmzettel_sitze','DE','stimmzellet_sitze','displayfield','Allgemein',12,1,1,NULL,NULL,NULL,'\'\'');
INSERT  IGNORE INTO `ds_reference_tables` (`table_name`, `reference_table_name`, `columnsdef`, `constraint_name`, `active`, `searchable`, `autosync`, `position`, `path`, `existsreal`, `tabtitle`) VALUES ('kandidaten_stimmenanzahl_losentscheid_stimmzettel','kandidaten_stimmenanzahl_liste','{\"rank\":\"rank\",\"stimmzettel_ridx\":\"stimmzettel_ridx\"}','manual_e4cc2333ff3ace7a546e9ffa5e2aeeef',0,0,0,999,'',1,'');
INSERT  IGNORE INTO `ds_access` (`role`, `table_name`, `read`, `write`, `delete`, `append`, `existsreal`) VALUES ('administration','kandidaten_stimmenanzahl_losentscheid_stimmzettel',1,1,0,1,0);