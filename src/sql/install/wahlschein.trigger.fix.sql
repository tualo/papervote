DELIMITER //
CREATE OR REPLACE TRIGGER   `wahlschein_login_bu`
    BEFORE UPDATE
    ON `wahlschein` FOR EACH ROW
BEGIN
    SET new.login = getSessionUser();
    SET new.update_date=curdate();
    SET new.update_time=curtime();
    
END //

CREATE TRIGGER IF NOT EXISTS `wahlschein_login_bi`
    BEFORE INSERT
    ON `wahlschein` FOR EACH ROW
BEGIN
    SET new.login = getSessionUser();
END //
