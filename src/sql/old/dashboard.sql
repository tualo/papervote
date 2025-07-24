delimiter;

insert
    ignore into dashboard_available_types (xtype, classname, description)
values
    (
        'tualodashboard_papervote_state',
        'Tualo.PaperVote.lazy.dashboard.State',
        ''
    );
insert
    ignore into dashboard (id, title, dashboard_type, position, configuration)
values
    (
        'c59eca3x-8ece-11ee-aac7-ac1f6bd9bb0c',
        'Status',
        'tualodashboard_papervote_state',
        1,
        '{}'
    );