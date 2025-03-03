
DELIMITER //



CREATE OR REPLACE PROCEDURE `proc_clone_vm_data`(in in_target_db varchar(128),in in_source_db varchar(128))
BEGIN
    declare template longtext;
    declare sqlstmt longtext;

    create temporary table if not exists tmp_clone_vm_cmommands (x longtext);
    set template = "
    insert into tmp_clone_vm_cmommands (x)

    select 

    concat(
        'insert ignore into targetdbname.copytablename ',
        '(',group_concat( concat('',tc.column_name) order by tc.column_name separator ','),')  ',
        'select ',group_concat( concat('st.',tc.column_name) order by tc.column_name separator ','),' from sourcedbname.copytablename st ',
        ''
    ) x

    from 
        targetdbname.ds_column tc join 
        sourcedbname.ds_column sc
            on (tc.table_name,tc.column_name) = (sc.table_name,sc.column_name)
                and tc.existsreal=1
                and sc.existsreal=1 
        

    where tc.table_name='copytablename'  
    group by tc.table_name
    ";
/*
        'install/ddl/wahlgruppe'                    => 'setup wahlgruppe',
        'install/ddl/wahlbezirk'                    => 'setup wahlbezirk',
        'install/ddl/stimmzettel'                   => 'setup stimmzettel',
        'install/ddl/stimmzettelgruppen'            => 'setup stimmzettelgruppen',
        'install/ddl/kandidaten'                    => 'setup kandidaten',

        'install/ddl/kandidaten_bilder_typen'       => 'setup kandidaten_bilder_typen',
        'install/ddl/kandidaten_bilder'             => 'setup kandidaten_bilder',

                'install/ddl/wahlberechtigte'               => 'setup wahlberechtigte',
        'install/ddl/wahlzeichnungsberechtigter'    => 'setup wahlzeichnungsberechtigter',
        'install/ddl/wahlschein'                    => 'setup wahlschein',
        'install/ddl/wahlberechtigte_anlage'              => 'setup wahlberechtigte_anlage',     
         'install/ddl/wahlscheinstatus_online_erlaubt'              => 'setup wahlscheinstatus_online_erlaubt',     

*/
    create temporary table if not exists tmp_clone_vm_data (tn varchar(128));
    insert into tmp_clone_vm_data (tn) values 
        ('wahltyp'),
        ('abgabetyp'),
        ('wahlscheinstatus'),
        ('wahlscheinstatus_grund'),
        ('wahlgruppe'),
        ('wahlbezirk'),
        ('stimmzettel'),
        ('stimmzettelgruppen'),
        ('kandidaten'),
        ('kandidaten_bilder_typen'),
        ('kandidaten_bilder'),
        ('ds_files'),
        ('ds_files_data'),
        ('wahlberechtigte'),
        ('wahlzeichnungsberechtigter'),
        ('wahlschein'),
        ('wahlberechtigte_anlage'),
        ('wahlscheinstatus_online_erlaubt')
        ;
    for rec in (
        select tn from tmp_clone_vm_data
    ) do
        set sqlstmt = replace(template,'copytablename',rec.tn);
        set sqlstmt = replace(sqlstmt,'sourcedbname',in_source_db);
        set sqlstmt = replace(sqlstmt,'targetdbname',in_target_db);

        
        prepare stmt from sqlstmt;
        execute stmt;
        deallocate prepare stmt;
        
    end for;
    drop temporary table if exists tmp_clone_vm_data;



    for rec in (
        select x from tmp_clone_vm_cmommands
    ) do
        set sqlstmt = rec.x;
        prepare stmt from sqlstmt;
        execute stmt;
        deallocate prepare stmt;
    end for;
    drop temporary table if exists tmp_clone_vm_cmommands;

END //
