delimiter //

CREATE TABLE IF NOT EXISTS `ballotbox_decrypted_sum` (
  `id` varchar(50) NOT NULL PRIMARY KEY,
  `keyname` varchar(50) NOT NULL,
  `anzahl` integer not null,
  `isvalid` tinyint(4) DEFAULT NULL,
  `stimmzettel` integer DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
   CONSTRAINT `fk_ballotbox_decrypted_sum_stimmzettel` FOREIGN KEY (`stimmzettel`) REFERENCES `stimmzettel` (`id`) ON DELETE CASCADE ON UPDATE CASCADE


) //


CREATE OR REPLACE TRIGGER `ballotbox_decrypted_sum_ai_onlinestimmen`
    AFTER INSERT
    ON `ballotbox_decrypted_sum` FOR EACH ROW
BEGIN
    if lower(new.status) = 'gültig'  or new.status like 'g%ltig' then
        insert into onlinestimmzettel(stimmzettel,anzahl) values (new.stimmzettel,new.anzahl) on duplicate key update anzahl = values(anzahl);
    end if;
    if lower(new.status) = 'ungültig'  then
        insert into onlinestimmzettel(stimmzettel,ungueltig) values (new.stimmzettel,new.anzahl)  on duplicate key update ungueltig = values(ungueltig);
    end if;
    if new.status = 'Enthaltung' then
        insert into onlinestimmzettel(stimmzettel,enthaltung) values (new.stimmzettel,new.anzahl)  on duplicate key update enthaltung = values(enthaltung);
    end if;
END //



CREATE OR REPLACE TRIGGER `ballotbox_decrypted_sum_au_onlinestimmen`
    AFTER UPDATE
    ON `ballotbox_decrypted_sum` FOR EACH ROW
BEGIN
    if new.status = 'gültig' or new.status like 'g%ltig' then
        insert into onlinestimmzettel(stimmzettel,anzahl) values (new.stimmzettel,new.anzahl) on duplicate key update anzahl = values(anzahl);
    end if;
     if lower(new.status) = 'ungültig'  then
        insert into onlinestimmzettel(stimmzettel,ungueltig) values (new.stimmzettel,new.anzahl)  on duplicate key update ungueltig = values(ungueltig);
    end if;
    if new.status = 'Enthaltung' then
        insert into onlinestimmzettel(stimmzettel,enthaltung) values (new.stimmzettel,new.anzahl)  on duplicate key update enthaltung = values(enthaltung);
    end if;
END //