DELIMITER;

REPLACE INTO
    `ds` (
        `table_name`,
        `title`,
        `reorderfield`,
        `use_history`,
        `searchfield`,
        `displayfield`,
        `sortfield`,
        `searchany`,
        `hint`,
        `overview_tpl`,
        `sync_table`,
        `writetable`,
        `globalsearch`,
        `listselectionmodel`,
        `sync_view`,
        `syncable`,
        `cssstyle`,
        `alternativeformxtype`,
        `read_table`,
        `class_name`,
        `special_add_panel`,
        `existsreal`,
        `character_set_name`,
        `read_filter`,
        `listxtypeprefix`,
        `phpexporter`,
        `phpexporterfilename`,
        `combined`,
        `default_pagesize`,
        `allowForm`,
        `listviewbaseclass`,
        `showactionbtn`,
        `modelbaseclass`
    )
VALUES
    (
        'ds_files_data',
        'DS Files Data',
        '',
        0,
        'file_id',
        'file_id',
        'file_id',
        0,
        '',
        '',
        '',
        '',
        0,
        'rowmodel',
        '',
        0,
        '',
        '',
        '',
        'Datenstamm',
        '',
        1,
        '',
        '',
        '',
        'XlsxWriter',
        'ds_files_data {DATE} {TIME}',
        0,
        1000,
        0,
        'Tualo.DataSets.ListView',
        1,
        'Tualo.DataSets.model.Basic'
    ) ;

INSERT
    IGNORE INTO `ds_column` (
        `table_name`,
        `column_name`,
        `default_value`,
        `default_max_value`,
        `default_min_value`,
        `update_value`,
        `is_primary`,
        `syncable`,
        `referenced_table`,
        `referenced_column_name`,
        `is_nullable`,
        `is_referenced`,
        `writeable`,
        `note`,
        `data_type`,
        `column_key`,
        `column_type`,
        `character_maximum_length`,
        `numeric_precision`,
        `numeric_scale`,
        `character_set_name`,
        `privileges`,
        `existsreal`,
        `deferedload`,
        `hint`,
        `fieldtype`
    )
VALUES
    (
        'ds_files_data',
        'data',
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        'NO',
        NULL,
        1,
        NULL,
        'longtext',
        '',
        'longtext',
        4294967295,
        NULL,
        NULL,
        'utf8mb4',
        'select,insert,update,references',
        1,
        NULL,
        NULL,
        ''
    ),
    (
        'ds_files_data',
        'file_id',
        NULL,
        NULL,
        NULL,
        NULL,
        1,
        NULL,
        NULL,
        NULL,
        'NO',
        NULL,
        1,
        NULL,
        'varchar',
        'PRI',
        'varchar(36)',
        36,
        NULL,
        NULL,
        'utf8mb4',
        'select,insert,update,references',
        1,
        NULL,
        NULL,
        ''
    );

INSERT
    IGNORE INTO `ds_column_list_label` (
        `table_name`,
        `column_name`,
        `language`,
        `label`,
        `xtype`,
        `editor`,
        `position`,
        `summaryrenderer`,
        `renderer`,
        `summarytype`,
        `hidden`,
        `active`,
        `filterstore`,
        `grouped`,
        `flex`,
        `direction`,
        `align`,
        `listfiltertype`,
        `hint`
    )
VALUES
    (
        'ds_files_data',
        'data',
        'DE',
        'data',
        'gridcolumn',
        '',
        999,
        '',
        '',
        '',
        0,
        1,
        '',
        0,
        1.00,
        '',
        'start',
        '',
        'NULL'
    ),
    (
        'ds_files_data',
        'file_id',
        'DE',
        'file_id',
        'gridcolumn',
        '',
        999,
        '',
        '',
        '',
        0,
        1,
        '',
        0,
        1.00,
        '',
        'start',
        '',
        'NULL'
    );

INSERT
    IGNORE INTO `ds_reference_tables` (
        `table_name`,
        `reference_table_name`,
        `columnsdef`,
        `constraint_name`,
        `active`,
        `searchable`,
        `autosync`,
        `position`,
        `path`,
        `existsreal`,
        `tabtitle`
    )
VALUES
    (
        'ds_files_data',
        'ds_files',
        '{\"file_id\":\"file_id\"}',
        'fk_ds_files_data_file_id',
        0,
        0,
        0,
        999,
        '',
        1,
        ''
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
    ('administration', 'ds_files_data', 1, 0, 0, 0, 0);