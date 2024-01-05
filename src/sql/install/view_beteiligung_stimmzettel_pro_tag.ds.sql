DELIMITER ;
INSERT INTO `ds` (`table_name`, `title`, `reorderfield`, `use_history`, `searchfield`, `displayfield`, `sortfield`, `searchany`, `hint`, `overview_tpl`, `sync_table`, `writetable`, `globalsearch`, `listselectionmodel`, `sync_view`, `syncable`, `cssstyle`, `alternativeformxtype`, `read_table`, `class_name`, `special_add_panel`, `existsreal`, `character_set_name`, `read_filter`, `listxtypeprefix`, `phpexporter`, `phpexporterfilename`, `combined`, `default_pagesize`, `allowForm`, `listviewbaseclass`, `showactionbtn`, `modelbaseclass`) VALUES ('view_beteiligung_stimmzettel_pro_tag','Beteiligung Stimmzettel pro Tag',NULL,NULL,'datum','datum','datum',NULL,NULL,NULL,NULL,NULL,NULL,'rowmodel',NULL,NULL,NULL,NULL,NULL,'Wahlsystem',NULL,1,NULL,NULL,NULL,'XlsxWriter','view_beteiligung_stimmzettel_pro_tag-{DATE}',0,1000,1,'Tualo.DataSets.ListView',1,'Tualo.DataSets.model.Basic') ON DUPLICATE KEY UPDATE title=VALUES(title), reorderfield=VALUES(reorderfield), use_history=VALUES(use_history), searchfield=VALUES(searchfield), displayfield=VALUES(displayfield), sortfield=VALUES(sortfield), searchany=VALUES(searchany), hint=VALUES(hint), overview_tpl=VALUES(overview_tpl), sync_table=VALUES(sync_table), writetable=VALUES(writetable), globalsearch=VALUES(globalsearch), listselectionmodel=VALUES(listselectionmodel), sync_view=VALUES(sync_view), syncable=VALUES(syncable), cssstyle=VALUES(cssstyle), alternativeformxtype=VALUES(alternativeformxtype), read_table=   VALUES(read_table), class_name=VALUES(class_name), special_add_panel=VALUES(special_add_panel), existsreal=VALUES(existsreal), character_set_name=VALUES(character_set_name), read_filter=VALUES(read_filter), listxtypeprefix=VALUES(listxtypeprefix), phpexporter=VALUES(phpexporter), phpexporterfilename=VALUES(phpexporterfilename), combined=VALUES(combined), default_pagesize=VALUES(default_pagesize), allowForm=VALUES(allowForm), listviewbaseclass=VALUES(listviewbaseclass), showactionbtn=VALUES(showactionbtn), modelbaseclass=VALUES(modelbaseclass);
INSERT  IGNORE INTO `ds_column` (`table_name`, `column_name`, `default_value`, `default_max_value`, `default_min_value`, `update_value`, `is_primary`, `syncable`, `referenced_table`, `referenced_column_name`, `is_nullable`, `is_referenced`, `writeable`, `note`, `data_type`, `column_key`, `column_type`, `character_maximum_length`, `numeric_precision`, `numeric_scale`, `character_set_name`, `privileges`, `existsreal`, `deferedload`, `hint`, `fieldtype`) VALUES ('view_beteiligung_stimmzettel_pro_tag','datum',NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,'YES',NULL,1,NULL,'date','','date',NULL,NULL,NULL,NULL,'select,insert,update,references',1,NULL,NULL,'');
INSERT  IGNORE INTO `ds_column_list_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `editor`, `position`, `summaryrenderer`, `renderer`, `summarytype`, `hidden`, `active`, `filterstore`, `grouped`, `flex`, `direction`, `align`, `listfiltertype`, `hint`) VALUES ('view_beteiligung_stimmzettel_pro_tag','datum','DE','','datecolumn',NULL,0,NULL,NULL,NULL,0,1,NULL,0,NULL,NULL,NULL,NULL,'NULL');
INSERT  IGNORE INTO `ds_column_form_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `field_path`, `position`, `hidden`, `active`, `allowempty`, `fieldgroup`, `flex`, `hint`) VALUES ('view_beteiligung_stimmzettel_pro_tag','datum','DE','Datum','displayfield','Allgemein',0,0,1,NULL,NULL,NULL,'\'\'');
INSERT  IGNORE INTO `ds_renderer` (`table_name`, `pug_template`, `label`, `orientation`, `useremote`) VALUES ('view_beteiligung_stimmzettel_pro_tag','wm_berichte_beteiligung_tagesprokoll_wrapper','PDF','',0);

INSERT INTO `ds` (`table_name`, `title`, `reorderfield`, `use_history`, `searchfield`, `displayfield`, `sortfield`, `searchany`, `hint`, `overview_tpl`, `sync_table`, `writetable`, `globalsearch`, `listselectionmodel`, `sync_view`, `syncable`, `cssstyle`, `alternativeformxtype`, `read_table`, `class_name`, `special_add_panel`, `existsreal`, `character_set_name`, `read_filter`, `listxtypeprefix`, `phpexporter`, `phpexporterfilename`, `combined`, `default_pagesize`, `allowForm`, `listviewbaseclass`, `showactionbtn`, `modelbaseclass`) VALUES ('view_beteiligung_stimmzettel','Beteiligung nach Stimmzettel',NULL,NULL,'stimmzettel','stimmzettel','stimmzettel',NULL,NULL,NULL,NULL,NULL,NULL,'tualomultirowmodel',NULL,NULL,NULL,NULL,NULL,'Wahlsystem',NULL,1,NULL,NULL,NULL,'XlsxWriter','view_beteiligung_stimmzettel-{DATE}',0,1000,1,'Tualo.DataSets.ListView',1,'Tualo.DataSets.model.Basic') ON DUPLICATE KEY UPDATE title=VALUES(title), reorderfield=VALUES(reorderfield), use_history=VALUES(use_history), searchfield=VALUES(searchfield), displayfield=VALUES(displayfield), sortfield=VALUES(sortfield), searchany=VALUES(searchany), hint=VALUES(hint), overview_tpl=VALUES(overview_tpl), sync_table=VALUES(sync_table), writetable=VALUES(writetable), globalsearch=VALUES(globalsearch), listselectionmodel=VALUES(listselectionmodel), sync_view=VALUES(sync_view), syncable=VALUES(syncable), cssstyle=VALUES(cssstyle), alternativeformxtype=VALUES(alternativeformxtype), read_table=   VALUES(read_table), class_name=VALUES(class_name), special_add_panel=VALUES(special_add_panel), existsreal=VALUES(existsreal), character_set_name=VALUES(character_set_name), read_filter=VALUES(read_filter), listxtypeprefix=VALUES(listxtypeprefix), phpexporter=VALUES(phpexporter), phpexporterfilename=VALUES(phpexporterfilename), combined=VALUES(combined), default_pagesize=VALUES(default_pagesize), allowForm=VALUES(allowForm), listviewbaseclass=VALUES(listviewbaseclass), showactionbtn=VALUES(showactionbtn), modelbaseclass=VALUES(modelbaseclass);
INSERT  IGNORE INTO `ds_column` (`table_name`, `column_name`, `default_value`, `default_max_value`, `default_min_value`, `update_value`, `is_primary`, `syncable`, `referenced_table`, `referenced_column_name`, `is_nullable`, `is_referenced`, `writeable`, `note`, `data_type`, `column_key`, `column_type`, `character_maximum_length`, `numeric_precision`, `numeric_scale`, `character_set_name`, `privileges`, `existsreal`, `deferedload`, `hint`, `fieldtype`) VALUES ('view_beteiligung_stimmzettel','briefwahl',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'YES',NULL,1,NULL,'decimal','','decimal(22,0)',NULL,22,0,NULL,'select,insert,update,references',1,NULL,NULL,''),('view_beteiligung_stimmzettel','briefwahl_prozent',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'YES',NULL,1,NULL,'decimal','','decimal(30,4)',NULL,30,4,NULL,'select,insert,update,references',1,NULL,NULL,''),('view_beteiligung_stimmzettel','datum',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'YES',NULL,1,NULL,'date','','date',NULL,NULL,NULL,NULL,'select,insert,update,references',1,NULL,NULL,''),('view_beteiligung_stimmzettel','ges_SZ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'NO',NULL,1,NULL,'bigint','','bigint(21)',NULL,19,0,NULL,'select,insert,update,references',1,NULL,NULL,''),('view_beteiligung_stimmzettel','onlinewahl',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'NO',NULL,1,NULL,'tinyint','','int(1)',NULL,10,0,NULL,'select,insert,update,references',1,NULL,NULL,''),('view_beteiligung_stimmzettel','onlinewahl_prozent',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'NO',NULL,1,NULL,'tinyint','','int(1)',NULL,10,0,NULL,'select,insert,update,references',1,NULL,NULL,''),('view_beteiligung_stimmzettel','stimmzettel',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'NO',NULL,1,NULL,'varchar','','varchar(12)',12,NULL,NULL,'utf8mb3','select,insert,update,references',1,NULL,NULL,''),('view_beteiligung_stimmzettel','SZ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'YES',NULL,1,NULL,'varchar','','varchar(255)',255,NULL,NULL,'utf8mb3','select,insert,update,references',1,NULL,NULL,''),('view_beteiligung_stimmzettel','wahlscheinstatus',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'YES',NULL,1,NULL,'varchar','','varchar(12)',12,NULL,NULL,'utf8mb3','select,insert,update,references',1,NULL,NULL,'');
INSERT  IGNORE INTO `ds_column_list_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `editor`, `position`, `summaryrenderer`, `renderer`, `summarytype`, `hidden`, `active`, `filterstore`, `grouped`, `flex`, `direction`, `align`, `listfiltertype`, `hint`) VALUES ('view_beteiligung_stimmzettel','briefwahl','DE','briefwahl','gridcolumn',NULL,999,NULL,NULL,NULL,0,1,NULL,0,NULL,NULL,NULL,NULL,'NULL'),('view_beteiligung_stimmzettel','briefwahl_prozent','DE','Briefwahl in promill','gridcolumn',NULL,999,NULL,NULL,NULL,0,1,NULL,0,NULL,NULL,NULL,NULL,'NULL'),('view_beteiligung_stimmzettel','datum','DE','datum','tualodedatedisplaycolumn',NULL,999,NULL,NULL,NULL,0,1,NULL,0,NULL,NULL,NULL,NULL,'NULL'),('view_beteiligung_stimmzettel','ges_SZ','DE','ges_sz','gridcolumn',NULL,999,NULL,NULL,NULL,0,1,NULL,0,NULL,NULL,NULL,NULL,'NULL'),('view_beteiligung_stimmzettel','onlinewahl','DE','onlinewahl','gridcolumn',NULL,999,NULL,NULL,NULL,0,1,NULL,0,NULL,NULL,NULL,NULL,'NULL'),('view_beteiligung_stimmzettel','onlinewahl_prozent','DE','Onlinewahl in promill','gridcolumn',NULL,999,NULL,NULL,NULL,0,1,NULL,0,NULL,NULL,NULL,NULL,'NULL'),('view_beteiligung_stimmzettel','stimmzettel','DE','stimmzettel','gridcolumn',NULL,999,NULL,NULL,NULL,0,1,NULL,0,NULL,NULL,NULL,NULL,'NULL'),('view_beteiligung_stimmzettel','SZ','DE','sz','gridcolumn',NULL,999,NULL,NULL,NULL,0,1,NULL,0,NULL,NULL,NULL,NULL,'NULL'),('view_beteiligung_stimmzettel','wahlscheinstatus','DE','wahlscheinstatus','gridcolumn',NULL,999,NULL,NULL,NULL,0,1,NULL,0,NULL,NULL,NULL,NULL,'NULL');
INSERT  IGNORE INTO `ds_column_form_label` (`table_name`, `column_name`, `language`, `label`, `xtype`, `field_path`, `position`, `hidden`, `active`, `allowempty`, `fieldgroup`, `flex`, `hint`) VALUES ('view_beteiligung_stimmzettel','ges_SZ','DE','{column_name}','displayfield','Allgemein',0,0,1,NULL,NULL,NULL,'\'\''),('view_beteiligung_stimmzettel','stimmzettel','DE','{column_name}','displayfield','Allgemein',0,0,1,NULL,NULL,NULL,'\'\'');


INSERT
    IGNORE INTO `ds_access` (
        `role`,
        `table_name`,
        `read`,
        `write`,
        `delete`,
        `append`,
        `existsreal`
    )
VALUES
    (
        'wahl_auswertung',
        'view_beteiligung_stimmzettel',
        1,
        0,
        0,
        0,
        1
    );


INSERT
    IGNORE INTO `ds_access` (
        `role`,
        `table_name`,
        `read`,
        `write`,
        `delete`,
        `append`,
        `existsreal`
    )
VALUES
    (
        'wahl_auswertung',
        'view_beteiligung_stimmzettel_pro_tag',
        1,
        0,
        0,
        0,
        1
    );