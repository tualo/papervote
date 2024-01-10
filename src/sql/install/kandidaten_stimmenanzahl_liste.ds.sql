DELIMITER ;
INSERT INTO `ds` (`table_name`, `title`, `reorderfield`, `use_history`, `searchfield`, `displayfield`, `sortfield`, `searchany`, `hint`, `overview_tpl`, `sync_table`, `writetable`, `globalsearch`, `listselectionmodel`, `sync_view`, `syncable`, `cssstyle`, `alternativeformxtype`, `read_table`, `class_name`, `special_add_panel`, `existsreal`, `character_set_name`, `read_filter`, `listxtypeprefix`, `phpexporter`, `phpexporterfilename`, `combined`, `default_pagesize`, `allowForm`, `listviewbaseclass`, `showactionbtn`, `modelbaseclass`) VALUES ('kandidaten_stimmenanzahl_liste','Los-Kandidaten',NULL,NULL,'anzeige_name','anzeige_name',NULL,NULL,NULL,NULL,NULL,'kandidaten',NULL,'cellmodel',NULL,NULL,NULL,NULL,NULL,'Wahlsystem',NULL,1,NULL,NULL,NULL,'XlsxWriter','kandidaten_stimmenanzahl_liste-{DATE}',0,1000,1,'Tualo.DataSets.ListView',1,'Tualo.DataSets.model.Basic') ON DUPLICATE KEY UPDATE title=VALUES(title), reorderfield=VALUES(reorderfield), use_history=VALUES(use_history), searchfield=VALUES(searchfield), displayfield=VALUES(displayfield), sortfield=VALUES(sortfield), searchany=VALUES(searchany), hint=VALUES(hint), overview_tpl=VALUES(overview_tpl), sync_table=VALUES(sync_table), writetable=VALUES(writetable), globalsearch=VALUES(globalsearch), listselectionmodel=VALUES(listselectionmodel), sync_view=VALUES(sync_view), syncable=VALUES(syncable), cssstyle=VALUES(cssstyle), alternativeformxtype=VALUES(alternativeformxtype), read_table=   VALUES(read_table), class_name=VALUES(class_name), special_add_panel=VALUES(special_add_panel), existsreal=VALUES(existsreal), character_set_name=VALUES(character_set_name), read_filter=VALUES(read_filter), listxtypeprefix=VALUES(listxtypeprefix), phpexporter=VALUES(phpexporter), phpexporterfilename=VALUES(phpexporterfilename), combined=VALUES(combined), default_pagesize=VALUES(default_pagesize), allowForm=VALUES(allowForm), listviewbaseclass=VALUES(listviewbaseclass), showactionbtn=VALUES(showactionbtn), modelbaseclass=VALUES(modelbaseclass);
INSERT  IGNORE INTO `ds_column` (`table_name`, `column_name`, `default_value`, `default_max_value`, `default_min_value`, `update_value`, `is_primary`, `syncable`, `referenced_table`, `referenced_column_name`, `is_nullable`, `is_referenced`, `writeable`, `note`, `data_type`, `column_key`, `column_type`, `character_maximum_length`, `numeric_precision`, `numeric_scale`, `character_set_name`, `privileges`, `existsreal`, `deferedload`, `hint`, `fieldtype`) VALUES ('kandidaten_stimmenanzahl_liste','anzeige_name',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'YES',NULL,1,NULL,'text','','text',65535,NULL,NULL,'utf8mb3','select,insert,update,references',1,NULL,NULL,''),('kandidaten_stimmenanzahl_liste','barcode',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'YES',NULL,1,NULL,'varchar','','varchar(5)',5,NULL,NULL,'utf8mb3','select,insert,update,references',1,NULL,NULL,''),('kandidaten_stimmenanzahl_liste','gesamtstimmen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'NO',NULL,1,NULL,'bigint','','bigint(22)',NULL,19,0,NULL,'select,insert,update,references',1,NULL,NULL,''),('kandidaten_stimmenanzahl_liste','id',NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,'NO',NULL,1,NULL,'int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,NULL,NULL,''),('kandidaten_stimmenanzahl_liste','losnummer',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'YES',NULL,1,NULL,'int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,NULL,NULL,''),('kandidaten_stimmenanzahl_liste','losnummer_stimmzettelgruppe',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'YES',NULL,1,NULL,'int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,NULL,NULL,''),('kandidaten_stimmenanzahl_liste','rank',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'NO',NULL,1,NULL,'bigint','','bigint(21)',NULL,19,0,NULL,'select,insert,update,references',1,NULL,NULL,''),('kandidaten_stimmenanzahl_liste','stimmzettelgruppen_mindestsitze',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'YES',NULL,1,NULL,'int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,NULL,NULL,''),('kandidaten_stimmenanzahl_liste','stimmzettelgruppen_name',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'YES',NULL,1,NULL,'varchar','','varchar(255)',255,NULL,NULL,'utf8mb3','select,insert,update,references',1,NULL,NULL,''),('kandidaten_stimmenanzahl_liste','stimmzettelgruppen_text',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'YES',NULL,1,NULL,'varchar','','varchar(255)',255,NULL,NULL,'utf8mb3','select,insert,update,references',1,NULL,NULL,''),('kandidaten_stimmenanzahl_liste','stimmzettel_name',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'YES',NULL,1,NULL,'varchar','','varchar(255)',255,NULL,NULL,'utf8mb3','select,insert,update,references',1,NULL,NULL,''),('kandidaten_stimmenanzahl_liste','stimmzettel_ridx',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'YES',NULL,1,NULL,'varchar','','varchar(12)',12,NULL,NULL,'utf8mb3','select,insert,update,references',1,NULL,NULL,''),('kandidaten_stimmenanzahl_liste','stimmzettel_sitze',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'YES',NULL,1,NULL,'varchar','','varchar(255)',255,NULL,NULL,'utf8mb3','select,insert,update,references',1,NULL,NULL,''),('kandidaten_stimmenanzahl_liste','Xrank',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'NO',NULL,1,NULL,'bigint','','bigint(21)',NULL,19,0,NULL,'select,insert,update,references',1,NULL,NULL,'');
INSERT  IGNORE INTO `ds_column_list_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `editor`, `position`, `summaryrenderer`, `renderer`, `summarytype`, `hidden`, `active`, `filterstore`, `grouped`, `flex`, `direction`, `align`, `listfiltertype`, `hint`) VALUES ('kandidaten_stimmenanzahl_liste','anzeige_name','DE','Name','gridcolumn',NULL,1,'','','',0,1,'',0,1.00,'ASC','left','',NULL),('kandidaten_stimmenanzahl_liste','barcode','DE','Barcode','gridcolumn',NULL,0,'','','',0,1,'',0,1.00,'ASC','left','',NULL),('kandidaten_stimmenanzahl_liste','gesamtstimmen','DE','Gesamt','gridcolumn',NULL,6,'','','',1,1,'',0,1.00,'ASC','left','',NULL),('kandidaten_stimmenanzahl_liste','id','DE','ID','gridcolumn',NULL,10,'','','',1,1,'',0,1.00,'ASC','left','',NULL),('kandidaten_stimmenanzahl_liste','losnummer','DE','Stimmzettel-Los','gridcolumn','numberfield',2,'','','',0,1,'',0,1.00,'ASC','end','',NULL),('kandidaten_stimmenanzahl_liste','losnummer_stimmzettelgruppe','DE','Stimmzettelgruppe','gridcolumn',NULL,3,'','','',1,1,'',0,1.00,'ASC','left','',NULL),('kandidaten_stimmenanzahl_liste','rank','DE','Rank','gridcolumn',NULL,9,'','','',1,1,'',0,1.00,'ASC','left','',NULL),('kandidaten_stimmenanzahl_liste','stimmzettelgruppen_mindestsitze','DE','SZG Sitze','gridcolumn',NULL,13,'','','',1,1,'',0,1.00,'ASC','left','',NULL),('kandidaten_stimmenanzahl_liste','stimmzettelgruppen_name','DE','Gruppenname','gridcolumn',NULL,5,'','','',1,1,'',0,1.00,'ASC','left','',NULL),('kandidaten_stimmenanzahl_liste','stimmzettelgruppen_text','DE','GruppenText','gridcolumn',NULL,8,'','','',1,1,'',0,1.00,'ASC','left','',NULL),('kandidaten_stimmenanzahl_liste','stimmzettel_name','DE','SZ Name','gridcolumn',NULL,12,'','','',1,1,'',0,1.00,'ASC','left','',NULL),('kandidaten_stimmenanzahl_liste','stimmzettel_ridx','DE','Stimmzettel RIDX','gridcolumn',NULL,4,'','','',1,1,'',0,1.00,'ASC','left','',NULL),('kandidaten_stimmenanzahl_liste','stimmzettel_sitze','DE','Sitze','gridcolumn',NULL,7,'','','',1,1,'',0,1.00,'ASC','left','',NULL),('kandidaten_stimmenanzahl_liste','Xrank','DE','XRank','gridcolumn',NULL,11,'','','',1,1,'',0,1.00,'ASC','left','',NULL);
INSERT  IGNORE INTO `ds_column_form_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `field_path`, `position`, `hidden`, `active`, `allowempty`, `fieldgroup`, `flex`, `hint`) VALUES ('kandidaten_stimmenanzahl_liste','anzeige_name','DE','Name','displayfield','Allgemein/Information',1,0,1,NULL,NULL,NULL,'\'\''),('kandidaten_stimmenanzahl_liste','barcode','DE','Barcode','displayfield','Allgemein/Information',0,0,1,NULL,NULL,NULL,'\'\''),('kandidaten_stimmenanzahl_liste','gesamtstimmen','DE','{column_name}','displayfield','Allgemein',6,0,1,NULL,NULL,NULL,'\'\''),('kandidaten_stimmenanzahl_liste','id','DE','{column_name}','displayfield','Allgemein',10,0,1,NULL,NULL,NULL,'\'\''),('kandidaten_stimmenanzahl_liste','losnummer','DE','Stimmzettel','displayfield','Allgemein/Los',2,0,1,NULL,NULL,NULL,'\'\''),('kandidaten_stimmenanzahl_liste','losnummer_stimmzettelgruppe','DE','Stimmzettelgruppe','displayfield','Allgemein/Los',3,0,1,NULL,NULL,NULL,'\'\''),('kandidaten_stimmenanzahl_liste','rank','DE','{column_name}','displayfield','Allgemein',9,0,1,NULL,NULL,NULL,'\'\''),('kandidaten_stimmenanzahl_liste','stimmzettelgruppen_mindestsitze','DE','{column_name}','displayfield','Allgemein',13,0,1,NULL,NULL,NULL,'\'\''),('kandidaten_stimmenanzahl_liste','stimmzettelgruppen_name','DE','{column_name}','displayfield','Allgemein',5,0,1,NULL,NULL,NULL,'\'\''),('kandidaten_stimmenanzahl_liste','stimmzettelgruppen_text','DE','{column_name}','displayfield','Allgemein',8,0,1,NULL,NULL,NULL,'\'\''),('kandidaten_stimmenanzahl_liste','stimmzettel_name','DE','{column_name}','displayfield','Allgemein',12,0,1,NULL,NULL,NULL,'\'\''),('kandidaten_stimmenanzahl_liste','stimmzettel_ridx','DE','{column_name}','displayfield','Allgemein',4,0,1,NULL,NULL,NULL,'\'\''),('kandidaten_stimmenanzahl_liste','stimmzettel_sitze','DE','{column_name}','displayfield','Allgemein',7,0,1,NULL,NULL,NULL,'\'\''),('kandidaten_stimmenanzahl_liste','Xrank','DE','{column_name}','displayfield','Allgemein',11,0,1,NULL,NULL,NULL,'\'\'');
INSERT  IGNORE INTO `ds_reference_tables` (`table_name`, `reference_table_name`, `columnsdef`, `constraint_name`, `active`, `searchable`, `autosync`, `position`, `path`, `existsreal`, `tabtitle`) VALUES ('kandidaten_stimmenanzahl_liste','kandidaten_stimmenanzahl_losentscheid_stimmzettel','{\"rank\":\"rank\",\"stimmzettel_ridx\":\"stimmzettel_ridx\"}','manual_c5cf1ee0626ca259fbf9a7f38826205f',1,0,0,999,'',1,'');

INSERT  IGNORE INTO `ds_access` (`role`, `table_name`, `read`, `write`, `delete`, `append`, `existsreal`) VALUES ('administration','kandidaten_stimmenanzahl_liste',1,1,0,1,0);

INSERT INTO `ds_referenced_manual` VALUES
('kandidaten_stimmenanzahl_liste','kandidaten_stimmenanzahl_losentscheid_stimmzettel'),
('kandidaten_stimmenanzahl_losentscheid_stimmzettel','kandidaten_stimmenanzahl_liste') ;


INSERT INTO `ds_referenced_manual_columns` VALUES
('kandidaten_stimmenanzahl_losentscheid_stimmzettel','kandidaten_stimmenanzahl_liste','rank','rank'),
('kandidaten_stimmenanzahl_losentscheid_stimmzettel','kandidaten_stimmenanzahl_liste','stimmzettel_ridx','stimmzettel_ridx'),
('kandidaten_stimmenanzahl_liste','kandidaten_stimmenanzahl_losentscheid_stimmzettel','rank','rank'),
('kandidaten_stimmenanzahl_liste','kandidaten_stimmenanzahl_losentscheid_stimmzettel','stimmzettel_ridx','stimmzettel_ridx') ;