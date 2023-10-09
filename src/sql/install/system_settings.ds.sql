DELIMITER;

INSERT INTO
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
        'system_settings',
        NULL,
        NULL,
        0,
        NULL,
        NULL,
        NULL,
        1,
        NULL,
        NULL,
        NULL,
        NULL,
        0,
        'cellmodel',
        NULL,
        0,
        NULL,
        NULL,
        1,
        'Unklassifiziert',
        NULL,
        NULL,
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
    ) ON DUPLICATE KEY
UPDATE
    title =
VALUES
(title),
    reorderfield =
VALUES
(reorderfield),
    use_history =
VALUES
(use_history),
    searchfield =
VALUES
(searchfield),
    displayfield =
VALUES
(displayfield),
    sortfield =
VALUES
(sortfield),
    searchany =
VALUES
(searchany),
    hint =
VALUES
(hint),
    overview_tpl =
VALUES
(overview_tpl),
    sync_table =
VALUES
(sync_table),
    writetable =
VALUES
(writetable),
    globalsearch =
VALUES
(globalsearch),
    listselectionmodel =
VALUES
(listselectionmodel),
    sync_view =
VALUES
(sync_view),
    syncable =
VALUES
(syncable),
    cssstyle =
VALUES
(cssstyle),
    alternativeformxtype =
VALUES
(alternativeformxtype),
    read_table =
VALUES
(read_table),
    class_name =
VALUES
(class_name),
    special_add_panel =
VALUES
(special_add_panel),
    existsreal =
VALUES
(existsreal),
    character_set_name =
VALUES
(character_set_name),
    read_filter =
VALUES
(read_filter),
    listxtypeprefix =
VALUES
(listxtypeprefix),
    phpexporter =
VALUES
(phpexporter),
    phpexporterfilename =
VALUES
(phpexporterfilename),
    combined =
VALUES
(combined),
    default_pagesize =
VALUES
(default_pagesize),
    allowForm =
VALUES
(allowForm),
    listviewbaseclass =
VALUES
(listviewbaseclass),
    showactionbtn =
VALUES
(showactionbtn),
    modelbaseclass =
VALUES
(modelbaseclass);

REPLACE INTO `ds_column` (
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
        'system_settings',
        'datatype',
        NULL,
        10000000,
        0,
        0,
        NULL,
        'YES',
        'NO',
        NULL,
        NULL,
        'varchar',
        '',
        'varchar(255)',
        255,
        NULL,
        NULL,
        'utf8mb3',
        'select,insert,update,references',
        1,
        0,
        1,
        '',
        NULL
    ),
    (
        'system_settings',
        'editor',
        NULL,
        10000000,
        0,
        0,
        NULL,
        'YES',
        'NO',
        NULL,
        NULL,
        'varchar',
        '',
        'varchar(255)',
        255,
        NULL,
        NULL,
        'utf8mb3',
        'select,insert,update,references',
        1,
        0,
        1,
        '',
        NULL
    ),
    (
        'system_settings',
        'label',
        NULL,
        10000000,
        0,
        0,
        NULL,
        'YES',
        'NO',
        NULL,
        NULL,
        'varchar',
        '',
        'varchar(255)',
        255,
        NULL,
        NULL,
        'utf8mb3',
        'select,insert,update,references',
        1,
        0,
        1,
        '',
        NULL
    ),
    (
        'system_settings',
        'min_quorum',
        NULL,
        10000000,
        0,
        0,
        NULL,
        'YES',
        'NO',
        NULL,
        NULL,
        'int',
        '',
        'int(11)',
        NULL,
        10,
        0,
        NULL,
        'select,insert,update,references',
        1,
        0,
        1,
        '',
        NULL
    ),
    (
        'system_settings',
        'property',
        NULL,
        10000000,
        0,
        0,
        NULL,
        'YES',
        'NO',
        NULL,
        NULL,
        'text',
        '',
        'text',
        65535,
        NULL,
        NULL,
        'utf8mb3',
        'select,insert,update,references',
        1,
        0,
        1,
        '',
        NULL
    ),
    (
        'system_settings',
        'system_settings_id',
        NULL,
        10000000,
        0,
        1,
        NULL,
        'NO',
        'NO',
        NULL,
        NULL,
        'varchar',
        'PRI',
        'varchar(50)',
        50,
        NULL,
        NULL,
        'utf8mb3',
        'select,insert,update,references',
        1,
        0,
        1,
        '',
        NULL
    );

REPLACE INTO `ds_column_list_label` (
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
        'system_settings',
        'system_settings_id',
        'DE',
        'system_settings_id',
        'gridcolumn',
        '',
        0,
        '',
        '',
        0,
        1,
        '',
        '',
        1.00,
        'ASC',
        'left',
        0,
        '',
        NULL
    );

REPLACE INTO `ds_column_form_label` (
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
        'system_settings',
        'system_settings_id',
        'DE',
        'system_settings_id',
        'displayfield',
        'Allgemein',
        0,
        0,
        1,
        1,
        '',
        1.00
    );