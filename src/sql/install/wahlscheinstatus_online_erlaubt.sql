delimiter ;
CREATE TABLE IF NOT EXISTS `wahlscheinstatus_online_erlaubt` (
  `wahlscheinstatus` varchar(12) NOT NULL,
  PRIMARY KEY (`wahlscheinstatus`),
  CONSTRAINT `fk_wahlscheinstatus_online_erlaubt_wahlscheinstatus` FOREIGN KEY (`wahlscheinstatus`) REFERENCES `wahlscheinstatus` (`ridx`) ON DELETE CASCADE ON UPDATE CASCADE
)
;

insert ignore into wahlscheinstatus_online_erlaubt (wahlscheinstatus) values ('1|0');