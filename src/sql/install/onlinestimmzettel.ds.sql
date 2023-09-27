DELIMITER ;

LOCK TABLES `ds` WRITE;
INSERT INTO `ds` (`table_name`, `title`, `reorderfield`, `use_history`, `searchfield`, `displayfield`, `sortfield`, `searchany`, `hint`, `overview_tpl`, `sync_table`, `writetable`, `globalsearch`, `listselectionmodel`, `sync_view`, `syncable`, `cssstyle`, `alternativeformxtype`, `read_table`, `class_name`, `special_add_panel`, `existsreal`, `character_set_name`, `read_filter`, `listxtypeprefix`, `phpexporter`, `phpexporterfilename`, `combined`, `default_pagesize`, `allowForm`, `listviewbaseclass`, `showactionbtn`, `modelbaseclass`) VALUES ('onlinestimmzettel','Stimmzettelanzahl: Online','',0,'stimmzettel','stimmzettel','stimmzettel',0,'','','','',0,'rowmodel','',0,'','','','Wahlsystem','',1,'','','','XlsxWriter','onlinestimmzettel {DATE} {TIME}',0,1000,0,'Tualo.DataSets.ListView',1,'Tualo.DataSets.model.Basic')

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
                    `read_table`=   values(`read_table`),
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
INSERT IGNORE INTO `ds_column` (`table_name`, `column_name`, `default_value`, `default_max_value`, `default_min_value`, `update_value`, `is_primary`, `syncable`, `referenced_table`, `referenced_column_name`, `is_nullable`, `is_referenced`, `writeable`, `note`, `data_type`, `column_key`, `column_type`, `character_maximum_length`, `numeric_precision`, `numeric_scale`, `character_set_name`, `privileges`, `existsreal`, `deferedload`, `hint`, `fieldtype`) VALUES ('onlinestimmzettel','anzahl',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'YES',NULL,1,NULL,'int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,NULL,NULL,''),
('onlinestimmzettel','stimmzettel',NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,'NO',NULL,1,NULL,'varchar','PRI','varchar(12)',12,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL,'');
UNLOCK TABLES;
LOCK TABLES `ds_column_list_label` WRITE;
INSERT IGNORE INTO `ds_column_list_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `editor`, `position`, `summaryrenderer`, `renderer`, `summarytype`, `hidden`, `active`, `filterstore`, `grouped`, `flex`, `direction`, `align`, `listfiltertype`, `hint`) VALUES ('onlinestimmzettel','anzahl','DE','Anzahl','gridcolumn',NULL,1,'','','',0,1,'',0,1.00,'ASC','left','',NULL),
('onlinestimmzettel','stimmzettel','DE','Stimmzettel','column_stimmzettel_ridx','',0,'','','',0,1,'',0,1.00,'','left','','NULL');
UNLOCK TABLES;
LOCK TABLES `ds_column_form_label` WRITE;
INSERT IGNORE INTO `ds_column_form_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `field_path`, `position`, `hidden`, `active`, `allowempty`, `fieldgroup`, `flex`, `hint`) VALUES ('onlinestimmzettel','anzahl','DE','Anzahl','displayfield','Allgemein/Angaben',1,0,1,0,'1',1.00,'\'\''),
('onlinestimmzettel','stimmzettel','DE','Stimmzettel','displaycombobox_stimmzettel_ridx','Allgemein/Angaben',0,0,1,0,'1',1.00,'\'\'');
UNLOCK TABLES;
LOCK TABLES `ds_dropdownfields` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_reference_tables` WRITE;
INSERT IGNORE INTO `ds_reference_tables` (`table_name`, `reference_table_name`, `columnsdef`, `constraint_name`, `active`, `searchable`, `autosync`, `position`, `path`, `existsreal`, `tabtitle`) VALUES ('onlinestimmzettel','stimmzettel','{\"stimmzettel\":\"ridx\"}','fk_onlinestimmzettel_stimmzettel',0,0,0,999,'',1,'');
UNLOCK TABLES;
LOCK TABLES `ds_addcommands` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_access` WRITE;
INSERT IGNORE INTO `ds_access` (`role`, `table_name`, `read`, `write`, `delete`, `append`) VALUES ('wahl_administration','onlinestimmzettel',1,1,1,1);
UNLOCK TABLES;
