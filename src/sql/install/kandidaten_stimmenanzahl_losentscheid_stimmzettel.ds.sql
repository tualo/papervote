delimiter ;
-- BEGIN DS kandidaten_stimmenanzahl_losentscheid_stimmzettel
-- NAME: Losentscheid Stimmzettel

insert into `ds`
                    (`table_name`)
                    values
                    ('kandidaten_stimmenanzahl_losentscheid_stimmzettel')
                    on duplicate key update `table_name`=values(`table_name`);
update `ds` set `title`='Losentscheid Stimmzettel',`reorderfield`='',`use_history`='0',`searchfield`='',`displayfield`='stimmzettel_name',`sortfield`='stimmzettel_name',`searchany`='1',`hint`='',`overview_tpl`='',`sync_table`='',`writetable`='',`globalsearch`='0',`listselectionmodel`='cellmodel',`sync_view`='',`syncable`='0',`cssstyle`='',`read_table`='',`existsreal`='1',`class_name`='Unklassifiziert',`special_add_panel`='',`read_filter`='',`listxtypeprefix`='listview',`phpexporter`='XlsxWriter',`phpexporterfilename`='{GUID}',`combined`='0',`allowForm`= 1 ,`alternativeformxtype`='',`character_set_name`='',`default_pagesize`='100',`listviewbaseclass`='Tualo.DataSets.ListView',`showactionbtn`='1' where `table_name`='kandidaten_stimmenanzahl_losentscheid_stimmzettel';
insert into `ds_column`
                    (`table_name`,`column_name`)
                    values
                    ('kandidaten_stimmenanzahl_losentscheid_stimmzettel','c')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`);
update `ds_column` set `default_value`='',`default_max_value`='10000000',`default_min_value`='0',`is_primary`='0',`update_value`='',`is_nullable`='NO',`is_referenced`='',`referenced_table`='',`referenced_column_name`='',`data_type`='bigint',`column_key`='',`column_type`='bigint(21)',`character_maximum_length`='0',`numeric_precision`='19',`numeric_scale`='0',`character_set_name`='',`privileges`='select,insert,update,references',`existsreal`='1',`deferedload`='0',`writeable`='1',`note`='',`hint`='' where `table_name`='kandidaten_stimmenanzahl_losentscheid_stimmzettel' and `column_name`='c';
insert into `ds_column`
                    (`table_name`,`column_name`)
                    values
                    ('kandidaten_stimmenanzahl_losentscheid_stimmzettel','gesamtstimmen')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`);
update `ds_column` set `default_value`='',`default_max_value`='10000000',`default_min_value`='0',`is_primary`='0',`update_value`='',`is_nullable`='NO',`is_referenced`='',`referenced_table`='',`referenced_column_name`='',`data_type`='bigint',`column_key`='',`column_type`='bigint(22)',`character_maximum_length`='0',`numeric_precision`='19',`numeric_scale`='0',`character_set_name`='',`privileges`='select,insert,update,references',`existsreal`='1',`deferedload`='0',`writeable`='1',`note`='',`hint`='' where `table_name`='kandidaten_stimmenanzahl_losentscheid_stimmzettel' and `column_name`='gesamtstimmen';
insert into `ds_column`
                    (`table_name`,`column_name`)
                    values
                    ('kandidaten_stimmenanzahl_losentscheid_stimmzettel','ids')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`);
update `ds_column` set `default_value`='',`default_max_value`='10000000',`default_min_value`='0',`is_primary`='0',`update_value`='',`is_nullable`='YES',`is_referenced`='',`referenced_table`='',`referenced_column_name`='',`data_type`='longtext',`column_key`='',`column_type`='longtext',`character_maximum_length`='4294967295',`numeric_precision`='0',`numeric_scale`='0',`character_set_name`='utf8mb3',`privileges`='select,insert,update,references',`existsreal`='1',`deferedload`='0',`writeable`='1',`note`='',`hint`='' where `table_name`='kandidaten_stimmenanzahl_losentscheid_stimmzettel' and `column_name`='ids';
insert into `ds_column`
                    (`table_name`,`column_name`)
                    values
                    ('kandidaten_stimmenanzahl_losentscheid_stimmzettel','kandidaten_namen')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`);
update `ds_column` set `default_value`='',`default_max_value`='10000000',`default_min_value`='0',`is_primary`='0',`update_value`='',`is_nullable`='YES',`is_referenced`='',`referenced_table`='',`referenced_column_name`='',`data_type`='longtext',`column_key`='',`column_type`='longtext',`character_maximum_length`='4294967295',`numeric_precision`='0',`numeric_scale`='0',`character_set_name`='utf8mb3',`privileges`='select,insert,update,references',`existsreal`='1',`deferedload`='0',`writeable`='1',`note`='',`hint`='' where `table_name`='kandidaten_stimmenanzahl_losentscheid_stimmzettel' and `column_name`='kandidaten_namen';
insert into `ds_column`
                    (`table_name`,`column_name`)
                    values
                    ('kandidaten_stimmenanzahl_losentscheid_stimmzettel','kn')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`);
update `ds_column` set `default_value`='',`default_max_value`='10000000',`default_min_value`='0',`is_primary`='0',`update_value`='',`is_nullable`='YES',`is_referenced`='',`referenced_table`='',`referenced_column_name`='',`data_type`='longtext',`column_key`='',`column_type`='longtext',`character_maximum_length`='4294967295',`numeric_precision`='0',`numeric_scale`='0',`character_set_name`='utf8mb3',`privileges`='select,insert,update,references',`existsreal`='1',`deferedload`='0',`writeable`='1',`note`='',`hint`='' where `table_name`='kandidaten_stimmenanzahl_losentscheid_stimmzettel' and `column_name`='kn';
insert into `ds_column`
                    (`table_name`,`column_name`)
                    values
                    ('kandidaten_stimmenanzahl_losentscheid_stimmzettel','max_xrank')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`);
update `ds_column` set `default_value`='',`default_max_value`='10000000',`default_min_value`='0',`is_primary`='0',`update_value`='',`is_nullable`='YES',`is_referenced`='',`referenced_table`='',`referenced_column_name`='',`data_type`='bigint',`column_key`='',`column_type`='bigint(21)',`character_maximum_length`='0',`numeric_precision`='19',`numeric_scale`='0',`character_set_name`='',`privileges`='select,insert,update,references',`existsreal`='1',`deferedload`='0',`writeable`='1',`note`='',`hint`='' where `table_name`='kandidaten_stimmenanzahl_losentscheid_stimmzettel' and `column_name`='max_xrank';
insert into `ds_column`
                    (`table_name`,`column_name`)
                    values
                    ('kandidaten_stimmenanzahl_losentscheid_stimmzettel','min_xrank')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`);
update `ds_column` set `default_value`='',`default_max_value`='10000000',`default_min_value`='0',`is_primary`='0',`update_value`='',`is_nullable`='YES',`is_referenced`='',`referenced_table`='',`referenced_column_name`='',`data_type`='bigint',`column_key`='',`column_type`='bigint(21)',`character_maximum_length`='0',`numeric_precision`='19',`numeric_scale`='0',`character_set_name`='',`privileges`='select,insert,update,references',`existsreal`='1',`deferedload`='0',`writeable`='1',`note`='',`hint`='' where `table_name`='kandidaten_stimmenanzahl_losentscheid_stimmzettel' and `column_name`='min_xrank';
insert into `ds_column`
                    (`table_name`,`column_name`)
                    values
                    ('kandidaten_stimmenanzahl_losentscheid_stimmzettel','msg')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`);
update `ds_column` set `default_value`='',`default_max_value`='10000000',`default_min_value`='0',`is_primary`='0',`update_value`='',`is_nullable`='YES',`is_referenced`='',`referenced_table`='',`referenced_column_name`='',`data_type`='varchar',`column_key`='',`column_type`='varchar(16)',`character_maximum_length`='16',`numeric_precision`='0',`numeric_scale`='0',`character_set_name`='utf8mb3',`privileges`='select,insert,update,references',`existsreal`='1',`deferedload`='0',`writeable`='1',`note`='',`hint`='' where `table_name`='kandidaten_stimmenanzahl_losentscheid_stimmzettel' and `column_name`='msg';
insert into `ds_column`
                    (`table_name`,`column_name`)
                    values
                    ('kandidaten_stimmenanzahl_losentscheid_stimmzettel','rank')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`);
update `ds_column` set `default_value`='',`default_max_value`='10000000',`default_min_value`='0',`is_primary`='0',`update_value`='',`is_nullable`='NO',`is_referenced`='',`referenced_table`='',`referenced_column_name`='',`data_type`='bigint',`column_key`='',`column_type`='bigint(21)',`character_maximum_length`='0',`numeric_precision`='19',`numeric_scale`='0',`character_set_name`='',`privileges`='select,insert,update,references',`existsreal`='1',`deferedload`='0',`writeable`='1',`note`='',`hint`='' where `table_name`='kandidaten_stimmenanzahl_losentscheid_stimmzettel' and `column_name`='rank';
insert into `ds_column`
                    (`table_name`,`column_name`)
                    values
                    ('kandidaten_stimmenanzahl_losentscheid_stimmzettel','stimmzettelgruppen_mindestsitze')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`);
update `ds_column` set `default_value`='',`default_max_value`='10000000',`default_min_value`='0',`is_primary`='0',`update_value`='',`is_nullable`='YES',`is_referenced`='',`referenced_table`='',`referenced_column_name`='',`data_type`='int',`column_key`='',`column_type`='int(11)',`character_maximum_length`='0',`numeric_precision`='10',`numeric_scale`='0',`character_set_name`='',`privileges`='select,insert,update,references',`existsreal`='1',`deferedload`='0',`writeable`='1',`note`='',`hint`='' where `table_name`='kandidaten_stimmenanzahl_losentscheid_stimmzettel' and `column_name`='stimmzettelgruppen_mindestsitze';
insert into `ds_column`
                    (`table_name`,`column_name`)
                    values
                    ('kandidaten_stimmenanzahl_losentscheid_stimmzettel','stimmzettelgruppen_name')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`);
update `ds_column` set `default_value`='',`default_max_value`='10000000',`default_min_value`='0',`is_primary`='0',`update_value`='',`is_nullable`='YES',`is_referenced`='',`referenced_table`='',`referenced_column_name`='',`data_type`='varchar',`column_key`='',`column_type`='varchar(255)',`character_maximum_length`='255',`numeric_precision`='0',`numeric_scale`='0',`character_set_name`='utf8mb3',`privileges`='select,insert,update,references',`existsreal`='1',`deferedload`='0',`writeable`='1',`note`='',`hint`='' where `table_name`='kandidaten_stimmenanzahl_losentscheid_stimmzettel' and `column_name`='stimmzettelgruppen_name';
insert into `ds_column`
                    (`table_name`,`column_name`)
                    values
                    ('kandidaten_stimmenanzahl_losentscheid_stimmzettel','stimmzettel_name')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`);
update `ds_column` set `default_value`='',`default_max_value`='10000000',`default_min_value`='0',`is_primary`='0',`update_value`='',`is_nullable`='YES',`is_referenced`='',`referenced_table`='',`referenced_column_name`='',`data_type`='varchar',`column_key`='',`column_type`='varchar(255)',`character_maximum_length`='255',`numeric_precision`='0',`numeric_scale`='0',`character_set_name`='utf8mb3',`privileges`='select,insert,update,references',`existsreal`='1',`deferedload`='0',`writeable`='1',`note`='',`hint`='' where `table_name`='kandidaten_stimmenanzahl_losentscheid_stimmzettel' and `column_name`='stimmzettel_name';
insert into `ds_column`
                    (`table_name`,`column_name`)
                    values
                    ('kandidaten_stimmenanzahl_losentscheid_stimmzettel','stimmzettel_ridx')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`);
update `ds_column` set `default_value`='',`default_max_value`='10000000',`default_min_value`='0',`is_primary`='0',`update_value`='',`is_nullable`='YES',`is_referenced`='',`referenced_table`='',`referenced_column_name`='',`data_type`='varchar',`column_key`='',`column_type`='varchar(12)',`character_maximum_length`='12',`numeric_precision`='0',`numeric_scale`='0',`character_set_name`='utf8mb3',`privileges`='select,insert,update,references',`existsreal`='1',`deferedload`='0',`writeable`='1',`note`='',`hint`='' where `table_name`='kandidaten_stimmenanzahl_losentscheid_stimmzettel' and `column_name`='stimmzettel_ridx';
insert into `ds_column`
                    (`table_name`,`column_name`)
                    values
                    ('kandidaten_stimmenanzahl_losentscheid_stimmzettel','stimmzettel_sitze')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`);
update `ds_column` set `default_value`='',`default_max_value`='10000000',`default_min_value`='0',`is_primary`='0',`update_value`='',`is_nullable`='YES',`is_referenced`='',`referenced_table`='',`referenced_column_name`='',`data_type`='varchar',`column_key`='',`column_type`='varchar(255)',`character_maximum_length`='255',`numeric_precision`='0',`numeric_scale`='0',`character_set_name`='utf8mb3',`privileges`='select,insert,update,references',`existsreal`='1',`deferedload`='0',`writeable`='1',`note`='',`hint`='' where `table_name`='kandidaten_stimmenanzahl_losentscheid_stimmzettel' and `column_name`='stimmzettel_sitze';
insert into `ds_access`
                    (`role`,`table_name`)
                    values
                    ('administration','kandidaten_stimmenanzahl_losentscheid_stimmzettel')
                    on duplicate key update `role`=values(`role`),`table_name`=values(`table_name`);
update `ds_access` set `read`='1',`write`='1',`delete`='0',`append`='1',`existsreal`='0' where `role`='administration' and `table_name`='kandidaten_stimmenanzahl_losentscheid_stimmzettel';
insert into `ds_column_list_label`
                    (`table_name`,`column_name`,`language`,`label`)
                    values
                    ('kandidaten_stimmenanzahl_losentscheid_stimmzettel','c','DE','Anzahl')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`),`language`=values(`language`),`label`=values(`label`);
update `ds_column_list_label` set `xtype`='gridcolumn',`editor`='',`position`='0',`summaryrenderer`='',`summarytype`='',`hidden`='0',`active`='1',`renderer`='',`filterstore`='',`flex`='1.00',`direction`='',`align`='',`grouped`='0',`listfiltertype`='',`hint`='NULL' where `table_name`='kandidaten_stimmenanzahl_losentscheid_stimmzettel' and `column_name`='c' and `language`='DE';
insert into `ds_column_list_label`
                    (`table_name`,`column_name`,`language`,`label`)
                    values
                    ('kandidaten_stimmenanzahl_losentscheid_stimmzettel','gesamtstimmen','DE','Gesamtstimmen')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`),`language`=values(`language`),`label`=values(`label`);
update `ds_column_list_label` set `xtype`='gridcolumn',`editor`='',`position`='1',`summaryrenderer`='',`summarytype`='',`hidden`='0',`active`='1',`renderer`='',`filterstore`='',`flex`='1.00',`direction`='',`align`='',`grouped`='0',`listfiltertype`='',`hint`='NULL' where `table_name`='kandidaten_stimmenanzahl_losentscheid_stimmzettel' and `column_name`='gesamtstimmen' and `language`='DE';
insert into `ds_column_list_label`
                    (`table_name`,`column_name`,`language`,`label`)
                    values
                    ('kandidaten_stimmenanzahl_losentscheid_stimmzettel','ids','DE','IDs')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`),`language`=values(`language`),`label`=values(`label`);
update `ds_column_list_label` set `xtype`='gridcolumn',`editor`='',`position`='2',`summaryrenderer`='',`summarytype`='',`hidden`='0',`active`='1',`renderer`='',`filterstore`='',`flex`='1.00',`direction`='',`align`='',`grouped`='0',`listfiltertype`='',`hint`='NULL' where `table_name`='kandidaten_stimmenanzahl_losentscheid_stimmzettel' and `column_name`='ids' and `language`='DE';
insert into `ds_column_list_label`
                    (`table_name`,`column_name`,`language`,`label`)
                    values
                    ('kandidaten_stimmenanzahl_losentscheid_stimmzettel','kandidaten_namen','DE','Kandidaten')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`),`language`=values(`language`),`label`=values(`label`);
update `ds_column_list_label` set `xtype`='gridcolumn',`editor`='',`position`='3',`summaryrenderer`='',`summarytype`='',`hidden`='0',`active`='1',`renderer`='',`filterstore`='',`flex`='1.00',`direction`='',`align`='',`grouped`='0',`listfiltertype`='',`hint`='NULL' where `table_name`='kandidaten_stimmenanzahl_losentscheid_stimmzettel' and `column_name`='kandidaten_namen' and `language`='DE';
insert into `ds_column_list_label`
                    (`table_name`,`column_name`,`language`,`label`)
                    values
                    ('kandidaten_stimmenanzahl_losentscheid_stimmzettel','kn','DE','kn')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`),`language`=values(`language`),`label`=values(`label`);
update `ds_column_list_label` set `xtype`='gridcolumn',`editor`='',`position`='4',`summaryrenderer`='',`summarytype`='',`hidden`='1',`active`='1',`renderer`='',`filterstore`='',`flex`='1.00',`direction`='',`align`='',`grouped`='0',`listfiltertype`='',`hint`='NULL' where `table_name`='kandidaten_stimmenanzahl_losentscheid_stimmzettel' and `column_name`='kn' and `language`='DE';
insert into `ds_column_list_label`
                    (`table_name`,`column_name`,`language`,`label`)
                    values
                    ('kandidaten_stimmenanzahl_losentscheid_stimmzettel','max_xrank','DE','max_xrank')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`),`language`=values(`language`),`label`=values(`label`);
update `ds_column_list_label` set `xtype`='gridcolumn',`editor`='',`position`='999',`summaryrenderer`='',`summarytype`='',`hidden`='0',`active`='1',`renderer`='',`filterstore`='',`flex`='1.00',`direction`='',`align`='',`grouped`='0',`listfiltertype`='',`hint`='NULL' where `table_name`='kandidaten_stimmenanzahl_losentscheid_stimmzettel' and `column_name`='max_xrank' and `language`='DE';
insert into `ds_column_list_label`
                    (`table_name`,`column_name`,`language`,`label`)
                    values
                    ('kandidaten_stimmenanzahl_losentscheid_stimmzettel','min_xrank','DE','min_xrank')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`),`language`=values(`language`),`label`=values(`label`);
update `ds_column_list_label` set `xtype`='gridcolumn',`editor`='',`position`='999',`summaryrenderer`='',`summarytype`='',`hidden`='0',`active`='1',`renderer`='',`filterstore`='',`flex`='1.00',`direction`='',`align`='',`grouped`='0',`listfiltertype`='',`hint`='NULL' where `table_name`='kandidaten_stimmenanzahl_losentscheid_stimmzettel' and `column_name`='min_xrank' and `language`='DE';
insert into `ds_column_list_label`
                    (`table_name`,`column_name`,`language`,`label`)
                    values
                    ('kandidaten_stimmenanzahl_losentscheid_stimmzettel','msg','DE','msg')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`),`language`=values(`language`),`label`=values(`label`);
update `ds_column_list_label` set `xtype`='gridcolumn',`editor`='',`position`='999',`summaryrenderer`='',`summarytype`='',`hidden`='0',`active`='1',`renderer`='',`filterstore`='',`flex`='1.00',`direction`='',`align`='',`grouped`='0',`listfiltertype`='',`hint`='NULL' where `table_name`='kandidaten_stimmenanzahl_losentscheid_stimmzettel' and `column_name`='msg' and `language`='DE';
insert into `ds_column_list_label`
                    (`table_name`,`column_name`,`language`,`label`)
                    values
                    ('kandidaten_stimmenanzahl_losentscheid_stimmzettel','rank','DE','Rang')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`),`language`=values(`language`),`label`=values(`label`);
update `ds_column_list_label` set `xtype`='gridcolumn',`editor`='',`position`='5',`summaryrenderer`='',`summarytype`='',`hidden`='0',`active`='1',`renderer`='',`filterstore`='',`flex`='1.00',`direction`='',`align`='',`grouped`='0',`listfiltertype`='',`hint`='NULL' where `table_name`='kandidaten_stimmenanzahl_losentscheid_stimmzettel' and `column_name`='rank' and `language`='DE';
insert into `ds_column_list_label`
                    (`table_name`,`column_name`,`language`,`label`)
                    values
                    ('kandidaten_stimmenanzahl_losentscheid_stimmzettel','stimmzettelgruppen_mindestsitze','DE','stimmzettelgruppen_mindestsitze')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`),`language`=values(`language`),`label`=values(`label`);
update `ds_column_list_label` set `xtype`='gridcolumn',`editor`='',`position`='999',`summaryrenderer`='',`summarytype`='',`hidden`='0',`active`='1',`renderer`='',`filterstore`='',`flex`='1.00',`direction`='',`align`='',`grouped`='0',`listfiltertype`='',`hint`='NULL' where `table_name`='kandidaten_stimmenanzahl_losentscheid_stimmzettel' and `column_name`='stimmzettelgruppen_mindestsitze' and `language`='DE';
insert into `ds_column_list_label`
                    (`table_name`,`column_name`,`language`,`label`)
                    values
                    ('kandidaten_stimmenanzahl_losentscheid_stimmzettel','stimmzettelgruppen_name','DE','stimmzettelgruppen_name')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`),`language`=values(`language`),`label`=values(`label`);
update `ds_column_list_label` set `xtype`='gridcolumn',`editor`='',`position`='999',`summaryrenderer`='',`summarytype`='',`hidden`='0',`active`='1',`renderer`='',`filterstore`='',`flex`='1.00',`direction`='',`align`='',`grouped`='0',`listfiltertype`='',`hint`='NULL' where `table_name`='kandidaten_stimmenanzahl_losentscheid_stimmzettel' and `column_name`='stimmzettelgruppen_name' and `language`='DE';
insert into `ds_column_list_label`
                    (`table_name`,`column_name`,`language`,`label`)
                    values
                    ('kandidaten_stimmenanzahl_losentscheid_stimmzettel','stimmzettel_name','DE','Stimmzettel')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`),`language`=values(`language`),`label`=values(`label`);
update `ds_column_list_label` set `xtype`='gridcolumn',`editor`='',`position`='6',`summaryrenderer`='',`summarytype`='',`hidden`='0',`active`='1',`renderer`='',`filterstore`='',`flex`='1.00',`direction`='',`align`='',`grouped`='0',`listfiltertype`='',`hint`='NULL' where `table_name`='kandidaten_stimmenanzahl_losentscheid_stimmzettel' and `column_name`='stimmzettel_name' and `language`='DE';
insert into `ds_column_list_label`
                    (`table_name`,`column_name`,`language`,`label`)
                    values
                    ('kandidaten_stimmenanzahl_losentscheid_stimmzettel','stimmzettel_ridx','DE','stimmzettel_ridx')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`),`language`=values(`language`),`label`=values(`label`);
update `ds_column_list_label` set `xtype`='gridcolumn',`editor`='',`position`='7',`summaryrenderer`='',`summarytype`='',`hidden`='0',`active`='1',`renderer`='',`filterstore`='',`flex`='1.00',`direction`='',`align`='',`grouped`='0',`listfiltertype`='',`hint`='NULL' where `table_name`='kandidaten_stimmenanzahl_losentscheid_stimmzettel' and `column_name`='stimmzettel_ridx' and `language`='DE';
insert into `ds_column_list_label`
                    (`table_name`,`column_name`,`language`,`label`)
                    values
                    ('kandidaten_stimmenanzahl_losentscheid_stimmzettel','stimmzettel_sitze','DE','stimmzettel_sitze')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`),`language`=values(`language`),`label`=values(`label`);
update `ds_column_list_label` set `xtype`='gridcolumn',`editor`='',`position`='999',`summaryrenderer`='',`summarytype`='',`hidden`='0',`active`='1',`renderer`='',`filterstore`='',`flex`='1.00',`direction`='',`align`='',`grouped`='0',`listfiltertype`='',`hint`='NULL' where `table_name`='kandidaten_stimmenanzahl_losentscheid_stimmzettel' and `column_name`='stimmzettel_sitze' and `language`='DE';
-- END DS kandidaten_stimmenanzahl_losentscheid_stimmzettel

