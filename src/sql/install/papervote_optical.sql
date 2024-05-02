DELIMITER ;

create table if not exists `papervote_optical` (

  `pagination_id` bigint not null,

  `box_id` varchar(32) not null,
  `stack_id` varchar(32) not null,
  `ballotpaper_id` integer not null,

  `marks` varchar(255) not null,
  
  `created` timestamp not null default current_timestamp,
  `modified` timestamp not null default current_timestamp on update current_timestamp,
  primary key (`pagination_id`)
) ;


create table if not exists `papervote_optical_data` (

  `pagination_id` bigint not null,
    `data` longtext not null,
    primary key (`pagination_id`),
    constraint `fk_papervote_optical_data_pagination_id` foreign key (`pagination_id`) references `papervote_optical` (`pagination_id`) on delete cascade on update cascade
) ;