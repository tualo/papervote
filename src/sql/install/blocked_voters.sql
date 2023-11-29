delimiter ;

CREATE OR REPLACE VIEW `blocked_voters` AS
select
    `wahlschein`.`id` AS `voter_id`,
    `wahlschein`.`stimmzettel`
from
    `wahlschein`
where
    (
        `wahlschein`.`wahlscheinstatus` <> '2|0'
        and `wahlschein`.`abgabetyp` = '2|0'
    )
    or `wahlschein`.`testdaten` = 1
;

insert into `ds`
                    (`table_name`)
                    values
                    ('blocked_voters')
                    on duplicate key update `table_name`=values(`table_name`);
update `ds` set `title`='blocked_voters',`reorderfield`='',`use_history`='0',`searchfield`='voter_id',`displayfield`='voter_id',`sortfield`='voter_id',`searchany`='1',`hint`='',`overview_tpl`='',`sync_table`='',`writetable`='',`globalsearch`='0',`listselectionmodel`='cellmodel',`sync_view`='',`syncable`='0',`cssstyle`='',`read_table`='',`existsreal`='1',`class_name`='Unklassifiziert',`special_add_panel`='',`read_filter`='',`listxtypeprefix`='listview',`phpexporter`='XlsxWriter',`phpexporterfilename`='{GUID}',`combined`='0',`allowForm`= 0 ,`alternativeformxtype`='',`character_set_name`='',`default_pagesize`='100',`listviewbaseclass`='Tualo.DataSets.ListView',`showactionbtn`='1' where `table_name`='blocked_voters';
insert into `ds_column`
                    (`table_name`,`column_name`)
                    values
                    ('blocked_voters','voter_id')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`);
update `ds_column` set `default_value`='',`default_max_value`='10000000',`default_min_value`='0',`is_primary`='1',`update_value`='',`is_nullable`='NO',`is_referenced`='0',`referenced_table`='',`referenced_column_name`='',`data_type`='bigint',`column_key`='',`column_type`='bigint(20)',`character_maximum_length`='0',`numeric_precision`='19',`numeric_scale`='0',`character_set_name`='',`privileges`='select,insert,update,references',`existsreal`='1',`deferedload`='0',`writeable`='1',`note`='\'\'',`hint`='' where `table_name`='blocked_voters' and `column_name`='voter_id';
insert into `ds_access`
                    (`role`,`table_name`)
                    values
                    ('administration','blocked_voters')
                    on duplicate key update `role`=values(`role`),`table_name`=values(`table_name`);
update `ds_access` set `read`='1',`write`='0',`delete`='0',`append`='0',`existsreal`='0' where `role`='administration' and `table_name`='blocked_voters';
insert into `ds_column_list_label`
                    (`table_name`,`column_name`,`language`,`label`)
                    values
                    ('blocked_voters','voter_id','DE','voter_id')
                    on duplicate key update `table_name`=values(`table_name`),`column_name`=values(`column_name`),`language`=values(`language`),`label`=values(`label`);
update `ds_column_list_label` set `xtype`='gridcolumn',`editor`='',`position`='999',`summaryrenderer`='',`summarytype`='',`hidden`='0',`active`='1',`renderer`='',`filterstore`='',`flex`='1.00',`direction`='',`align`='',`grouped`='0',`listfiltertype`='',`hint`='' where `table_name`='blocked_voters' and `column_name`='voter_id' and `language`='DE';
-- END DS blocked_voters


