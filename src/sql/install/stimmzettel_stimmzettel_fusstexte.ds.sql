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
        `read_table`,
        `existsreal`,
        `class_name`,
        `special_add_panel`,
        `read_filter`,
        `listxtypeprefix`,
        `phpexporter`,
        `phpexporterfilename`,
        `combined`,
        `allowForm`,
        `alternativeformxtype`,
        `character_set_name`,
        `default_pagesize`,
        `listviewbaseclass`,
        `showactionbtn`
    )
VALUES
    (
        'stimmzettel_stimmzettel_fusstexte',
        'SZ-Fusstext-Zuordnung',
        'pos',
        0,
        '',
        'id_stimmzettel',
        'pos',
        1,
        'Zuordnung der Fusstexte zum Stimmzettel',
        '',
        '',
        '',
        0,
        'cellmodel',
        '',
        0,
        '',
        '',
        1,
        'Wahlsystem',
        '',
        '',
        'listview',
        'XlsxWriter',
        '{GUID}',
        0,
        1,
        '',
        '',
        100,
        'Tualo.DataSets.ListView',
        1
    )  ;

replace INTO `ds_column` (
        `table_name`,
        `column_name`,
        `default_value`,
        `default_max_value`,
        `default_min_value`,
        `is_primary`,
        `update_value`,
        `is_nullable`,
        `is_referenced`,
        `referenced_table`,
        `referenced_column_name`,
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
        `writeable`,
        `note`,
        `hint`
    )
VALUES
    (
        'stimmzettel_stimmzettel_fusstexte',
        'id_stimmzettel',
        '',
        10000000,
        0,
        1,
        '',
        'NO',
        '',
        '',
        '',
        'int',
        'PRI',
        'int(11)',
        0,
        10,
        0,
        '',
        'select,insert,update,references',
        1,
        0,
        1,
        '',
        ''
    ),
    (
        'stimmzettel_stimmzettel_fusstexte',
        'id_stimmzettel_fusstexte',
        '',
        10000000,
        0,
        1,
        '',
        'NO',
        '',
        '',
        '',
        'varchar',
        'PRI',
        'varchar(36)',
        36,
        0,
        0,
        'utf8',
        'select,insert,update,references',
        1,
        0,
        1,
        '',
        ''
    ),
    (
        'stimmzettel_stimmzettel_fusstexte',
        'pos',
        '',
        10000000,
        0,
        0,
        '',
        'YES',
        '',
        '',
        '',
        'int',
        '',
        'int(11)',
        0,
        10,
        0,
        '',
        'select,insert,update,references',
        1,
        0,
        1,
        '',
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
        `summarytype`,
        `hidden`,
        `active`,
        `renderer`,
        `filterstore`,
        `flex`,
        `direction`,
        `align`,
        `grouped`,
        `listfiltertype`,
        `hint`
    )
VALUES
    (
        'stimmzettel_stimmzettel_fusstexte',
        'id_stimmzettel',
        'DE',
        'Stimmzettel',
        'column_stimmzettel_id',
        '',
        0,
        '',
        '',
        0,
        1,
        '',
        '',
        1.00,
        '',
        '',
        0,
        '',
        'NULL'
    ),
    (
        'stimmzettel_stimmzettel_fusstexte',
        'id_stimmzettel_fusstexte',
        'DE',
        'Fusstext',
        'column_stimmzettel_fusstexte_id',
        '',
        0,
        '',
        '',
        0,
        1,
        '',
        '',
        1.00,
        '',
        '',
        0,
        '',
        'NULL'
    ),
    (
        'stimmzettel_stimmzettel_fusstexte',
        'pos',
        'DE',
        'Position',
        'gridcolumn',
        '',
        999,
        '',
        '',
        0,
        1,
        '',
        '',
        1.00,
        '',
        '',
        0,
        '',
        'NULL'
    );

INSERT
    IGNORE INTO `ds_column_form_label` (
        `table_name`,
        `column_name`,
        `language`,
        `label`,
        `xtype`,
        `field_path`,
        `position`,
        `hidden`,
        `active`,
        `allowempty`,
        `fieldgroup`,
        `flex`
    )
VALUES
    (
        'stimmzettel_stimmzettel_fusstexte',
        'id_stimmzettel',
        'DE',
        'Stimmzettel',
        'combobox_stimmzettel_id',
        'Allgemein',
        0,
        0,
        1,
        0,
        '',
        1.00
    ),
    (
        'stimmzettel_stimmzettel_fusstexte',
        'id_stimmzettel_fusstexte',
        'DE',
        'Fusstext',
        'combobox_stimmzettel_fusstexte_id',
        'Allgemein',
        0,
        0,
        1,
        0,
        '',
        1.00
    ),
    (
        'stimmzettel_stimmzettel_fusstexte',
        'pos',
        'DE',
        'Postion',
        'number0',
        'Allgemein',
        999,
        0,
        1,
        0,
        '',
        1.00
    );

INSERT
    IGNORE INTO `ds_reference_tables` (
        `table_name`,
        `reference_table_name`,
        `columnsdef`,
        `active`,
        `constraint_name`,
        `searchable`,
        `autosync`,
        `position`,
        `path`,
        `existsreal`,
        `tabtitle`
    )
VALUES
    (
        'stimmzettel_stimmzettel_fusstexte',
        'stimmzettel',
        '{\"stimmzettel_stimmzettel_fusstexte__id_stimmzettel\":\"stimmzettel__id\"}',
        1,
        'fk_stimmzettel_fusstexte_stimmzettel',
        0,
        1,
        99999,
        '\'\'',
        1,
        ''
    ),
    (
        'stimmzettel_stimmzettel_fusstexte',
        'stimmzettel_fusstexte',
        '{\"stimmzettel_stimmzettel_fusstexte__id_stimmzettel_fusstexte\":\"stimmzettel_fusstexte__id\"}',
        1,
        'fk_stimmzettel_stimmzettel_fusstexte',
        0,
        1,
        99999,
        '\'\'',
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
    (
        'administration',
        'stimmzettel_stimmzettel_fusstexte',
        1,
        1,
        1,
        1,
        0
    ),
    (
        '_default_',
        'stimmzettel_stimmzettel_fusstexte',
        1,
        0,
        0,
        0,
        0
    );