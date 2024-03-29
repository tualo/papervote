DELIMITER ;
INSERT INTO `ds` (`table_name`, `title`, `reorderfield`, `use_history`, `searchfield`, `displayfield`, `sortfield`, `searchany`, `hint`, `overview_tpl`, `sync_table`, `writetable`, `globalsearch`, `listselectionmodel`, `sync_view`, `syncable`, `cssstyle`, `read_table`, `existsreal`, `class_name`, `special_add_panel`, `read_filter`, `listxtypeprefix`, `phpexporter`, `phpexporterfilename`, `combined`, `allowForm`, `alternativeformxtype`, `character_set_name`, `default_pagesize`, `listviewbaseclass`, `showactionbtn`) VALUES ('kandidaten_stimmenanzahl_rank','Kandidaten Stimmenanzahl Ranking','id',0,'','id','id',1,'','','','',0,'cellmodel','',0,'','',1,'Wahlsystem','','','listview','XlsxWriter','{GUID}',0,1,'','',100,'Tualo.DataSets.ListView',1) ON DUPLICATE KEY UPDATE title=VALUES(title), reorderfield=VALUES(reorderfield), use_history=VALUES(use_history), searchfield=VALUES(searchfield), displayfield=VALUES(displayfield), sortfield=VALUES(sortfield), searchany=VALUES(searchany), hint=VALUES(hint), overview_tpl=VALUES(overview_tpl), sync_table=VALUES(sync_table), writetable=VALUES(writetable), globalsearch=VALUES(globalsearch), listselectionmodel=VALUES(listselectionmodel), sync_view=VALUES(sync_view), syncable=VALUES(syncable), cssstyle=VALUES(cssstyle), alternativeformxtype=VALUES(alternativeformxtype), read_table=   VALUES(read_table), class_name=VALUES(class_name), special_add_panel=VALUES(special_add_panel), existsreal=VALUES(existsreal), character_set_name=VALUES(character_set_name), read_filter=VALUES(read_filter), listxtypeprefix=VALUES(listxtypeprefix), phpexporter=VALUES(phpexporter), phpexporterfilename=VALUES(phpexporterfilename), combined=VALUES(combined), default_pagesize=VALUES(default_pagesize), allowForm=VALUES(allowForm), listviewbaseclass=VALUES(listviewbaseclass), showactionbtn=VALUES(showactionbtn), modelbaseclass=VALUES(modelbaseclass);
INSERT  IGNORE INTO `ds_column` (`table_name`, `column_name`, `default_value`, `default_max_value`, `default_min_value`, `is_primary`, `update_value`, `is_nullable`, `is_referenced`, `referenced_table`, `referenced_column_name`, `data_type`, `column_key`, `column_type`, `character_maximum_length`, `numeric_precision`, `numeric_scale`, `character_set_name`, `privileges`, `existsreal`, `deferedload`, `writeable`, `note`, `hint`) VALUES ('kandidaten_stimmenanzahl_rank','anzeige_name','',10000000,0,0,NULL,'YES',NULL,NULL,NULL,'text','','text',65535,NULL,NULL,'utf8mb3','select,insert,update,references',1,0,1,'',''),
('kandidaten_stimmenanzahl_rank','gesamtstimmen','',10000000,0,0,NULL,'NO',NULL,NULL,NULL,'bigint','','bigint(22)',NULL,19,0,NULL,'select,insert,update,references',1,0,1,'',''),
('kandidaten_stimmenanzahl_rank','gewaehlt','',10000000,0,0,NULL,'YES',NULL,NULL,NULL,'tinyint','','int(1)',NULL,10,0,NULL,'select,insert,update,references',1,0,1,'',''),
('kandidaten_stimmenanzahl_rank','id','',10000000,0,0,NULL,'NO',NULL,NULL,NULL,'int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,1,'',''),
('kandidaten_stimmenanzahl_rank','kooptiert','',10000000,0,0,NULL,'YES',NULL,NULL,NULL,'tinyint','','tinyint(4)',NULL,3,0,NULL,'select,insert,update,references',1,0,1,'',''),
('kandidaten_stimmenanzahl_rank','losnummer','',10000000,0,0,NULL,'YES',NULL,NULL,NULL,'int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,1,'',''),
('kandidaten_stimmenanzahl_rank','losnummer_stimmzettelgruppe','',10000000,0,0,NULL,'YES',NULL,NULL,NULL,'int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,1,'',''),
('kandidaten_stimmenanzahl_rank','norm_vote','',10000000,0,0,NULL,'YES',NULL,NULL,NULL,'tinyint','','int(1)',NULL,10,0,NULL,'select,insert,update,references',1,0,1,'',''),
('kandidaten_stimmenanzahl_rank','offlinestimmen','',10000000,0,0,NULL,'NO',NULL,NULL,NULL,'bigint','','bigint(21)',NULL,19,0,NULL,'select,insert,update,references',1,0,1,'',''),
('kandidaten_stimmenanzahl_rank','onlinestimmen','',10000000,0,0,NULL,'NO',NULL,NULL,NULL,'int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,1,'',''),
('kandidaten_stimmenanzahl_rank','rank','',10000000,0,0,NULL,'NO',NULL,NULL,NULL,'bigint','','bigint(21)',NULL,19,0,NULL,'select,insert,update,references',1,0,1,'',''),
('kandidaten_stimmenanzahl_rank','stimmzettelgruppen','',10000000,0,0,NULL,'YES',NULL,NULL,NULL,'varchar','','varchar(12)',12,NULL,NULL,'utf8mb3','select,insert,update,references',1,0,1,'',''),
('kandidaten_stimmenanzahl_rank','stimmzettelgruppen_mindestsitze','',10000000,0,0,NULL,'YES',NULL,NULL,NULL,'int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,1,'',''),
('kandidaten_stimmenanzahl_rank','stimmzettelgruppen_name','',10000000,0,0,NULL,'YES',NULL,NULL,NULL,'varchar','','varchar(255)',255,NULL,NULL,'utf8mb3','select,insert,update,references',1,0,1,'',''),
('kandidaten_stimmenanzahl_rank','stimmzettelgruppen_rang','',10000000,0,0,NULL,'NO',NULL,NULL,NULL,'bigint','','bigint(21)',NULL,19,0,NULL,'select,insert,update,references',1,0,1,'',''),
('kandidaten_stimmenanzahl_rank','stimmzettelgruppen_ridx','',10000000,0,0,NULL,'YES',NULL,NULL,NULL,'varchar','','varchar(12)',12,NULL,NULL,'utf8mb3','select,insert,update,references',1,0,1,'',''),
('kandidaten_stimmenanzahl_rank','stimmzettelgruppen_sitze','',10000000,0,0,NULL,'YES',NULL,NULL,NULL,'int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,1,'',''),
('kandidaten_stimmenanzahl_rank','stimmzettel_name','',10000000,0,0,NULL,'YES',NULL,NULL,NULL,'varchar','','varchar(255)',255,NULL,NULL,'utf8mb3','select,insert,update,references',1,0,1,'',''),
('kandidaten_stimmenanzahl_rank','stimmzettel_rang','',10000000,0,0,NULL,'NO',NULL,NULL,NULL,'bigint','','bigint(21)',NULL,19,0,NULL,'select,insert,update,references',1,0,1,'',''),
('kandidaten_stimmenanzahl_rank','stimmzettel_ridx','',10000000,0,0,NULL,'YES',NULL,NULL,NULL,'varchar','','varchar(12)',12,NULL,NULL,'utf8mb3','select,insert,update,references',1,0,1,'',''),
('kandidaten_stimmenanzahl_rank','stimmzettel_sitze','',10000000,0,0,NULL,'YES',NULL,NULL,NULL,'varchar','','varchar(255)',255,NULL,NULL,'utf8mb3','select,insert,update,references',1,0,1,'',''),
('kandidaten_stimmenanzahl_rank','up_vote','',10000000,0,0,NULL,'YES',NULL,NULL,NULL,'tinyint','','int(1)',NULL,10,0,NULL,'select,insert,update,references',1,0,1,'',''),
('kandidaten_stimmenanzahl_rank','xrank','',10000000,0,0,NULL,'NO',NULL,NULL,NULL,'bigint','','bigint(21)',NULL,19,0,NULL,'select,insert,update,references',1,0,1,'','');
INSERT  IGNORE INTO `ds_column_list_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `editor`, `position`, `summaryrenderer`, `summarytype`, `hidden`, `active`, `renderer`, `filterstore`, `flex`, `direction`, `align`, `grouped`, `listfiltertype`, `hint`) VALUES ('kandidaten_stimmenanzahl_rank','anzeige_name','DE','anzeige_name','gridcolumn','',999,'','',0,1,'','',1.00,'','',0,'','NULL'),
('kandidaten_stimmenanzahl_rank','gesamtstimmen','DE','gesamtstimmen','gridcolumn','',10,'','',0,1,'','',1.00,'','',0,'','NULL'),
('kandidaten_stimmenanzahl_rank','gewaehlt','DE','gewaehlt','gridcolumn','',999,'','',0,1,'','',1.00,'','',0,'','NULL'),
('kandidaten_stimmenanzahl_rank','id','DE','id','gridcolumn','',0,'','',0,1,'','',1.00,'','',0,'','NULL'),
('kandidaten_stimmenanzahl_rank','kooptiert','DE','kooptiert','gridcolumn','',17,'','',0,1,'','',1.00,'','',0,'','NULL'),
('kandidaten_stimmenanzahl_rank','losnummer','DE','losnummer','gridcolumn','',7,'','',0,1,'','',1.00,'','',0,'','NULL'),
('kandidaten_stimmenanzahl_rank','losnummer_stimmzettelgruppe','DE','losnummer_stimmzettelgruppe','gridcolumn','',13,'','',0,1,'','',1.00,'','',0,'','NULL'),
('kandidaten_stimmenanzahl_rank','norm_vote','DE','norm_vote','gridcolumn','',14,'','',0,1,'','',1.00,'','',0,'','NULL'),
('kandidaten_stimmenanzahl_rank','offlinestimmen','DE','offlinestimmen','gridcolumn','',2,'','',0,1,'','',1.00,'','',0,'','NULL'),
('kandidaten_stimmenanzahl_rank','onlinestimmen','DE','onlinestimmen','gridcolumn','',3,'','',0,1,'','',1.00,'','',0,'','NULL'),
('kandidaten_stimmenanzahl_rank','rank','DE','rank','gridcolumn','',4,'','',0,1,'','',1.00,'','',0,'','NULL'),
('kandidaten_stimmenanzahl_rank','stimmzettelgruppen','DE','stimmzettelgruppen','gridcolumn','',19,'','',0,1,'','',1.00,'','',0,'','NULL'),
('kandidaten_stimmenanzahl_rank','stimmzettelgruppen_mindestsitze','DE','stimmzettelgruppen_mindestsitze','gridcolumn','',8,'','',0,1,'','',1.00,'','',0,'','NULL'),
('kandidaten_stimmenanzahl_rank','stimmzettelgruppen_name','DE','stimmzettelgruppen_name','gridcolumn','',15,'','',0,1,'','',1.00,'','',0,'','NULL'),
('kandidaten_stimmenanzahl_rank','stimmzettelgruppen_rang','DE','stimmzettelgruppen_rang','gridcolumn','',21,'','',0,1,'','',1.00,'','',0,'','NULL'),
('kandidaten_stimmenanzahl_rank','stimmzettelgruppen_ridx','DE','stimmzettelgruppen_ridx','gridcolumn','',16,'','',0,1,'','',1.00,'','',0,'','NULL'),
('kandidaten_stimmenanzahl_rank','stimmzettelgruppen_sitze','DE','stimmzettelgruppen_sitze','gridcolumn','',6,'','',0,1,'','',1.00,'','',0,'','NULL'),
('kandidaten_stimmenanzahl_rank','stimmzettel_name','DE','stimmzettel_name','gridcolumn','',11,'','',0,1,'','',1.00,'','',0,'','NULL'),
('kandidaten_stimmenanzahl_rank','stimmzettel_rang','DE','stimmzettel_rang','gridcolumn','',18,'','',0,1,'','',1.00,'','',0,'','NULL'),
('kandidaten_stimmenanzahl_rank','stimmzettel_ridx','DE','stimmzettel_ridx','gridcolumn','',12,'','',0,1,'','',1.00,'','',0,'','NULL'),
('kandidaten_stimmenanzahl_rank','stimmzettel_sitze','DE','stimmzettel_sitze','gridcolumn','',5,'','',0,1,'','',1.00,'','',0,'','NULL'),
('kandidaten_stimmenanzahl_rank','up_vote','DE','up_vote','gridcolumn','',9,'','',0,1,'','',1.00,'','',0,'','NULL'),
('kandidaten_stimmenanzahl_rank','xrank','DE','xrank','gridcolumn','',1,'','',0,1,'','',1.00,'','',0,'','NULL');
INSERT  IGNORE INTO `ds_access` (`role`, `table_name`, `read`, `write`, `delete`, `append`, `existsreal`) VALUES ('administration','kandidaten_stimmenanzahl_rank',1,1,0,0,1);


update `ds_column` set `is_primary`=1 where 
`table_name`='kandidaten_stimmenanzahl_rank' and `column_name`='id'
and (select sum(`is_primary`) from `ds_column` where `table_name`='kandidaten_stimmenanzahl_rank')=0;

