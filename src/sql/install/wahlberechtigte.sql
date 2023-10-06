DELIMITER ;
CREATE TABLE IF NOT EXISTS `wahlberechtigte` (
  `id` bigint(20) NOT NULL,
  `kostenstelle` int(11) NOT NULL DEFAULT 0,
  `ridx` varchar(12) DEFAULT NULL,
  `insert_date` date DEFAULT NULL,
  `update_date` date DEFAULT NULL,
  `login` varchar(255) DEFAULT NULL,
  `insert_time` time DEFAULT NULL,
  `update_time` time DEFAULT NULL,
  `aktiv` varchar(255) DEFAULT NULL,
  `identnummer` varchar(255) DEFAULT NULL,
  `identkurz` int(11) DEFAULT 0,
  PRIMARY KEY (`id`,`kostenstelle`),
  UNIQUE KEY `uidx_wahlberechtigte_ridx` (`ridx`),
  KEY `idx_wahlberechtigte_identnummer` (`identnummer`)
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
/*!50003 CREATE*/ /*!50017 DEFINER=`thomashoffmann`@`localhost`*/ /*!50003 TRIGGER `wahlberechtigte__ai` after insert ON `wahlberechtigte` FOR EACH ROW
        BEGIN
        DECLARE uu_id varchar(36);
        SET uu_id = ifnull(@useuuid,uuid());

        if ( (@use_hstr_trigger=1) or (@use_hstr_trigger is null) ) THEN

          INSERT INTO `wahlberechtigte_hstr`
          (
            hstr_sessionuser,
            hstr_action,
            hstr_revision,
            `aktiv`,`id`,`identkurz`,`identnummer`,`insert_date`,`insert_time`,`kostenstelle`,`login`,`ridx`,`update_date`,`update_time`
          )
           SELECT
            ifnull(@sessionuser,"not set"),
            "insert",
            uu_id,
            `aktiv`,`id`,`identkurz`,`identnummer`,`insert_date`,`insert_time`,`kostenstelle`,`login`,`ridx`,`update_date`,`update_time`
          FROM
            `wahlberechtigte`
          WHERE
            `id` = NEW.`id` and `kostenstelle` = NEW.`kostenstelle`
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
/*!50003 CREATE*/ /*!50017 DEFINER=`thomashoffmann`@`localhost`*/ /*!50003 TRIGGER `wahlberechtigte__au` after update ON `wahlberechtigte` FOR EACH ROW
        BEGIN
        DECLARE uu_id varchar(36);
        SET uu_id = ifnull(@useuuid,uuid());

        if ( (@use_hstr_trigger=1) or (@use_hstr_trigger is null) ) THEN

          INSERT INTO `wahlberechtigte_hstr`
          (
            hstr_sessionuser,
            hstr_action,
            hstr_revision,
            `aktiv`,`id`,`identkurz`,`identnummer`,`insert_date`,`insert_time`,`kostenstelle`,`login`,`ridx`,`update_date`,`update_time`
          )
           SELECT
            ifnull(@sessionuser,"not set"),
            "update",
            uu_id,
            `aktiv`,`id`,`identkurz`,`identnummer`,`insert_date`,`insert_time`,`kostenstelle`,`login`,`ridx`,`update_date`,`update_time`
          FROM
            `wahlberechtigte`
          WHERE
            `id` = NEW.`id` and `kostenstelle` = NEW.`kostenstelle`
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
/*!50003 CREATE*/ /*!50017 DEFINER=`thomashoffmann`@`localhost`*/ /*!50003 TRIGGER `wahlberechtigte__bd` before delete ON `wahlberechtigte` FOR EACH ROW
        BEGIN
        DECLARE uu_id varchar(36);
        SET uu_id = ifnull(@useuuid,uuid());

        if ( (@use_hstr_trigger=1) or (@use_hstr_trigger is null) ) THEN

          INSERT INTO `wahlberechtigte_hstr`
          (
            hstr_sessionuser,
            hstr_action,
            hstr_revision,
            `aktiv`,`id`,`identkurz`,`identnummer`,`insert_date`,`insert_time`,`kostenstelle`,`login`,`ridx`,`update_date`,`update_time`
          )
           SELECT
            ifnull(@sessionuser,"not set"),
            "delete",
            uu_id,
            `aktiv`,`id`,`identkurz`,`identnummer`,`insert_date`,`insert_time`,`kostenstelle`,`login`,`ridx`,`update_date`,`update_time`
          FROM
            `wahlberechtigte`
          WHERE
            `id` = OLD.`id` and `kostenstelle` = OLD.`kostenstelle`
          on duplicate key update hstr_action=values(hstr_action),hstr_revision=values(hstr_revision),hstr_datetime=values(hstr_datetime)
          ;
          END IF;
          END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
