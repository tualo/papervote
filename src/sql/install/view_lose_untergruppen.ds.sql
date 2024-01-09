delimiter ;
-- BEGIN DS view_lose_untergruppen
-- NAME: Los-Entscheide Mindestsitze

insert into `ds`
                    (`table_name`)
                    values
                    ('view_lose_untergruppen')
                    on duplicate key update `table_name`=values(`table_name`);
update `ds` set `title`='Los-Entscheide Mindestsitze',`reorderfield`='',`use_history`='0',`searchfield`='',`displayfield`='stimmzettelgruppe',`sortfield`='stimmzettelgruppe',`searchany`='1',`hint`='',`overview_tpl`='',`sync_table`='',`writetable`='',`globalsearch`='0',`listselectionmodel`='cellmodel',`sync_view`='',`syncable`='0',`cssstyle`='',`read_table`='',`existsreal`='1',`class_name`='Unklassifiziert',`special_add_panel`='',`read_filter`='',`listxtypeprefix`='listview',`phpexporter`='XlsxWriter',`phpexporterfilename`='{GUID}',`combined`='0',`allowForm`= 0 ,`alternativeformxtype`='',`character_set_name`='',`default_pagesize`='100',`listviewbaseclass`='Tualo.DataSets.ListView',`showactionbtn`='1' where `table_name`='view_lose_untergruppen';
insert into `ds_column`
                    (`table_name`,`column_name`)
                    values
                    ('view_lose_untergruppen','c')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`);
update `ds_column` set `default_value`='',`default_max_value`='10000000',`default_min_value`='0',`is_primary`='0',`update_value`='',`is_nullable`='NO',`is_referenced`='',`referenced_table`='',`referenced_column_name`='',`data_type`='bigint',`column_key`='',`column_type`='bigint(21)',`character_maximum_length`='0',`numeric_precision`='19',`numeric_scale`='0',`character_set_name`='',`privileges`='select,insert,update,references',`existsreal`='1',`deferedload`='0',`writeable`='1',`note`='',`hint`='' where `table_name`='view_lose_untergruppen' and `column_name`='c';
insert into `ds_column`
                    (`table_name`,`column_name`)
                    values
                    ('view_lose_untergruppen','gesamtstimmen')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`);
update `ds_column` set `default_value`='',`default_max_value`='10000000',`default_min_value`='0',`is_primary`='0',`update_value`='',`is_nullable`='NO',`is_referenced`='',`referenced_table`='',`referenced_column_name`='',`data_type`='bigint',`column_key`='',`column_type`='bigint(22)',`character_maximum_length`='0',`numeric_precision`='19',`numeric_scale`='0',`character_set_name`='',`privileges`='select,insert,update,references',`existsreal`='1',`deferedload`='0',`writeable`='1',`note`='',`hint`='' where `table_name`='view_lose_untergruppen' and `column_name`='gesamtstimmen';
insert into `ds_column`
                    (`table_name`,`column_name`)
                    values
                    ('view_lose_untergruppen','kandidaten')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`);
update `ds_column` set `default_value`='',`default_max_value`='10000000',`default_min_value`='0',`is_primary`='0',`update_value`='',`is_nullable`='YES',`is_referenced`='',`referenced_table`='',`referenced_column_name`='',`data_type`='longtext',`column_key`='',`column_type`='longtext',`character_maximum_length`='4294967295',`numeric_precision`='0',`numeric_scale`='0',`character_set_name`='utf8mb3',`privileges`='select,insert,update,references',`existsreal`='1',`deferedload`='0',`writeable`='1',`note`='',`hint`='' where `table_name`='view_lose_untergruppen' and `column_name`='kandidaten';
insert into `ds_column`
                    (`table_name`,`column_name`)
                    values
                    ('view_lose_untergruppen','kandidaten_namen')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`);
update `ds_column` set `default_value`='',`default_max_value`='10000000',`default_min_value`='0',`is_primary`='0',`update_value`='',`is_nullable`='YES',`is_referenced`='',`referenced_table`='',`referenced_column_name`='',`data_type`='longtext',`column_key`='',`column_type`='longtext',`character_maximum_length`='4294967295',`numeric_precision`='0',`numeric_scale`='0',`character_set_name`='utf8mb3',`privileges`='select,insert,update,references',`existsreal`='1',`deferedload`='0',`writeable`='1',`note`='',`hint`='' where `table_name`='view_lose_untergruppen' and `column_name`='kandidaten_namen';
insert into `ds_column`
                    (`table_name`,`column_name`)
                    values
                    ('view_lose_untergruppen','kn')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`);
update `ds_column` set `default_value`='',`default_max_value`='10000000',`default_min_value`='0',`is_primary`='0',`update_value`='',`is_nullable`='YES',`is_referenced`='',`referenced_table`='',`referenced_column_name`='',`data_type`='longtext',`column_key`='',`column_type`='longtext',`character_maximum_length`='4294967295',`numeric_precision`='0',`numeric_scale`='0',`character_set_name`='utf8mb3',`privileges`='select,insert,update,references',`existsreal`='1',`deferedload`='0',`writeable`='1',`note`='',`hint`='' where `table_name`='view_lose_untergruppen' and `column_name`='kn';
insert into `ds_column`
                    (`table_name`,`column_name`)
                    values
                    ('view_lose_untergruppen','stimmzettel')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`);
update `ds_column` set `default_value`='',`default_max_value`='10000000',`default_min_value`='0',`is_primary`='0',`update_value`='',`is_nullable`='YES',`is_referenced`='',`referenced_table`='',`referenced_column_name`='',`data_type`='varchar',`column_key`='',`column_type`='varchar(255)',`character_maximum_length`='255',`numeric_precision`='0',`numeric_scale`='0',`character_set_name`='utf8mb3',`privileges`='select,insert,update,references',`existsreal`='1',`deferedload`='0',`writeable`='1',`note`='',`hint`='' where `table_name`='view_lose_untergruppen' and `column_name`='stimmzettel';
insert into `ds_column`
                    (`table_name`,`column_name`)
                    values
                    ('view_lose_untergruppen','stimmzettelgruppe')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`);
update `ds_column` set `default_value`='',`default_max_value`='10000000',`default_min_value`='0',`is_primary`='0',`update_value`='',`is_nullable`='YES',`is_referenced`='',`referenced_table`='',`referenced_column_name`='',`data_type`='varchar',`column_key`='',`column_type`='varchar(255)',`character_maximum_length`='255',`numeric_precision`='0',`numeric_scale`='0',`character_set_name`='utf8mb3',`privileges`='select,insert,update,references',`existsreal`='1',`deferedload`='0',`writeable`='1',`note`='',`hint`='' where `table_name`='view_lose_untergruppen' and `column_name`='stimmzettelgruppe';
insert into `ds_column`
                    (`table_name`,`column_name`)
                    values
                    ('view_lose_untergruppen','stimmzettelgruppen_mindestsitze')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`);
update `ds_column` set `default_value`='',`default_max_value`='10000000',`default_min_value`='0',`is_primary`='0',`update_value`='',`is_nullable`='YES',`is_referenced`='',`referenced_table`='',`referenced_column_name`='',`data_type`='int',`column_key`='',`column_type`='int(11)',`character_maximum_length`='0',`numeric_precision`='10',`numeric_scale`='0',`character_set_name`='',`privileges`='select,insert,update,references',`existsreal`='1',`deferedload`='0',`writeable`='1',`note`='',`hint`='' where `table_name`='view_lose_untergruppen' and `column_name`='stimmzettelgruppen_mindestsitze';
insert into `ds_column`
                    (`table_name`,`column_name`)
                    values
                    ('view_lose_untergruppen','stimmzettelgruppen_ridx')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`);
update `ds_column` set `default_value`='',`default_max_value`='10000000',`default_min_value`='0',`is_primary`='0',`update_value`='',`is_nullable`='YES',`is_referenced`='',`referenced_table`='',`referenced_column_name`='',`data_type`='varchar',`column_key`='',`column_type`='varchar(12)',`character_maximum_length`='12',`numeric_precision`='0',`numeric_scale`='0',`character_set_name`='utf8mb3',`privileges`='select,insert,update,references',`existsreal`='1',`deferedload`='0',`writeable`='1',`note`='',`hint`='' where `table_name`='view_lose_untergruppen' and `column_name`='stimmzettelgruppen_ridx';
insert into `ds_column`
                    (`table_name`,`column_name`)
                    values
                    ('view_lose_untergruppen','stimmzettel_ridx')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`);
update `ds_column` set `default_value`='',`default_max_value`='10000000',`default_min_value`='0',`is_primary`='0',`update_value`='',`is_nullable`='YES',`is_referenced`='',`referenced_table`='',`referenced_column_name`='',`data_type`='varchar',`column_key`='',`column_type`='varchar(12)',`character_maximum_length`='12',`numeric_precision`='0',`numeric_scale`='0',`character_set_name`='utf8mb3',`privileges`='select,insert,update,references',`existsreal`='1',`deferedload`='0',`writeable`='1',`note`='',`hint`='' where `table_name`='view_lose_untergruppen' and `column_name`='stimmzettel_ridx';
insert into `ds_column`
                    (`table_name`,`column_name`)
                    values
                    ('view_lose_untergruppen','stimmzettel_sitze')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`);
update `ds_column` set `default_value`='',`default_max_value`='10000000',`default_min_value`='0',`is_primary`='0',`update_value`='',`is_nullable`='YES',`is_referenced`='',`referenced_table`='',`referenced_column_name`='',`data_type`='varchar',`column_key`='',`column_type`='varchar(255)',`character_maximum_length`='255',`numeric_precision`='0',`numeric_scale`='0',`character_set_name`='utf8mb3',`privileges`='select,insert,update,references',`existsreal`='1',`deferedload`='0',`writeable`='1',`note`='',`hint`='' where `table_name`='view_lose_untergruppen' and `column_name`='stimmzettel_sitze';
insert into `ds_access`
                    (`role`,`table_name`)
                    values
                    ('administration','view_lose_untergruppen')
                    on duplicate key update `role`=values(`role`),`table_name`=values(`table_name`);
update `ds_access` set `read`='1',`write`='1',`delete`='0',`append`='0',`existsreal`='0' where `role`='administration' and `table_name`='view_lose_untergruppen';
insert into `ds_column_list_label`
                    (`table_name`,`column_name`,`language`,`label`)
                    values
                    ('view_lose_untergruppen','c','DE','Anzahl')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`),`language`=values(`language`),`label`=values(`label`);
update `ds_column_list_label` set `xtype`='gridcolumn',`editor`='',`position`='0',`summaryrenderer`='',`summarytype`='',`hidden`='0',`active`='1',`renderer`='',`filterstore`='',`flex`='1.00',`direction`='',`align`='',`grouped`='0',`listfiltertype`='',`hint`='NULL' where `table_name`='view_lose_untergruppen' and `column_name`='c' and `language`='DE';
insert into `ds_column_list_label`
                    (`table_name`,`column_name`,`language`,`label`)
                    values
                    ('view_lose_untergruppen','gesamtstimmen','DE','Stimmen')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`),`language`=values(`language`),`label`=values(`label`);
update `ds_column_list_label` set `xtype`='gridcolumn',`editor`='',`position`='1',`summaryrenderer`='',`summarytype`='',`hidden`='0',`active`='1',`renderer`='',`filterstore`='',`flex`='1.00',`direction`='',`align`='',`grouped`='0',`listfiltertype`='',`hint`='NULL' where `table_name`='view_lose_untergruppen' and `column_name`='gesamtstimmen' and `language`='DE';
insert into `ds_column_list_label`
                    (`table_name`,`column_name`,`language`,`label`)
                    values
                    ('view_lose_untergruppen','kandidaten','DE','Kandidaten')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`),`language`=values(`language`),`label`=values(`label`);
update `ds_column_list_label` set `xtype`='gridcolumn',`editor`='',`position`='2',`summaryrenderer`='',`summarytype`='',`hidden`='1',`active`='1',`renderer`='',`filterstore`='',`flex`='1.00',`direction`='',`align`='',`grouped`='0',`listfiltertype`='',`hint`='NULL' where `table_name`='view_lose_untergruppen' and `column_name`='kandidaten' and `language`='DE';
insert into `ds_column_list_label`
                    (`table_name`,`column_name`,`language`,`label`)
                    values
                    ('view_lose_untergruppen','kandidaten_namen','DE','kandidaten_namen')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`),`language`=values(`language`),`label`=values(`label`);
update `ds_column_list_label` set `xtype`='gridcolumn',`editor`='',`position`='3',`summaryrenderer`='',`summarytype`='',`hidden`='1',`active`='1',`renderer`='',`filterstore`='',`flex`='1.00',`direction`='',`align`='',`grouped`='0',`listfiltertype`='',`hint`='NULL' where `table_name`='view_lose_untergruppen' and `column_name`='kandidaten_namen' and `language`='DE';
insert into `ds_column_list_label`
                    (`table_name`,`column_name`,`language`,`label`)
                    values
                    ('view_lose_untergruppen','kn','DE','kn')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`),`language`=values(`language`),`label`=values(`label`);
update `ds_column_list_label` set `xtype`='gridcolumn',`editor`='',`position`='4',`summaryrenderer`='',`summarytype`='',`hidden`='0',`active`='1',`renderer`='',`filterstore`='',`flex`='1.00',`direction`='',`align`='',`grouped`='0',`listfiltertype`='',`hint`='NULL' where `table_name`='view_lose_untergruppen' and `column_name`='kn' and `language`='DE';
insert into `ds_column_list_label`
                    (`table_name`,`column_name`,`language`,`label`)
                    values
                    ('view_lose_untergruppen','stimmzettel','DE','Stimmzettel')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`),`language`=values(`language`),`label`=values(`label`);
update `ds_column_list_label` set `xtype`='gridcolumn',`editor`='',`position`='5',`summaryrenderer`='',`summarytype`='',`hidden`='0',`active`='1',`renderer`='',`filterstore`='',`flex`='1.00',`direction`='',`align`='',`grouped`='0',`listfiltertype`='',`hint`='NULL' where `table_name`='view_lose_untergruppen' and `column_name`='stimmzettel' and `language`='DE';
insert into `ds_column_list_label`
                    (`table_name`,`column_name`,`language`,`label`)
                    values
                    ('view_lose_untergruppen','stimmzettelgruppe','DE','Stimmzettelgruppe')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`),`language`=values(`language`),`label`=values(`label`);
update `ds_column_list_label` set `xtype`='gridcolumn',`editor`='',`position`='6',`summaryrenderer`='',`summarytype`='',`hidden`='0',`active`='1',`renderer`='',`filterstore`='',`flex`='1.00',`direction`='',`align`='',`grouped`='0',`listfiltertype`='',`hint`='NULL' where `table_name`='view_lose_untergruppen' and `column_name`='stimmzettelgruppe' and `language`='DE';
insert into `ds_column_list_label`
                    (`table_name`,`column_name`,`language`,`label`)
                    values
                    ('view_lose_untergruppen','stimmzettelgruppen_mindestsitze','DE','stimmzettelgruppen_mindestsitze')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`),`language`=values(`language`),`label`=values(`label`);
update `ds_column_list_label` set `xtype`='gridcolumn',`editor`='',`position`='7',`summaryrenderer`='',`summarytype`='',`hidden`='0',`active`='1',`renderer`='',`filterstore`='',`flex`='1.00',`direction`='',`align`='',`grouped`='0',`listfiltertype`='',`hint`='NULL' where `table_name`='view_lose_untergruppen' and `column_name`='stimmzettelgruppen_mindestsitze' and `language`='DE';
insert into `ds_column_list_label`
                    (`table_name`,`column_name`,`language`,`label`)
                    values
                    ('view_lose_untergruppen','stimmzettelgruppen_ridx','DE','stimmzettelgruppen_ridx')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`),`language`=values(`language`),`label`=values(`label`);
update `ds_column_list_label` set `xtype`='gridcolumn',`editor`='',`position`='8',`summaryrenderer`='',`summarytype`='',`hidden`='0',`active`='1',`renderer`='',`filterstore`='',`flex`='1.00',`direction`='',`align`='',`grouped`='0',`listfiltertype`='',`hint`='NULL' where `table_name`='view_lose_untergruppen' and `column_name`='stimmzettelgruppen_ridx' and `language`='DE';
insert into `ds_column_list_label`
                    (`table_name`,`column_name`,`language`,`label`)
                    values
                    ('view_lose_untergruppen','stimmzettel_ridx','DE','stimmzettel_ridx')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`),`language`=values(`language`),`label`=values(`label`);
update `ds_column_list_label` set `xtype`='gridcolumn',`editor`='',`position`='9',`summaryrenderer`='',`summarytype`='',`hidden`='1',`active`='1',`renderer`='',`filterstore`='',`flex`='1.00',`direction`='',`align`='',`grouped`='0',`listfiltertype`='',`hint`='NULL' where `table_name`='view_lose_untergruppen' and `column_name`='stimmzettel_ridx' and `language`='DE';
insert into `ds_column_list_label`
                    (`table_name`,`column_name`,`language`,`label`)
                    values
                    ('view_lose_untergruppen','stimmzettel_sitze','DE','Mindestsitze')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`),`language`=values(`language`),`label`=values(`label`);
update `ds_column_list_label` set `xtype`='gridcolumn',`editor`='',`position`='10',`summaryrenderer`='',`summarytype`='',`hidden`='0',`active`='1',`renderer`='',`filterstore`='',`flex`='1.00',`direction`='',`align`='',`grouped`='0',`listfiltertype`='',`hint`='NULL' where `table_name`='view_lose_untergruppen' and `column_name`='stimmzettel_sitze' and `language`='DE';
-- END DS view_lose_untergruppen

