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
        'wm_tanboegen',
        'Tanbögen',
        '',
        0,
        'id',
        'id',
        'id',
        1,
        '',
        '',
        '',
        '',
        0,
        'cellmodel',
        '',
        0,
        '',
        '',
        '',
        'Wahlsystem',
        '',
        1,
        '',
        '',
        'listview',
        'XlsxWriter',
        'tanbögen',
        0,
        1000,
        0,
        'Tualo.DataSets.ListView',
        1,
        'Tualo.DataSets.model.Basic'
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

INSERT INTO `ds_column` (
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
        'wm_tanboegen',
        'datum',
        '{DATE}',
        10000000,
        0,
        '',
        0,
        0,
        '',
        '',
        'YES',
        'NO',
        1,
        '',
        'date',
        '',
        'date',
        NULL,
        NULL,
        NULL,
        NULL,
        'select,insert,update,references',
        1,
        0,
        '',
        ''
    ),
    (
        'wm_tanboegen',
        'id',
        '{#serial}',
        10000000,
        0,
        '',
        1,
        0,
        '',
        '',
        'NO',
        'NO',
        1,
        '',
        'int',
        'PRI',
        'int(11)',
        NULL,
        10,
        0,
        NULL,
        'select,insert,update,references',
        1,
        0,
        '',
        ''
    ),
    (
        'wm_tanboegen',
        'zeit',
        '{TIME}',
        10000000,
        0,
        '',
        0,
        0,
        '',
        '',
        'YES',
        'NO',
        1,
        '',
        'time',
        '',
        'time',
        NULL,
        NULL,
        NULL,
        NULL,
        'select,insert,update,references',
        1,
        0,
        '',
        ''
    )
on DUPLICATE key update  default_value=values(default_value);


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
        'wm_tanboegen',
        'datum',
        'DE',
        'Datum',
        'gridcolumn',
        NULL,
        999,
        '',
        '',
        '',
        0,
        1,
        '',
        0,
        1.00,
        'ASC',
        'left',
        '',
        NULL
    ),
    (
        'wm_tanboegen',
        'id',
        'DE',
        'Bogen-ID',
        'gridcolumn',
        '',
        0,
        '',
        '',
        '',
        0,
        1,
        '',
        0,
        1.00,
        'ASC',
        'left',
        '',
        ''
    ),
    (
        'wm_tanboegen',
        'zeit',
        'DE',
        'Zeit',
        'gridcolumn',
        NULL,
        999,
        '',
        '',
        '',
        0,
        1,
        '',
        0,
        1.00,
        'ASC',
        'left',
        '',
        NULL
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
        `flex`,
        `hint`
    )
VALUES
    (
        'wm_tanboegen',
        'datum',
        'DE',
        'Datum',
        'displayfield',
        'Allgemein/Angaben',
        999,
        0,
        1,
        1,
        '1',
        1.00,
        '\'\''
    ),
    (
        'wm_tanboegen',
        'id',
        'DE',
        'Bogen-ID',
        'displayfield',
        'Allgemein/Angaben',
        0,
        0,
        1,
        1,
        '',
        1.00,
        '\'\''
    ),
    (
        'wm_tanboegen',
        'zeit',
        'DE',
        'Zeit',
        'displayfield',
        'Allgemein/Angaben',
        999,
        0,
        1,
        1,
        '1',
        1.00,
        '\'\''
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
    ('administration', 'wm_tanboegen', 1, 1, 1, 1, 1);

INSERT
    IGNORE INTO `ds_renderer` (
        `table_name`,
        `pug_template`,
        `label`,
        `orientation`,
        `useremote`
    )
VALUES
    (
        'wm_tanboegen',
        'wm_berichte_tanboegen',
        'PDF',
        '',
        NULL
    );