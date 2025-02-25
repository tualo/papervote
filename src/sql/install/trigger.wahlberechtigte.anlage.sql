DELIMITER //

CREATE OR REPLACE TRIGGER `before_insert_wahlberechtigte_anlage`
BEFORE INSERT ON `wahlberechtigte_anlage` FOR EACH  ROW
BEGIN

  DECLARE msg varchar(255);
  DECLARE tempid integer;
  DECLARE prefix integer;
  DECLARE add_stimmzettel varchar(10);
  DECLARE set_stimmzettel varchar(255);

  SET add_stimmzettel = '1';

  IF (@sessionuser IS NULL) THEN
    SET @sessionuser='NOT SET';
  END IF;

  SET set_stimmzettel = NEW.stimmzettel;

  IF (NEW.identnummer is null) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "DIE IDENTNUMMER muss übergeben werden.";

  END IF;




      IF (SELECT count(*) FROM stimmzettel WHERE id = set_stimmzettel)=1 THEN
        SELECT id into prefix FROM stimmzettel WHERE id = set_stimmzettel;

        INSERT IGNORE INTO `wahlberechtigte`
        (
         `id`,
         `identnummer`

        ) VALUES (
          NEW.identnummer, 
          NEW.identnummer
        );

        INSERT INTO `wahlschein`
        (
          `id`,
          `stimmzettel`,
          `wahlscheinnummer`,
          `wahlberechtigte`,
          `wahlscheinstatus`,
          `wahlscheinstatus_grund`,
          `abgabetyp`,

          `pwhash`,
          `username`,
          `kombiniert`,
          `testdaten`

        ) VALUES (
          
          concat(prefix,lpad(NEW.identnummer,14,'0')),
          set_stimmzettel,
          NEW.wahlscheinnummer,
          NEW.identnummer,
          '17|0',
          NULL,
          '0|0',

          NEW.pwhash,
          NEW.username,
          if(ifnull(new.kombiniert,'')='' is null,concat(prefix,lpad(NEW.identnummer,14,'0')),new.kombiniert),
          new.testdaten

        ) ON DUPLICATE KEY UPDATE id=values(ID);


      ELSE
        set msg = concat("Der Stimmzettel-Typ existiert nicht ",ifnull(set_stimmzettel,""), NEW.identnummer);
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg;
      END IF;


END //
