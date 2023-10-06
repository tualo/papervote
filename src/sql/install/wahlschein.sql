DELIMITER ;
CREATE TABLE IF NOT EXISTS `wahlschein` (
  `ridx` varchar(12) DEFAULT NULL,
  `id` bigint(20) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `aktiv` int(11) DEFAULT 1,
  `insert_date` date NOT NULL,
  `insert_time` time DEFAULT NULL,
  `update_date` date NOT NULL,
  `update_time` time DEFAULT NULL,
  `login` varchar(255) NOT NULL,
  `stimmzettel` varchar(12) NOT NULL,
  `wahlscheinnummer` varchar(255) DEFAULT NULL,
  `wahlberechtigte` varchar(12) DEFAULT NULL,
  `wahlscheinstatus` varchar(12) DEFAULT NULL,
  `wahlscheinstatus_grund` varchar(255) DEFAULT NULL,
  `abgabetyp` varchar(255) DEFAULT NULL,
  `pwhash` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `abgabehash` varchar(255) DEFAULT NULL,
  `sendtotmg` tinyint(4) DEFAULT 0,
  `antrag` tinyint(4) DEFAULT 0,
  `blocknumber` varchar(30) DEFAULT '0',
  `kostenstelle` int(11) NOT NULL DEFAULT 0,
  `defered` tinyint(4) DEFAULT 0,
  `xwn` varchar(10) DEFAULT NULL,
  `secret` varchar(500) DEFAULT NULL,
  `onlinecheck` tinyint(4) DEFAULT 0,
  `testdaten` tinyint(4) DEFAULT 0,
  `usedate` date DEFAULT NULL,
  PRIMARY KEY (`id`,`stimmzettel`),
  UNIQUE KEY `idx_wahlschein` (`ridx`),
  UNIQUE KEY `idx_wahlschein_ridx` (`ridx`),
  KEY `idx_wahlschein_wahlscheinstatus` (`wahlscheinstatus`),
  KEY `idx_wahlschein_wahlscheinstatus_grund` (`wahlscheinstatus_grund`),
  KEY `idx_wahlschein_wahlberechtigte` (`wahlberechtigte`),
  KEY `idx_wahlschein_wahlscheinnummer` (`wahlscheinnummer`),
  KEY `idx_wahlschein_name` (`name`),
  KEY `idx_wahlschein_abgabetyp` (`abgabetyp`),
  KEY `idx_wahlschein_sendtotmg` (`sendtotmg`),
  KEY `fk_wahlschein_stimmzettel` (`stimmzettel`),
  KEY `uidx_wahlschein_username` (`username`),
  KEY `idx_wahlschein_blocknumber` (`blocknumber`),
  CONSTRAINT `fk_wahlschein_stimmzettel` FOREIGN KEY (`stimmzettel`) REFERENCES `stimmzettel` (`ridx`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_wahlschein_wahlberechtigte` FOREIGN KEY (`wahlberechtigte`) REFERENCES `wahlberechtigte` (`ridx`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_wahlschein_wahlscheinstatus` FOREIGN KEY (`wahlscheinstatus`) REFERENCES `wahlscheinstatus` (`ridx`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`thomashoffmann`@`localhost`*/ /*!50003 TRIGGER `wahlschein__ai` after insert ON `wahlschein` FOR EACH ROW
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
          END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`thomashoffmann`@`localhost`*/ /*!50003 TRIGGER `wahlschein__au` after update ON `wahlschein` FOR EACH ROW
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
          END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`thomashoffmann`@`localhost`*/ /*!50003 TRIGGER `wahlschein__bd` before delete ON `wahlschein` FOR EACH ROW
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
          END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
