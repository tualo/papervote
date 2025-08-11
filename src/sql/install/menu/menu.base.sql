delimiter ;
-- MariaDB dump 10.19-11.0.2-MariaDB, for osx10.18 (arm64)
INSERT IGNORE INTO SESSIONDB.`macc_groups` VALUES
('wahl_administration',1,NULL,'unkategorisiert'),
('wahl_auswertungen',1,NULL,'unkategorisiert'),
('wahl_auszaehlung',1,NULL,'unkategorisiert'),
('wahl_ruecklauf',1,NULL,'unkategorisiert'),
('wahl_nachzaehlung',1,NULL,'unkategorisiert');


-- MariaDB dump 10.19-11.0.2-MariaDB, for osx10.18 (arm64)
-- WHERE:  id in (select id from rolle_menu where rolle like 'wahl_%')
INSERT IGNORE INTO SESSIONDB.`macc_menu` VALUES
('0bd562a6-5b84-11ee-86a9-c6832147e485','Wahlbezirk','',NULL,'',5,NULL,'e101dd3a-5b82-11ee-86a9-c6832147e485',0,1,'fa fa-map','#ds/wahlbezirk'),
('28208bd4-5b84-11ee-86a9-c6832147e485','Abgabetyp','',NULL,'',1,NULL,'e101dd3a-5b82-11ee-86a9-c6832147e485',0,1,'entypo et-hand','#ds/abgabetyp'),
('3fca8a32-5b84-11ee-86a9-c6832147e485','Wahlscheinstatus','',NULL,'',2,NULL,'e101dd3a-5b82-11ee-86a9-c6832147e485',0,1,'entypo et-text-document-inverted','#ds/wahlscheinstatus'),
('5c60bf04-5b84-11ee-86a9-c6832147e485','Wahltyp','',NULL,'',0,NULL,'e101dd3a-5b82-11ee-86a9-c6832147e485',0,1,'x-fa fa-circle','#ds/wahltyp'),
('705d1d7c-5b84-11ee-86a9-c6832147e485','Stimmzettelgruppen','',NULL,'',3,NULL,'e101dd3a-5b82-11ee-86a9-c6832147e485',0,1,'fa fa-file-text','#ds/stimmzettel'),
('8af26750-5b84-11ee-86a9-c6832147e485','Stimmzettel','',NULL,'',4,NULL,'e101dd3a-5b82-11ee-86a9-c6832147e485',0,1,'fa fa-file-text','#ds/stimmzettel'),
('a820c524-5b84-11ee-86a9-c6832147e485','Kandidaten','',NULL,'',7,NULL,'e101dd3a-5b82-11ee-86a9-c6832147e485',0,1,'fa fa-user','#ds/kandidaten'),
('e101dd3a-5b82-11ee-86a9-c6832147e485','Wahlgrundeinstellungen','',NULL,'',0,NULL,'',0,1,'fa fa-cogs',''),
('f7d51756-5b83-11ee-86a9-c6832147e485','Wahlgruppen','',NULL,'',6,NULL,'e101dd3a-5b82-11ee-86a9-c6832147e485',0,1,'typcn typcn-group','#ds/wahlgruppe')

;


INSERT IGNORE INTO SESSIONDB.macc_menu (id, title, path, param, component, priority, target, path2, automenu, use_iframe, iconcls, route_to) VALUES ('af999344-5c51-11ee-86a9-c6832147e485', 'Rücklauferfassung', '', null, '', 0, null, '', 0, 1, 'fa fa-envelope', '#papervote/return');
INSERT IGNORE INTO SESSIONDB.macc_menu (id, title, path, param, component, priority, target, path2, automenu, use_iframe, iconcls, route_to) VALUES ('e299ecb2-5c51-11ee-86a9-c6832147e485', 'Auszählung', '', null, '', 0, null, '', 0, 1, 'fa fa-barcode', '#papervote/counting');
REPLACE INTO SESSIONDB.macc_menu (id, title, path, param, component, priority, target, path2, automenu, use_iframe, iconcls, route_to) VALUES ('e299ecb2-5c51-11ee-86a9-c6832147e486', 'Nachzählung (angenommen,Brief)', '', null, '', 0, null, '', 0, 1, 'fa fa-barcode', '#papervote/rescan/1/2');
REPLACE INTO SESSIONDB.macc_menu (id, title, path, param, component, priority, target, path2, automenu, use_iframe, iconcls, route_to) VALUES ('e299ecb2-5c51-11ee-86a9-c6832147e487', 'Nachzählung (abgewiesen,Brief)', '', null, '', 0, null, '', 0, 1, 'fa fa-barcode', '#papervote/rescan/1/3');
INSERT IGNORE INTO SESSIONDB.macc_menu (id, title, path, param, component, priority, target, path2, automenu, use_iframe, iconcls, route_to) VALUES ('8a75dfea-5d38-11ee-86a9-c6832147e485', 'Monitor', '', null, '', 5, null, '', 0, 1, 'fa fa-bar-chart', '#papervote/monitor');


-- MariaDB dump 10.19-11.0.2-MariaDB, for osx10.18 (arm64)
INSERT IGNORE INTO SESSIONDB.`rolle_menu` VALUES
('0bd562a6-5b84-11ee-86a9-c6832147e485','wahl_administration',NULL),
('28208bd4-5b84-11ee-86a9-c6832147e485','wahl_administration',NULL),
('3fca8a32-5b84-11ee-86a9-c6832147e485','wahl_administration',NULL),
('5c60bf04-5b84-11ee-86a9-c6832147e485','wahl_administration',NULL),
('705d1d7c-5b84-11ee-86a9-c6832147e485','wahl_administration',NULL),
('8af26750-5b84-11ee-86a9-c6832147e485','wahl_administration',NULL),
('a820c524-5b84-11ee-86a9-c6832147e485','wahl_administration',NULL),
('e101dd3a-5b82-11ee-86a9-c6832147e485','wahl_administration',NULL),
('f7d51756-5b83-11ee-86a9-c6832147e485','wahl_administration',NULL),
('f7d51756-5b83-11ee-86a9-c6832147e485','wahl_administration',NULL),
('f7d51756-5b83-11ee-86a9-c6832147e485','wahl_administration',NULL);

INSERT IGNORE INTO SESSIONDB.rolle_menu (id, rolle, typ) VALUES ('8a75dfea-5d38-11ee-86a9-c6832147e485', 'wahl_administration', null);

INSERT IGNORE INTO SESSIONDB.rolle_menu (id, rolle, typ) VALUES ('af999344-5c51-11ee-86a9-c6832147e485', 'wahl_ruecklauf', null);
INSERT IGNORE INTO SESSIONDB.rolle_menu (id, rolle, typ) VALUES ('e299ecb2-5c51-11ee-86a9-c6832147e485', 'wahl_auszaehlung', null);
INSERT IGNORE INTO SESSIONDB.rolle_menu (id, rolle, typ) VALUES ('e299ecb2-5c51-11ee-86a9-c6832147e486', 'wahl_nachzaehlung', null);