DELIMITER ;

INSERT IGNORE INTO `wm_berichte` VALUES
('wm_bekanntmachung','Bekanntmachung des Wahlausschusses - Wahlergebnis'),
('wm_berichte_abgewiesene_online','Protokolle Abgewiesene Online-Wähler'),
('wm_berichte_abschlussbericht_gesamt','Abschlussbericht - Gesamt'),
('wm_berichte_beteiligung_gesamt','Gesamtbeteiligung'),
('wm_berichte_offlinewahl_teilergebnis','Teilergebnis der Briefwahl'),
('wm_berichte_onlinewahl_teilergebnis','Teilergebnis der Onlinewahl'),
('wm_berichte_prozentuale_verteilung','Erreichte Stimmenanzahl je Kandidaten'),
('wm_berichte_zaehlprotokoll','Zählprotokoll'),
('wm_erwartet','Protokoll Erwartet');


insert ignore into wm_berichte (id,name) values ('wm_bekanntmachung','Bekanntmachung des Wahlausschusses - Wahlergebnis');
insert ignore into wm_berichte (id,name) values ('wm_berichte_abgewiesene_online','Protokolle Abgewiesene Online-Wähler');
insert ignore into wm_berichte (id,name) values ('wm_berichte_abschlussbericht_gesamt','Abschlussbericht - Gesamt');
insert ignore into wm_berichte (id,name) values ('wm_berichte_beteiligung_gesamt','Gesamtbeteiligung');
insert ignore into wm_berichte (id,name) values ('wm_berichte_beteiligung_tagesprokoll','Beteiligung Tagesprokoll');
insert ignore into wm_berichte (id,name) values ('wm_berichte_blocksystem','Blocksystem');
insert ignore into wm_berichte (id,name) values ('wm_berichte_double_voter','Doppelwähler');
insert ignore into wm_berichte (id,name) values ('wm_berichte_offlinewahl_teilergebnis','Teilergebnis der Briefwahl');
insert ignore into wm_berichte (id,name) values ('wm_berichte_onlinewahl_teilergebnis','Teilergebnis der Onlinewahl');
insert ignore into wm_berichte (id,name) values ('wm_berichte_prozentuale_verteilung','Erreichte Stimmenanzahl je Kandidaten');
insert ignore into wm_berichte (id,name) values ('wm_berichte_zaehlprotokoll','Zählprotokoll');
insert ignore into wm_berichte (id,name) values ('wm_erwartet','Protokoll Erwartet');



INSERT IGNORE INTO `wm_berichte` VALUES
('wm_berichte_losentscheid_stimmzettel','Losentscheide nach Stimmzettel'),
('wm_berichte_los_mindestsitze','Losentscheide nach Mindestsitz');


INSERT IGNORE INTO `wm_berichte` VALUES
('wm_berichte_erwartet_online','Protokoll Erwartet Online');


