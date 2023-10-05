DELIMITER ;
CREATE TABLE IF NOT EXISTS `wahlschein_hstr` (
  `hstr_sessionuser` varchar(150) DEFAULT '',
  `hstr_action` varchar(8) NOT NULL DEFAULT 'insert',
  `hstr_revision` varchar(36) NOT NULL,
  `hstr_datetime` timestamp NOT NULL DEFAULT current_timestamp(),
  `abgabehash` varchar(255) DEFAULT NULL,
  `abgabetyp` varchar(255) DEFAULT NULL,
  `aktiv` int(11) DEFAULT NULL,
  `antrag` tinyint(4) DEFAULT NULL,
  `blocknumber` varchar(30) DEFAULT NULL,
  `defered` tinyint(4) DEFAULT NULL,
  `id` bigint(20) DEFAULT NULL,
  `insert_date` date DEFAULT NULL,
  `insert_time` time DEFAULT NULL,
  `kostenstelle` int(11) DEFAULT NULL,
  `login` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `onlinecheck` tinyint(4) DEFAULT NULL,
  `pwhash` varchar(255) DEFAULT NULL,
  `ridx` varchar(12) DEFAULT NULL,
  `secret` varchar(500) DEFAULT NULL,
  `sendtotmg` tinyint(4) DEFAULT NULL,
  `stimmzettel` varchar(12) DEFAULT NULL,
  `testdaten` tinyint(4) DEFAULT NULL,
  `update_date` date DEFAULT NULL,
  `update_time` time DEFAULT NULL,
  `usedate` date DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `wahlberechtigte` varchar(12) DEFAULT NULL,
  `wahlscheinnummer` varchar(255) DEFAULT NULL,
  `wahlscheinstatus` varchar(12) DEFAULT NULL,
  `wahlscheinstatus_grund` varchar(255) DEFAULT NULL,
  `xwn` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`hstr_revision`),
  KEY `idx_pri_wahlschein_hstr` (`id`,`stimmzettel`)
);

DELIMITER //

CREATE  TRIGGER IF NOT EXISTS `wahlschein__ai` after insert ON `wahlschein` FOR EACH ROW
BEGIN
DECLARE uu_id varchar(36);
SET uu_id = ifnull(@useuuid,uuid());

if ( (@use_hstr_trigger=1) or (@use_hstr_trigger is null) ) THEN

  INSERT INTO `wahlschein_hstr`
  (
    hstr_sessionuser,
    hstr_action,
    hstr_revision,
    `abgabehash`,`abgabetyp`,`aktiv`,`antrag`,`blocknumber`,`defered`,`id`,`insert_date`,`insert_time`,`kostenstelle`,`login`,`name`,`onlinecheck`,`pwhash`,`ridx`,`secret`,`sendtotmg`,`stimmzettel`,`testdaten`,`update_date`,`update_time`,`usedate`,`username`,`wahlberechtigte`,`wahlscheinnummer`,`wahlscheinstatus`,`wahlscheinstatus_grund`,`xwn`
  )
    SELECT
    ifnull(@sessionuser,"not set"),
    "insert",
    uu_id,
    `abgabehash`,`abgabetyp`,`aktiv`,`antrag`,`blocknumber`,`defered`,`id`,`insert_date`,`insert_time`,`kostenstelle`,`login`,`name`,`onlinecheck`,`pwhash`,`ridx`,`secret`,`sendtotmg`,`stimmzettel`,`testdaten`,`update_date`,`update_time`,`usedate`,`username`,`wahlberechtigte`,`wahlscheinnummer`,`wahlscheinstatus`,`wahlscheinstatus_grund`,`xwn`
  FROM
    `wahlschein`
  WHERE
    `id` = NEW.`id` and `stimmzettel` = NEW.`stimmzettel`
  on duplicate key update hstr_action=values(hstr_action),hstr_revision=values(hstr_revision),hstr_datetime=values(hstr_datetime)
  ;
  END IF;
END //


CREATE  TRIGGER IF NOT EXISTS `wahlschein__au` after update ON `wahlschein` FOR EACH ROW
        BEGIN
        DECLARE uu_id varchar(36);
        SET uu_id = ifnull(@useuuid,uuid());

        if ( (@use_hstr_trigger=1) or (@use_hstr_trigger is null) ) THEN

          INSERT INTO `wahlschein_hstr`
          (
            hstr_sessionuser,
            hstr_action,
            hstr_revision,
            `abgabehash`,`abgabetyp`,`aktiv`,`antrag`,`blocknumber`,`defered`,`id`,`insert_date`,`insert_time`,`kostenstelle`,`login`,`name`,`onlinecheck`,`pwhash`,`ridx`,`secret`,`sendtotmg`,`stimmzettel`,`testdaten`,`update_date`,`update_time`,`usedate`,`username`,`wahlberechtigte`,`wahlscheinnummer`,`wahlscheinstatus`,`wahlscheinstatus_grund`,`xwn`
          )
           SELECT
            ifnull(@sessionuser,"not set"),
            "update",
            uu_id,
            `abgabehash`,`abgabetyp`,`aktiv`,`antrag`,`blocknumber`,`defered`,`id`,`insert_date`,`insert_time`,`kostenstelle`,`login`,`name`,`onlinecheck`,`pwhash`,`ridx`,`secret`,`sendtotmg`,`stimmzettel`,`testdaten`,`update_date`,`update_time`,`usedate`,`username`,`wahlberechtigte`,`wahlscheinnummer`,`wahlscheinstatus`,`wahlscheinstatus_grund`,`xwn`
          FROM
            `wahlschein`
          WHERE
            `id` = NEW.`id` and `stimmzettel` = NEW.`stimmzettel`
          on duplicate key update hstr_action=values(hstr_action),hstr_revision=values(hstr_revision),hstr_datetime=values(hstr_datetime)
          ;
          END IF;
END //


CREATE  TRIGGER IF NOT EXISTS `wahlschein__bd` before delete ON `wahlschein` FOR EACH ROW
        BEGIN
        DECLARE uu_id varchar(36);
        SET uu_id = ifnull(@useuuid,uuid());

        if ( (@use_hstr_trigger=1) or (@use_hstr_trigger is null) ) THEN

          INSERT INTO `wahlschein_hstr`
          (
            hstr_sessionuser,
            hstr_action,
            hstr_revision,
            `abgabehash`,`abgabetyp`,`aktiv`,`antrag`,`blocknumber`,`defered`,`id`,`insert_date`,`insert_time`,`kostenstelle`,`login`,`name`,`onlinecheck`,`pwhash`,`ridx`,`secret`,`sendtotmg`,`stimmzettel`,`testdaten`,`update_date`,`update_time`,`usedate`,`username`,`wahlberechtigte`,`wahlscheinnummer`,`wahlscheinstatus`,`wahlscheinstatus_grund`,`xwn`
          )
           SELECT
            ifnull(@sessionuser,"not set"),
            "delete",
            uu_id,
            `abgabehash`,`abgabetyp`,`aktiv`,`antrag`,`blocknumber`,`defered`,`id`,`insert_date`,`insert_time`,`kostenstelle`,`login`,`name`,`onlinecheck`,`pwhash`,`ridx`,`secret`,`sendtotmg`,`stimmzettel`,`testdaten`,`update_date`,`update_time`,`usedate`,`username`,`wahlberechtigte`,`wahlscheinnummer`,`wahlscheinstatus`,`wahlscheinstatus_grund`,`xwn`
          FROM
            `wahlschein`
          WHERE
            `id` = OLD.`id` and `stimmzettel` = OLD.`stimmzettel`
          on duplicate key update hstr_action=values(hstr_action),hstr_revision=values(hstr_revision),hstr_datetime=values(hstr_datetime)
          ;
          END IF;
END //