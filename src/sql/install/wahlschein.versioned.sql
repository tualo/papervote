DELIMITER //

CREATE OR REPLACE PROCEDURE `setupWahlscheinVersioning`()
BEGIN
    IF not exists(select * from information_schema.tables where table_schema=database() and table_name='wahlschein' and table_type='SYSTEM VERSIONED') THEN
            drop trigger if exists wahlschein__ai;
            drop trigger if exists wahlschein__au;
            drop trigger if exists wahlschein__bd;

            ALTER TABLE wahlschein ADD COLUMN ts TIMESTAMP(6) GENERATED ALWAYS AS ROW START,
            ADD COLUMN te TIMESTAMP(6) GENERATED ALWAYS AS ROW END,
            ADD PERIOD FOR SYSTEM_TIME(ts, te),
            ADD SYSTEM VERSIONING;
    END IF;

    IF not exists(select * from information_schema.tables where table_schema=database() and table_name='wahlberechtigte' and table_type='SYSTEM VERSIONED') THEN
        drop trigger if exists wahlberechtigte__ai;
        drop trigger if exists wahlberechtigte__au;
        drop trigger if exists wahlberechtigte__bd;
        ALTER TABLE wahlberechtigte ADD COLUMN ts TIMESTAMP(6) GENERATED ALWAYS AS ROW START,
        ADD COLUMN te TIMESTAMP(6) GENERATED ALWAYS AS ROW END,
        ADD PERIOD FOR SYSTEM_TIME(ts, te),
        ADD SYSTEM VERSIONING;
    END IF;
END //
call setupWahlscheinVersioning() //

CREATE TRIGGER IF NOT EXISTS `wahlschein_login_bi`
    BEFORE INSERT
    ON `wahlschein` FOR EACH ROW
BEGIN
    SET new.login = getSessionUser();
END //


CREATE TRIGGER IF NOT EXISTS `wahlschein_login_bu`
    BEFORE UPDATE
    ON `wahlschein` FOR EACH ROW
BEGIN
    SET new.login = getSessionUser();
END //