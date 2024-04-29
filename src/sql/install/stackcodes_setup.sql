delimiter ;

create table if not exists stackcodes_setup(
    id integer default 1 primary key,
    page_width integer default 105,
    page_height integer default 297,
    start_code integer default 100000,
    stop_code integer default  100020
);
alter table stackcodes_setup add column if not exists name varchar(255) default 'default';
alter table stackcodes_setup add column if not exists prefix varchar(3) default 'FC3';

"dsview_ds_pug_templates"

create table if not exists boxcodes_setup(
    id integer default 1 primary key,
    page_width integer default 80,
    page_height integer default 80,
    start_code integer default 100000,
    stop_code integer default  100020
);
alter table stackcodes_setup add column if not exists name varchar(255) default 'default';
alter table stackcodes_setup add column if not exists prefix varchar(3) default 'FC4';


create table if not exists pagination_setup(
    id integer default 1 primary key,
    name varchar(255) default 'default',
    page_width integer default 80,
    page_height integer default 80,
    start_code integer default 100000,
    stop_code integer default  100020
);