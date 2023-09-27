DELIMITER ;

LOCK TABLES `ds` WRITE;
INSERT INTO `ds` (`table_name`, `title`, `reorderfield`, `use_history`, `searchfield`, `displayfield`, `sortfield`, `searchany`, `hint`, `overview_tpl`, `sync_table`, `writetable`, `globalsearch`, `listselectionmodel`, `sync_view`, `syncable`, `cssstyle`, `read_table`, `existsreal`, `class_name`, `special_add_panel`, `read_filter`, `listxtypeprefix`, `phpexporter`, `phpexporterfilename`, `combined`, `allowForm`, `alternativeformxtype`, `character_set_name`, `default_pagesize`, `listviewbaseclass`, `showactionbtn`) 
VALUES ('view_stimmenanzahl_ranking_los_monitor_list','Ranking-Monitor-Liste','',0,'stimmzettelgruppen_name','stimmzettelgruppen_name','id',1,'','','','',0,'tualomultirowmodel','',0,'','',1,'Wahlsystem','','','listview','XlsxWriter','{GUID}',0,0,'','',100,'Tualo.DataSets.ListView',1)
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
                    `read_table`=  VALUES(`read_table`),
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
INSERT IGNORE INTO `ds_column` (`table_name`, `column_name`, `default_value`, `default_max_value`, `default_min_value`, `is_primary`, `update_value`, `is_nullable`, `is_referenced`, `referenced_table`, `referenced_column_name`, `data_type`, `column_key`, `column_type`, `character_maximum_length`, `numeric_precision`, `numeric_scale`, `character_set_name`, `privileges`, `existsreal`, `deferedload`, `writeable`, `note`, `hint`) 
VALUES ('view_stimmenanzahl_ranking_los_monitor_list','erwartet','',10000000,0,0,'','NO','NO','','','bigint','','bigint(21)',NULL,19,0,NULL,'select,insert,update,references',1,0,1,'',''),
('view_stimmenanzahl_ranking_los_monitor_list','gescannt','',10000000,0,0,'','NO','NO','','','bigint','','bigint(21)',NULL,19,0,NULL,'select,insert,update,references',1,0,1,'',''),
('view_stimmenanzahl_ranking_los_monitor_list','id','',10000000,0,0,NULL,'NO','NO',NULL,NULL,'int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,1,'',''),
('view_stimmenanzahl_ranking_los_monitor_list','kontrolle','',10000000,0,0,NULL,'NO','NO',NULL,NULL,'bigint','','bigint(23)',NULL,19,0,NULL,'select,insert,update,references',1,0,1,'',''),
('view_stimmenanzahl_ranking_los_monitor_list','quote','',10000000,0,0,NULL,'YES','NO',NULL,NULL,'decimal','','decimal(34,4)',NULL,34,4,NULL,'select,insert,update,references',1,0,1,'',''),
('view_stimmenanzahl_ranking_los_monitor_list','stimmzettelgruppen_name','',10000000,0,0,'','YES','NO','','','varchar','','varchar(255)',255,NULL,NULL,'utf8mb3','select,insert,update,references',1,0,1,'',''),
('view_stimmenanzahl_ranking_los_monitor_list','stimmzettelgruppen_ridx','',10000000,0,0,'','YES','NO','','','varchar','','varchar(12)',12,NULL,NULL,'utf8mb3','select,insert,update,references',1,0,1,'',''),
('view_stimmenanzahl_ranking_los_monitor_list','stimmzettel_name','',10000000,0,0,'','YES','NO','','','varchar','','varchar(255)',255,NULL,NULL,'utf8mb3','select,insert,update,references',1,0,1,'',''),
('view_stimmenanzahl_ranking_los_monitor_list','stimmzettel_ridx','',10000000,0,0,'','YES','NO','','','varchar','','varchar(12)',12,NULL,NULL,'utf8mb3','select,insert,update,references',1,0,1,'',''),
('view_stimmenanzahl_ranking_los_monitor_list','ungueltig','',10000000,0,0,NULL,'NO','NO',NULL,NULL,'int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,1,'','');
UNLOCK TABLES;
LOCK TABLES `ds_column_list_label` WRITE;
INSERT IGNORE INTO `ds_column_list_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `editor`, `position`, `summaryrenderer`, `summarytype`, `hidden`, `active`, `renderer`, `filterstore`, `flex`, `direction`, `align`, `grouped`, `listfiltertype`, `hint`) VALUES ('view_stimmenanzahl_ranking_los_monitor_list','erwartet','DE','erwartet','gridcolumn','',5,'','',0,1,'','',1.00,'ASC','left',0,'',''),
('view_stimmenanzahl_ranking_los_monitor_list','gescannt','DE','gescannt','gridcolumn','',6,'','',0,1,'','',1.00,'ASC','left',0,'',''),
('view_stimmenanzahl_ranking_los_monitor_list','id','DE','id','gridcolumn','',999,'','',0,1,'','',1.00,'ASC','left',0,'',''),
('view_stimmenanzahl_ranking_los_monitor_list','kontrolle','DE','kontrolle','gridcolumn','',8,'','',0,1,'','',1.00,'ASC','left',0,'',''),
('view_stimmenanzahl_ranking_los_monitor_list','quote','DE','quote','gridcolumn','',2,'','',0,1,'','',1.00,'ASC','left',0,'',''),
('view_stimmenanzahl_ranking_los_monitor_list','stimmzettelgruppen_name','DE','stimmzettelgruppen_name','gridcolumn','',3,'','',0,1,'','',1.00,'ASC','left',0,'',''),
('view_stimmenanzahl_ranking_los_monitor_list','stimmzettelgruppen_ridx','DE','stimmzettelgruppen_ridx','gridcolumn','',4,'','',0,1,'','',1.00,'ASC','left',0,'',''),
('view_stimmenanzahl_ranking_los_monitor_list','stimmzettel_name','DE','stimmzettel_name','gridcolumn','',0,'','',0,1,'','',1.00,'ASC','left',0,'',''),
('view_stimmenanzahl_ranking_los_monitor_list','stimmzettel_ridx','DE','stimmzettel_ridx','gridcolumn','',1,'','',0,1,'','',1.00,'ASC','left',0,'',''),
('view_stimmenanzahl_ranking_los_monitor_list','ungueltig','DE','ungueltig','gridcolumn','',7,'','',0,1,'','',1.00,'ASC','left',0,'','');
UNLOCK TABLES;
LOCK TABLES `ds_column_form_label` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_dropdownfields` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_reference_tables` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_addcommands` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_access` WRITE;
INSERT IGNORE INTO `ds_access` (`role`, `table_name`, `read`, `write`, `delete`, `append` ) 
VALUES ('wahl_administration','view_stimmenanzahl_ranking_los_monitor_list',1,0,0,0 );
UNLOCK TABLES;
