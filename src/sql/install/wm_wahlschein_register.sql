DELIMITER ;
CREATE TABLE IF NOT EXISTS `wm_wahlschein_register` (
  `id` bigint,
  `stimmzettel` varchar(12) NOT NULL,
  `token` varchar(36) NOT NULL,
  
  `birthdate_year` varchar(4) DEFAULT NULL,
  `birthdate_month` varchar(4) DEFAULT NULL,
  `birthdate_day` varchar(4) DEFAULT NULL,
  `phone_lc` varchar(5) DEFAULT NULL,
  `phone_number` varchar(25) DEFAULT NULL,
  `pin` varchar(10) DEFAULT NULL,
  `createdate` datetime NOT NULL,
  `sms_response` varchar(255) DEFAULT NULL,
  `tmg_token` varchar(255) DEFAULT NULL,
  `person` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id`,stimmzettel),
  constraint fk_wm_wahlschein_register_stimmzettel foreign key (stimmzettel) references stimmzettel (ridx) on delete cascade on update cascade

) ;


call addFieldIfNotExists('wm_wahlschein_register','formdata','json default null');
