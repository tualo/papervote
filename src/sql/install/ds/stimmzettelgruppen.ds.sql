DELIMITER;
SET FOREIGN_KEY_CHECKS=0;
INSERT INTO `ds` (`allowform`,`alternativeformxtype`,`autosave`,`base_store_class`,`character_set_name`,`class_name`,`combined`,`cssstyle`,`default_pagesize`,`displayfield`,`existsreal`,`globalsearch`,`hint`,`listselectionmodel`,`listviewbaseclass`,`listxtypeprefix`,`modelbaseclass`,`overview_tpl`,`phpexporter`,`phpexporterfilename`,`read_filter`,`read_table`,`reorderfield`,`searchany`,`searchfield`,`showactionbtn`,`sortfield`,`special_add_panel`,`syncable`,`sync_table`,`sync_view`,`table_name`,`title`,`use_history`,`use_insert_for_update`,`writetable`) VALUES ('0','','0','Tualo.DataSets.data.Store','','Wahlsystem','0','','1000','name','1','0','','tualomultirowmodel','Tualo.DataSets.ListView','listview','Tualo.DataSets.model.Basic','','XlsxWriter','stimmzettelgruppen','','','','1','name','1','id','','0','','','stimmzettelgruppen','Stimmzettelgruppen','0','0','') ON DUPLICATE KEY UPDATE `allowform`=values(`allowform`),`alternativeformxtype`=values(`alternativeformxtype`),`autosave`=values(`autosave`),`base_store_class`=values(`base_store_class`),`character_set_name`=values(`character_set_name`),`class_name`=values(`class_name`),`combined`=values(`combined`),`cssstyle`=values(`cssstyle`),`default_pagesize`=values(`default_pagesize`),`displayfield`=values(`displayfield`),`existsreal`=values(`existsreal`),`globalsearch`=values(`globalsearch`),`hint`=values(`hint`),`listselectionmodel`=values(`listselectionmodel`),`listviewbaseclass`=values(`listviewbaseclass`),`listxtypeprefix`=values(`listxtypeprefix`),`modelbaseclass`=values(`modelbaseclass`),`overview_tpl`=values(`overview_tpl`),`phpexporter`=values(`phpexporter`),`phpexporterfilename`=values(`phpexporterfilename`),`read_filter`=values(`read_filter`),`read_table`=values(`read_table`),`reorderfield`=values(`reorderfield`),`searchany`=values(`searchany`),`searchfield`=values(`searchfield`),`showactionbtn`=values(`showactionbtn`),`sortfield`=values(`sortfield`),`special_add_panel`=values(`special_add_panel`),`syncable`=values(`syncable`),`sync_table`=values(`sync_table`),`sync_view`=values(`sync_view`),`table_name`=values(`table_name`),`title`=values(`title`),`use_history`=values(`use_history`),`use_insert_for_update`=values(`use_insert_for_update`),`writetable`=values(`writetable`); 
INSERT IGNORE INTO `ds_column` (`character_maximum_length`,`character_set_name`,`column_key`,`column_name`,`column_type`,`data_type`,`default_max_value`,`default_min_value`,`default_value`,`deferedload`,`existsreal`,`fieldtype`,`hint`,`is_nullable`,`is_primary`,`is_referenced`,`note`,`numeric_precision`,`numeric_scale`,`privileges`,`referenced_column_name`,`referenced_table`,`syncable`,`table_name`,`update_value`,`writeable`) VALUES ('0','','','created_at','timestamp','time','0','0','{:now()}','0','1','','','NO','0','','','0','0','select,insert,update,references','','','0','stimmzettelgruppen','','1') ; 
INSERT IGNORE INTO `ds_column` (`column_key`,`column_name`,`column_type`,`data_type`,`default_max_value`,`default_min_value`,`default_value`,`deferedload`,`existsreal`,`fieldtype`,`hint`,`is_nullable`,`is_primary`,`is_referenced`,`note`,`numeric_precision`,`numeric_scale`,`privileges`,`syncable`,`table_name`,`writeable`) VALUES ('PRI','id','int(11)','int','10000000','0','','0','1','','','NO','1','NO','','10','0','select,insert,update,references','0','stimmzettelgruppen','1') ; 
INSERT IGNORE INTO `ds_column` (`character_maximum_length`,`character_set_name`,`column_key`,`column_name`,`column_type`,`data_type`,`default_max_value`,`default_min_value`,`default_value`,`deferedload`,`existsreal`,`fieldtype`,`hint`,`is_nullable`,`is_primary`,`is_referenced`,`note`,`numeric_precision`,`numeric_scale`,`privileges`,`referenced_column_name`,`referenced_table`,`syncable`,`table_name`,`update_value`,`writeable`) VALUES ('255','utf8mb4','','login','varchar(255)','varchar','0','0','{:getSessionUser()}','0','1','','','NO','0','','','0','0','select,insert,update,references','','','0','stimmzettelgruppen','','1') ; 
INSERT IGNORE INTO `ds_column` (`column_key`,`column_name`,`column_type`,`data_type`,`default_max_value`,`default_min_value`,`default_value`,`deferedload`,`existsreal`,`fieldtype`,`hint`,`is_nullable`,`is_primary`,`is_referenced`,`note`,`numeric_precision`,`numeric_scale`,`privileges`,`referenced_column_name`,`referenced_table`,`syncable`,`table_name`,`update_value`,`writeable`) VALUES ('','mindestsitze','int(11)','int','10000000','0','0','0','1','','','YES','0','','','10','0','select,insert,update,references','','','0','stimmzettelgruppen','','1') ; 
INSERT IGNORE INTO `ds_column` (`character_maximum_length`,`character_set_name`,`column_key`,`column_name`,`column_type`,`data_type`,`default_max_value`,`default_min_value`,`default_value`,`deferedload`,`existsreal`,`fieldtype`,`hint`,`is_nullable`,`is_primary`,`is_referenced`,`note`,`privileges`,`referenced_column_name`,`referenced_table`,`syncable`,`table_name`,`update_value`,`writeable`) VALUES ('255','utf8mb4','','name','varchar(255)','varchar','10000000','0','','0','1','','','YES','0','NO','\'\'','select,insert,update,references','','','0','stimmzettelgruppen','','1') ; 
INSERT IGNORE INTO `ds_column` (`character_maximum_length`,`character_set_name`,`column_key`,`column_name`,`column_type`,`data_type`,`existsreal`,`fieldtype`,`is_nullable`,`privileges`,`table_name`,`writeable`) VALUES ('255','utf8mb4','','onlinebezeichnung','varchar(255)','varchar','1','','YES','select,insert,update,references','stimmzettelgruppen','1') ; 
INSERT IGNORE INTO `ds_column` (`column_key`,`column_name`,`column_type`,`data_type`,`default_max_value`,`default_min_value`,`default_value`,`deferedload`,`existsreal`,`fieldtype`,`hint`,`is_nullable`,`is_primary`,`is_referenced`,`note`,`numeric_precision`,`numeric_scale`,`privileges`,`referenced_column_name`,`referenced_table`,`syncable`,`table_name`,`update_value`,`writeable`) VALUES ('','sitze','int(11)','int','10000000','0','0','0','1','','','YES','0','NO','','10','0','select,insert,update,references','','','0','stimmzettelgruppen','','1') ; 
INSERT IGNORE INTO `ds_column` (`character_maximum_length`,`character_set_name`,`column_key`,`column_name`,`column_type`,`data_type`,`default_max_value`,`default_min_value`,`default_value`,`deferedload`,`existsreal`,`fieldtype`,`hint`,`is_nullable`,`is_primary`,`is_referenced`,`note`,`numeric_precision`,`numeric_scale`,`privileges`,`referenced_column_name`,`referenced_table`,`syncable`,`table_name`,`update_value`,`writeable`) VALUES ('0','','MUL','stimmzettel','int(11)','int','10000000','0','1','0','1','','','NO','0','NO','','10','0','select,insert,update,references','','','0','stimmzettelgruppen','','1') ; 
INSERT IGNORE INTO `ds_column` (`character_maximum_length`,`character_set_name`,`column_key`,`column_name`,`column_type`,`data_type`,`default_max_value`,`default_min_value`,`default_value`,`deferedload`,`existsreal`,`fieldtype`,`hint`,`is_nullable`,`is_primary`,`is_referenced`,`note`,`numeric_precision`,`numeric_scale`,`privileges`,`referenced_column_name`,`referenced_table`,`syncable`,`table_name`,`update_value`,`writeable`) VALUES ('0','','','updated_at','timestamp','time','0','0','{:now()}','0','1','','','NO','0','','','0','0','select,insert,update,references','','','0','stimmzettelgruppen','','1') ; 
INSERT IGNORE INTO `ds_column_list_label` (`active`,`column_name`,`editor`,`filterstore`,`flex`,`grouped`,`hidden`,`label`,`language`,`listfiltertype`,`position`,`renderer`,`summaryrenderer`,`summarytype`,`table_name`,`xtype`) VALUES ('1','created_at','','','1.00','0','1','Anlage','DE','','7','','','','stimmzettelgruppen','gridcolumn') ; 
INSERT IGNORE INTO `ds_column_list_label` (`active`,`column_name`,`editor`,`filterstore`,`flex`,`grouped`,`hidden`,`label`,`language`,`listfiltertype`,`position`,`renderer`,`summaryrenderer`,`summarytype`,`table_name`,`xtype`) VALUES ('1','id','','','1.00','0','0','ID','DE','','0','','','','stimmzettelgruppen','gridcolumn') ; 
INSERT IGNORE INTO `ds_column_list_label` (`active`,`column_name`,`editor`,`filterstore`,`flex`,`grouped`,`hidden`,`label`,`language`,`listfiltertype`,`position`,`renderer`,`summaryrenderer`,`summarytype`,`table_name`,`xtype`) VALUES ('1','login','','','1.00','0','1','Login','DE','','6','','','','stimmzettelgruppen','gridcolumn') ; 
INSERT IGNORE INTO `ds_column_list_label` (`active`,`column_name`,`editor`,`filterstore`,`flex`,`grouped`,`hidden`,`label`,`language`,`listfiltertype`,`position`,`renderer`,`summaryrenderer`,`summarytype`,`table_name`,`xtype`) VALUES ('1','mindestsitze','','','1.00','0','0','Mindestsitze','DE','','5','','','','stimmzettelgruppen','gridcolumn') ; 
INSERT IGNORE INTO `ds_column_list_label` (`active`,`column_name`,`editor`,`filterstore`,`flex`,`grouped`,`hidden`,`label`,`language`,`listfiltertype`,`position`,`renderer`,`summaryrenderer`,`summarytype`,`table_name`,`xtype`) VALUES ('1','name','','','1.00','0','0','Name','DE','','1','','','','stimmzettelgruppen','gridcolumn') ; 
INSERT IGNORE INTO `ds_column_list_label` (`active`,`column_name`,`editor`,`filterstore`,`flex`,`grouped`,`hidden`,`label`,`language`,`listfiltertype`,`position`,`renderer`,`summaryrenderer`,`summarytype`,`table_name`,`xtype`) VALUES ('1','onlinebezeichnung','','','1.00','0','0','Onlinebezeichnung','DE','','2','','','','stimmzettelgruppen','gridcolumn') ; 
INSERT IGNORE INTO `ds_column_list_label` (`active`,`column_name`,`editor`,`filterstore`,`flex`,`grouped`,`hidden`,`label`,`language`,`listfiltertype`,`position`,`renderer`,`summaryrenderer`,`summarytype`,`table_name`,`xtype`) VALUES ('1','sitze','','','1.00','0','0','Sitze','DE','','4','','','','stimmzettelgruppen','gridcolumn') ; 
INSERT IGNORE INTO `ds_column_list_label` (`active`,`column_name`,`editor`,`filterstore`,`flex`,`grouped`,`hidden`,`label`,`language`,`listfiltertype`,`position`,`renderer`,`summaryrenderer`,`summarytype`,`table_name`,`xtype`) VALUES ('1','stimmzettel','','','1.00','0','0','Stimmzettel','DE','','3','','','','stimmzettelgruppen','column_stimmzettel_id') ; 
INSERT IGNORE INTO `ds_column_list_label` (`active`,`column_name`,`editor`,`filterstore`,`flex`,`grouped`,`hidden`,`label`,`language`,`listfiltertype`,`position`,`renderer`,`summaryrenderer`,`summarytype`,`table_name`,`xtype`) VALUES ('1','updated_at','','','1.00','0','1','Änderung','DE','','8','','','','stimmzettelgruppen','gridcolumn') ; 
INSERT IGNORE INTO `ds_column_form_label` (`active`,`allowempty`,`column_name`,`field_path`,`flex`,`hidden`,`label`,`language`,`position`,`table_name`,`xtype`) VALUES ('1','1','created_at','Allgemein/Satzinformationen','1.00','0','Anlage','DE','7','stimmzettelgruppen','displayfield') ; 
INSERT IGNORE INTO `ds_column_form_label` (`active`,`allowempty`,`column_name`,`field_path`,`flex`,`hidden`,`label`,`language`,`position`,`table_name`,`xtype`) VALUES ('1','1','id','Allgemein/Satzinformationen','1.00','0','ID','DE','5','stimmzettelgruppen','displayfield') ; 
INSERT IGNORE INTO `ds_column_form_label` (`active`,`allowempty`,`column_name`,`field_path`,`flex`,`hidden`,`label`,`language`,`position`,`table_name`,`xtype`) VALUES ('1','1','login','Allgemein/Satzinformationen','1.00','0','Login','DE','6','stimmzettelgruppen','displayfield') ; 
INSERT IGNORE INTO `ds_column_form_label` (`active`,`allowempty`,`column_name`,`field_path`,`flex`,`hidden`,`label`,`language`,`position`,`table_name`,`xtype`) VALUES ('1','0','mindestsitze','Allgemein/Angaben','1.00','0','Mindestsitze','DE','4','stimmzettelgruppen','number0') ; 
INSERT IGNORE INTO `ds_column_form_label` (`active`,`allowempty`,`column_name`,`field_path`,`flex`,`hidden`,`label`,`language`,`position`,`table_name`,`xtype`) VALUES ('1','1','name','Allgemein/Angaben','1.00','0','Name','DE','0','stimmzettelgruppen','textfield') ; 
INSERT IGNORE INTO `ds_column_form_label` (`active`,`allowempty`,`column_name`,`field_path`,`flex`,`hidden`,`label`,`language`,`position`,`table_name`,`xtype`) VALUES ('1','1','onlinebezeichnung','Allgemein/Angaben','1.00','0','Onlinebezeichnung','DE','1','stimmzettelgruppen','displayfield') ; 
INSERT IGNORE INTO `ds_column_form_label` (`active`,`allowempty`,`column_name`,`field_path`,`flex`,`hidden`,`label`,`language`,`position`,`table_name`,`xtype`) VALUES ('1','0','sitze','Allgemein/Angaben','1.00','0','Sitze','DE','3','stimmzettelgruppen','number0') ; 
INSERT IGNORE INTO `ds_column_form_label` (`active`,`allowempty`,`column_name`,`field_path`,`flex`,`hidden`,`label`,`language`,`position`,`table_name`,`xtype`) VALUES ('1','0','stimmzettel','Allgemein/Angaben','1.00','0','Stimmzettel','DE','2','stimmzettelgruppen','combobox_stimmzettel_id') ; 
INSERT IGNORE INTO `ds_column_form_label` (`active`,`allowempty`,`column_name`,`field_path`,`flex`,`hidden`,`label`,`language`,`position`,`table_name`,`xtype`) VALUES ('1','1','updated_at','Allgemein/Satzinformationen','1.00','0','Änderung','DE','8','stimmzettelgruppen','displayfield') ; 
INSERT IGNORE INTO `ds_dropdownfields` (`displayfield`,`filterconfig`,`idfield`,`name`,`table_name`) VALUES ('name','','id','id','stimmzettelgruppen') ; 
INSERT IGNORE INTO `ds_reference_tables` (`active`,`autosync`,`columnsdef`,`constraint_name`,`existsreal`,`path`,`position`,`reference_table_name`,`searchable`,`table_name`,`tabtitle`) VALUES ('1','0','{\"stimmzettel\":\"id\"}','fk_stimmzettelgruppen_stimmzettel','1','','999','stimmzettel','0','stimmzettelgruppen','') ; 
INSERT IGNORE INTO `ds_access` (`append`,`delete`,`read`,`role`,`table_name`,`write`) VALUES ('0','0','0','_default_','stimmzettelgruppen','0') ; 
INSERT IGNORE INTO `ds_access` (`append`,`delete`,`read`,`role`,`table_name`,`write`) VALUES ('1','1','1','administration','stimmzettelgruppen','1') ; 
SET FOREIGN_KEY_CHECKS=1;