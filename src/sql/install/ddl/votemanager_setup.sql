DELIMITER;

create table if not exists votemanager_setup (
    id varchar(100) primary key,
    val varchar(128) not null,
    created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp on update current_timestamp
);

insert ignore into votemanager_setup (id, val) values ('wm_report_base', 'stimmzettel');
insert ignore into votemanager_setup (id, val) values ('wm_report_partial', 'show');
insert ignore into votemanager_setup (id, val) values ('wm_report_pagenumbers', 'show');
insert ignore into votemanager_setup (id, val) values ('wm_report_bp_break', 'yes');

