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


      IF (SELECT count(*) FROM stimmzettel WHERE ridx = set_stimmzettel)=1 THEN
      SELECT id into prefix FROM stimmzettel WHERE ridx = set_stimmzettel;
        INSERT IGNORE INTO `wahlberechtigte`
        (
         `kostenstelle`,
         `id`,
         `ridx`,
         `identnummer`,

         `insert_date`,
         `update_date`,
         `login`,
         `insert_time`,
         `update_time`,
         `aktiv`

        ) VALUES (
         0,
         NEW.identnummer, 
         NEW.identnummer, 
         NEW.identnummer,


         CURRENT_DATE,
         CURRENT_DATE,
         @sessionuser,
         CURRENT_TIME,
         CURRENT_TIME,
         1
       ) ON DUPLICATE KEY UPDATE id=values(ID);

        INSERT INTO `wahlschein`
        (
          `ridx`,
          `id`,
          `kostenstelle`,
          `name`,
          `aktiv`,
          `insert_date`,
          `update_date`,
          `login`,
          `stimmzettel`,
          `insert_time`,
          `update_time`,
          `wahlscheinnummer`,
          `wahlberechtigte`,
          `wahlscheinstatus`,
          `wahlscheinstatus_grund`,
          `abgabetyp`,
          `defered`,
          `pwhash`,
          `username`,
          `abgabehash`,
          `sendtotmg`,
          `kombiniert`

        ) VALUES (
          concat(prefix,lpad(NEW.identnummer,8,'0')),
          concat(prefix,lpad(NEW.identnummer,8,'0')),
          0,
          NEW.identnummer,
          1,
          CURRENT_DATE,
          CURRENT_DATE,
          @sessionuser,
          set_stimmzettel,
          CURRENT_TIME,
          CURRENT_TIME,
          NEW.wahlscheinnummer,
          NEW.identnummer, 
          '17|0',
          NULL,
          NULL,
          0,
          NEW.pwhash,
          NEW.username,
          '',
          0,
          if(ifnull(new.kombiniert,'')='' is null,concat(prefix,lpad(NEW.identnummer,8,'0')),new.kombiniert)
        ) ON DUPLICATE KEY UPDATE id=values(ID);
      ELSE
        set msg = concat("Der Stimmzettel-Typ existiert nicht ",ifnull(set_stimmzettel,""));
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg;
      END IF;


END //
