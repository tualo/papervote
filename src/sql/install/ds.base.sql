delimiter ;
LOCK TABLES `ds` WRITE;
INSERT IGNORE INTO `ds` (`table_name`, `title`, `reorderfield`, `use_history`, `searchfield`, `displayfield`, `sortfield`, `searchany`, `hint`, `overview_tpl`, `sync_table`, `writetable`, `globalsearch`, `listselectionmodel`, `sync_view`, `syncable`, `cssstyle`, `alternativeformxtype`, `read_table`, `class_name`, `special_add_panel`, `existsreal`, `character_set_name`, `read_filter`, `listxtypeprefix`, `phpexporter`, `phpexporterfilename`, `combined`, `default_pagesize`, `allowForm`, `listviewbaseclass`, `showactionbtn`, `modelbaseclass`) VALUES ('abgabetyp','Abgabetyp','',0,'name','name','id',1,'Mit dem Abgabetyp wird festgelegt, auf welchem Weg der Wähler an der Wahl teilgenommen hat.','','','',1,'','',0,'','','','Wahlsystem','',1,'','','listview','XlsxWriter','abgabetyp',0,100,0,'Tualo.DataSets.ListView',1,'Tualo.DataSets.model.Basic');
UNLOCK TABLES;
LOCK TABLES `ds_column` WRITE;
INSERT IGNORE INTO `ds_column` (`table_name`, `column_name`, `default_value`, `default_max_value`, `default_min_value`, `update_value`, `is_primary`, `syncable`, `referenced_table`, `referenced_column_name`, `is_nullable`, `is_referenced`, `writeable`, `note`, `data_type`, `column_key`, `column_type`, `character_maximum_length`, `numeric_precision`, `numeric_scale`, `character_set_name`, `privileges`, `existsreal`, `deferedload`, `hint`, `fieldtype`) VALUES ('abgabetyp','aktiv','1',0,0,'',0,0,NULL,NULL,'YES','NO',1,'','int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,'',''),
('abgabetyp','id','{#serial}',1000,1,'',1,0,NULL,NULL,'NO','NO',1,'','int','PRI','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,'',''),
('abgabetyp','insert_date','null',0,0,'',0,0,NULL,NULL,'NO','NO',1,'','date','','date',NULL,NULL,NULL,NULL,'select,insert,update,references',1,0,'',''),
('abgabetyp','insert_time','null',0,0,'',0,0,NULL,NULL,'YES','NO',1,'','time','','time',NULL,NULL,NULL,NULL,'select,insert,update,references',1,0,'',''),
('abgabetyp','kostenstelle','0',0,0,'',1,0,NULL,NULL,'NO','NO',1,'','int','PRI','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,'',''),
('abgabetyp','login','null',0,0,'',0,0,NULL,NULL,'NO','NO',1,'','varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('abgabetyp','name','',0,0,'',0,0,NULL,NULL,'YES','NO',1,'','varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('abgabetyp','ridx','null|null',0,0,'null|null',0,0,NULL,NULL,'YES','NO',1,'','varchar','UNI','varchar(12)',12,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('abgabetyp','update_date','null',0,0,'null',0,0,NULL,NULL,'NO','NO',1,'','date','','date',NULL,NULL,NULL,NULL,'select,insert,update,references',1,0,'',''),
('abgabetyp','update_time','null',0,0,'null',0,0,NULL,NULL,'YES','NO',1,'','time','','time',NULL,NULL,NULL,NULL,'select,insert,update,references',1,0,'','');
UNLOCK TABLES;
LOCK TABLES `ds_column_list_label` WRITE;
INSERT IGNORE INTO `ds_column_list_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `editor`, `position`, `summaryrenderer`, `renderer`, `summarytype`, `hidden`, `active`, `filterstore`, `grouped`, `flex`, `direction`, `align`, `listfiltertype`, `hint`) VALUES ('abgabetyp','id','DE','ID','gridcolumn','',999,NULL,'',NULL,0,1,'',0,1.00,'ASC','left','',''),
('abgabetyp','kostenstelle','DE','kostenstelle','gridcolumn','',0,'','','',0,1,'',0,1.00,'ASC','left','',''),
('abgabetyp','name','DE','Name','gridcolumn','',999,NULL,'',NULL,0,1,'',0,1.00,'ASC','left','',''),
('abgabetyp','ridx','DE','RIDX','gridcolumn','',999,NULL,'',NULL,0,1,'',0,1.00,'ASC','left','','');
UNLOCK TABLES;
LOCK TABLES `ds_column_form_label` WRITE;
INSERT IGNORE INTO `ds_column_form_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `field_path`, `position`, `hidden`, `active`, `allowempty`, `fieldgroup`, `flex`, `hint`) VALUES ('abgabetyp','aktiv','DE','Aktiv','checkbox','Allgemein',2,0,1,1,'',1.00,''),
('abgabetyp','id','DE','ID','displayfield','Allgemein',0,0,1,1,'',1.00,''),
('abgabetyp','kostenstelle','DE','kostenstelle','displayfield','Allgemein',0,1,1,1,'',1.00,'\'\''),
('abgabetyp','name','DE','Name','textfield','Allgemein',1,0,1,1,'',1.00,'');
UNLOCK TABLES;
LOCK TABLES `ds_dropdownfields` WRITE;
INSERT IGNORE INTO `ds_dropdownfields` (`table_name`, `name`, `idfield`, `displayfield`, `filterconfig`) VALUES ('abgabetyp','RIDX','ridx','name',NULL);
UNLOCK TABLES;
LOCK TABLES `ds_reference_tables` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_addcommands` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_access` WRITE;
INSERT IGNORE INTO `ds_access` (`role`, `table_name`, `read`, `write`, `delete`, `append`) VALUES ('wahl_administration','abgabetyp',1,1,1,1);
UNLOCK TABLES;
LOCK TABLES `ds` WRITE;
INSERT IGNORE INTO `ds` (`table_name`, `title`, `reorderfield`, `use_history`, `searchfield`, `displayfield`, `sortfield`, `searchany`, `hint`, `overview_tpl`, `sync_table`, `writetable`, `globalsearch`, `listselectionmodel`, `sync_view`, `syncable`, `cssstyle`, `alternativeformxtype`, `read_table`, `class_name`, `special_add_panel`, `existsreal`, `character_set_name`, `read_filter`, `listxtypeprefix`, `phpexporter`, `phpexporterfilename`, `combined`, `default_pagesize`, `allowForm`, `listviewbaseclass`, `showactionbtn`, `modelbaseclass`) VALUES ('wahlbezirk','Wahlbezirk','',0,'name','name','id',1,'','','','',1,'','',0,'','','','Wahlsystem','',1,'','','listview','XlsxWriter','wahlbezirk',0,1000,0,'Tualo.DataSets.ListView',1,'Tualo.DataSets.model.Basic');
UNLOCK TABLES;
LOCK TABLES `ds_column` WRITE;
INSERT IGNORE INTO `ds_column` (`table_name`, `column_name`, `default_value`, `default_max_value`, `default_min_value`, `update_value`, `is_primary`, `syncable`, `referenced_table`, `referenced_column_name`, `is_nullable`, `is_referenced`, `writeable`, `note`, `data_type`, `column_key`, `column_type`, `character_maximum_length`, `numeric_precision`, `numeric_scale`, `character_set_name`, `privileges`, `existsreal`, `deferedload`, `hint`, `fieldtype`) VALUES ('wahlbezirk','aktiv','1',0,0,'',0,0,NULL,NULL,'YES','NO',1,'','int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,'',''),
('wahlbezirk','id','{#serial}',1000,1,'',1,0,NULL,NULL,'NO','NO',1,'','int','PRI','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,'',''),
('wahlbezirk','insert_date','null',0,0,'',0,0,NULL,NULL,'NO','NO',1,'','date','','date',NULL,NULL,NULL,NULL,'select,insert,update,references',1,0,'',''),
('wahlbezirk','insert_time','null',0,0,'null',0,0,NULL,NULL,'YES','NO',1,'','time','','time',NULL,NULL,NULL,NULL,'select,insert,update,references',1,0,'',''),
('wahlbezirk','kostenstelle','0',0,0,'',1,0,NULL,NULL,'NO','NO',1,'','int','PRI','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,'',''),
('wahlbezirk','kurzbezeichnung','',0,0,'',0,0,NULL,NULL,'YES','NO',1,'','varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('wahlbezirk','login','null',0,0,'',0,0,NULL,NULL,'NO','NO',1,'','varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('wahlbezirk','name','',0,0,'',0,0,NULL,NULL,'YES','NO',1,'','varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('wahlbezirk','ridx','null|null',0,0,'null|null',0,0,NULL,NULL,'YES','NO',1,'','varchar','UNI','varchar(12)',12,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('wahlbezirk','update_date','null',0,0,'null',0,0,NULL,NULL,'NO','NO',1,'','date','','date',NULL,NULL,NULL,NULL,'select,insert,update,references',1,0,'',''),
('wahlbezirk','update_time','null',0,0,'null',0,0,NULL,NULL,'YES','NO',1,'','time','','time',NULL,NULL,NULL,NULL,'select,insert,update,references',1,0,'',''),
('wahlbezirk','zuweisungsschluessel','0',0,0,'',0,0,NULL,NULL,'YES','NO',1,'','varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'','');
UNLOCK TABLES;
LOCK TABLES `ds_column_list_label` WRITE;
INSERT IGNORE INTO `ds_column_list_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `editor`, `position`, `summaryrenderer`, `renderer`, `summarytype`, `hidden`, `active`, `filterstore`, `grouped`, `flex`, `direction`, `align`, `listfiltertype`, `hint`) VALUES ('wahlbezirk','aktiv','DE','Aktiv','booleancolumn','',999,NULL,'',NULL,0,1,'',0,1.00,'ASC','left','',''),
('wahlbezirk','id','DE','ID','gridcolumn','',999,NULL,'',NULL,0,1,'',0,1.00,'ASC','left','',''),
('wahlbezirk','kostenstelle','DE','kostenstelle','gridcolumn','',0,'','','',0,1,'',0,1.00,'ASC','left','',''),
('wahlbezirk','name','DE','Name','gridcolumn','',999,NULL,'',NULL,0,1,'',0,1.00,'ASC','left','',''),
('wahlbezirk','ridx','DE','RIDX','gridcolumn','',999,NULL,'',NULL,0,1,'',0,1.00,'ASC','left','',''),
('wahlbezirk','zuweisungsschluessel','DE','Schlüssel','gridcolumn','',999,NULL,'',NULL,0,1,'',0,1.00,'ASC','left','','');
UNLOCK TABLES;
LOCK TABLES `ds_column_form_label` WRITE;
INSERT IGNORE INTO `ds_column_form_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `field_path`, `position`, `hidden`, `active`, `allowempty`, `fieldgroup`, `flex`, `hint`) VALUES ('wahlbezirk','aktiv','DE','Aktiv','checkbox','Allgemein',2,0,1,1,'',1.00,''),
('wahlbezirk','id','DE','ID','displayfield','Allgemein',0,0,1,1,'',1.00,''),
('wahlbezirk','kostenstelle','DE','kostenstelle','displayfield','Allgemein',0,0,1,1,'',1.00,''),
('wahlbezirk','kurzbezeichnung','DE','Kurz','textfield','Allgemein',4,0,1,1,'',1.00,''),
('wahlbezirk','name','DE','Name','textfield','Allgemein',5,0,1,1,'',1.00,''),
('wahlbezirk','ridx','DE','RIXD','displayfield','Allgemein',1,0,1,1,'',1.00,''),
('wahlbezirk','zuweisungsschluessel','DE','Schlüssel','textfield','Allgemein',3,0,1,1,'',1.00,'');
UNLOCK TABLES;
LOCK TABLES `ds_dropdownfields` WRITE;
INSERT IGNORE INTO `ds_dropdownfields` (`table_name`, `name`, `idfield`, `displayfield`, `filterconfig`) VALUES ('wahlbezirk','RIDX','ridx','name',NULL),
('wahlbezirk','RIXD','ridx','name',NULL);
UNLOCK TABLES;
LOCK TABLES `ds_reference_tables` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_addcommands` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_access` WRITE;
INSERT IGNORE INTO `ds_access` (`role`, `table_name`, `read`, `write`, `delete`, `append` ) VALUES ('wahl_administration','wahlbezirk',1,1,1,1 );
UNLOCK TABLES;
LOCK TABLES `ds` WRITE;
INSERT IGNORE INTO `ds` (`table_name`, `title`, `reorderfield`, `use_history`, `searchfield`, `displayfield`, `sortfield`, `searchany`, `hint`, `overview_tpl`, `sync_table`, `writetable`, `globalsearch`, `listselectionmodel`, `sync_view`, `syncable`, `cssstyle`, `alternativeformxtype`, `read_table`, `class_name`, `special_add_panel`, `existsreal`, `character_set_name`, `read_filter`, `listxtypeprefix`, `phpexporter`, `phpexporterfilename`, `combined`, `default_pagesize`, `allowForm`, `listviewbaseclass`, `showactionbtn`, `modelbaseclass`) VALUES ('wahlgruppe','Wahlgruppe','',0,'name','name','zuweisungsschluessel',1,'','','','',1,'','',0,'','','','Wahlsystem','',1,'','','listview','XlsxWriter','wahlgruppe',0,1000,0,'Tualo.DataSets.ListView',1,'Tualo.DataSets.model.Basic');
UNLOCK TABLES;
LOCK TABLES `ds_column` WRITE;
INSERT IGNORE INTO `ds_column` (`table_name`, `column_name`, `default_value`, `default_max_value`, `default_min_value`, `update_value`, `is_primary`, `syncable`, `referenced_table`, `referenced_column_name`, `is_nullable`, `is_referenced`, `writeable`, `note`, `data_type`, `column_key`, `column_type`, `character_maximum_length`, `numeric_precision`, `numeric_scale`, `character_set_name`, `privileges`, `existsreal`, `deferedload`, `hint`, `fieldtype`) VALUES ('wahlgruppe','aktiv','1',0,0,'',0,0,NULL,NULL,'YES','NO',1,'','int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,'',''),
('wahlgruppe','id','{#serial}',1000,1,'',1,0,NULL,NULL,'NO','NO',1,'','int','PRI','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,'',''),
('wahlgruppe','insert_date','null',0,0,'',0,0,NULL,NULL,'NO','NO',1,'','date','','date',NULL,NULL,NULL,NULL,'select,insert,update,references',1,0,'',''),
('wahlgruppe','insert_time','null',0,0,'',0,0,NULL,NULL,'YES','NO',1,'','time','','time',NULL,NULL,NULL,NULL,'select,insert,update,references',1,0,'',''),
('wahlgruppe','kostenstelle','0',0,0,'',1,0,NULL,NULL,'NO','NO',1,'','int','PRI','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,'',''),
('wahlgruppe','kurzbezeichnung','',0,0,'',0,0,NULL,NULL,'YES','NO',1,'','varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('wahlgruppe','login','null',0,0,'',0,0,NULL,NULL,'NO','NO',1,'','varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('wahlgruppe','name','',0,0,'',0,0,NULL,NULL,'YES','NO',1,'','varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('wahlgruppe','ridx','null|null',0,0,'null|null',0,0,NULL,NULL,'YES','NO',1,'','varchar','UNI','varchar(12)',12,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('wahlgruppe','update_date','null',0,0,'null',0,0,NULL,NULL,'NO','NO',1,'','date','','date',NULL,NULL,NULL,NULL,'select,insert,update,references',1,0,'',''),
('wahlgruppe','update_time','null',0,0,'null',0,0,NULL,NULL,'YES','NO',1,'','time','','time',NULL,NULL,NULL,NULL,'select,insert,update,references',1,0,'',''),
('wahlgruppe','zuweisungsschluessel','0',0,0,'',0,0,NULL,NULL,'YES','NO',1,'','varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'','');
UNLOCK TABLES;
LOCK TABLES `ds_column_list_label` WRITE;
INSERT IGNORE INTO `ds_column_list_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `editor`, `position`, `summaryrenderer`, `renderer`, `summarytype`, `hidden`, `active`, `filterstore`, `grouped`, `flex`, `direction`, `align`, `listfiltertype`, `hint`) VALUES ('wahlgruppe','aktiv','DE','Aktiv','booleancolumn','',999,NULL,'',NULL,0,1,'',0,1.00,'ASC','left','',''),
('wahlgruppe','id','DE','ID','gridcolumn','',999,NULL,'',NULL,0,1,'',0,1.00,'ASC','left','',''),
('wahlgruppe','kostenstelle','DE','kostenstelle','gridcolumn','',999,'','','',1,1,'',0,1.00,'ASC','left','',''),
('wahlgruppe','name','DE','Name','gridcolumn','',999,NULL,'',NULL,0,1,'',0,1.00,'ASC','left','',''),
('wahlgruppe','ridx','DE','RIDX','gridcolumn','',999,'','','',1,1,'',0,1.00,'ASC','left','','');
UNLOCK TABLES;
LOCK TABLES `ds_column_form_label` WRITE;
INSERT IGNORE INTO `ds_column_form_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `field_path`, `position`, `hidden`, `active`, `allowempty`, `fieldgroup`, `flex`, `hint`) VALUES ('wahlgruppe','aktiv','DE','Aktiv','checkbox','Allgemein',3,0,1,1,'',1.00,''),
('wahlgruppe','id','DE','ID','numberfield','Allgemein',0,0,1,1,'',1.00,''),
('wahlgruppe','insert_date','DE','insert_date','displayfield','Allgemein',8,1,1,1,'',1.00,''),
('wahlgruppe','insert_time','DE','insert_time','displayfield','Allgemein',11,1,1,1,'',1.00,''),
('wahlgruppe','kostenstelle','DE','Unternummer','numberfield','Allgemein',1,0,1,1,'',1.00,''),
('wahlgruppe','kurzbezeichnung','DE','Kurz','textfield','Allgemein',6,0,1,1,'',1.00,''),
('wahlgruppe','login','DE','login','displayfield','Allgemein',9,1,1,1,'',1.00,''),
('wahlgruppe','name','DE','Name','textfield','Allgemein',5,0,1,1,'',1.00,''),
('wahlgruppe','ridx','DE','RIDX','displayfield','Allgemein',2,1,0,1,'',1.00,''),
('wahlgruppe','update_date','DE','update_date','displayfield','Allgemein',7,1,1,1,'',1.00,''),
('wahlgruppe','update_time','DE','update_time','displayfield','Allgemein',10,1,1,1,'',1.00,''),
('wahlgruppe','zuweisungsschluessel','DE','Schlüssel','textfield','Allgemein',4,0,1,1,'',1.00,'');
UNLOCK TABLES;
LOCK TABLES `ds_dropdownfields` WRITE;
INSERT IGNORE INTO `ds_dropdownfields` (`table_name`, `name`, `idfield`, `displayfield`, `filterconfig`) VALUES ('wahlgruppe','RIDX','ridx','name',NULL);
UNLOCK TABLES;
LOCK TABLES `ds_reference_tables` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_addcommands` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_access` WRITE;
INSERT IGNORE INTO `ds_access` (`role`, `table_name`, `read`, `write`, `delete`, `append` ) VALUES ('wahl_administration','wahlgruppe',1,1,1,1 );
UNLOCK TABLES;
LOCK TABLES `ds` WRITE;
INSERT IGNORE INTO `ds` (`table_name`, `title`, `reorderfield`, `use_history`, `searchfield`, `displayfield`, `sortfield`, `searchany`, `hint`, `overview_tpl`, `sync_table`, `writetable`, `globalsearch`, `listselectionmodel`, `sync_view`, `syncable`, `cssstyle`, `alternativeformxtype`, `read_table`, `class_name`, `special_add_panel`, `existsreal`, `character_set_name`, `read_filter`, `listxtypeprefix`, `phpexporter`, `phpexporterfilename`, `combined`, `default_pagesize`, `allowForm`, `listviewbaseclass`, `showactionbtn`, `modelbaseclass`) VALUES ('stimmzettel','Stimmzettel','',0,'name','name','',1,'','','','',0,'cellmodel','',0,'','','','Wahlsystem','',1,'','','listview','XlsxWriter','stimmzettel',0,1000,0,'Tualo.DataSets.ListView',1,'Tualo.DataSets.model.Basic');
UNLOCK TABLES;
LOCK TABLES `ds_column` WRITE;
INSERT IGNORE INTO `ds_column` (`table_name`, `column_name`, `default_value`, `default_max_value`, `default_min_value`, `update_value`, `is_primary`, `syncable`, `referenced_table`, `referenced_column_name`, `is_nullable`, `is_referenced`, `writeable`, `note`, `data_type`, `column_key`, `column_type`, `character_maximum_length`, `numeric_precision`, `numeric_scale`, `character_set_name`, `privileges`, `existsreal`, `deferedload`, `hint`, `fieldtype`) VALUES ('stimmzettel','aktiv','1',100000,0,'',0,0,'','','YES','NO',1,'','int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,'',''),
('stimmzettel','anzahl_10','0',100000,0,'',0,0,'','','YES','NO',1,'','int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,'',''),
('stimmzettel','anzahl_notwendige_bewerber_je_kombinummer','',0,0,'',0,0,'','','YES','NO',1,'','varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('stimmzettel','bh1','',10000000,0,NULL,0,0,NULL,NULL,'YES','NO',1,'','int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,'',''),
('stimmzettel','bh2','',10000000,0,NULL,0,0,NULL,NULL,'YES','NO',1,'','int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,'',''),
('stimmzettel','ds_count','0',0,0,'',0,0,'','','YES','NO',1,'','int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,'',''),
('stimmzettel','farbe','',10000000,0,'',0,0,'','','YES','NO',1,'','varchar','','varchar(100)',100,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('stimmzettel','id','{#serial}',100000,1,'',1,0,'','','NO','NO',1,'','int','PRI','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,'',''),
('stimmzettel','insert_date','null',100000,0,'',0,0,'','','NO','NO',1,'','date','','date',NULL,NULL,NULL,NULL,'select,insert,update,references',1,0,'',''),
('stimmzettel','insert_time','null',100000,0,'',0,0,'','','YES','NO',1,'','time','','time',NULL,NULL,NULL,NULL,'select,insert,update,references',1,0,'',''),
('stimmzettel','kandidat_text_einzel','',10000000,0,NULL,0,0,NULL,NULL,'YES','NO',1,'','varchar','','varchar(50)',50,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('stimmzettel','kandidat_text_mehr','',10000000,0,NULL,0,0,NULL,NULL,'YES','NO',1,'','varchar','','varchar(50)',50,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('stimmzettel','laufende_nummer_1_24__nach_zuordnung_wg_wb','',0,0,'',0,0,'','','YES','NO',1,'','varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('stimmzettel','login','null',100000,0,'null',0,0,'','','NO','NO',1,'','varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('stimmzettel','name','',100000,0,'',0,0,'','','YES','NO',1,'','varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('stimmzettel','ridx','null|null',100000,0,'',0,0,'','','YES','NO',1,'','varchar','UNI','varchar(12)',12,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('stimmzettel','sitzbindung','0',100000,0,'',0,0,'','','YES','NO',1,'','varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('stimmzettel','sitze','1',100000,0,'',0,0,'','','YES','NO',1,'','varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('stimmzettel','typtitel','',10000000,0,NULL,0,0,NULL,NULL,'YES','NO',1,'','varchar','','varchar(100)',100,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('stimmzettel','ungueltig','',10000000,0,'',0,0,'','','YES','NO',1,'','int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,'',''),
('stimmzettel','update_date','null',100000,0,'null',0,0,'','','NO','NO',1,'','date','','date',NULL,NULL,NULL,NULL,'select,insert,update,references',1,0,'',''),
('stimmzettel','update_time','null',100000,0,'null',0,0,'','','YES','NO',1,'','time','','time',NULL,NULL,NULL,NULL,'select,insert,update,references',1,0,'',''),
('stimmzettel','wahlbezirk','',100000,0,'',0,0,'','','YES','NO',1,'','varchar','MUL','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('stimmzettel','wahlgruppe','',100000,0,'',0,0,'','','YES','NO',1,'','varchar','MUL','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('stimmzettel','wahltyp','',100000,0,'',0,0,'','','YES','NO',1,'','varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('stimmzettel','xlink','',10000000,0,NULL,0,0,NULL,NULL,'YES','NO',1,'','varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('stimmzettel','zaehlung_1','0',100000,0,'',0,0,'','','YES','NO',1,'','int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,'',''),
('stimmzettel','zaehlung_2','0',100000,0,'',0,0,'','','YES','NO',1,'','int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,'',''),
('stimmzettel','zaehlung_3','0',100000,0,'',0,0,'','','YES','NO',1,'','int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,'',''),
('stimmzettel','zaehlung_4','0',100000,0,'',0,0,'','','YES','NO',1,'','int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,'',''),
('stimmzettel','zaehlung_5','0',100000,0,'',0,0,'','','YES','NO',1,'','int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,'',''),
('stimmzettel','zaehlung_6','0',100000,0,'',0,0,'','','YES','NO',1,'','int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,'',''),
('stimmzettel','zaehlung_7','0',100000,0,'',0,0,'','','YES','NO',1,'','int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,'',''),
('stimmzettel','zaehlung_8','0',100000,0,'',0,0,'','','YES','NO',1,'','int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,'',''),
('stimmzettel','zaehlung_9','0',100000,0,'',0,0,'','','YES','NO',1,'','int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,'','');
UNLOCK TABLES;
LOCK TABLES `ds_column_list_label` WRITE;
INSERT IGNORE INTO `ds_column_list_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `editor`, `position`, `summaryrenderer`, `renderer`, `summarytype`, `hidden`, `active`, `filterstore`, `grouped`, `flex`, `direction`, `align`, `listfiltertype`, `hint`) VALUES ('stimmzettel','aktiv','DE','Aktiv','gridcolumn','',1,'','','',1,1,'',0,1.00,'ASC','left','',''),
('stimmzettel','anzahl_10','DE','anzahl_10','gridcolumn','',15,'','','',1,0,'',0,1.00,'ASC','left','',''),
('stimmzettel','anzahl_notwendige_bewerber_je_kombinummer','DE','anzahl_notwendige_bewerber_je_kombinummer','gridcolumn','',23,'','','',1,0,'',0,1.00,'ASC','left','',''),
('stimmzettel','bh1','DE','Höhe 1','gridcolumn','',28,'','','',1,1,'',0,1.00,'','','',''),
('stimmzettel','bh2','DE','Höhe 2','gridcolumn','',29,'','','',1,1,'',0,1.00,'','','',''),
('stimmzettel','ds_count','DE','ds_count','gridcolumn','',18,'','','',1,0,'',0,1.00,'ASC','left','',''),
('stimmzettel','farbe','DE','Farbe','column_farben_rgb','',31,'','','',0,1,'',0,1.00,'','','',''),
('stimmzettel','id','DE','id','gridcolumn','',0,'','','',1,1,'',0,1.00,'ASC','left','',''),
('stimmzettel','insert_date','DE','insert_date','gridcolumn','',13,'','','',1,0,'',0,1.00,'ASC','left','',''),
('stimmzettel','insert_time','DE','insert_time','gridcolumn','',9,'','','',1,0,'',0,1.00,'ASC','left','',''),
('stimmzettel','kandidat_text_einzel','DE','kandidat_text_einzel','gridcolumn','',30,'','','',1,0,'',0,1.00,'','','',''),
('stimmzettel','kandidat_text_mehr','DE','kandidat_text_mehr','gridcolumn','',32,'','','',1,1,'',0,1.00,'','','',''),
('stimmzettel','laufende_nummer_1_24__nach_zuordnung_wg_wb','DE','laufende_nummer_1_24__nach_zuordnung_wg_wb','gridcolumn','',26,'','','',1,0,'',0,1.00,'ASC','left','',''),
('stimmzettel','login','DE','login','gridcolumn','',12,'','','',1,0,'',0,1.00,'ASC','left','',''),
('stimmzettel','name','DE','Name','gridcolumn','',2,'','','',0,1,'',0,1.00,'ASC','left','',''),
('stimmzettel','ridx','DE','ridx','gridcolumn','',27,'','','',1,0,'',0,1.00,'ASC','left','',''),
('stimmzettel','sitzbindung','DE','sitzbindung','gridcolumn','',22,'','','',1,0,'',0,1.00,'ASC','left','',''),
('stimmzettel','sitze','DE','sitze','gridcolumn','',10,'','','',1,0,'',0,1.00,'ASC','left','',''),
('stimmzettel','typtitel','DE','typtitel','gridcolumn','',33,'','','',0,1,'',0,1.00,'','','',''),
('stimmzettel','ungueltig','DE','Ungültig','tualocolumnnumber0','numberfield',6,'','','',0,1,'',0,1.00,'ASC','left','',''),
('stimmzettel','update_date','DE','update_date','gridcolumn','',21,'','','',1,0,'',0,1.00,'ASC','left','',''),
('stimmzettel','update_time','DE','update_time','gridcolumn','',17,'','','',1,0,'',0,1.00,'ASC','left','',''),
('stimmzettel','wahlbezirk','DE','Wahlbezirk','column_wahlbezirk_ridx','',4,'','','',1,1,'',0,1.00,'ASC','left','',''),
('stimmzettel','wahlgruppe','DE','Wahlgruppe','column_wahlgruppe_ridx','',3,'','','',1,1,'',0,1.00,'ASC','left','',''),
('stimmzettel','wahltyp','DE','Wahltyp','column_wahltyp_ridx','',5,'','','',0,1,'',0,1.00,'ASC','left','',''),
('stimmzettel','xlink','DE','xlink','gridcolumn','',999,'','','',1,1,'',0,1.00,'ASC','left','',''),
('stimmzettel','zaehlung_1','DE','zaehlung_1','gridcolumn','',8,'','','',1,0,'',0,1.00,'ASC','left','',''),
('stimmzettel','zaehlung_2','DE','zaehlung_2','gridcolumn','',24,'','','',1,0,'',0,1.00,'ASC','left','',''),
('stimmzettel','zaehlung_3','DE','zaehlung_3','gridcolumn','',11,'','','',1,0,'',0,1.00,'ASC','left','',''),
('stimmzettel','zaehlung_4','DE','zaehlung_4','gridcolumn','',16,'','','',1,0,'',0,1.00,'ASC','left','',''),
('stimmzettel','zaehlung_5','DE','zaehlung_5','gridcolumn','',25,'','','',1,0,'',0,1.00,'ASC','left','',''),
('stimmzettel','zaehlung_6','DE','zaehlung_6','gridcolumn','',20,'','','',1,0,'',0,1.00,'ASC','left','',''),
('stimmzettel','zaehlung_7','DE','zaehlung_7','gridcolumn','',7,'','','',1,0,'',0,1.00,'ASC','left','',''),
('stimmzettel','zaehlung_8','DE','zaehlung_8','gridcolumn','',14,'','','',1,0,'',0,1.00,'ASC','left','',''),
('stimmzettel','zaehlung_9','DE','zaehlung_9','gridcolumn','',19,'','','',1,0,'',0,1.00,'ASC','left','','');
UNLOCK TABLES;
LOCK TABLES `ds_column_form_label` WRITE;
INSERT IGNORE INTO `ds_column_form_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `field_path`, `position`, `hidden`, `active`, `allowempty`, `fieldgroup`, `flex`, `hint`) VALUES ('stimmzettel','aktiv','DE','Aktiv','checkbox','Allgemein/Angaben',1,0,1,1,'',1.00,''),
('stimmzettel','anzahl_10','DE','Anzahl ohne Wahlschein','numberfield','Zählung/Angaben',20,0,1,1,'',1.00,''),
('stimmzettel','anzahl_notwendige_bewerber_je_kombinummer','DE','anzahl_notwendige_bewerber_je_kombinummer','displayfield','Allgemein',32,1,0,0,'',1.00,''),
('stimmzettel','bh1','DE','Höhe 1','numberfield','Allgemein/Angaben',9,0,1,1,'',1.00,''),
('stimmzettel','bh2','DE','Höhe 2','numberfield','Allgemein/Angaben',10,0,1,1,'',1.00,''),
('stimmzettel','ds_count','DE','ds_count','displayfield','Allgemein',30,1,0,0,'',1.00,''),
('stimmzettel','farbe','DE','Farbe','combobox_farben_rgb','Allgemein/Angaben',7,0,1,0,'',1.00,''),
('stimmzettel','id','DE','ID','displayfield','Allgemein/Satzinformationen',15,0,1,1,'',1.00,''),
('stimmzettel','insert_date','DE','Anlagedatum','displayfield','Allgemein/Satzinformationen',17,0,1,1,'',1.00,''),
('stimmzettel','insert_time','DE','Anlagezeit','displayfield','Allgemein/Satzinformationen',14,0,1,1,'',1.00,''),
('stimmzettel','kandidat_text_einzel','DE','kandidat_text_einzel','displayfield','Allgemein',34,1,0,0,'',1.00,''),
('stimmzettel','kandidat_text_mehr','DE','Kand. Texttyp','textfield','Allgemein/Angaben',8,0,1,1,'',1.00,''),
('stimmzettel','laufende_nummer_1_24__nach_zuordnung_wg_wb','DE','laufende_nummer_1_24__nach_zuordnung_wg_wb','displayfield','Allgemein',33,1,0,0,'',1.00,''),
('stimmzettel','login','DE','Login','displayfield','Allgemein/Satzinformationen',19,0,1,1,'',1.00,''),
('stimmzettel','name','DE','Name','textfield','Allgemein/Angaben',0,0,1,1,'',1.00,''),
('stimmzettel','ridx','DE','RIDX','displayfield','Allgemein/Satzinformationen',16,0,1,1,'',1.00,''),
('stimmzettel','sitzbindung','DE','Sitzbindung','numberfield','Allgemein/Angaben',6,0,1,1,'',1.00,''),
('stimmzettel','sitze','DE','Sitze','numberfield','Allgemein/Angaben',5,0,1,1,'',1.00,''),
('stimmzettel','typtitel','DE','Typtitel','textarea','Allgemein/Angaben',12,0,1,1,'',1.00,''),
('stimmzettel','ungueltig','DE','ungueltig','displayfield','Allgemein',31,1,0,0,'',1.00,''),
('stimmzettel','update_date','DE','Änderungsdatum','displayfield','Allgemein/Satzinformationen',18,0,1,1,'',1.00,''),
('stimmzettel','update_time','DE','Änderungszeit','displayfield','Allgemein/Satzinformationen',13,0,1,1,'',1.00,''),
('stimmzettel','wahlbezirk','DE','Wahlbezirk','combobox_wahlbezirk_ridx','Allgemein/Angaben',3,0,1,1,'',1.00,''),
('stimmzettel','wahlgruppe','DE','Wahlgruppe','combobox_wahlgruppe_ridx','Allgemein/Angaben',2,0,1,1,'',1.00,''),
('stimmzettel','wahltyp','DE','Wahltyp','combobox_wahltyp_ridx','Allgemein/Angaben',4,0,1,1,'',1.00,''),
('stimmzettel','xlink','DE','X-Link','textfield','Allgemein/Angaben',11,0,1,1,'',1.00,''),
('stimmzettel','zaehlung_1','DE','Anzahl Umschlag: ohne Stimmzettel','numberfield','Zählung/Angaben',21,0,1,1,'',1.00,''),
('stimmzettel','zaehlung_2','DE','Anzahl Umschlag: mit mehr als einem Stimmzettel','numberfield','Zählung/Angaben',22,0,1,1,'',1.00,''),
('stimmzettel','zaehlung_3','DE','Anzahl Umschlag: mit fremden Inhalt','numberfield','Zählung/Angaben',23,0,1,1,'',1.00,''),
('stimmzettel','zaehlung_4','DE','Anzahl Umschlag: mit Stimmzettel mit Enthaltung','numberfield','Zählung/Angaben',24,0,1,1,'',1.00,''),
('stimmzettel','zaehlung_5','DE','Anzahl Umschlag: mit beschaedigtem Stimmzettel','numberfield','Zählung/Angaben',25,0,1,1,'',1.00,''),
('stimmzettel','zaehlung_6','DE','Anzahl Stimmzettel mit Enthaltung','numberfield','Zählung/Angaben',26,0,1,1,'',1.00,''),
('stimmzettel','zaehlung_7','DE','Anzahl Stimmzettel mit Streichungen/ Vermerken','numberfield','Zählung/Angaben',27,0,1,1,'',1.00,''),
('stimmzettel','zaehlung_8','DE','Anzahl Stimmzettel mit mehr Kreuzen','numberfield','Zählung/Angaben',28,0,1,1,'',1.00,''),
('stimmzettel','zaehlung_9','DE','Anzahl Umschlag: SZ mit mehr Kreuzen','numberfield','Zählung/Angaben',29,0,1,1,'',1.00,'');
UNLOCK TABLES;
LOCK TABLES `ds_dropdownfields` WRITE;
INSERT IGNORE INTO `ds_dropdownfields` (`table_name`, `name`, `idfield`, `displayfield`, `filterconfig`) VALUES ('stimmzettel','RIDX','ridx','name','');
UNLOCK TABLES;
LOCK TABLES `ds_reference_tables` WRITE;
INSERT IGNORE INTO `ds_reference_tables` (`table_name`, `reference_table_name`, `columnsdef`, `constraint_name`, `active`, `searchable`, `autosync`, `position`, `path`, `existsreal`, `tabtitle`) VALUES ('stimmzettel','stimmzettelgruppen','{\"stimmzettel__stimmzettelgruppen\":\"stimmzettelgruppen__name\"}','fk_stimmzettel_stimmzettelgruppen',0,0,1,99999,'',0,''),
('stimmzettel','stimmzettelgruppen','{\"stimmzettel__stimmzettelgruppen\":\"stimmzettelgruppen__name\"}','fk_stimmzettel_stimmzettelgruppen',0,0,1,99999,'',0,''),
('stimmzettel','stimmzettelgruppen','{\"stimmzettel__stimmzettelgruppen\":\"stimmzettelgruppen__name\"}','fk_stimmzettel_stimmzettelgruppen',0,0,1,99999,'',0,''),
('stimmzettel','stimmzettelgruppen','{\"stimmzettel__stimmzettelgruppen\":\"stimmzettelgruppen__name\"}','fk_stimmzettel_stimmzettelgruppen',0,0,1,99999,'',0,''),
('stimmzettel','stimmzettelgruppen','{\"stimmzettel__stimmzettelgruppen\":\"stimmzettelgruppen__name\"}','fk_stimmzettel_stimmzettelgruppen',0,0,1,99999,'',0,''),
('stimmzettel','stimmzettelgruppen','{\"stimmzettel__stimmzettelgruppen\":\"stimmzettelgruppen__name\"}','fk_stimmzettel_stimmzettelgruppen',0,0,1,99999,'',0,''),
('stimmzettel','stimmzettelgruppen','{\"stimmzettel__stimmzettelgruppen\":\"stimmzettelgruppen__name\"}','fk_stimmzettel_stimmzettelgruppen',0,0,1,99999,'',0,''),
('stimmzettel','stimmzettelgruppen','{\"stimmzettel__stimmzettelgruppen\":\"stimmzettelgruppen__name\"}','fk_stimmzettel_stimmzettelgruppen',0,0,1,99999,'',0,''),
('stimmzettel','wahlbezirk','{\"wahlbezirk\":\"ridx\"}','fk_stimmzettel_wahlbezirk',0,0,0,999,'',0,''),
('stimmzettel','wahlgruppe','{\"wahlgruppe\":\"ridx\"}','fk_stimmzettel_wahlgruppe',0,0,0,999,'',0,''),
('stimmzettel','stimmzettelgruppen','{\"stimmzettel__stimmzettelgruppen\":\"stimmzettelgruppen__name\"}','fk_stimmzettel_stimmzettelgruppen',0,0,1,99999,'',0,''),
('stimmzettel','stimmzettelgruppen','{\"stimmzettel__stimmzettelgruppen\":\"stimmzettelgruppen__name\"}','fk_stimmzettel_stimmzettelgruppen',0,0,1,99999,'',0,''),
('stimmzettel','stimmzettelgruppen','{\"stimmzettel__stimmzettelgruppen\":\"stimmzettelgruppen__name\"}','fk_stimmzettel_stimmzettelgruppen',0,0,1,99999,'',0,''),
('stimmzettel','stimmzettelgruppen','{\"stimmzettel__stimmzettelgruppen\":\"stimmzettelgruppen__name\"}','fk_stimmzettel_stimmzettelgruppen',0,0,1,99999,'',0,''),
('stimmzettel','wahlbezirk','{\"wahlbezirk\":\"ridx\"}','fk_stimmzettel_wahlbezirk',0,0,0,999,'',0,''),
('stimmzettel','wahlgruppe','{\"wahlgruppe\":\"ridx\"}','fk_stimmzettel_wahlgruppe',0,0,0,999,'',0,''),
('stimmzettel','wahlbezirk','{\"wahlbezirk\":\"ridx\"}','fk_stimmzettel_wahlbezirk',0,0,0,999,'',0,''),
('stimmzettel','wahlgruppe','{\"wahlgruppe\":\"ridx\"}','fk_stimmzettel_wahlgruppe',0,0,0,999,'',0,''),
('stimmzettel','wahlbezirk','{\"wahlbezirk\":\"ridx\"}','fk_stimmzettel_wahlbezirk',0,0,0,999,'',1,''),
('stimmzettel','wahlgruppe','{\"wahlgruppe\":\"ridx\"}','fk_stimmzettel_wahlgruppe',0,0,0,999,'',1,'');
UNLOCK TABLES;
LOCK TABLES `ds_addcommands` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_access` WRITE;
INSERT IGNORE INTO `ds_access` (`role`, `table_name`, `read`, `write`, `delete`, `append` ) VALUES ('wahl_administration','stimmzettel',1,1,1,1 );
UNLOCK TABLES;
LOCK TABLES `ds` WRITE;
INSERT IGNORE INTO `ds` (`table_name`, `title`, `reorderfield`, `use_history`, `searchfield`, `displayfield`, `sortfield`, `searchany`, `hint`, `overview_tpl`, `sync_table`, `writetable`, `globalsearch`, `listselectionmodel`, `sync_view`, `syncable`, `cssstyle`, `alternativeformxtype`, `read_table`, `class_name`, `special_add_panel`, `existsreal`, `character_set_name`, `read_filter`, `listxtypeprefix`, `phpexporter`, `phpexporterfilename`, `combined`, `default_pagesize`, `allowForm`, `listviewbaseclass`, `showactionbtn`, `modelbaseclass`) VALUES ('stimmzettelgruppen','Stimmzettelgruppen','',0,'name','name','id',1,'','','','',0,'tualomultirowmodel','',0,'','','','Wahlsystem','',1,'','','listview','XlsxWriter','stimmzettelgruppen',0,1000,0,'Tualo.DataSets.ListView',1,'Tualo.DataSets.model.Basic');
UNLOCK TABLES;
LOCK TABLES `ds_column` WRITE;
INSERT IGNORE INTO `ds_column` (`table_name`, `column_name`, `default_value`, `default_max_value`, `default_min_value`, `update_value`, `is_primary`, `syncable`, `referenced_table`, `referenced_column_name`, `is_nullable`, `is_referenced`, `writeable`, `note`, `data_type`, `column_key`, `column_type`, `character_maximum_length`, `numeric_precision`, `numeric_scale`, `character_set_name`, `privileges`, `existsreal`, `deferedload`, `hint`, `fieldtype`) VALUES ('stimmzettelgruppen','id','',10000000,0,NULL,1,0,NULL,NULL,'NO','NO',1,'','int','PRI','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,'',''),
('stimmzettelgruppen','kostenstelle','',10000000,0,NULL,0,0,NULL,NULL,'NO','NO',1,'','int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,'',''),
('stimmzettelgruppen','mindestsitze','',10000000,0,NULL,0,0,NULL,NULL,'YES',NULL,1,'','int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,'',''),
('stimmzettelgruppen','name','',10000000,0,'',0,0,'','','YES','NO',1,'\'\'','varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('stimmzettelgruppen','ridx','',10000000,0,NULL,0,0,NULL,NULL,'YES','NO',1,'','varchar','UNI','varchar(12)',12,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('stimmzettelgruppen','sitze','',10000000,0,NULL,0,0,NULL,NULL,'YES','NO',1,'','int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,'',''),
('stimmzettelgruppen','stimmzettel','',10000000,0,NULL,0,0,NULL,NULL,'NO','NO',1,'','varchar','MUL','varchar(12)',12,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'','');
UNLOCK TABLES;
LOCK TABLES `ds_column_list_label` WRITE;
INSERT IGNORE INTO `ds_column_list_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `editor`, `position`, `summaryrenderer`, `renderer`, `summarytype`, `hidden`, `active`, `filterstore`, `grouped`, `flex`, `direction`, `align`, `listfiltertype`, `hint`) VALUES ('stimmzettelgruppen','id','DE','ID','gridcolumn','',0,'','','',1,1,'',0,1.00,'ASC','left','',''),
('stimmzettelgruppen','kostenstelle','DE','KST','gridcolumn','',1,'','','',1,1,'',0,1.00,'ASC','left','',''),
('stimmzettelgruppen','mindestsitze','DE','Mindestsitze','gridcolumn','',2,'','','',0,1,'',0,1.00,'','','','NULL'),
('stimmzettelgruppen','name','DE','Name','gridcolumn','',3,'','','',0,1,'',0,1.00,'ASC','left','',''),
('stimmzettelgruppen','ridx','DE','RIDX','gridcolumn','',4,'','','',1,1,'',0,1.00,'','','','NULL'),
('stimmzettelgruppen','sitze','DE','Sitze','gridcolumn','',5,'','','',0,1,'',0,1.00,'','','','NULL'),
('stimmzettelgruppen','stimmzettel','DE','Stimmzettel','gridcolumn','',6,'','','',0,1,'',0,1.00,'','','','NULL');
UNLOCK TABLES;
LOCK TABLES `ds_column_form_label` WRITE;
INSERT IGNORE INTO `ds_column_form_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `field_path`, `position`, `hidden`, `active`, `allowempty`, `fieldgroup`, `flex`, `hint`) VALUES ('stimmzettelgruppen','id','DE','ID','displayfield','Allgemein',0,0,1,0,'',1.00,''),
('stimmzettelgruppen','kostenstelle','DE','KST','displayfield','Allgemein',1,1,1,0,'',1.00,''),
('stimmzettelgruppen','mindestsitze','DE','Mindestsitze','number0','Allgemein',6,0,1,0,'',1.00,''),
('stimmzettelgruppen','name','DE','Name','textfield','Allgemein',3,0,1,0,'',1.00,''),
('stimmzettelgruppen','ridx','DE','RIDX','textfield','Allgemein',2,0,1,0,'',1.00,''),
('stimmzettelgruppen','sitze','DE','Sitze','number0','Allgemein',5,0,1,0,'',1.00,''),
('stimmzettelgruppen','stimmzettel','DE','Stimmzettel','combobox_stimmzettel_ridx','Allgemein',4,0,1,0,'',1.00,'');
UNLOCK TABLES;
LOCK TABLES `ds_dropdownfields` WRITE;
INSERT IGNORE INTO `ds_dropdownfields` (`table_name`, `name`, `idfield`, `displayfield`, `filterconfig`) VALUES ('stimmzettelgruppen','ridx','ridx','name',NULL);
UNLOCK TABLES;
LOCK TABLES `ds_reference_tables` WRITE;
INSERT IGNORE INTO `ds_reference_tables` (`table_name`, `reference_table_name`, `columnsdef`, `constraint_name`, `active`, `searchable`, `autosync`, `position`, `path`, `existsreal`, `tabtitle`) VALUES ('stimmzettelgruppen','stimmzettel','{\"stimmzettel\":\"ridx\"}','fk_stimmzettelgruppen_stimmzettel',1,0,0,999,'',1,''),
('stimmzettelgruppen','stimmzettel','{\"stimmzettel\":\"ridx\"}','fk_stimmzettelgruppen_stimmzettel',1,0,0,999,'',1,''),
('stimmzettelgruppen','stimmzettel','{\"stimmzettel\":\"ridx\"}','fk_stimmzettelgruppen_stimmzettel',1,0,0,999,'',1,''),
('stimmzettelgruppen','stimmzettel','{\"stimmzettel\":\"ridx\"}','fk_stimmzettelgruppen_stimmzettel',1,0,0,999,'',1,''),
('stimmzettelgruppen','stimmzettel','{\"stimmzettel\":\"ridx\"}','fk_stimmzettelgruppen_stimmzettel',1,0,0,999,'',1,''),
('stimmzettelgruppen','stimmzettel','{\"stimmzettel\":\"ridx\"}','fk_stimmzettelgruppen_stimmzettel',1,0,0,999,'',1,''),
('stimmzettelgruppen','stimmzettel','{\"stimmzettel\":\"ridx\"}','fk_stimmzettelgruppen_stimmzettel',1,0,0,999,'',1,''),
('stimmzettelgruppen','stimmzettel','{\"stimmzettel\":\"ridx\"}','fk_stimmzettelgruppen_stimmzettel',1,0,0,999,'',1,''),
('stimmzettelgruppen','stimmzettel','{\"stimmzettel\":\"ridx\"}','fk_stimmzettelgruppen_stimmzettel',1,0,0,999,'',1,''),
('stimmzettelgruppen','stimmzettel','{\"stimmzettel\":\"ridx\"}','fk_stimmzettelgruppen_stimmzettel',1,0,0,999,'',1,''),
('stimmzettelgruppen','stimmzettel','{\"stimmzettel\":\"ridx\"}','fk_stimmzettelgruppen_stimmzettel',1,0,0,999,'',1,''),
('stimmzettelgruppen','stimmzettel','{\"stimmzettel\":\"ridx\"}','fk_stimmzettelgruppen_stimmzettel',1,0,0,999,'',1,''),
('stimmzettelgruppen','stimmzettel','{\"stimmzettel\":\"ridx\"}','fk_stimmzettelgruppen_stimmzettel',1,0,0,999,'',1,''),
('stimmzettelgruppen','stimmzettel','{\"stimmzettel\":\"ridx\"}','fk_stimmzettelgruppen_stimmzettel',1,0,0,999,'',1,''),
('stimmzettelgruppen','stimmzettel','{\"stimmzettel\":\"ridx\"}','fk_stimmzettelgruppen_stimmzettel',1,0,0,999,'',1,''),
('stimmzettelgruppen','stimmzettel','{\"stimmzettel\":\"ridx\"}','fk_stimmzettelgruppen_stimmzettel',1,0,0,999,'',1,''),
('stimmzettelgruppen','stimmzettel','{\"stimmzettel\":\"ridx\"}','fk_stimmzettelgruppen_stimmzettel',1,0,0,999,'',1,''),
('stimmzettelgruppen','stimmzettel','{\"stimmzettel\":\"ridx\"}','fk_stimmzettelgruppen_stimmzettel',1,0,0,999,'',1,'');
UNLOCK TABLES;
LOCK TABLES `ds_addcommands` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_access` WRITE;
INSERT IGNORE INTO `ds_access` (`role`, `table_name`, `read`, `write`, `delete`, `append` ) VALUES ('wahl_administration','stimmzettelgruppen',1,1,1,1 );
UNLOCK TABLES;
LOCK TABLES `ds` WRITE;
INSERT IGNORE INTO `ds` (`table_name`, `title`, `reorderfield`, `use_history`, `searchfield`, `displayfield`, `sortfield`, `searchany`, `hint`, `overview_tpl`, `sync_table`, `writetable`, `globalsearch`, `listselectionmodel`, `sync_view`, `syncable`, `cssstyle`, `alternativeformxtype`, `read_table`, `class_name`, `special_add_panel`, `existsreal`, `character_set_name`, `read_filter`, `listxtypeprefix`, `phpexporter`, `phpexporterfilename`, `combined`, `default_pagesize`, `allowForm`, `listviewbaseclass`, `showactionbtn`, `modelbaseclass`) VALUES ('kandidaten','Kandidaten','',0,'anzeige_name','anzeige_name','barcode',1,'','1','0','',0,'tualomultirowmodel','',0,'1','','view_readtable_kandidaten','Wahlsystem','',1,'','','listview','XlsxWriter','kandidaten-{DATE}',0,10000,0,'Tualo.DataSets.ListView',1,'Tualo.DataSets.model.Basic');
UNLOCK TABLES;
LOCK TABLES `ds_column` WRITE;
INSERT IGNORE INTO `ds_column` (`table_name`, `column_name`, `default_value`, `default_max_value`, `default_min_value`, `update_value`, `is_primary`, `syncable`, `referenced_table`, `referenced_column_name`, `is_nullable`, `is_referenced`, `writeable`, `note`, `data_type`, `column_key`, `column_type`, `character_maximum_length`, `numeric_precision`, `numeric_scale`, `character_set_name`, `privileges`, `existsreal`, `deferedload`, `hint`, `fieldtype`) VALUES ('kandidaten','aktiv','1',NULL,NULL,NULL,0,NULL,NULL,NULL,'YES',NULL,1,NULL,'tinyint','','tinyint(4)',NULL,3,0,NULL,'select,insert,update,references',1,NULL,NULL,''),
('kandidaten','anrede','',NULL,NULL,NULL,0,NULL,NULL,NULL,'YES',NULL,1,NULL,'varchar','','varchar(100)',100,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL,''),
('kandidaten','anzeige_name',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'YES',NULL,0,NULL,'text','','text',65535,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL,''),
('kandidaten','barcode','{#serial}',NULL,NULL,NULL,0,NULL,NULL,NULL,'YES',NULL,1,NULL,'varchar','','varchar(5)',5,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL,''),
('kandidaten','branche','',NULL,NULL,NULL,0,NULL,NULL,NULL,'YES',NULL,1,NULL,'varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL,''),
('kandidaten','email','',NULL,NULL,NULL,0,NULL,NULL,NULL,'YES',NULL,1,NULL,'varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL,''),
('kandidaten','firma1','',NULL,NULL,NULL,0,NULL,NULL,NULL,'YES',NULL,1,NULL,'varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL,''),
('kandidaten','firma2','',NULL,NULL,NULL,0,NULL,NULL,NULL,'YES',NULL,1,NULL,'varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL,''),
('kandidaten','firma3','',NULL,NULL,NULL,0,NULL,NULL,NULL,'YES',NULL,1,NULL,'varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL,''),
('kandidaten','firma4','',NULL,NULL,NULL,0,NULL,NULL,NULL,'YES',NULL,1,NULL,'varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL,''),
('kandidaten','firma_ort','',NULL,NULL,NULL,0,NULL,NULL,NULL,'YES',NULL,1,NULL,'varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL,''),
('kandidaten','firma_plz','',NULL,NULL,NULL,0,NULL,NULL,NULL,'YES',NULL,1,NULL,'varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL,''),
('kandidaten','firma_strasse','',NULL,NULL,NULL,0,NULL,NULL,NULL,'YES',NULL,1,NULL,'varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL,''),
('kandidaten','firmen_identnummer','',NULL,NULL,NULL,0,NULL,NULL,NULL,'YES',NULL,1,NULL,'varchar','','varchar(15)',15,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL,''),
('kandidaten','funktion1','',NULL,NULL,NULL,0,NULL,NULL,NULL,'YES',NULL,1,NULL,'varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL,''),
('kandidaten','funktion2','',NULL,NULL,NULL,0,NULL,NULL,NULL,'YES',NULL,1,NULL,'varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL,''),
('kandidaten','funktion3','',NULL,NULL,NULL,0,NULL,NULL,NULL,'YES',NULL,1,NULL,'varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL,''),
('kandidaten','geburtsdatum','',NULL,NULL,NULL,0,NULL,NULL,NULL,'YES',NULL,1,NULL,'date','','date',NULL,NULL,NULL,NULL,'select,insert,update,references',1,NULL,NULL,''),
('kandidaten','geburtsjahr','',NULL,NULL,NULL,0,NULL,NULL,NULL,'YES',NULL,1,NULL,'varchar','','varchar(5)',5,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL,''),
('kandidaten','geschlecht','',NULL,NULL,NULL,0,NULL,NULL,NULL,'YES',NULL,1,NULL,'varchar','','varchar(5)',5,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL,''),
('kandidaten','id','{#serial}',NULL,NULL,NULL,1,NULL,NULL,NULL,'NO',NULL,1,NULL,'int','PRI','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,NULL,NULL,''),
('kandidaten','ist_gewaehlt','',NULL,NULL,NULL,0,NULL,NULL,NULL,'YES',NULL,1,NULL,'tinyint','','tinyint(4)',NULL,3,0,NULL,'select,insert,update,references',1,NULL,NULL,''),
('kandidaten','kooptiert','',NULL,NULL,NULL,0,NULL,NULL,NULL,'YES',NULL,1,NULL,'tinyint','','tinyint(4)',NULL,3,0,NULL,'select,insert,update,references',1,NULL,NULL,''),
('kandidaten','kostenstelle','0',NULL,NULL,NULL,1,NULL,NULL,NULL,'YES',NULL,1,NULL,'int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,NULL,NULL,''),
('kandidaten','losnummer','0',NULL,NULL,NULL,0,NULL,NULL,NULL,'YES',NULL,1,NULL,'int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,NULL,NULL,''),
('kandidaten','losnummer_stimmzettelgruppe','0',NULL,NULL,NULL,0,NULL,NULL,NULL,'YES',NULL,1,NULL,'int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,NULL,NULL,''),
('kandidaten','losung_verloren','',NULL,NULL,NULL,0,NULL,NULL,NULL,'YES',NULL,1,NULL,'tinyint','','tinyint(4)',NULL,3,0,NULL,'select,insert,update,references',1,NULL,NULL,''),
('kandidaten','nachname','',NULL,NULL,NULL,0,NULL,NULL,NULL,'YES',NULL,1,NULL,'varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL,''),
('kandidaten','nachruecker','',NULL,NULL,NULL,0,NULL,NULL,NULL,'YES',NULL,1,NULL,'tinyint','','tinyint(4)',NULL,3,0,NULL,'select,insert,update,references',1,NULL,NULL,''),
('kandidaten','personen_identnummer','',NULL,NULL,NULL,0,NULL,NULL,NULL,'YES',NULL,1,NULL,'varchar','','varchar(15)',15,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL,''),
('kandidaten','ridx','null',NULL,NULL,NULL,0,NULL,NULL,NULL,'YES',NULL,1,NULL,'varchar','UNI','varchar(12)',12,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL,''),
('kandidaten','sitze',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'YES',NULL,0,NULL,'int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,NULL,NULL,''),
('kandidaten','stimmzettelgruppen','',NULL,NULL,NULL,0,NULL,NULL,NULL,'YES',NULL,1,NULL,'varchar','MUL','varchar(12)',12,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL,''),
('kandidaten','stimmzettelgruppen_text',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'YES',NULL,0,NULL,'varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL,''),
('kandidaten','telefon','',NULL,NULL,NULL,0,NULL,NULL,NULL,'YES',NULL,1,NULL,'varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL,''),
('kandidaten','titel','',NULL,NULL,NULL,0,NULL,NULL,NULL,'YES',NULL,1,NULL,'varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL,''),
('kandidaten','vergeben',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'NO',NULL,0,NULL,'bigint','','bigint(21)',NULL,19,0,NULL,'select,insert,update,references',1,NULL,NULL,''),
('kandidaten','vorname','',NULL,NULL,NULL,0,NULL,NULL,NULL,'YES',NULL,1,NULL,'varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL,''),
('kandidaten','www','',NULL,NULL,NULL,0,NULL,NULL,NULL,'YES',NULL,1,NULL,'varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL,'');
UNLOCK TABLES;
LOCK TABLES `ds_column_list_label` WRITE;
INSERT IGNORE INTO `ds_column_list_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `editor`, `position`, `summaryrenderer`, `renderer`, `summarytype`, `hidden`, `active`, `filterstore`, `grouped`, `flex`, `direction`, `align`, `listfiltertype`, `hint`) VALUES ('kandidaten','aktiv','DE','Aktiv','gridcolumn','',0,'','','',1,1,'',0,1.00,'ASC','left','',''),
('kandidaten','anrede','DE','anrede','gridcolumn','',47,'','','',1,0,'',0,1.00,'','','',''),
('kandidaten','anzeige_name','DE','anzeige_name','gridcolumn','',28,'','','',1,1,'',0,1.00,'ASC','left','',''),
('kandidaten','aussenwirtschaftssausschuss','DE','aussenwirtschaftssausschuss','gridcolumn','',34,'','','',1,1,'',0,1.00,'','','',''),
('kandidaten','barcode','DE','Barcode','gridcolumn','',7,'','','',0,1,'',0,1.00,'ASC','left','',''),
('kandidaten','barcodebild','DE','Barcodebild','tualoimagedocumentcolumn','',22,'','','',1,1,'',0,1.00,'','','','NULL'),
('kandidaten','berufsbildungsausschuss','DE','berufsbildungsausschuss','gridcolumn','',51,'','','',1,1,'',0,1.00,'','','',''),
('kandidaten','branche','DE','branche','gridcolumn','',33,'','','',1,0,'',0,1.00,'','','',''),
('kandidaten','email','DE','E-Mail','gridcolumn','',5,'','','',1,1,'',0,1.00,'ASC','left','',''),
('kandidaten','finanzsteuerausschuss','DE','finanzsteuerausschuss','gridcolumn','',48,'','','',1,1,'',0,1.00,'','','',''),
('kandidaten','firma1','DE','Firma 1','gridcolumn','',9,'','','',0,1,'',0,1.00,'ASC','left','',''),
('kandidaten','firma2','DE','Firma 2','gridcolumn','',10,'','','',0,1,'',0,1.00,'','','','NULL'),
('kandidaten','firma3','DE','Firma 3','gridcolumn','',11,'','','',1,1,'',0,1.00,'ASC','left','',''),
('kandidaten','firma4','DE','Firma 4','gridcolumn','',12,'','','',1,1,'',0,1.00,'ASC','left','',''),
('kandidaten','firma_ort','DE','Ort','gridcolumn','',15,'','','',1,1,'',0,1.00,'ASC','left','',''),
('kandidaten','firma_plz','DE','PLZ','gridcolumn','',14,'','','',1,1,'',0,1.00,'ASC','left','',''),
('kandidaten','firma_strasse','DE','Straße','gridcolumn','',13,'','','',1,1,'',0,1.00,'ASC','left','',''),
('kandidaten','firmen_identnummer','DE','firmen_identnummer','gridcolumn','',41,'','','',1,1,'',0,1.00,'','','',''),
('kandidaten','foto','DE','foto','gridcolumn','',46,'','','',1,0,'',0,1.00,'','','',''),
('kandidaten','funktion1','DE','Funktion 1','gridcolumn','',16,'','','',1,1,'',0,1.00,'ASC','left','',''),
('kandidaten','funktion2','DE','Funktion 2','gridcolumn','',17,'','','',1,1,'',0,1.00,'ASC','left','',''),
('kandidaten','funktion3','DE','Funktion 3','gridcolumn','',18,'','','',1,1,'',0,1.00,'ASC','left','',''),
('kandidaten','geburtsdatum','DE','geburtsdatum','gridcolumn','',50,'','','',1,1,'',0,1.00,'','','',''),
('kandidaten','geburtsjahr','DE','geburtsjahr','gridcolumn','',29,'','','',1,0,'',0,1.00,'','','',''),
('kandidaten','geschlecht','DE','geschlecht','gridcolumn','',38,'','','',1,1,'',0,1.00,'','','',''),
('kandidaten','handelsausschuss','DE','handelsausschuss','gridcolumn','',42,'','','',1,1,'',0,1.00,'','','',''),
('kandidaten','id','DE','ID','gridcolumn','',25,'','','',0,1,'',0,1.00,'ASC','left','',''),
('kandidaten','id_ihk','DE','id_ihk','gridcolumn','',31,'','','',1,0,'',0,1.00,'','','',''),
('kandidaten','imagebild','DE','Imagebild','gridcolumn','',24,'','','',1,0,'',0,1.00,'ASC','left','',''),
('kandidaten','industrieausschuss','DE','industrieausschuss','gridcolumn','',45,'','','',1,1,'',0,1.00,'','','',''),
('kandidaten','kandidaten_bild','DE','Kandidaten-Bild','gridcolumn','',49,'','','',1,1,'',0,1.00,'','','','NULL'),
('kandidaten','kmunehmensausschuss','DE','kmunehmensausschuss','gridcolumn','',30,'','','',1,1,'',0,1.00,'','','',''),
('kandidaten','kooptiert','DE','kooptiert','gridcolumn','',999,'','','',1,1,'',0,1.00,'','','','NULL'),
('kandidaten','kostenstelle','DE','Unternummer','gridcolumn','',27,'','','',1,1,'',0,1.00,'ASC','left','',''),
('kandidaten','losnummer','DE','losnummer','gridcolumn','',999,'','','',1,1,'',0,1.00,'','','','NULL'),
('kandidaten','losnummer_stimmzettelgruppe','DE','losnummer_stimmzettelgruppe','gridcolumn','',999,'','','',1,1,'',0,1.00,'','','','NULL'),
('kandidaten','losung_verloren','DE','losung_verloren','checkcolumn','',999,'','','',1,1,'',0,1.00,'','','','\'\''),
('kandidaten','mitglieddervv','DE','mitglieddervv','gridcolumn','',43,'','','',1,1,'',0,1.00,'','','',''),
('kandidaten','nachname','DE','Nachname','gridcolumn','',3,'','','',0,1,'',0,1.00,'ASC','left','',''),
('kandidaten','nachruecker','DE','nachruecker','checkcolumn','',999,'','','',1,1,'',0,1.00,'','','','\'\''),
('kandidaten','personen_identnummer','DE','personen_identnummer','gridcolumn','',39,'','','',1,0,'',0,1.00,'','','',''),
('kandidaten','portaitbild','DE','Portrait','tualoimagedocumentcolumn','',23,'','','',1,1,'',0,1.00,'','','','NULL'),
('kandidaten','ridx','DE','RIDX','gridcolumn','',26,'','','',1,1,'',0,1.00,'ASC','left','',''),
('kandidaten','sitze','DE','sitze','gridcolumn','',36,'','','',1,0,'',0,1.00,'','','',''),
('kandidaten','statement','DE','Statement','gridcolumn','',19,'1','1','1',1,1,'1',0,1.00,'ASC','left','',''),
('kandidaten','statement_freigabe','DE','Freigabe','gridcolumn','',21,'','','',1,0,'',0,1.00,'ASC','left','',''),
('kandidaten','stimmzettelgruppen','DE','Stimmzettelgruppe','gridcolumn','',8,'','','',1,1,'',0,1.00,'ASC','left','',''),
('kandidaten','stimmzettelgruppen_text','DE','stimmzettelgruppen_text','gridcolumn','',35,'','','',1,1,'',0,1.00,'','','',''),
('kandidaten','telefon','DE','Telefon','gridcolumn','',4,'','','',1,1,'',0,1.00,'ASC','left','',''),
('kandidaten','titel','DE','Titel','gridcolumn','',1,'','','',0,1,'',0,1.00,'ASC','left','',''),
('kandidaten','titel2','DE','titel2','gridcolumn','',999,'','','',1,1,'',0,1.00,'','','','NULL'),
('kandidaten','tourismusausschuss','DE','tourismusausschuss','gridcolumn','',32,'','','',1,1,'',0,1.00,'','','',''),
('kandidaten','umweltenergieausschuss','DE','umweltenergieausschuss','gridcolumn','',37,'','','',1,1,'',0,1.00,'','','',''),
('kandidaten','vergeben','DE','vergeben','gridcolumn','',40,'','','',1,0,'',0,1.00,'','','',''),
('kandidaten','verkehrsausschuss','DE','verkehrsausschuss','gridcolumn','',44,'','','',1,1,'',0,1.00,'','','',''),
('kandidaten','vorname','DE','Vorname','gridcolumn','',2,'','','',0,1,'',0,1.00,'ASC','left','',''),
('kandidaten','www','DE','Internet-Adresse','gridcolumn','',6,'','','',1,1,'',0,1.00,'ASC','left','',''),
('kandidaten','www2','DE','Internet-Adresse','gridcolumn','',20,'','','',1,1,'',0,1.00,'ASC','left','','');
UNLOCK TABLES;
LOCK TABLES `ds_column_form_label` WRITE;
INSERT IGNORE INTO `ds_column_form_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `field_path`, `position`, `hidden`, `active`, `allowempty`, `fieldgroup`, `flex`, `hint`) VALUES ('kandidaten','aktiv','DE','Aktiv','checkbox','Allgemein/Kandidat',0,0,1,1,'',1.00,''),
('kandidaten','anrede','DE','Kreis','textfield','Firma/Angaben',1,1,0,1,'',1.00,''),
('kandidaten','anzeige_name','DE','anzeige_name','displayfield','Allgemein',37,1,1,1,'',1.00,''),
('kandidaten','aussenwirtschaftssausschuss','DE','Fotofreigabe','checkbox','Bilder',39,0,1,1,'',1.00,''),
('kandidaten','barcode','DE','Barcode','textfield','Allgemein/Stimmzettel',11,0,1,1,'',1.00,''),
('kandidaten','barcodebild','DE','Barcodebild','dsdocumentfield','Bilder',29,0,1,1,'',1.00,''),
('kandidaten','berufsbildungsausschuss','DE','Berufsbildung','checkbox','Zusatz/Ausschuss',40,1,1,1,'',1.00,''),
('kandidaten','branche','DE','VV-BGKL ab 20','textfield','Firma/Angaben',23,1,0,1,'',1.00,''),
('kandidaten','email','DE','E-Mail','textfield','Allgemein/Kandidat',7,0,1,1,'',1.00,''),
('kandidaten','finanzsteuerausschuss','DE','Finanz- und Steuer','checkbox','Zusatz/Ausschuss',42,1,1,1,'',1.00,''),
('kandidaten','firma1','DE','Firma 1','textfield','Firma/Angaben',13,0,1,1,'',1.00,''),
('kandidaten','firma2','DE','Firma 2','textfield','Firma/Angaben',14,0,1,1,'',1.00,''),
('kandidaten','firma3','DE','Firma 3','textfield','Firma/Angaben',15,0,1,1,'',1.00,''),
('kandidaten','firma4','DE','Firma 4','textfield','Firma/Angaben',16,0,1,1,'',1.00,''),
('kandidaten','firma_ort','DE','Ort','textfield','Firma/Angaben',19,0,1,1,'ort',3.00,'\'\''),
('kandidaten','firma_plz','DE','PLZ','textfield','Firma/Angaben',18,0,1,1,'ort',1.00,'\'\''),
('kandidaten','firma_strasse','DE','Straße','textfield','Firma/Angaben',17,0,1,1,'',1.00,''),
('kandidaten','firmen_identnummer','DE','Fa-Id.-Nr.','textfield','Firma/Angaben',24,0,1,1,'',1.00,''),
('kandidaten','foto','DE','Foto','textfield','Allgemein/Extra',48,0,0,1,'',1.00,''),
('kandidaten','funktion1','DE','Funktion','textfield','Firma/Angaben',20,0,1,1,'',1.00,''),
('kandidaten','funktion2','DE','Kreis','textfield','Firma/Angaben',21,1,0,1,'',1.00,''),
('kandidaten','funktion3','DE','VV-BGKL bis 19','textfield','Firma/Angaben',22,1,0,1,'',1.00,''),
('kandidaten','geburtsdatum','DE','Geburtsdatum','datefield','Allgemein/Kandidat',10,0,1,1,'',1.00,''),
('kandidaten','geburtsjahr','DE','Geburtsjahr','textfield','Allgemein/Extra',53,1,0,1,'',1.00,''),
('kandidaten','geschlecht','DE','geschlecht','displayfield','Allgemein/Extra',52,1,0,1,'',1.00,''),
('kandidaten','handelsausschuss','DE','Handel','checkbox','Zusatz/Ausschuss',43,1,1,1,'',1.00,''),
('kandidaten','id','DE','ID','displayfield','Satzinformationen/Angaben',34,0,1,1,'',1.00,''),
('kandidaten','id_ihk','DE','ID (IHK)','textfield','Allgemein/Extra',54,1,0,1,'',1.00,''),
('kandidaten','imagebild','DE','Imagebild','dsdocumentfield','Bilder',31,1,1,1,'',1.00,''),
('kandidaten','industrieausschuss','DE','Industrie','checkbox','Zusatz/Ausschuss',44,1,1,1,'',1.00,''),
('kandidaten','ist_gewaehlt','DE','ist_gewaehlt','displayfield','Allgemein',999,1,0,1,'',1.00,''),
('kandidaten','kandidaten_bild','DE','kandidaten_bild','textfield','Allgemein/Extra',51,1,0,1,'',1.00,''),
('kandidaten','kandidaten_bild2','DE','kandidaten_bild2','displayfield','Allgemein',55,1,0,1,'',1.00,''),
('kandidaten','kmunehmensausschuss','DE','Einpersonen- und Kleinunternehmen','checkbox','Zusatz/Ausschuss',41,1,1,1,'',1.00,''),
('kandidaten','kooptiert','DE','Kooptiert','checkbox','Auszählung/Losungen',999,0,1,1,'',1.00,''),
('kandidaten','kostenstelle','DE','Unternummer','displayfield','Satzinformationen/Angaben',35,0,1,1,'',1.00,''),
('kandidaten','losnummer','DE','Stimmzettel-Los','number0','Auszählung/Losungen',999,0,1,1,'',1.00,''),
('kandidaten','losnummer_stimmzettelgruppe','DE','Stimmzettelgruppen-Los','number0','Auszählung/Losungen',999,0,1,1,'',1.00,''),
('kandidaten','losung_verloren','DE','losung_verloren','checkbox','Auszählung/Entscheidung',50,0,1,1,'',1.00,''),
('kandidaten','mitglieddervv','DE','Wahlwerbung','checkbox','Zusatz/Satz',28,0,1,1,'',1.00,''),
('kandidaten','nachname','DE','Nachname','textfield','Allgemein/Kandidat',5,0,1,1,'',1.00,''),
('kandidaten','nachruecker','DE','nachruecker','checkbox','Auszählung/Entscheidung',49,0,1,1,'',1.00,''),
('kandidaten','personen_identnummer','DE','Personen-ID.Nr','textfield','Allgemein/Kandidat',9,0,1,1,'',1.00,''),
('kandidaten','portaitbild','DE','Portrait','dsdocumentfield','Bilder',30,0,1,1,'',1.00,''),
('kandidaten','ridx','DE','RIDX','displayfield','Satzinformationen/Angaben',36,0,1,1,'',1.00,''),
('kandidaten','sitze','DE','mögliche Sitze','displayfield','Satzinformationen/Angaben',32,1,0,1,'',1.00,''),
('kandidaten','statement','DE','Statement','textarea','Zusatz/Satz',25,0,1,1,'',1.00,''),
('kandidaten','statement_freigabe','DE','Freigabe','checkbox','Zusatz/Satz',26,0,0,1,'',1.00,''),
('kandidaten','stimmzettelgruppen','DE','Stimmzettelgruppe','combobox_stimmzettelgruppen_ridx','Allgemein/Stimmzettel',12,0,1,1,'',1.00,''),
('kandidaten','stimmzettelgruppen_text','DE','stimmzettelgruppen_text','displayfield','Allgemein',38,1,0,1,'',1.00,''),
('kandidaten','telefon','DE','Telefon','textfield','Allgemein/Kandidat',6,0,1,1,'',1.00,''),
('kandidaten','titel','DE','Titel','textfield','Allgemein/Kandidat',2,0,1,1,'',1.00,''),
('kandidaten','titel2','DE','Pers. Ident-Nr.','textfield','Allgemein/Kandidat',3,1,0,1,'',1.00,''),
('kandidaten','tourismusausschuss','DE','Tourismus','checkbox','Zusatz/Ausschuss',45,1,1,1,'',1.00,''),
('kandidaten','umweltenergieausschuss','DE','Umwelt- und Energie','checkbox','Zusatz/Ausschuss',46,1,1,1,'',1.00,''),
('kandidaten','vergeben','DE','Sitze vergeben','displayfield','Satzinformationen/Angaben',33,1,0,1,'',1.00,''),
('kandidaten','verkehrsausschuss','DE','Verkehr','checkbox','Zusatz/Ausschuss',47,1,1,1,'',1.00,''),
('kandidaten','vorname','DE','Vorname','textfield','Allgemein/Kandidat',4,0,1,1,'',1.00,''),
('kandidaten','www','DE','Kreuzbild','textfield','Allgemein/Kandidat',8,1,0,1,'',1.00,''),
('kandidaten','www2','DE','WWW2','textfield','Zusatz/Satz',27,1,0,1,'',1.00,'');
UNLOCK TABLES;
LOCK TABLES `ds_dropdownfields` WRITE;
INSERT IGNORE INTO `ds_dropdownfields` (`table_name`, `name`, `idfield`, `displayfield`, `filterconfig`) VALUES ('kandidaten','RIDX','ridx','name',NULL);
UNLOCK TABLES;
LOCK TABLES `ds_reference_tables` WRITE;
INSERT IGNORE INTO `ds_reference_tables` (`table_name`, `reference_table_name`, `columnsdef`, `constraint_name`, `active`, `searchable`, `autosync`, `position`, `path`, `existsreal`, `tabtitle`) VALUES ('kandidaten','stimmzettel','{\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\"}','',0,0,1,99999,'',0,''),
('kandidaten','stimmzettel','{\"kandidaten__stimmzettel\":\"stimmzettel__ridx\"}','kandidaten_ibfk_1',0,0,1,99999,'',0,''),
('kandidaten','stimmzettel','{\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\"}','',0,0,1,99999,'',0,''),
('kandidaten','stimmzettel','{\"kandidaten__stimmzettel\":\"stimmzettel__ridx\"}','kandidaten_ibfk_1',0,0,1,99999,'',0,''),
('kandidaten','stimmzettel','{\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\"}','',0,0,1,99999,'',0,''),
('kandidaten','stimmzettel','{\"kandidaten__stimmzettel\":\"stimmzettel__ridx\"}','kandidaten_ibfk_1',0,0,1,99999,'',0,''),
('kandidaten','stimmzettel','{\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\"}','',0,0,1,99999,'',0,''),
('kandidaten','stimmzettel','{\"kandidaten__stimmzettel\":\"stimmzettel__ridx\"}','kandidaten_ibfk_1',0,0,1,99999,'',0,''),
('kandidaten','stimmzettel','{\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\"}','',0,0,1,99999,'',0,''),
('kandidaten','stimmzettel','{\"kandidaten__stimmzettel\":\"stimmzettel__ridx\"}','kandidaten_ibfk_1',0,0,1,99999,'',0,''),
('kandidaten','stimmzettel','{\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\"}','',0,0,1,99999,'',0,''),
('kandidaten','stimmzettel','{\"kandidaten__stimmzettel\":\"stimmzettel__ridx\"}','kandidaten_ibfk_1',0,0,1,99999,'',0,''),
('kandidaten','stimmzettel','{\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\"}','',0,0,1,99999,'',0,''),
('kandidaten','stimmzettel','{\"kandidaten__stimmzettel\":\"stimmzettel__ridx\"}','kandidaten_ibfk_1',0,0,1,99999,'',0,''),
('kandidaten','stimmzettel','{\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\"}','',0,0,1,99999,'',0,''),
('kandidaten','stimmzettel','{\"kandidaten__stimmzettel\":\"stimmzettel__ridx\"}','kandidaten_ibfk_1',0,0,1,99999,'',0,''),
('kandidaten','stimmzettel','{\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\"}','',0,0,1,99999,'',0,''),
('kandidaten','stimmzettel','{\"kandidaten__stimmzettel\":\"stimmzettel__ridx\"}','kandidaten_ibfk_1',0,0,1,99999,'',0,''),
('kandidaten','stimmzettel','{\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\"}','',0,0,1,99999,'',0,''),
('kandidaten','stimmzettel','{\"kandidaten__stimmzettel\":\"stimmzettel__ridx\"}','kandidaten_ibfk_1',0,0,1,99999,'',0,''),
('kandidaten','stimmzettel','{\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\"}','',0,0,1,99999,'',0,''),
('kandidaten','stimmzettel','{\"kandidaten__stimmzettel\":\"stimmzettel__ridx\"}','kandidaten_ibfk_1',0,0,1,99999,'',0,''),
('kandidaten','stimmzettel','{\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\"}','',0,0,1,99999,'',0,''),
('kandidaten','stimmzettel','{\"kandidaten__stimmzettel\":\"stimmzettel__ridx\"}','kandidaten_ibfk_1',0,0,1,99999,'',0,''),
('kandidaten','stimmzettelgruppen','{\"stimmzettelgruppen\":\"ridx\"}','fk_kandidaten_stimmzettelgruppen',1,0,0,999,'',1,''),
('kandidaten','stimmzettelgruppen','{\"stimmzettelgruppen\":\"ridx\"}','fk_kandidaten_stimmzettelgruppen',1,0,0,999,'',1,''),
('kandidaten','stimmzettelgruppen','{\"stimmzettelgruppen\":\"ridx\"}','fk_kandidaten_stimmzettelgruppen',1,0,0,999,'',1,''),
('kandidaten','stimmzettelgruppen','{\"stimmzettelgruppen\":\"ridx\"}','fk_kandidaten_stimmzettelgruppen',1,0,0,999,'',1,''),
('kandidaten','stimmzettelgruppen','{\"stimmzettelgruppen\":\"ridx\"}','fk_kandidaten_stimmzettelgruppen',1,0,0,999,'',1,''),
('kandidaten','stimmzettelgruppen','{\"stimmzettelgruppen\":\"ridx\"}','fk_kandidaten_stimmzettelgruppen',1,0,0,999,'',1,''),
('kandidaten','stimmzettelgruppen','{\"stimmzettelgruppen\":\"ridx\"}','fk_kandidaten_stimmzettelgruppen',1,0,0,999,'',1,''),
('kandidaten','stimmzettelgruppen','{\"stimmzettelgruppen\":\"ridx\"}','fk_kandidaten_stimmzettelgruppen',1,0,0,999,'',1,''),
('kandidaten','stimmzettelgruppen','{\"stimmzettelgruppen\":\"ridx\"}','fk_kandidaten_stimmzettelgruppen',1,0,0,999,'',1,''),
('kandidaten','stimmzettelgruppen','{\"stimmzettelgruppen\":\"ridx\"}','fk_kandidaten_stimmzettelgruppen',1,0,0,999,'',1,''),
('kandidaten','stimmzettelgruppen','{\"stimmzettelgruppen\":\"ridx\"}','fk_kandidaten_stimmzettelgruppen',1,0,0,999,'',1,''),
('kandidaten','stimmzettelgruppen','{\"stimmzettelgruppen\":\"ridx\"}','fk_kandidaten_stimmzettelgruppen',1,0,0,999,'',1,''),
('kandidaten','stimmzettelgruppen','{\"stimmzettelgruppen\":\"ridx\"}','fk_kandidaten_stimmzettelgruppen',1,0,0,999,'',1,''),
('kandidaten','stimmzettelgruppen','{\"stimmzettelgruppen\":\"ridx\"}','fk_kandidaten_stimmzettelgruppen',1,0,0,999,'',1,''),
('kandidaten','stimmzettelgruppen','{\"stimmzettelgruppen\":\"ridx\"}','fk_kandidaten_stimmzettelgruppen',1,0,0,999,'',1,''),
('kandidaten','stimmzettelgruppen','{\"stimmzettelgruppen\":\"ridx\"}','fk_kandidaten_stimmzettelgruppen',1,0,0,999,'',1,''),
('kandidaten','stimmzettelgruppen','{\"stimmzettelgruppen\":\"ridx\"}','fk_kandidaten_stimmzettelgruppen',1,0,0,999,'',1,'');
UNLOCK TABLES;
LOCK TABLES `ds_addcommands` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_access` WRITE;
INSERT IGNORE INTO `ds_access` (`role`, `table_name`, `read`, `write`, `delete`, `append` ) VALUES ('wahl_administration','kandidaten',1,1,1,1 );
UNLOCK TABLES;
LOCK TABLES `ds` WRITE;
INSERT IGNORE INTO `ds` (`table_name`, `title`, `reorderfield`, `use_history`, `searchfield`, `displayfield`, `sortfield`, `searchany`, `hint`, `overview_tpl`, `sync_table`, `writetable`, `globalsearch`, `listselectionmodel`, `sync_view`, `syncable`, `cssstyle`, `alternativeformxtype`, `read_table`, `class_name`, `special_add_panel`, `existsreal`, `character_set_name`, `read_filter`, `listxtypeprefix`, `phpexporter`, `phpexporterfilename`, `combined`, `default_pagesize`, `allowForm`, `listviewbaseclass`, `showactionbtn`, `modelbaseclass`) VALUES ('wahlruecklauf_felder','wahlruecklauf_felder','pos',0,'name','name','name',1,'','','','',1,'','',0,'','','','Wahlsystem','',1,'','','listview','XlsxWriter','wahlruecklauffelder',0,1000,0,'Tualo.DataSets.ListView',1,'Tualo.DataSets.model.Basic');
UNLOCK TABLES;
LOCK TABLES `ds_column` WRITE;
INSERT IGNORE INTO `ds_column` (`table_name`, `column_name`, `default_value`, `default_max_value`, `default_min_value`, `update_value`, `is_primary`, `syncable`, `referenced_table`, `referenced_column_name`, `is_nullable`, `is_referenced`, `writeable`, `note`, `data_type`, `column_key`, `column_type`, `character_maximum_length`, `numeric_precision`, `numeric_scale`, `character_set_name`, `privileges`, `existsreal`, `deferedload`, `hint`, `fieldtype`) VALUES ('wahlruecklauf_felder','aktiv','1',0,0,'',0,0,NULL,NULL,'YES','NO',1,'','varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('wahlruecklauf_felder','id','{#serial}',10000,1,'',1,0,NULL,NULL,'NO','NO',1,'','int','PRI','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,'',''),
('wahlruecklauf_felder','insert_date','null',0,0,'',0,0,NULL,NULL,'YES','NO',1,'','date','','date',NULL,NULL,NULL,NULL,'select,insert,update,references',1,0,'',''),
('wahlruecklauf_felder','insert_time','null',0,0,'',0,0,NULL,NULL,'YES','NO',1,'','time','','time',NULL,NULL,NULL,NULL,'select,insert,update,references',1,0,'',''),
('wahlruecklauf_felder','kostenstelle','0',0,0,'',1,0,NULL,NULL,'NO','NO',1,'','int','PRI','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,'',''),
('wahlruecklauf_felder','login','null',0,0,'',0,0,NULL,NULL,'YES','NO',1,'','varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('wahlruecklauf_felder','name','',0,0,'',0,0,NULL,NULL,'YES','NO',1,'','varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('wahlruecklauf_felder','pos','1',0,0,'',0,0,NULL,NULL,'YES','NO',1,'','int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,'',''),
('wahlruecklauf_felder','ridx','null',0,0,'',0,0,NULL,NULL,'YES','NO',1,'','varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('wahlruecklauf_felder','update_date','null',0,0,'null',0,0,NULL,NULL,'YES','NO',1,'','date','','date',NULL,NULL,NULL,NULL,'select,insert,update,references',1,0,'',''),
('wahlruecklauf_felder','update_time','null',0,0,'null',0,0,NULL,NULL,'YES','NO',1,'','time','','time',NULL,NULL,NULL,NULL,'select,insert,update,references',1,0,'','');
UNLOCK TABLES;
LOCK TABLES `ds_column_list_label` WRITE;
INSERT IGNORE INTO `ds_column_list_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `editor`, `position`, `summaryrenderer`, `renderer`, `summarytype`, `hidden`, `active`, `filterstore`, `grouped`, `flex`, `direction`, `align`, `listfiltertype`, `hint`) VALUES ('wahlruecklauf_felder','aktiv','DE','Aktiv','gridcolumn','',999,NULL,'',NULL,0,1,'',0,1.00,'ASC','left','',''),
('wahlruecklauf_felder','id','DE','id','gridcolumn','',0,'','','',0,1,'',0,1.00,'ASC','left','',''),
('wahlruecklauf_felder','kostenstelle','DE','kostenstelle','gridcolumn','',0,'','','',0,1,'',0,1.00,'ASC','left','',''),
('wahlruecklauf_felder','name','DE','Feld','gridcolumn','',999,NULL,'',NULL,0,1,'',0,1.00,'ASC','left','',''),
('wahlruecklauf_felder','pos','DE','Position','numbercolumn','',999,NULL,'',NULL,0,1,'',0,1.00,'ASC','left','','');
UNLOCK TABLES;
LOCK TABLES `ds_column_form_label` WRITE;
INSERT IGNORE INTO `ds_column_form_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `field_path`, `position`, `hidden`, `active`, `allowempty`, `fieldgroup`, `flex`, `hint`) VALUES ('wahlruecklauf_felder','aktiv','DE','Aktiv','checkbox','Allgemein',999,0,1,1,'',1.00,''),
('wahlruecklauf_felder','id','DE','ID','displayfield','Allgemein',999,0,1,1,'',1.00,''),
('wahlruecklauf_felder','kostenstelle','DE','kostenstelle','displayfield','Allgemein',0,0,1,1,'',1.00,''),
('wahlruecklauf_felder','name','DE','Feld','combobox_view_ruecklauffelder_columns_column_name','Allgemein',999,0,1,1,'',1.00,''),
('wahlruecklauf_felder','pos','DE','Position','displayfield','Allgemein',999,0,1,1,'',1.00,''),
('wahlruecklauf_felder','ridx','DE','RIDX','displayfield','Allgemein',999,0,1,1,'',1.00,'');
UNLOCK TABLES;
LOCK TABLES `ds_dropdownfields` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_reference_tables` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_addcommands` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_access` WRITE;
INSERT IGNORE INTO `ds_access` (`role`, `table_name`, `read`, `write`, `delete`, `append` ) VALUES ('wahl_administration','wahlruecklauf_felder',1,1,1,1 );
UNLOCK TABLES;
LOCK TABLES `ds` WRITE;
INSERT IGNORE INTO `ds` (`table_name`, `title`, `reorderfield`, `use_history`, `searchfield`, `displayfield`, `sortfield`, `searchany`, `hint`, `overview_tpl`, `sync_table`, `writetable`, `globalsearch`, `listselectionmodel`, `sync_view`, `syncable`, `cssstyle`, `alternativeformxtype`, `read_table`, `class_name`, `special_add_panel`, `existsreal`, `character_set_name`, `read_filter`, `listxtypeprefix`, `phpexporter`, `phpexporterfilename`, `combined`, `default_pagesize`, `allowForm`, `listviewbaseclass`, `showactionbtn`, `modelbaseclass`) VALUES ('wahlberechtigte','Wahlberechtigte','',0,'identnummer','identnummer','id',1,'','','','',0,'','',0,'','','','Wahlsystem','',1,'','','listview','XlsxWriter','wahlberechtigte',0,10000,0,'Tualo.DataSets.ListView',1,'Tualo.DataSets.model.Basic');
UNLOCK TABLES;
LOCK TABLES `ds_column` WRITE;
INSERT IGNORE INTO `ds_column` (`table_name`, `column_name`, `default_value`, `default_max_value`, `default_min_value`, `update_value`, `is_primary`, `syncable`, `referenced_table`, `referenced_column_name`, `is_nullable`, `is_referenced`, `writeable`, `note`, `data_type`, `column_key`, `column_type`, `character_maximum_length`, `numeric_precision`, `numeric_scale`, `character_set_name`, `privileges`, `existsreal`, `deferedload`, `hint`, `fieldtype`) VALUES ('wahlberechtigte','aktiv','',100000,0,'',0,0,NULL,NULL,'YES','NO',1,'','varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('wahlberechtigte','id','',0,0,'',1,0,NULL,NULL,'NO','NO',1,'','bigint','PRI','bigint(20)',NULL,19,0,NULL,'select,insert,update,references',1,0,'',''),
('wahlberechtigte','identkurz','',100000,0,'',0,0,NULL,NULL,'YES','NO',1,'','int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,'',''),
('wahlberechtigte','identnummer','',100000,0,'',0,0,NULL,NULL,'YES','NO',1,'','varchar','MUL','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('wahlberechtigte','insert_date','null',100000,0,'',0,0,NULL,NULL,'YES','NO',1,'','date','','date',NULL,NULL,NULL,NULL,'select,insert,update,references',1,0,'',''),
('wahlberechtigte','insert_time','null',100000,0,'',0,0,NULL,NULL,'YES','NO',1,'','time','','time',NULL,NULL,NULL,NULL,'select,insert,update,references',1,0,'',''),
('wahlberechtigte','kostenstelle','0',0,0,'',1,0,NULL,NULL,'NO','NO',1,'','int','PRI','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,'',''),
('wahlberechtigte','login','null',100000,0,'',0,0,NULL,NULL,'YES','NO',1,'','varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('wahlberechtigte','ridx','',100000,0,'',0,0,NULL,NULL,'YES','NO',1,'','varchar','UNI','varchar(12)',12,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('wahlberechtigte','update_date','null',100000,0,'null',0,0,NULL,NULL,'YES','NO',1,'','date','','date',NULL,NULL,NULL,NULL,'select,insert,update,references',1,0,'',''),
('wahlberechtigte','update_time','null',100000,0,'null',0,0,NULL,NULL,'YES','NO',1,'','time','','time',NULL,NULL,NULL,NULL,'select,insert,update,references',1,0,'','');
UNLOCK TABLES;
LOCK TABLES `ds_column_list_label` WRITE;
INSERT IGNORE INTO `ds_column_list_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `editor`, `position`, `summaryrenderer`, `renderer`, `summarytype`, `hidden`, `active`, `filterstore`, `grouped`, `flex`, `direction`, `align`, `listfiltertype`, `hint`) VALUES ('wahlberechtigte','aktiv','DE','Aktiv','gridcolumn','',1,'','','',0,1,'',0,1.00,'ASC','left','',''),
('wahlberechtigte','id','DE','ID','gridcolumn','',18,'','','',0,1,'',0,1.00,'ASC','left','',''),
('wahlberechtigte','identkurz','DE','identkurz','gridcolumn','',11,'','','',0,1,'',0,1.00,'ASC','left','',''),
('wahlberechtigte','identnummer','DE','Identnummer','gridcolumn','',2,'','','',0,1,'',0,1.00,'ASC','left','',''),
('wahlberechtigte','insert_date','DE','Anlagedatum','gridcolumn','',16,'','','',0,1,'',0,1.00,'ASC','left','',''),
('wahlberechtigte','insert_time','DE','Anlagezeit','gridcolumn','',15,'','','',0,1,'',0,1.00,'ASC','left','',''),
('wahlberechtigte','kostenstelle','DE','kostenstelle','gridcolumn','',0,'','','',0,1,'',0,1.00,'ASC','left','',''),
('wahlberechtigte','land','DE','Land','gridcolumn','',10,'','','',0,1,'',0,1.00,'ASC','left','',''),
('wahlberechtigte','login','DE','Login','gridcolumn','',13,'','','',0,1,'',0,1.00,'ASC','left','',''),
('wahlberechtigte','name','DE','Name','gridcolumn','',3,'','','',0,1,'',0,1.00,'ASC','left','',''),
('wahlberechtigte','name2','DE','Name2','gridcolumn','',4,'','','',0,1,'',0,1.00,'ASC','left','',''),
('wahlberechtigte','name3','DE','Name3','gridcolumn','',5,'','','',0,1,'',0,1.00,'ASC','left','',''),
('wahlberechtigte','name4','DE','Name4','gridcolumn','',6,'','','',0,1,'',0,1.00,'ASC','left','',''),
('wahlberechtigte','ort','DE','Ort','gridcolumn','',9,'','','',0,1,'',0,1.00,'ASC','left','',''),
('wahlberechtigte','plz','DE','PLZ','gridcolumn','',8,'','','',0,1,'',0,1.00,'ASC','left','',''),
('wahlberechtigte','ridx','DE','RIDX','gridcolumn','',14,'','','',0,1,'',0,1.00,'ASC','left','',''),
('wahlberechtigte','str','DE','Strasse','gridcolumn','',7,'','','',0,1,'',0,1.00,'ASC','left','',''),
('wahlberechtigte','update_date','DE','Änderungsdatum','gridcolumn','',17,'','','',0,1,'',0,1.00,'ASC','left','',''),
('wahlberechtigte','update_time','DE','Änderungszeit','gridcolumn','',12,'','','',0,1,'',0,1.00,'ASC','left','','');
UNLOCK TABLES;
LOCK TABLES `ds_column_form_label` WRITE;
INSERT IGNORE INTO `ds_column_form_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `field_path`, `position`, `hidden`, `active`, `allowempty`, `fieldgroup`, `flex`, `hint`) VALUES ('wahlberechtigte','aktiv','DE','Aktiv','textfield','Allgemein',1,0,1,1,'',1.00,''),
('wahlberechtigte','id','DE','id','displayfield','Allgemein',0,0,1,1,'',1.00,''),
('wahlberechtigte','identkurz','DE','identkurz','textfield','Allgemein',11,0,1,1,'',1.00,''),
('wahlberechtigte','identnummer','DE','Identnummer','textfield','Allgemein',2,0,1,1,'',1.00,''),
('wahlberechtigte','insert_date','DE','Anlagedatum','textfield','Allgemein',16,0,1,1,'',1.00,''),
('wahlberechtigte','insert_time','DE','Anlagezeit','textfield','Allgemein',15,0,1,1,'',1.00,''),
('wahlberechtigte','kostenstelle','DE','kostenstelle','displayfield','Allgemein',0,0,1,1,'',1.00,''),
('wahlberechtigte','land','DE','Land','textfield','Allgemein',10,0,1,1,'',1.00,''),
('wahlberechtigte','login','DE','Login','textfield','Allgemein',13,0,1,1,'',1.00,''),
('wahlberechtigte','name','DE','Name','textfield','Allgemein',3,0,1,1,'',1.00,''),
('wahlberechtigte','name2','DE','Name2','textfield','Allgemein',4,0,1,1,'',1.00,''),
('wahlberechtigte','name3','DE','Name3','textfield','Allgemein',5,0,1,1,'',1.00,''),
('wahlberechtigte','name4','DE','Name4','textfield','Allgemein',6,0,1,1,'',1.00,''),
('wahlberechtigte','ort','DE','Ort','textfield','Allgemein',9,0,1,1,'',1.00,''),
('wahlberechtigte','plz','DE','PLZ','textfield','Allgemein',8,0,1,1,'',1.00,''),
('wahlberechtigte','ridx','DE','RIDX','textfield','Allgemein',14,0,1,1,'',1.00,''),
('wahlberechtigte','str','DE','Strasse','textfield','Allgemein',7,0,1,1,'',1.00,''),
('wahlberechtigte','update_date','DE','Änderungsdatum','textfield','Allgemein',17,0,1,1,'',1.00,''),
('wahlberechtigte','update_time','DE','Änderungszeit','textfield','Allgemein',12,0,1,1,'',1.00,'');
UNLOCK TABLES;
LOCK TABLES `ds_dropdownfields` WRITE;
INSERT IGNORE INTO `ds_dropdownfields` (`table_name`, `name`, `idfield`, `displayfield`, `filterconfig`) VALUES ('wahlberechtigte','RIDX','ridx','name',NULL);
UNLOCK TABLES;
LOCK TABLES `ds_reference_tables` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_addcommands` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_access` WRITE;
INSERT IGNORE INTO `ds_access` (`role`, `table_name`, `read`, `write`, `delete`, `append` ) VALUES ('wahl_administration','wahlberechtigte',1,1,1,1 );
UNLOCK TABLES;
LOCK TABLES `ds` WRITE;
INSERT IGNORE INTO `ds` (`table_name`, `title`, `reorderfield`, `use_history`, `searchfield`, `displayfield`, `sortfield`, `searchany`, `hint`, `overview_tpl`, `sync_table`, `writetable`, `globalsearch`, `listselectionmodel`, `sync_view`, `syncable`, `cssstyle`, `alternativeformxtype`, `read_table`, `class_name`, `special_add_panel`, `existsreal`, `character_set_name`, `read_filter`, `listxtypeprefix`, `phpexporter`, `phpexporterfilename`, `combined`, `default_pagesize`, `allowForm`, `listviewbaseclass`, `showactionbtn`, `modelbaseclass`) VALUES ('wahlzeichnungsberechtigter','Zeichnungsberechtige','',0,'anzeige_name','anzeige_name','anzeige_name',1,'','','','',0,'cellmodel','',0,'','','view_readtable_wahlzeichnungsberechtigter','Wahlsystem','',1,'','','listview','XlsxWriter','wahlzeichnungsberechtigter',0,1000,0,'Tualo.DataSets.ListView',1,'Tualo.DataSets.model.Basic');
UNLOCK TABLES;
LOCK TABLES `ds_column` WRITE;
INSERT IGNORE INTO `ds_column` (`table_name`, `column_name`, `default_value`, `default_max_value`, `default_min_value`, `update_value`, `is_primary`, `syncable`, `referenced_table`, `referenced_column_name`, `is_nullable`, `is_referenced`, `writeable`, `note`, `data_type`, `column_key`, `column_type`, `character_maximum_length`, `numeric_precision`, `numeric_scale`, `character_set_name`, `privileges`, `existsreal`, `deferedload`, `hint`, `fieldtype`) VALUES ('wahlzeichnungsberechtigter','aktiv','1',0,0,'',0,0,NULL,NULL,'YES','NO',1,'','varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('wahlzeichnungsberechtigter','funktion','',0,0,'',0,0,NULL,NULL,'YES','NO',1,'','varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('wahlzeichnungsberechtigter','geburtsdatum','',10000000,0,NULL,0,0,NULL,NULL,'YES','NO',1,'','date','','date',NULL,NULL,NULL,NULL,'select,insert,update,references',1,0,'',''),
('wahlzeichnungsberechtigter','id','{#serial}',1000000,1,'',1,0,NULL,NULL,'NO','NO',1,'','int','PRI','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,'',''),
('wahlzeichnungsberechtigter','insert_date','{:now()}',0,0,'',0,0,NULL,NULL,'YES','NO',1,'','date','','date',NULL,NULL,NULL,NULL,'select,insert,update,references',1,0,'',''),
('wahlzeichnungsberechtigter','insert_time','{:now()}',0,0,'null',0,0,NULL,NULL,'YES','NO',1,'','time','','time',NULL,NULL,NULL,NULL,'select,insert,update,references',1,0,'',''),
('wahlzeichnungsberechtigter','kostenstelle','0',0,0,'',1,0,'','','NO','NO',1,'\'\'','int','PRI','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,'',''),
('wahlzeichnungsberechtigter','login','{:getSessionUser()}',0,0,'null',0,0,NULL,NULL,'YES','NO',1,'','varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('wahlzeichnungsberechtigter','nachname','',10000000,0,NULL,0,0,NULL,NULL,'YES','NO',1,'','varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('wahlzeichnungsberechtigter','nachtitel','',10000000,0,NULL,0,0,NULL,NULL,'YES','NO',1,'','varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('wahlzeichnungsberechtigter','name','',0,0,'',0,0,NULL,NULL,'YES','NO',1,'','varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('wahlzeichnungsberechtigter','namenstitel','',10000000,0,NULL,0,0,NULL,NULL,'YES','NO',1,'','varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('wahlzeichnungsberechtigter','personenident','',0,0,'',0,0,NULL,NULL,'YES','NO',1,'','varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('wahlzeichnungsberechtigter','ridx','',0,0,'',0,0,NULL,NULL,'YES','NO',1,'','varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('wahlzeichnungsberechtigter','update_date','{:now()}',0,0,'null',0,0,NULL,NULL,'YES','NO',1,'','date','','date',NULL,NULL,NULL,NULL,'select,insert,update,references',1,0,'',''),
('wahlzeichnungsberechtigter','update_time','{:now()}',0,0,'null',0,0,NULL,NULL,'YES','NO',1,'','time','','time',NULL,NULL,NULL,NULL,'select,insert,update,references',1,0,'',''),
('wahlzeichnungsberechtigter','vorname','',10000000,0,NULL,0,0,NULL,NULL,'YES','NO',1,'','varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('wahlzeichnungsberechtigter','wahlberechtigte','',0,0,'',0,0,NULL,NULL,'YES','NO',1,'','varchar','MUL','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'','');
UNLOCK TABLES;
LOCK TABLES `ds_column_list_label` WRITE;
INSERT IGNORE INTO `ds_column_list_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `editor`, `position`, `summaryrenderer`, `renderer`, `summarytype`, `hidden`, `active`, `filterstore`, `grouped`, `flex`, `direction`, `align`, `listfiltertype`, `hint`) VALUES ('wahlzeichnungsberechtigter','aktiv','DE','aktiv','gridcolumn','',13,'','','',1,1,'',0,1.00,'','','',''),
('wahlzeichnungsberechtigter','anzeige_name','DE','anzeige_name','gridcolumn','',8,'','','',1,1,'',0,1.00,'','','',''),
('wahlzeichnungsberechtigter','funktion','DE','funktion','gridcolumn','',5,'','','',1,1,'',0,1.00,'','','',''),
('wahlzeichnungsberechtigter','geburtsdatum','DE','geburtsdatum','gridcolumn','',7,'','','',1,1,'',0,1.00,'','','',''),
('wahlzeichnungsberechtigter','id','DE','ID','gridcolumn','',0,'','','',1,1,'',0,1.00,'','','',''),
('wahlzeichnungsberechtigter','insert_date','DE','insert_date','gridcolumn','',17,'','','',1,1,'',0,1.00,'','','',''),
('wahlzeichnungsberechtigter','insert_time','DE','insert_time','gridcolumn','',10,'','','',1,1,'',0,1.00,'','','',''),
('wahlzeichnungsberechtigter','kostenstelle','DE','kostenstelle','gridcolumn','',4,'','','',1,1,'',0,1.00,'','','',''),
('wahlzeichnungsberechtigter','login','DE','login','gridcolumn','',12,'','','',1,1,'',0,1.00,'','','',''),
('wahlzeichnungsberechtigter','nachname','DE','Nachname','gridcolumn','',2,'','','',0,1,'',0,1.00,'','','',''),
('wahlzeichnungsberechtigter','nachtitel','DE','nachtitel','gridcolumn','',6,'','','',1,1,'',0,1.00,'','','',''),
('wahlzeichnungsberechtigter','name','DE','name','gridcolumn','',18,'','','',1,1,'',0,1.00,'','','',''),
('wahlzeichnungsberechtigter','namenstitel','DE','namenstitel','gridcolumn','',15,'','','',1,1,'',0,1.00,'','','',''),
('wahlzeichnungsberechtigter','personenident','DE','Personen-Ident','gridcolumn','',3,'','','',0,1,'',0,1.00,'','','',''),
('wahlzeichnungsberechtigter','ridx','DE','ridx','gridcolumn','',9,'','','',1,1,'',0,1.00,'','','',''),
('wahlzeichnungsberechtigter','update_date','DE','update_date','gridcolumn','',16,'','','',1,1,'',0,1.00,'','','',''),
('wahlzeichnungsberechtigter','update_time','DE','update_time','gridcolumn','',11,'','','',1,1,'',0,1.00,'','','',''),
('wahlzeichnungsberechtigter','vorname','DE','Vorname','gridcolumn','',1,'','','',0,1,'',0,1.00,'','','',''),
('wahlzeichnungsberechtigter','wahlberechtigte','DE','Berrechtigte','gridcolumn','',14,'','','',1,1,'',0,1.00,'','','','');
UNLOCK TABLES;
LOCK TABLES `ds_column_form_label` WRITE;
INSERT IGNORE INTO `ds_column_form_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `field_path`, `position`, `hidden`, `active`, `allowempty`, `fieldgroup`, `flex`, `hint`) VALUES ('wahlzeichnungsberechtigter','anzeige_name','DE','anzeige_name','displayfield','Allgemein',999,1,1,1,'',1.00,''),
('wahlzeichnungsberechtigter','funktion','DE','Funktion','textfield','Allgemein',2,0,1,1,'',1.00,''),
('wahlzeichnungsberechtigter','geburtsdatum','DE','geburtsdatum','displayfield','Allgemein',999,1,1,1,'',1.00,''),
('wahlzeichnungsberechtigter','id','DE','id','displayfield','Allgemein',0,0,1,1,'',1.00,''),
('wahlzeichnungsberechtigter','kostenstelle','DE','kostenstelle','displayfield','Allgemein',0,0,1,1,'',1.00,''),
('wahlzeichnungsberechtigter','nachname','DE','nachname','displayfield','Allgemein',999,1,1,1,'',1.00,''),
('wahlzeichnungsberechtigter','nachtitel','DE','nachtitel','displayfield','Allgemein',999,1,1,1,'',1.00,''),
('wahlzeichnungsberechtigter','name','DE','Name','textfield','Allgemein',1,0,1,1,'',1.00,''),
('wahlzeichnungsberechtigter','namenstitel','DE','namenstitel','displayfield','Allgemein',999,1,1,1,'',1.00,''),
('wahlzeichnungsberechtigter','personenident','DE','Personen-Ident','textfield','Allgemein',999,0,1,1,'',1.00,''),
('wahlzeichnungsberechtigter','vorname','DE','vorname','displayfield','Allgemein',999,1,1,1,'',1.00,''),
('wahlzeichnungsberechtigter','wahlberechtigte','DE','Berechtigte','textfield','Allgemein',999,0,1,1,'',1.00,'');
UNLOCK TABLES;
LOCK TABLES `ds_dropdownfields` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_reference_tables` WRITE;
INSERT IGNORE INTO `ds_reference_tables` (`table_name`, `reference_table_name`, `columnsdef`, `constraint_name`, `active`, `searchable`, `autosync`, `position`, `path`, `existsreal`, `tabtitle`) VALUES ('wahlzeichnungsberechtigter','wahlberechtigte','{\"wahlberechtigte\":\"ridx\"}','fk_wahlzeichnungsberechtigter_wahlberechtigte',0,0,0,999,'',0,''),
('wahlzeichnungsberechtigter','wahlberechtigte','{\"wahlberechtigte\":\"ridx\"}','fk_wahlzeichnungsberechtigter_wahlberechtigte',0,0,0,999,'',0,''),
('wahlzeichnungsberechtigter','wahlberechtigte','{\"wahlberechtigte\":\"ridx\"}','fk_wahlzeichnungsberechtigter_wahlberechtigte',0,0,0,999,'',0,''),
('wahlzeichnungsberechtigter','wahlberechtigte','{\"wahlberechtigte\":\"ridx\"}','fk_wahlzeichnungsberechtigter_wahlberechtigte',0,0,0,999,'',1,'');
UNLOCK TABLES;
LOCK TABLES `ds_addcommands` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_access` WRITE;
INSERT IGNORE INTO `ds_access` (`role`, `table_name`, `read`, `write`, `delete`, `append` ) VALUES ('wahl_administration','wahlzeichnungsberechtigter',1,1,1,1 );
UNLOCK TABLES;
LOCK TABLES `ds` WRITE;
INSERT IGNORE INTO `ds` (`table_name`, `title`, `reorderfield`, `use_history`, `searchfield`, `displayfield`, `sortfield`, `searchany`, `hint`, `overview_tpl`, `sync_table`, `writetable`, `globalsearch`, `listselectionmodel`, `sync_view`, `syncable`, `cssstyle`, `alternativeformxtype`, `read_table`, `class_name`, `special_add_panel`, `existsreal`, `character_set_name`, `read_filter`, `listxtypeprefix`, `phpexporter`, `phpexporterfilename`, `combined`, `default_pagesize`, `allowForm`, `listviewbaseclass`, `showactionbtn`, `modelbaseclass`) VALUES ('wahlschein','Wahlschein','',0,'name','name','',1,'','','','',0,'','',0,'','','','Wahlsystem','',1,'','','listview','XlsxWriter','wahlschein',0,1000,0,'Tualo.DataSets.ListView',1,'Tualo.DataSets.model.Basic');
UNLOCK TABLES;
LOCK TABLES `ds_column` WRITE;
INSERT IGNORE INTO `ds_column` (`table_name`, `column_name`, `default_value`, `default_max_value`, `default_min_value`, `update_value`, `is_primary`, `syncable`, `referenced_table`, `referenced_column_name`, `is_nullable`, `is_referenced`, `writeable`, `note`, `data_type`, `column_key`, `column_type`, `character_maximum_length`, `numeric_precision`, `numeric_scale`, `character_set_name`, `privileges`, `existsreal`, `deferedload`, `hint`, `fieldtype`) VALUES ('wahlschein','abgabehash','',0,0,'',0,0,NULL,NULL,'YES','NO',1,'','varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('wahlschein','abgabetyp','',100000,0,'',0,0,NULL,NULL,'YES','NO',1,'','varchar','MUL','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('wahlschein','aktiv','1',100000,0,'',0,0,NULL,NULL,'YES','NO',1,'','int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,'',''),
('wahlschein','antrag','',10000000,0,NULL,0,0,NULL,NULL,'YES','NO',1,'','tinyint','','tinyint(4)',NULL,3,0,NULL,'select,insert,update,references',1,0,'',''),
('wahlschein','blocknumber','',10000000,0,NULL,0,0,NULL,NULL,'YES','NO',1,'','varchar','MUL','varchar(30)',30,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('wahlschein','defered','',10000000,0,NULL,0,0,NULL,NULL,'YES','NO',1,'','tinyint','','tinyint(4)',NULL,3,0,NULL,'select,insert,update,references',1,0,'',''),
('wahlschein','id','',100000,0,'',1,0,NULL,NULL,'NO','NO',1,'','bigint','PRI','bigint(20)',NULL,19,0,NULL,'select,insert,update,references',1,0,'',''),
('wahlschein','insert_date','null',100000,0,'',0,0,NULL,NULL,'NO','NO',1,'','date','','date',NULL,NULL,NULL,NULL,'select,insert,update,references',1,0,'',''),
('wahlschein','insert_time','null',100000,0,'',0,0,NULL,NULL,'YES','NO',1,'','time','','time',NULL,NULL,NULL,NULL,'select,insert,update,references',1,0,'',''),
('wahlschein','kostenstelle','',10000000,0,NULL,0,0,NULL,NULL,'NO','NO',1,'','int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,'',''),
('wahlschein','login','null',100000,0,'',0,0,NULL,NULL,'NO','NO',1,'','varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('wahlschein','name','',100000,0,'',0,0,NULL,NULL,'YES','NO',1,'','varchar','MUL','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('wahlschein','onlinecheck','',10000000,0,NULL,0,0,NULL,NULL,'YES','NO',1,'','tinyint','','tinyint(4)',NULL,3,0,NULL,'select,insert,update,references',1,0,'',''),
('wahlschein','pwhash','',0,0,'',0,0,NULL,NULL,'YES','NO',1,'','varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('wahlschein','ridx','',100000,0,'',0,0,NULL,NULL,'YES','NO',1,'','varchar','UNI','varchar(12)',12,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('wahlschein','secret','',10000000,0,NULL,0,0,NULL,NULL,'YES','NO',1,'','varchar','','varchar(500)',500,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('wahlschein','sendtotmg','0',0,0,'',0,0,NULL,NULL,'YES','NO',1,'','tinyint','MUL','tinyint(4)',NULL,3,0,NULL,'select,insert,update,references',1,0,'',''),
('wahlschein','stimmzettel','',100000,0,'',1,0,NULL,NULL,'NO','NO',1,'','varchar','PRI','varchar(12)',12,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('wahlschein','testdaten','',10000000,0,NULL,0,0,NULL,NULL,'YES',NULL,1,'','tinyint','','tinyint(4)',NULL,3,0,NULL,'select,insert,update,references',1,0,'',''),
('wahlschein','update_date','null',100000,0,'null',0,0,NULL,NULL,'NO','NO',1,'','date','','date',NULL,NULL,NULL,NULL,'select,insert,update,references',1,0,'',''),
('wahlschein','update_time','null',100000,0,'null',0,0,NULL,NULL,'YES','NO',1,'','time','','time',NULL,NULL,NULL,NULL,'select,insert,update,references',1,0,'',''),
('wahlschein','usedate',NULL,10000000,0,NULL,0,0,NULL,NULL,'YES',NULL,1,'','date','','date',NULL,NULL,NULL,NULL,'select,insert,update,references',1,0,'',''),
('wahlschein','username','',0,0,'',0,0,NULL,NULL,'YES','NO',1,'','varchar','MUL','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('wahlschein','wahlberechtigte','',100000,0,'',0,0,NULL,NULL,'YES','NO',1,'','varchar','MUL','varchar(12)',12,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('wahlschein','wahlscheinnummer','',100000,0,'',0,0,NULL,NULL,'YES','NO',1,'','varchar','MUL','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('wahlschein','wahlscheinstatus','1|0',100000,0,'',0,0,NULL,NULL,'YES','NO',1,'','varchar','MUL','varchar(12)',12,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('wahlschein','wahlscheinstatus_grund','',100000,0,'',0,0,NULL,NULL,'YES','NO',1,'','varchar','MUL','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'','');
UNLOCK TABLES;
LOCK TABLES `ds_column_list_label` WRITE;
INSERT IGNORE INTO `ds_column_list_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `editor`, `position`, `summaryrenderer`, `renderer`, `summarytype`, `hidden`, `active`, `filterstore`, `grouped`, `flex`, `direction`, `align`, `listfiltertype`, `hint`) VALUES ('wahlschein','abgabetyp','DE','Abgabetyp','column_abgabetyp_ridx','',13,'','','',0,1,'',0,1.00,'ASC','left','',''),
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
('wahlschein','wahlberechtigte','DE','Berechtigte','column__ridx','',7,'','','',0,1,'',0,1.00,'ASC','left','',''),
('wahlschein','wahlscheinnummer','DE','Wahlscheinnummer','gridcolumn','',6,'','','',0,1,'',0,1.00,'ASC','left','',''),
('wahlschein','wahlscheinstatus','DE','Status Vollversammlungswahl','column_wahlscheinstatus_ridx','',12,'','','',0,1,'',0,1.00,'ASC','left','',''),
('wahlschein','wahlscheinstatus_grund','DE','Grund Vollversammlungswahl','column_wahlscheinstatus_grund_ridx','',9,'','','',0,1,'',0,1.00,'ASC','left','','');
UNLOCK TABLES;
LOCK TABLES `ds_column_form_label` WRITE;
INSERT IGNORE INTO `ds_column_form_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `field_path`, `position`, `hidden`, `active`, `allowempty`, `fieldgroup`, `flex`, `hint`) VALUES ('wahlschein','abgabetyp','DE','Abgabetyp','combobox_abgabetyp_ridx','Allgemein',13,0,1,1,'',1.00,''),
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
('wahlschein','wahlberechtigte','DE','Berechtigte','combobox__ridx','Allgemein',7,0,1,1,'',1.00,''),
('wahlschein','wahlscheinnummer','DE','Wahlscheinnummer','textfield','Allgemein',6,0,1,1,'',1.00,''),
('wahlschein','wahlscheinstatus','DE','Status Vollversammlungswahl','combobox_wahlscheinstatus_ridx','Allgemein',12,0,1,1,'',1.00,''),
('wahlschein','wahlscheinstatus_grund','DE','Grund Vollversammlungswahl','combobox_wahlscheinstatus_grund_ridx','Allgemein',9,0,1,1,'',1.00,'');
UNLOCK TABLES;
LOCK TABLES `ds_dropdownfields` WRITE;
INSERT IGNORE INTO `ds_dropdownfields` (`table_name`, `name`, `idfield`, `displayfield`, `filterconfig`) VALUES ('wahlschein','RIDX','ridx','name',NULL);
UNLOCK TABLES;
LOCK TABLES `ds_reference_tables` WRITE;
INSERT IGNORE INTO `ds_reference_tables` (`table_name`, `reference_table_name`, `columnsdef`, `constraint_name`, `active`, `searchable`, `autosync`, `position`, `path`, `existsreal`, `tabtitle`) VALUES ('wahlschein','stimmzettel','{\"stimmzettel\":\"ridx\"}','fk_wahlschein_stimmzettel',1,0,0,999,'',1,''),
('wahlschein','wahlberechtigte','{\"wahlschein__wahlberechtigte\":\"wahlberechtigte__ridx\"}','fk_wahlschein_wahlberechtigte',0,0,1,99999,'',0,''),
('wahlschein','wahlscheinstatus','{\"wahlschein__wahlscheinstatus\":\"wahlscheinstatus__ridx\"}','fk_wahlschein_wahlscheinstatus',0,0,1,99999,'',0,''),
('wahlschein','stimmzettel','{\"stimmzettel\":\"ridx\"}','fk_wahlschein_stimmzettel',1,0,0,999,'',1,''),
('wahlschein','wahlberechtigte','{\"wahlschein__wahlberechtigte\":\"wahlberechtigte__ridx\"}','fk_wahlschein_wahlberechtigte',0,0,1,99999,'',0,''),
('wahlschein','wahlscheinstatus','{\"wahlschein__wahlscheinstatus\":\"wahlscheinstatus__ridx\"}','fk_wahlschein_wahlscheinstatus',0,0,1,99999,'',0,''),
('wahlschein','stimmzettel','{\"stimmzettel\":\"ridx\"}','fk_wahlschein_stimmzettel',1,0,0,999,'',1,''),
('wahlschein','wahlberechtigte','{\"wahlschein__wahlberechtigte\":\"wahlberechtigte__ridx\"}','fk_wahlschein_wahlberechtigte',0,0,1,99999,'',0,''),
('wahlschein','wahlscheinstatus','{\"wahlschein__wahlscheinstatus\":\"wahlscheinstatus__ridx\"}','fk_wahlschein_wahlscheinstatus',0,0,1,99999,'',0,''),
('wahlschein','stimmzettel','{\"stimmzettel\":\"ridx\"}','fk_wahlschein_stimmzettel',1,0,0,999,'',1,''),
('wahlschein','wahlberechtigte','{\"wahlschein__wahlberechtigte\":\"wahlberechtigte__ridx\"}','fk_wahlschein_wahlberechtigte',0,0,1,99999,'',0,''),
('wahlschein','wahlscheinstatus','{\"wahlschein__wahlscheinstatus\":\"wahlscheinstatus__ridx\"}','fk_wahlschein_wahlscheinstatus',0,0,1,99999,'',0,''),
('wahlschein','stimmzettel','{\"stimmzettel\":\"ridx\"}','fk_wahlschein_stimmzettel',1,0,0,999,'',1,''),
('wahlschein','wahlberechtigte','{\"wahlschein__wahlberechtigte\":\"wahlberechtigte__ridx\"}','fk_wahlschein_wahlberechtigte',0,0,1,99999,'',0,''),
('wahlschein','wahlscheinstatus','{\"wahlschein__wahlscheinstatus\":\"wahlscheinstatus__ridx\"}','fk_wahlschein_wahlscheinstatus',0,0,1,99999,'',0,''),
('wahlschein','stimmzettel','{\"stimmzettel\":\"ridx\"}','fk_wahlschein_stimmzettel',1,0,0,999,'',1,''),
('wahlschein','wahlberechtigte','{\"wahlschein__wahlberechtigte\":\"wahlberechtigte__ridx\"}','fk_wahlschein_wahlberechtigte',0,0,1,99999,'',0,''),
('wahlschein','wahlscheinstatus','{\"wahlschein__wahlscheinstatus\":\"wahlscheinstatus__ridx\"}','fk_wahlschein_wahlscheinstatus',0,0,1,99999,'',0,''),
('wahlschein','stimmzettel','{\"stimmzettel\":\"ridx\"}','fk_wahlschein_stimmzettel',1,0,0,999,'',1,''),
('wahlschein','wahlberechtigte','{\"wahlschein__wahlberechtigte\":\"wahlberechtigte__ridx\"}','fk_wahlschein_wahlberechtigte',0,0,1,99999,'',0,''),
('wahlschein','wahlscheinstatus','{\"wahlschein__wahlscheinstatus\":\"wahlscheinstatus__ridx\"}','fk_wahlschein_wahlscheinstatus',0,0,1,99999,'',0,''),
('wahlschein','stimmzettel','{\"stimmzettel\":\"ridx\"}','fk_wahlschein_stimmzettel',1,0,0,999,'',1,''),
('wahlschein','wahlberechtigte','{\"wahlschein__wahlberechtigte\":\"wahlberechtigte__ridx\"}','fk_wahlschein_wahlberechtigte',0,0,1,99999,'',0,''),
('wahlschein','wahlscheinstatus','{\"wahlschein__wahlscheinstatus\":\"wahlscheinstatus__ridx\"}','fk_wahlschein_wahlscheinstatus',0,0,1,99999,'',0,''),
('wahlschein','stimmzettel','{\"stimmzettel\":\"ridx\"}','fk_wahlschein_stimmzettel',1,0,0,999,'',1,''),
('wahlschein','wahlberechtigte','{\"wahlschein__wahlberechtigte\":\"wahlberechtigte__ridx\"}','fk_wahlschein_wahlberechtigte',0,0,1,99999,'',0,''),
('wahlschein','wahlscheinstatus','{\"wahlschein__wahlscheinstatus\":\"wahlscheinstatus__ridx\"}','fk_wahlschein_wahlscheinstatus',0,0,1,99999,'',0,''),
('wahlschein','stimmzettel','{\"stimmzettel\":\"ridx\"}','fk_wahlschein_stimmzettel',1,0,0,999,'',1,''),
('wahlschein','wahlberechtigte','{\"wahlberechtigte\":\"ridx\"}','fk_wahlschein_wahlberechtigte',0,0,0,999,'',0,''),
('wahlschein','wahlscheinstatus','{\"wahlscheinstatus\":\"ridx\"}','fk_wahlschein_wahlscheinstatus',0,0,0,999,'',0,''),
('wahlschein','stimmzettel','{\"stimmzettel\":\"ridx\"}','fk_wahlschein_stimmzettel',1,0,0,999,'',1,''),
('wahlschein','wahlberechtigte','{\"wahlschein__wahlberechtigte\":\"wahlberechtigte__ridx\"}','fk_wahlschein_wahlberechtigte',0,0,1,99999,'',0,''),
('wahlschein','wahlscheinstatus','{\"wahlschein__wahlscheinstatus\":\"wahlscheinstatus__ridx\"}','fk_wahlschein_wahlscheinstatus',0,0,1,99999,'',0,''),
('wahlschein','stimmzettel','{\"stimmzettel\":\"ridx\"}','fk_wahlschein_stimmzettel',1,0,0,999,'',1,''),
('wahlschein','wahlberechtigte','{\"wahlschein__wahlberechtigte\":\"wahlberechtigte__ridx\"}','fk_wahlschein_wahlberechtigte',0,0,1,99999,'',0,''),
('wahlschein','wahlscheinstatus','{\"wahlschein__wahlscheinstatus\":\"wahlscheinstatus__ridx\"}','fk_wahlschein_wahlscheinstatus',0,0,1,99999,'',0,''),
('wahlschein','stimmzettel','{\"stimmzettel\":\"ridx\"}','fk_wahlschein_stimmzettel',1,0,0,999,'',1,''),
('wahlschein','wahlberechtigte','{\"wahlschein__wahlberechtigte\":\"wahlberechtigte__ridx\"}','fk_wahlschein_wahlberechtigte',0,0,1,99999,'',0,''),
('wahlschein','wahlscheinstatus','{\"wahlschein__wahlscheinstatus\":\"wahlscheinstatus__ridx\"}','fk_wahlschein_wahlscheinstatus',0,0,1,99999,'',0,''),
('wahlschein','stimmzettel','{\"stimmzettel\":\"ridx\"}','fk_wahlschein_stimmzettel',1,0,0,999,'',1,''),
('wahlschein','wahlberechtigte','{\"wahlschein__wahlberechtigte\":\"wahlberechtigte__ridx\"}','fk_wahlschein_wahlberechtigte',0,0,1,99999,'',0,''),
('wahlschein','wahlscheinstatus','{\"wahlschein__wahlscheinstatus\":\"wahlscheinstatus__ridx\"}','fk_wahlschein_wahlscheinstatus',0,0,1,99999,'',0,''),
('wahlschein','stimmzettel','{\"stimmzettel\":\"ridx\"}','fk_wahlschein_stimmzettel',1,0,0,999,'',1,''),
('wahlschein','wahlberechtigte','{\"wahlberechtigte\":\"ridx\"}','fk_wahlschein_wahlberechtigte',0,0,0,999,'',0,''),
('wahlschein','wahlscheinstatus','{\"wahlscheinstatus\":\"ridx\"}','fk_wahlschein_wahlscheinstatus',0,0,0,999,'',0,''),
('wahlschein','stimmzettel','{\"stimmzettel\":\"ridx\"}','fk_wahlschein_stimmzettel',1,0,0,999,'',1,''),
('wahlschein','wahlberechtigte','{\"wahlberechtigte\":\"ridx\"}','fk_wahlschein_wahlberechtigte',0,0,0,999,'',0,''),
('wahlschein','wahlscheinstatus','{\"wahlscheinstatus\":\"ridx\"}','fk_wahlschein_wahlscheinstatus',0,0,0,999,'',0,''),
('wahlschein','stimmzettel','{\"stimmzettel\":\"ridx\"}','fk_wahlschein_stimmzettel',1,0,0,999,'',1,''),
('wahlschein','wahlberechtigte','{\"wahlberechtigte\":\"ridx\"}','fk_wahlschein_wahlberechtigte',0,0,0,999,'',1,''),
('wahlschein','wahlscheinstatus','{\"wahlscheinstatus\":\"ridx\"}','fk_wahlschein_wahlscheinstatus',0,0,0,999,'',1,''),
('wahlschein','stimmzettel','{\"stimmzettel\":\"ridx\"}','fk_wahlschein_stimmzettel',1,0,0,999,'',1,'');
UNLOCK TABLES;
LOCK TABLES `ds_addcommands` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_access` WRITE;
INSERT IGNORE INTO `ds_access` (`role`, `table_name`, `read`, `write`, `delete`, `append` ) VALUES ('wahl_administration','wahlschein',1,1,1,1 );
UNLOCK TABLES;
LOCK TABLES `ds` WRITE;
INSERT IGNORE INTO `ds` (`table_name`, `title`, `reorderfield`, `use_history`, `searchfield`, `displayfield`, `sortfield`, `searchany`, `hint`, `overview_tpl`, `sync_table`, `writetable`, `globalsearch`, `listselectionmodel`, `sync_view`, `syncable`, `cssstyle`, `alternativeformxtype`, `read_table`, `class_name`, `special_add_panel`, `existsreal`, `character_set_name`, `read_filter`, `listxtypeprefix`, `phpexporter`, `phpexporterfilename`, `combined`, `default_pagesize`, `allowForm`, `listviewbaseclass`, `showactionbtn`, `modelbaseclass`) VALUES ('wahlberechtigte_anlage','Anlage von Wahlberechtigten','',0,'identnummer','identnummer','identnummer',1,'','','','',0,'cellmodel','',0,'',' ','','Wahlsystem','',1,'','','listview','XlsxWriter','wahlberechtigte_anlage',0,1000000,0,'Tualo.DataSets.ListView',1,'Tualo.DataSets.model.Basic');
UNLOCK TABLES;
LOCK TABLES `ds_column` WRITE;
INSERT IGNORE INTO `ds_column` (`table_name`, `column_name`, `default_value`, `default_max_value`, `default_min_value`, `update_value`, `is_primary`, `syncable`, `referenced_table`, `referenced_column_name`, `is_nullable`, `is_referenced`, `writeable`, `note`, `data_type`, `column_key`, `column_type`, `character_maximum_length`, `numeric_precision`, `numeric_scale`, `character_set_name`, `privileges`, `existsreal`, `deferedload`, `hint`, `fieldtype`) VALUES ('wahlberechtigte_anlage','identnummer',NULL,10000000,0,NULL,1,0,NULL,NULL,'NO',NULL,1,'','varchar','PRI','varchar(20)',20,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('wahlberechtigte_anlage','kombiniert',NULL,10000000,0,NULL,0,0,NULL,NULL,'YES',NULL,1,'','bigint','','bigint(20)',NULL,19,0,NULL,'select,insert,update,references',1,0,'',''),
('wahlberechtigte_anlage','pwhash',NULL,10000000,0,NULL,0,0,NULL,NULL,'YES',NULL,1,'','varchar','','varchar(100)',100,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('wahlberechtigte_anlage','stimmzettel',NULL,10000000,0,NULL,1,0,NULL,NULL,'NO',NULL,1,'','varchar','PRI','varchar(12)',12,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('wahlberechtigte_anlage','testdaten',NULL,10000000,0,NULL,0,0,NULL,NULL,'YES',NULL,1,'','tinyint','','tinyint(4)',NULL,3,0,NULL,'select,insert,update,references',1,0,'',''),
('wahlberechtigte_anlage','username',NULL,10000000,0,NULL,0,0,NULL,NULL,'YES',NULL,1,'','varchar','','varchar(10)',10,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'',''),
('wahlberechtigte_anlage','wahlscheinnummer',NULL,10000000,0,NULL,0,0,NULL,NULL,'YES',NULL,1,'','varchar','MUL','varchar(12)',12,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'','');
UNLOCK TABLES;
LOCK TABLES `ds_column_list_label` WRITE;
INSERT IGNORE INTO `ds_column_list_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `editor`, `position`, `summaryrenderer`, `renderer`, `summarytype`, `hidden`, `active`, `filterstore`, `grouped`, `flex`, `direction`, `align`, `listfiltertype`, `hint`) VALUES ('wahlberechtigte_anlage','alphasort','DE','ALPHASORT','gridcolumn','',999,'','','',0,1,'',0,1.00,'ASC','left','',''),
('wahlberechtigte_anlage','anzahl_azub','DE','Anzahl_Azub','gridcolumn','',999,'','','',0,1,'',0,1.00,'ASC','left','',''),
('wahlberechtigte_anlage','asta','DE','ASTA','gridcolumn','',999,'','','',0,1,'',0,1.00,'ASC','left','',''),
('wahlberechtigte_anlage','beitrag','DE','Beitrag','gridcolumn','',999,'','','',0,1,'',0,1.00,'ASC','left','',''),
('wahlberechtigte_anlage','gemkz','DE','GEMKZ','gridcolumn','',999,'','','',0,1,'',0,1.00,'ASC','left','',''),
('wahlberechtigte_anlage','hr_kgt','DE','HR_KGT','gridcolumn','',999,'','','',0,1,'',0,1.00,'ASC','left','',''),
('wahlberechtigte_anlage','id','DE','ID','gridcolumn','',999,'','','',0,1,'',0,1.00,'ASC','left','',''),
('wahlberechtigte_anlage','identnummer','DE','Identnummer','gridcolumn','',0,'','','',0,1,'',0,1.00,'ASC','left','',''),
('wahlberechtigte_anlage','ihk_aktiv','DE','ihk_aktiv','gridcolumn','',999,'','','',0,1,'',0,1.00,'ASC','left','',''),
('wahlberechtigte_anlage','kombiniert','DE','kombiniert','gridcolumn','',999,'','','',0,1,'',0,1.00,'ASC','left','',''),
('wahlberechtigte_anlage','plz_ort','DE','PLZ_ORT','gridcolumn','',999,'','','',0,1,'',0,1.00,'ASC','left','',''),
('wahlberechtigte_anlage','post_land','DE','POST_LAND','gridcolumn','',999,'','','',0,1,'',0,1.00,'ASC','left','',''),
('wahlberechtigte_anlage','post_name1','DE','POST_NAME1','gridcolumn','',999,'','','',0,1,'',0,1.00,'ASC','left','',''),
('wahlberechtigte_anlage','post_name2','DE','POST_NAME2','gridcolumn','',999,'','','',0,1,'',0,1.00,'ASC','left','',''),
('wahlberechtigte_anlage','post_name3','DE','POST_NAME3','gridcolumn','',999,'','','',0,1,'',0,1.00,'ASC','left','',''),
('wahlberechtigte_anlage','post_name4','DE','POST_NAME4','gridcolumn','',999,'','','',0,1,'',0,1.00,'ASC','left','',''),
('wahlberechtigte_anlage','post_name5','DE','POST_NAME5','gridcolumn','',999,'','','',0,1,'',0,1.00,'ASC','left','',''),
('wahlberechtigte_anlage','post_ort','DE','POST_ORT','gridcolumn','',999,'','','',0,1,'',0,1.00,'ASC','left','',''),
('wahlberechtigte_anlage','post_ot','DE','POST_OT','gridcolumn','',999,'','','',0,1,'',0,1.00,'ASC','left','',''),
('wahlberechtigte_anlage','post_plz','DE','POST_PLZ','gridcolumn','',999,'','','',0,1,'',0,1.00,'ASC','left','',''),
('wahlberechtigte_anlage','post_strasse','DE','POST_STRASSE','gridcolumn','',999,'','','',0,1,'',0,1.00,'ASC','left','',''),
('wahlberechtigte_anlage','pwhash','DE','pwhash','gridcolumn','',999,'','','',0,1,'',0,1.00,'ASC','left','',''),
('wahlberechtigte_anlage','rechtsform','DE','RECHTSFORM','gridcolumn','',999,'','','',0,1,'',0,1.00,'ASC','left','',''),
('wahlberechtigte_anlage','stimmzettel','DE','stimmzettel','gridcolumn','',0,'','','',0,1,'',0,1.00,'ASC','left','',''),
('wahlberechtigte_anlage','testdaten','DE','Testdaten','gridcolumn','',999,'','','',0,1,'',0,1.00,'ASC','left','',''),
('wahlberechtigte_anlage','typkennzeichen','DE','TYPKENNZEICHEN','gridcolumn','',999,'','','',0,1,'',0,1.00,'ASC','left','',''),
('wahlberechtigte_anlage','username','DE','username','gridcolumn','',999,'','','',0,1,'',0,1.00,'ASC','left','',''),
('wahlberechtigte_anlage','vtypkz','DE','VTYPKZ','gridcolumn','',999,'','','',0,1,'',0,1.00,'ASC','left','',''),
('wahlberechtigte_anlage','wahlb','DE','WAHLB','gridcolumn','',999,'','','',0,1,'',0,1.00,'ASC','left','',''),
('wahlberechtigte_anlage','wahlb_text','DE','WAHLB_TEXT','gridcolumn','',999,'','','',0,1,'',0,1.00,'ASC','left','',''),
('wahlberechtigte_anlage','wahlg','DE','WAHLG','gridcolumn','',999,'','','',0,1,'',0,1.00,'ASC','left','',''),
('wahlberechtigte_anlage','wahlg_text','DE','WAHLG_TEXT','gridcolumn','',999,'','','',0,1,'',0,1.00,'ASC','left','',''),
('wahlberechtigte_anlage','wahlscheinnummer','DE','wahlscheinnummer','gridcolumn','',999,'','','',0,1,'',0,1.00,'ASC','left','',''),
('wahlberechtigte_anlage','wirtschaftszweig','DE','WIRTSCHAFTSZWEIG','gridcolumn','',999,'','','',0,1,'',0,1.00,'ASC','left','','');
UNLOCK TABLES;
LOCK TABLES `ds_column_form_label` WRITE;
INSERT IGNORE INTO `ds_column_form_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `field_path`, `position`, `hidden`, `active`, `allowempty`, `fieldgroup`, `flex`, `hint`) VALUES ('wahlberechtigte_anlage','identnummer','DE','identnummer','displayfield','Allgemein',0,0,1,1,'',1.00,''),
('wahlberechtigte_anlage','plz_ort','DE','plz_ort','displayfield','Allgemein',999,0,1,0,'',1.00,''),
('wahlberechtigte_anlage','post_land','DE','post_land','displayfield','Allgemein',999,0,1,0,'',1.00,''),
('wahlberechtigte_anlage','post_name1','DE','post_name1','displayfield','Allgemein',999,0,1,0,'',1.00,''),
('wahlberechtigte_anlage','post_name2','DE','post_name2','displayfield','Allgemein',999,0,1,0,'',1.00,''),
('wahlberechtigte_anlage','post_name3','DE','post_name3','displayfield','Allgemein',999,0,1,0,'',1.00,''),
('wahlberechtigte_anlage','post_name4','DE','post_name4','displayfield','Allgemein',999,0,1,0,'',1.00,''),
('wahlberechtigte_anlage','post_strasse','DE','post_strasse','displayfield','Allgemein',999,0,1,0,'',1.00,''),
('wahlberechtigte_anlage','stimmzettel','DE','stimmzettel','displayfield','Allgemein',0,0,1,1,'',1.00,'');
UNLOCK TABLES;
LOCK TABLES `ds_dropdownfields` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_reference_tables` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_addcommands` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_access` WRITE;
INSERT IGNORE INTO `ds_access` (`role`, `table_name`, `read`, `write`, `delete`, `append` ) VALUES ('wahl_administration','wahlberechtigte_anlage',1,1,1,1 );
UNLOCK TABLES;
LOCK TABLES `ds` WRITE;
INSERT IGNORE INTO `ds` (`table_name`, `title`, `reorderfield`, `use_history`, `searchfield`, `displayfield`, `sortfield`, `searchany`, `hint`, `overview_tpl`, `sync_table`, `writetable`, `globalsearch`, `listselectionmodel`, `sync_view`, `syncable`, `cssstyle`, `alternativeformxtype`, `read_table`, `class_name`, `special_add_panel`, `existsreal`, `character_set_name`, `read_filter`, `listxtypeprefix`, `phpexporter`, `phpexporterfilename`, `combined`, `default_pagesize`, `allowForm`, `listviewbaseclass`, `showactionbtn`, `modelbaseclass`) VALUES ('wm_tanboegen','Tanbögen','',0,'id','id','id',1,'','','','',0,'cellmodel','',0,'','','','Wahlsystem','',1,'','','listview','XlsxWriter','tanbögen',0,1000,0,'Tualo.DataSets.ListView',1,'Tualo.DataSets.model.Basic');
UNLOCK TABLES;
LOCK TABLES `ds_column` WRITE;
INSERT IGNORE INTO `ds_column` (`table_name`, `column_name`, `default_value`, `default_max_value`, `default_min_value`, `update_value`, `is_primary`, `syncable`, `referenced_table`, `referenced_column_name`, `is_nullable`, `is_referenced`, `writeable`, `note`, `data_type`, `column_key`, `column_type`, `character_maximum_length`, `numeric_precision`, `numeric_scale`, `character_set_name`, `privileges`, `existsreal`, `deferedload`, `hint`, `fieldtype`) VALUES ('wm_tanboegen','datum','{DATE}',10000000,0,'',0,0,'','','YES','NO',1,'','date','','date',NULL,NULL,NULL,NULL,'select,insert,update,references',1,0,'',''),
('wm_tanboegen','id','{#serial}',10000000,0,'',1,0,'','','NO','NO',1,'','int','PRI','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,'',''),
('wm_tanboegen','zeit','{TIME}',10000000,0,'',0,0,'','','YES','NO',1,'','time','','time',NULL,NULL,NULL,NULL,'select,insert,update,references',1,0,'','');
UNLOCK TABLES;
LOCK TABLES `ds_column_list_label` WRITE;
INSERT IGNORE INTO `ds_column_list_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `editor`, `position`, `summaryrenderer`, `renderer`, `summarytype`, `hidden`, `active`, `filterstore`, `grouped`, `flex`, `direction`, `align`, `listfiltertype`, `hint`) VALUES ('wm_tanboegen','datum','DE','Datum','gridcolumn',NULL,999,'','','',0,1,'',0,1.00,'ASC','left','',NULL),
('wm_tanboegen','id','DE','Bogen-ID','gridcolumn','',0,'','','',0,1,'',0,1.00,'ASC','left','',''),
('wm_tanboegen','zeit','DE','Zeit','gridcolumn',NULL,999,'','','',0,1,'',0,1.00,'ASC','left','',NULL);
UNLOCK TABLES;
LOCK TABLES `ds_column_form_label` WRITE;
INSERT IGNORE INTO `ds_column_form_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `field_path`, `position`, `hidden`, `active`, `allowempty`, `fieldgroup`, `flex`, `hint`) VALUES ('wm_tanboegen','datum','DE','Datum','displayfield','Allgemein/Angaben',999,0,1,1,'1',1.00,'\'\''),
('wm_tanboegen','id','DE','Bogen-ID','displayfield','Allgemein/Angaben',0,0,1,1,'',1.00,'\'\''),
('wm_tanboegen','zeit','DE','Zeit','displayfield','Allgemein/Angaben',999,0,1,1,'1',1.00,'\'\'');
UNLOCK TABLES;
LOCK TABLES `ds_dropdownfields` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_reference_tables` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_addcommands` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_access` WRITE;
INSERT IGNORE INTO `ds_access` (`role`, `table_name`, `read`, `write`, `delete`, `append` ) VALUES ('wahl_administration','wm_tanboegen',1,1,1,1 );
UNLOCK TABLES;
LOCK TABLES `ds` WRITE;
INSERT IGNORE INTO `ds` (`table_name`, `title`, `reorderfield`, `use_history`, `searchfield`, `displayfield`, `sortfield`, `searchany`, `hint`, `overview_tpl`, `sync_table`, `writetable`, `globalsearch`, `listselectionmodel`, `sync_view`, `syncable`, `cssstyle`, `alternativeformxtype`, `read_table`, `class_name`, `special_add_panel`, `existsreal`, `character_set_name`, `read_filter`, `listxtypeprefix`, `phpexporter`, `phpexporterfilename`, `combined`, `default_pagesize`, `allowForm`, `listviewbaseclass`, `showactionbtn`, `modelbaseclass`) VALUES ('wm_tannummer','TAN','',0,'tannummer','tannummer','tannummer',1,'','','','',0,'cellmodel','',0,'','','','Wahlsystem','',1,'','','listview','XlsxWriter','tannummern',0,1000,0,'Tualo.DataSets.ListView',1,'Tualo.DataSets.model.Basic');
UNLOCK TABLES;
LOCK TABLES `ds_column` WRITE;
INSERT IGNORE INTO `ds_column` (`table_name`, `column_name`, `default_value`, `default_max_value`, `default_min_value`, `update_value`, `is_primary`, `syncable`, `referenced_table`, `referenced_column_name`, `is_nullable`, `is_referenced`, `writeable`, `note`, `data_type`, `column_key`, `column_type`, `character_maximum_length`, `numeric_precision`, `numeric_scale`, `character_set_name`, `privileges`, `existsreal`, `deferedload`, `hint`, `fieldtype`) VALUES ('wm_tannummer','aktiv','',10000000,0,NULL,0,0,NULL,NULL,'YES','NO',1,'','int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,'',''),
('wm_tannummer','bogen','',10000000,0,NULL,0,0,NULL,NULL,'NO','NO',1,'','int','MUL','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,0,'',''),
('wm_tannummer','tannummer','',10000000,0,NULL,1,0,NULL,NULL,'NO','NO',1,'','varchar','PRI','varchar(25)',25,NULL,NULL,'utf8mb4','select,insert,update,references',1,0,'','');
UNLOCK TABLES;
LOCK TABLES `ds_column_list_label` WRITE;
INSERT IGNORE INTO `ds_column_list_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `editor`, `position`, `summaryrenderer`, `renderer`, `summarytype`, `hidden`, `active`, `filterstore`, `grouped`, `flex`, `direction`, `align`, `listfiltertype`, `hint`) VALUES ('wm_tannummer','aktiv','DE','aktiv','gridcolumn',NULL,2,'','','',0,1,'',0,1.00,'ASC','left','',NULL),
('wm_tannummer','bogen','DE','Bogen','gridcolumn',NULL,0,'','','',0,1,'',0,1.00,'ASC','left','',NULL),
('wm_tannummer','tannummer','DE','Nummer','gridcolumn','',1,'','','',0,1,'',0,1.00,'ASC','left','','');
UNLOCK TABLES;
LOCK TABLES `ds_column_form_label` WRITE;
INSERT IGNORE INTO `ds_column_form_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `field_path`, `position`, `hidden`, `active`, `allowempty`, `fieldgroup`, `flex`, `hint`) VALUES ('wm_tannummer','aktiv','DE','aktiv','displayfield','Allgemein/Angaben',2,0,1,1,'1',1.00,'\'\''),
('wm_tannummer','bogen','DE','Bogen','displayfield','Allgemein/Angaben',0,0,1,1,'1',1.00,'\'\''),
('wm_tannummer','tannummer','DE','Nummer','displayfield','Allgemein/Angaben',1,0,1,1,'',1.00,'\'\'');
UNLOCK TABLES;
LOCK TABLES `ds_dropdownfields` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_reference_tables` WRITE;
INSERT IGNORE INTO `ds_reference_tables` (`table_name`, `reference_table_name`, `columnsdef`, `constraint_name`, `active`, `searchable`, `autosync`, `position`, `path`, `existsreal`, `tabtitle`) VALUES ('wm_tannummer','wm_tanboegen','{\"bogen\":\"id\"}','fk_wm_tanboegen_bogen',1,0,0,999,'',0,''),
('wm_tannummer','wm_tanboegen','{\"bogen\":\"id\"}','fk_wm_tanboegen_bogen',1,0,0,999,'',0,''),
('wm_tannummer','wm_tanboegen','{\"bogen\":\"id\"}','fk_wm_tanboegen_bogen',0,0,0,999,'',0,''),
('wm_tannummer','wm_tanboegen','{\"bogen\":\"id\"}','fk_wm_tanboegen_bogen',0,0,0,999,'',0,''),
('wm_tannummer','wm_tanboegen','{\"bogen\":\"id\"}','fk_wm_tanboegen_bogen',0,0,0,999,'',1,'');
UNLOCK TABLES;
LOCK TABLES `ds_addcommands` WRITE;
UNLOCK TABLES;
LOCK TABLES `ds_access` WRITE;
INSERT IGNORE INTO `ds_access` (`role`, `table_name`, `read`, `write`, `delete`, `append` ) VALUES ('wahl_administration','wm_tannummer',1,1,1,1 );
UNLOCK TABLES;
