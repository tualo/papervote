DELIMITER ;
INSERT INTO `ds` (`table_name`, `title`, `reorderfield`, `use_history`, `searchfield`, `displayfield`, `sortfield`, `searchany`, `hint`, `overview_tpl`, `sync_table`, `writetable`, `globalsearch`, `listselectionmodel`, `sync_view`, `syncable`, `cssstyle`, `alternativeformxtype`, `read_table`, `class_name`, `special_add_panel`, `existsreal`, `character_set_name`, `read_filter`, `listxtypeprefix`, `phpexporter`, `phpexporterfilename`, `combined`, `default_pagesize`, `allowForm`, `listviewbaseclass`, `showactionbtn`, `modelbaseclass`) VALUES ('kandidaten','Kandidaten','',0,'anzeige_name','anzeige_name','barcode',1,'','1','0','',0,'tualomultirowmodel','',0,'1','','view_readtable_kandidaten','Wahlsystem','',1,'','','listview','XlsxWriter','kandidaten-{DATE}',0,10000,0,'Tualo.DataSets.ListView',1,'Tualo.DataSets.model.Basic') ON DUPLICATE KEY UPDATE title=VALUES(title), reorderfield=VALUES(reorderfield), use_history=VALUES(use_history), searchfield=VALUES(searchfield), displayfield=VALUES(displayfield), sortfield=VALUES(sortfield), searchany=VALUES(searchany), hint=VALUES(hint), overview_tpl=VALUES(overview_tpl), sync_table=VALUES(sync_table), writetable=VALUES(writetable), globalsearch=VALUES(globalsearch), listselectionmodel=VALUES(listselectionmodel), sync_view=VALUES(sync_view), syncable=VALUES(syncable), cssstyle=VALUES(cssstyle), alternativeformxtype=VALUES(alternativeformxtype), read_table=   VALUES(read_table), class_name=VALUES(class_name), special_add_panel=VALUES(special_add_panel), existsreal=VALUES(existsreal), character_set_name=VALUES(character_set_name), read_filter=VALUES(read_filter), listxtypeprefix=VALUES(listxtypeprefix), phpexporter=VALUES(phpexporter), phpexporterfilename=VALUES(phpexporterfilename), combined=VALUES(combined), default_pagesize=VALUES(default_pagesize), allowForm=VALUES(allowForm), listviewbaseclass=VALUES(listviewbaseclass), showactionbtn=VALUES(showactionbtn), modelbaseclass=VALUES(modelbaseclass);
REPLACE INTO `ds_column` (`table_name`, `column_name`, `default_value`, `default_max_value`, `default_min_value`, `update_value`, `is_primary`, `syncable`, `referenced_table`, `referenced_column_name`, `is_nullable`, `is_referenced`, `writeable`, `note`, `data_type`, `column_key`, `column_type`, `character_maximum_length`, `numeric_precision`, `numeric_scale`, `character_set_name`, `privileges`, `existsreal`, `deferedload`, `hint`, `fieldtype`) VALUES ('kandidaten','aktiv','1',NULL,NULL,NULL,0,NULL,NULL,NULL,'YES',NULL,1,NULL,'tinyint','','tinyint(4)',NULL,3,0,NULL,'select,insert,update,references',1,NULL,NULL,''),
('kandidaten','anrede','',NULL,NULL,NULL,0,NULL,NULL,NULL,'YES',NULL,1,NULL,'varchar','','varchar(100)',100,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL,''),
('kandidaten','anzeige_name',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'YES',NULL,0,NULL,'text','','text',65535,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL,''),
('kandidaten','barcode','',0,0,'',0,0,'','','YES','',1,'','varchar','','varchar(5)',5,0,0,'utf8mb4','select,insert,update,references',1,0,'',''),
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
('kandidaten','kostenstelle','0',NULL,NULL,NULL,0,NULL,NULL,NULL,'YES',NULL,1,NULL,'int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,NULL,NULL,''),
('kandidaten','losnummer','0',NULL,NULL,NULL,0,NULL,NULL,NULL,'YES',NULL,1,NULL,'int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,NULL,NULL,''),
('kandidaten','losnummer_stimmzettelgruppe','0',NULL,NULL,NULL,0,NULL,NULL,NULL,'YES',NULL,1,NULL,'int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,NULL,NULL,''),
('kandidaten','losung_verloren','',NULL,NULL,NULL,0,NULL,NULL,NULL,'YES',NULL,1,NULL,'tinyint','','tinyint(4)',NULL,3,0,NULL,'select,insert,update,references',1,NULL,NULL,''),
('kandidaten','nachname','',NULL,NULL,NULL,0,NULL,NULL,NULL,'YES',NULL,1,NULL,'varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL,''),
('kandidaten','nachruecker','',NULL,NULL,NULL,0,NULL,NULL,NULL,'YES',NULL,1,NULL,'tinyint','','tinyint(4)',NULL,3,0,NULL,'select,insert,update,references',1,NULL,NULL,''),
('kandidaten','personen_identnummer','',NULL,NULL,NULL,0,NULL,NULL,NULL,'YES',NULL,1,NULL,'varchar','','varchar(15)',15,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL,''),
('kandidaten','portrait_url',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'YES',NULL,0,NULL,'varchar','','varchar(64)',64,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL,''),
('kandidaten','ridx','',0,0,'',0,0,'','','YES','',1,'','varchar','UNI','varchar(12)',12,0,0,'utf8mb4','select,insert,update,references',1,0,'',''),
('kandidaten','sitze',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'YES',NULL,0,NULL,'int','','int(11)',NULL,10,0,NULL,'select,insert,update,references',1,NULL,NULL,''),
('kandidaten','stimmzettelgruppen','',NULL,NULL,NULL,0,NULL,NULL,NULL,'YES',NULL,1,NULL,'varchar','MUL','varchar(12)',12,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL,''),
('kandidaten','stimmzettelgruppen_text',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'YES',NULL,0,NULL,'varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL,''),
('kandidaten','telefon','',NULL,NULL,NULL,0,NULL,NULL,NULL,'YES',NULL,1,NULL,'varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL,''),
('kandidaten','titel','',NULL,NULL,NULL,0,NULL,NULL,NULL,'YES',NULL,1,NULL,'varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL,''),
('kandidaten','vergeben',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'NO',NULL,0,NULL,'bigint','','bigint(21)',NULL,19,0,NULL,'select,insert,update,references',1,NULL,NULL,''),
('kandidaten','vorname','',NULL,NULL,NULL,0,NULL,NULL,NULL,'YES',NULL,1,NULL,'varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL,''),
('kandidaten','www','',NULL,NULL,NULL,0,NULL,NULL,NULL,'YES',NULL,1,NULL,'varchar','','varchar(255)',255,NULL,NULL,'utf8mb4','select,insert,update,references',1,NULL,NULL,'');
INSERT  IGNORE INTO `ds_column_list_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `editor`, `position`, `summaryrenderer`, `renderer`, `summarytype`, `hidden`, `active`, `filterstore`, `grouped`, `flex`, `direction`, `align`, `listfiltertype`, `hint`) VALUES ('kandidaten','aktiv','DE','Aktiv','gridcolumn','',0,'','','',1,1,'',0,1.00,'ASC','left','',''),
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
('kandidaten','portrait_url','DE','portrait_url','gridcolumn','',999,'','','',1,1,'',0,1.00,'','start','','NULL'),
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
INSERT  IGNORE INTO `ds_column_form_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `field_path`, `position`, `hidden`, `active`, `allowempty`, `fieldgroup`, `flex`, `hint`) VALUES ('kandidaten','aktiv','DE','Aktiv','checkbox','Allgemein/Kandidat',0,0,1,1,'',1.00,''),
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
INSERT  IGNORE INTO `ds_dropdownfields` (`table_name`, `name`, `idfield`, `displayfield`, `filterconfig`) VALUES ('kandidaten','RIDX','ridx','name',NULL);
INSERT  IGNORE INTO `ds_reference_tables` (`table_name`, `reference_table_name`, `columnsdef`, `constraint_name`, `active`, `searchable`, `autosync`, `position`, `path`, `existsreal`, `tabtitle`) VALUES ('kandidaten','stimmzettel','{\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\",\"kandidaten__stimmzettel\":\"stimmzettel__ridx\"}','',0,0,1,99999,'',0,''),
('kandidaten','stimmzettel','{\"kandidaten__stimmzettel\":\"stimmzettel__ridx\"}','kandidaten_ibfk_1',0,0,1,99999,'',0,''),
('kandidaten','stimmzettelgruppen','{\"stimmzettelgruppen\":\"ridx\"}','fk_kandidaten_stimmzettelgruppen',1,0,0,999,'',1,'');
INSERT  IGNORE INTO `ds_access` (`role`, `table_name`, `read`, `write`, `delete`, `append`, `existsreal`) VALUES ('administration','kandidaten',1,1,1,1,1);


update ds_column set is_primary = 0 where table_name = 'kandidaten' and column_name = 'kostenstelle';