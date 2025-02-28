DELIMITER;
SET FOREIGN_KEY_CHECKS=0;
INSERT INTO `ds` (`allowform`,`alternativeformxtype`,`autosave`,`base_store_class`,`character_set_name`,`class_name`,`combined`,`cssstyle`,`default_pagesize`,`displayfield`,`existsreal`,`globalsearch`,`hint`,`listselectionmodel`,`listviewbaseclass`,`listxtypeprefix`,`modelbaseclass`,`overview_tpl`,`phpexporter`,`phpexporterfilename`,`read_filter`,`read_table`,`reorderfield`,`searchany`,`searchfield`,`showactionbtn`,`sortfield`,`special_add_panel`,`syncable`,`sync_table`,`sync_view`,`table_name`,`title`,`use_history`,`use_insert_for_update`,`writetable`) VALUES ('0','','0','Tualo.DataSets.data.Store','','Wahlsystem','0','','10000','identnummer','1','0','','cellmodel','Tualo.DataSets.ListView','listview','Tualo.DataSets.model.Basic','','XlsxWriter','wahlberechtigte-{DATE}','','','','1','identnummer','1','id','','0','','','wahlberechtigte','Wahlberechtigte','0','0','') ON DUPLICATE KEY UPDATE `allowform`=values(`allowform`),`alternativeformxtype`=values(`alternativeformxtype`),`autosave`=values(`autosave`),`base_store_class`=values(`base_store_class`),`character_set_name`=values(`character_set_name`),`class_name`=values(`class_name`),`combined`=values(`combined`),`cssstyle`=values(`cssstyle`),`default_pagesize`=values(`default_pagesize`),`displayfield`=values(`displayfield`),`existsreal`=values(`existsreal`),`globalsearch`=values(`globalsearch`),`hint`=values(`hint`),`listselectionmodel`=values(`listselectionmodel`),`listviewbaseclass`=values(`listviewbaseclass`),`listxtypeprefix`=values(`listxtypeprefix`),`modelbaseclass`=values(`modelbaseclass`),`overview_tpl`=values(`overview_tpl`),`phpexporter`=values(`phpexporter`),`phpexporterfilename`=values(`phpexporterfilename`),`read_filter`=values(`read_filter`),`read_table`=values(`read_table`),`reorderfield`=values(`reorderfield`),`searchany`=values(`searchany`),`searchfield`=values(`searchfield`),`showactionbtn`=values(`showactionbtn`),`sortfield`=values(`sortfield`),`special_add_panel`=values(`special_add_panel`),`syncable`=values(`syncable`),`sync_table`=values(`sync_table`),`sync_view`=values(`sync_view`),`table_name`=values(`table_name`),`title`=values(`title`),`use_history`=values(`use_history`),`use_insert_for_update`=values(`use_insert_for_update`),`writetable`=values(`writetable`); 
INSERT IGNORE INTO `ds_column` (`character_maximum_length`,`character_set_name`,`column_key`,`column_name`,`column_type`,`data_type`,`default_max_value`,`default_min_value`,`default_value`,`deferedload`,`existsreal`,`fieldtype`,`hint`,`is_generated`,`is_nullable`,`is_primary`,`is_referenced`,`note`,`numeric_precision`,`numeric_scale`,`privileges`,`referenced_column_name`,`referenced_table`,`syncable`,`table_name`,`update_value`,`writeable`) VALUES ('0','','','aktiv','tinyint(4)','tinyint','100000','0','0','0','1','','','NEVER','YES','0','NO','','3','0','select,insert,update,references','','','0','wahlberechtigte','','1') ; 
INSERT IGNORE INTO `ds_column` (`character_maximum_length`,`character_set_name`,`column_key`,`column_name`,`column_type`,`data_type`,`default_max_value`,`default_min_value`,`default_value`,`deferedload`,`existsreal`,`fieldtype`,`hint`,`is_generated`,`is_nullable`,`is_primary`,`is_referenced`,`note`,`numeric_precision`,`numeric_scale`,`privileges`,`referenced_column_name`,`referenced_table`,`syncable`,`table_name`,`update_value`,`writeable`) VALUES ('0','','','created_at','timestamp','time','0','0','{:now()}','0','1','','','NEVER','NO','0','','','0','0','select,insert,update,references','','','0','wahlberechtigte','','1') ; 
INSERT IGNORE INTO `ds_column` (`character_maximum_length`,`character_set_name`,`column_key`,`column_name`,`column_type`,`data_type`,`default_max_value`,`default_min_value`,`default_value`,`deferedload`,`existsreal`,`fieldtype`,`hint`,`is_generated`,`is_nullable`,`is_primary`,`is_referenced`,`note`,`numeric_precision`,`numeric_scale`,`privileges`,`referenced_column_name`,`referenced_table`,`syncable`,`table_name`,`update_value`,`writeable`) VALUES ('0','','PRI','id','bigint(20)','bigint','0','0','{#serial}','0','1','','','NEVER','NO','1','NO','','19','0','select,insert,update,references','','','0','wahlberechtigte','','1') ; 
INSERT IGNORE INTO `ds_column` (`character_maximum_length`,`character_set_name`,`column_key`,`column_name`,`column_type`,`data_type`,`default_max_value`,`default_min_value`,`default_value`,`deferedload`,`existsreal`,`fieldtype`,`hint`,`is_generated`,`is_nullable`,`is_primary`,`is_referenced`,`note`,`privileges`,`syncable`,`table_name`,`update_value`,`writeable`) VALUES ('255','utf8mb4','MUL','identnummer','varchar(255)','varchar','100000','0','','0','1','','','NEVER','YES','0','NO','','select,insert,update,references','0','wahlberechtigte','','1') ; 
INSERT IGNORE INTO `ds_column` (`character_maximum_length`,`character_set_name`,`column_key`,`column_name`,`column_type`,`data_type`,`default_max_value`,`default_min_value`,`default_value`,`deferedload`,`existsreal`,`fieldtype`,`hint`,`is_generated`,`is_nullable`,`is_primary`,`is_referenced`,`note`,`privileges`,`referenced_column_name`,`referenced_table`,`syncable`,`table_name`,`update_value`,`writeable`) VALUES ('255','utf8mb4','','login','varchar(255)','varchar','100000','0','{:getSessionUser()}','0','1','','','NEVER','NO','0','NO','','select,insert,update,references','','','0','wahlberechtigte','','1') ; 
INSERT IGNORE INTO `ds_column` (`character_maximum_length`,`character_set_name`,`column_key`,`column_name`,`column_type`,`data_type`,`default_max_value`,`default_min_value`,`default_value`,`deferedload`,`existsreal`,`fieldtype`,`hint`,`is_generated`,`is_nullable`,`is_primary`,`is_referenced`,`note`,`numeric_precision`,`numeric_scale`,`privileges`,`referenced_column_name`,`referenced_table`,`syncable`,`table_name`,`update_value`,`writeable`) VALUES ('0','','','updated_at','timestamp','time','0','0','{:now()}','0','1','','','NEVER','NO','0','','','0','0','select,insert,update,references','','','0','wahlberechtigte','','1') ; 
INSERT IGNORE INTO `ds_column_list_label` (`active`,`column_name`,`editor`,`filterstore`,`flex`,`grouped`,`hidden`,`label`,`language`,`listfiltertype`,`position`,`renderer`,`summaryrenderer`,`summarytype`,`table_name`,`xtype`) VALUES ('1','aktiv','','','1.00','0','0','Aktiv','DE','','1','','','','wahlberechtigte','checkcolumn') ; 
INSERT IGNORE INTO `ds_column_list_label` (`active`,`column_name`,`editor`,`filterstore`,`flex`,`grouped`,`hidden`,`label`,`language`,`listfiltertype`,`position`,`renderer`,`summaryrenderer`,`summarytype`,`table_name`,`xtype`) VALUES ('1','created_at','','','1.00','0','1','Anlage','DE','','4','','','','wahlberechtigte','gridcolumn') ; 
INSERT IGNORE INTO `ds_column_list_label` (`active`,`column_name`,`editor`,`filterstore`,`flex`,`grouped`,`hidden`,`label`,`language`,`listfiltertype`,`position`,`renderer`,`summaryrenderer`,`summarytype`,`table_name`,`xtype`) VALUES ('1','id','','','1.00','0','0','ID','DE','','0','','','','wahlberechtigte','gridcolumn') ; 
INSERT IGNORE INTO `ds_column_list_label` (`active`,`column_name`,`editor`,`filterstore`,`flex`,`grouped`,`hidden`,`label`,`language`,`listfiltertype`,`position`,`renderer`,`summaryrenderer`,`summarytype`,`table_name`,`xtype`) VALUES ('1','identnummer','','','1.00','0','0','Identnummer','DE','','2','','','','wahlberechtigte','gridcolumn') ; 
INSERT IGNORE INTO `ds_column_list_label` (`active`,`column_name`,`editor`,`filterstore`,`flex`,`grouped`,`hidden`,`label`,`language`,`listfiltertype`,`position`,`renderer`,`summaryrenderer`,`summarytype`,`table_name`,`xtype`) VALUES ('1','login','','','1.00','0','1','Login','DE','','3','','','','wahlberechtigte','gridcolumn') ; 
INSERT IGNORE INTO `ds_column_list_label` (`active`,`column_name`,`editor`,`filterstore`,`flex`,`grouped`,`hidden`,`label`,`language`,`listfiltertype`,`position`,`renderer`,`summaryrenderer`,`summarytype`,`table_name`,`xtype`) VALUES ('1','updated_at','','','1.00','0','1','Änderung','DE','','5','','','','wahlberechtigte','gridcolumn') ; 
INSERT IGNORE INTO `ds_column_form_label` (`active`,`allowempty`,`column_name`,`field_path`,`flex`,`hidden`,`label`,`language`,`position`,`table_name`,`xtype`) VALUES ('1','1','aktiv','Allgemein/Angaben','1.00','0','Aktiv','DE','0','wahlberechtigte','checkbox') ; 
INSERT IGNORE INTO `ds_column_form_label` (`active`,`allowempty`,`column_name`,`field_path`,`flex`,`hidden`,`label`,`language`,`position`,`table_name`,`xtype`) VALUES ('1','1','created_at','Allgemein/Satzinformationen','1.00','0','Anlage','DE','4','wahlberechtigte','displayfield') ; 
INSERT IGNORE INTO `ds_column_form_label` (`active`,`allowempty`,`column_name`,`field_path`,`flex`,`hidden`,`label`,`language`,`position`,`table_name`,`xtype`) VALUES ('1','1','id','Allgemein/Satzinformationen','1.00','0','ID','DE','2','wahlberechtigte','displayfield') ; 
INSERT IGNORE INTO `ds_column_form_label` (`active`,`allowempty`,`column_name`,`field_path`,`flex`,`hidden`,`label`,`language`,`position`,`table_name`,`xtype`) VALUES ('1','1','identnummer','Allgemein/Angaben','1.00','0','Identnummer','DE','1','wahlberechtigte','textfield') ; 
INSERT IGNORE INTO `ds_column_form_label` (`active`,`allowempty`,`column_name`,`field_path`,`flex`,`hidden`,`label`,`language`,`position`,`table_name`,`xtype`) VALUES ('1','1','login','Allgemein/Satzinformationen','1.00','0','Login','DE','3','wahlberechtigte','textfield') ; 
INSERT IGNORE INTO `ds_column_form_label` (`active`,`allowempty`,`column_name`,`field_path`,`flex`,`hidden`,`label`,`language`,`position`,`table_name`,`xtype`) VALUES ('1','1','updated_at','Allgemein/Satzinformationen','1.00','0','Änderung','DE','5','wahlberechtigte','displayfield') ; 
INSERT IGNORE INTO `ds_dropdownfields` (`displayfield`,`filterconfig`,`idfield`,`name`,`table_name`) VALUES ('name','','id','id','wahlberechtigte') ; 
INSERT IGNORE INTO `ds_access` (`append`,`delete`,`read`,`role`,`table_name`,`write`) VALUES ('0','0','0','_default_','wahlberechtigte','0') ; 
INSERT IGNORE INTO `ds_access` (`append`,`delete`,`read`,`role`,`table_name`,`write`) VALUES ('1','1','1','administration','wahlberechtigte','1') ; 
SET FOREIGN_KEY_CHECKS=1;