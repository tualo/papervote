delimiter ;
CREATE TABLE IF NOT EXISTS `ruecklauffelder` (
  `column_name` varchar(50) NOT NULL,
  `aktiv` tinyint(4) DEFAULT 1,
  `reihenfolge` int(11) DEFAULT 0,
  PRIMARY KEY (`column_name`)
);

INSERT IGNORE INTO `ruecklauffelder` VALUES
('displ_stimmzettel_name_bold',1,9),
('hstr',1,13),
('identnummer',1,0),
('last_state_text',1,12),
('leerzeile',1,8),
('leerzeile2',1,11),
('plz_ort',1,6),
('post_land',1,7),
('post_name1',1,1),
('post_name2',1,2),
('post_name3',1,3),
('post_name4',1,4),
('post_strasse',1,5);


LOCK TABLES `ds` WRITE;
INSERT INTO `ds` (`table_name`, `title`, `reorderfield`, `use_history`, `searchfield`, `displayfield`, `sortfield`, `searchany`, `hint`, `overview_tpl`, `sync_table`, `writetable`, `globalsearch`, `listselectionmodel`, `sync_view`, `syncable`, `cssstyle`, `read_table`, `existsreal`, `class_name`, `special_add_panel`, `read_filter`, `listxtypeprefix`, `phpexporter`, `phpexporterfilename`, `combined`, `allowForm`, `alternativeformxtype`, `character_set_name`, `default_pagesize`, `listviewbaseclass`, `showactionbtn`) VALUES ('wahlscheinstatus_grund','wahlscheinstatus_grund',NULL,0,'name','name','id',1,'',NULL,NULL,NULL,0,NULL,NULL,0,NULL,'',1,'Unklassifiziert',NULL,NULL,'listview','XlsxWriter','{GUID}',0,1,'','',100,'Tualo.DataSets.ListView',1)

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
                    `read_table`=   "view_pwgen_wahlberechtigte_anlage",
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

