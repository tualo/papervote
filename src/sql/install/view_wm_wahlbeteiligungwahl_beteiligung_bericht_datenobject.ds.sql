DELIMITER ;
INSERT INTO `ds` (`table_name`, `title`, `reorderfield`, `use_history`, `searchfield`, `displayfield`, `sortfield`, `searchany`, `hint`, `overview_tpl`, `sync_table`, `writetable`, `globalsearch`, `listselectionmodel`, `sync_view`, `syncable`, `cssstyle`, `read_table`, `existsreal`, `class_name`, `special_add_panel`, `read_filter`, `listxtypeprefix`, `phpexporter`, `phpexporterfilename`, `combined`, `allowForm`, `alternativeformxtype`, `character_set_name`, `default_pagesize`, `listviewbaseclass`, `showactionbtn`) VALUES ('view_wm_wahlbeteiligungwahl_beteiligung_bericht_datenobject','view_wm_wahlbeteiligungwahl_beteiligung_bericht_datenobject','',0,'name','name','position',1,'','','','',0,'cellmodel','',0,'','',1,'Wahlsystem','','','listview','XlsxWriter','{GUID}',0,1,'','',100,'Tualo.DataSets.ListView',1) ON DUPLICATE KEY UPDATE title=VALUES(title), reorderfield=VALUES(reorderfield), use_history=VALUES(use_history), searchfield=VALUES(searchfield), displayfield=VALUES(displayfield), sortfield=VALUES(sortfield), searchany=VALUES(searchany), hint=VALUES(hint), overview_tpl=VALUES(overview_tpl), sync_table=VALUES(sync_table), writetable=VALUES(writetable), globalsearch=VALUES(globalsearch), listselectionmodel=VALUES(listselectionmodel), sync_view=VALUES(sync_view), syncable=VALUES(syncable), cssstyle=VALUES(cssstyle), alternativeformxtype=VALUES(alternativeformxtype), read_table=   VALUES(read_table), class_name=VALUES(class_name), special_add_panel=VALUES(special_add_panel), existsreal=VALUES(existsreal), character_set_name=VALUES(character_set_name), read_filter=VALUES(read_filter), listxtypeprefix=VALUES(listxtypeprefix), phpexporter=VALUES(phpexporter), phpexporterfilename=VALUES(phpexporterfilename), combined=VALUES(combined), default_pagesize=VALUES(default_pagesize), allowForm=VALUES(allowForm), listviewbaseclass=VALUES(listviewbaseclass), showactionbtn=VALUES(showactionbtn), modelbaseclass=VALUES(modelbaseclass);
INSERT  IGNORE INTO `ds_column` (`table_name`, `column_name`, `default_value`, `default_max_value`, `default_min_value`, `is_primary`, `update_value`, `is_nullable`, `is_referenced`, `referenced_table`, `referenced_column_name`, `data_type`, `column_key`, `column_type`, `character_maximum_length`, `numeric_precision`, `numeric_scale`, `character_set_name`, `privileges`, `existsreal`, `deferedload`, `writeable`, `note`, `hint`) VALUES ('view_wm_wahlbeteiligungwahl_beteiligung_bericht_datenobject','data','',10000000,0,0,'','YES','NO','','','mediumtext','','mediumtext',16777215,NULL,NULL,'utf8mb3','select,insert,update,references',1,0,1,'',''),
('view_wm_wahlbeteiligungwahl_beteiligung_bericht_datenobject','formelconfig','',10000000,0,0,'','YES','NO','','','mediumtext','','mediumtext',16777215,NULL,NULL,'utf8mb3','select,insert,update,references',1,0,1,'',''),
('view_wm_wahlbeteiligungwahl_beteiligung_bericht_datenobject','name','',10000000,0,0,'','YES','NO','','','varchar','','varchar(255)',255,NULL,NULL,'utf8mb3','select,insert,update,references',1,0,1,'',''),
('view_wm_wahlbeteiligungwahl_beteiligung_bericht_datenobject','position','',10000000,0,0,'','NO','NO','','','int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,1,'',''),
('view_wm_wahlbeteiligungwahl_beteiligung_bericht_datenobject','spaltenconfig','',10000000,0,0,'','YES','NO','','','mediumtext','','mediumtext',16777215,NULL,NULL,'utf8mb3','select,insert,update,references',1,0,1,'',''),
('view_wm_wahlbeteiligungwahl_beteiligung_bericht_datenobject','stimmzettel','',10000000,0,0,'','YES','NO','','','varchar','','varchar(12)',12,NULL,NULL,'utf8mb3','select,insert,update,references',1,0,1,'',''),
('view_wm_wahlbeteiligungwahl_beteiligung_bericht_datenobject','typtitel','',10000000,0,0,NULL,'YES','NO',NULL,NULL,'varchar','','varchar(358)',358,NULL,NULL,'utf8mb3','select,insert,update,references',1,0,1,'',''),
('view_wm_wahlbeteiligungwahl_beteiligung_bericht_datenobject','wahltyp','',10000000,0,0,NULL,'YES','NO',NULL,NULL,'varchar','','varchar(255)',255,NULL,NULL,'utf8mb3','select,insert,update,references',1,0,1,'',''),
('view_wm_wahlbeteiligungwahl_beteiligung_bericht_datenobject','wahltypconfig','',10000000,0,0,'','YES','NO','','','mediumtext','','mediumtext',16777215,NULL,NULL,'utf8mb3','select,insert,update,references',1,0,1,'',''),
('view_wm_wahlbeteiligungwahl_beteiligung_bericht_datenobject','wahltypname','',10000000,0,0,'','YES','NO','','','varchar','','varchar(255)',255,NULL,NULL,'utf8mb3','select,insert,update,references',1,0,1,'','');
INSERT  IGNORE INTO `ds_column_list_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `editor`, `position`, `summaryrenderer`, `summarytype`, `hidden`, `active`, `renderer`, `filterstore`, `flex`, `direction`, `align`, `grouped`, `listfiltertype`, `hint`) VALUES ('view_wm_wahlbeteiligungwahl_beteiligung_bericht_datenobject','data','DE','data','gridcolumn','',3,'','',0,1,'','',1.00,'','',0,'','\'\''),
('view_wm_wahlbeteiligungwahl_beteiligung_bericht_datenobject','formelconfig','DE','formelconfig','gridcolumn','',5,'','',0,1,'','',1.00,'','',0,'','\'\''),
('view_wm_wahlbeteiligungwahl_beteiligung_bericht_datenobject','name','DE','name','gridcolumn','',1,'','',0,1,'','',1.00,'','',0,'','\'\''),
('view_wm_wahlbeteiligungwahl_beteiligung_bericht_datenobject','position','DE','position','gridcolumn','',2,'','',0,1,'','',1.00,'','',0,'','\'\''),
('view_wm_wahlbeteiligungwahl_beteiligung_bericht_datenobject','spaltenconfig','DE','spaltenconfig','gridcolumn','',4,'','',0,1,'','',1.00,'','',0,'','\'\''),
('view_wm_wahlbeteiligungwahl_beteiligung_bericht_datenobject','stimmzettel','DE','stimmzettel','gridcolumn','',6,'','',0,1,'','',1.00,'','',0,'','\'\''),
('view_wm_wahlbeteiligungwahl_beteiligung_bericht_datenobject','typtitel','DE','typtitel','gridcolumn','',999,'','',0,1,'','',1.00,'','',0,'','\'\''),
('view_wm_wahlbeteiligungwahl_beteiligung_bericht_datenobject','wahltyp','DE','wahltyp','gridcolumn','',999,'','',0,1,'','',1.00,'','',0,'','\'\''),
('view_wm_wahlbeteiligungwahl_beteiligung_bericht_datenobject','wahltypconfig','DE','wahltypconfig','gridcolumn','',999,'','',0,1,'','',1.00,'','',0,'',''),
('view_wm_wahlbeteiligungwahl_beteiligung_bericht_datenobject','wahltypname','DE','wahltypname','gridcolumn','',0,'','',0,1,'','',1.00,'','',0,'','');
INSERT  IGNORE INTO `ds_access` (`role`, `table_name`, `read`, `write`, `delete`, `append`, `existsreal`) VALUES ('administration','view_wm_wahlbeteiligungwahl_beteiligung_bericht_datenobject',1,0,0,0,1);
