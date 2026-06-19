DELIMITER //

CREATE OR REPLACE FUNCTION `randomPWGenString`(length SMALLINT(3),allowedChars varchar(255)) 
RETURNS varchar(100) CHARSET utf8
begin
    SET @returnStr = '';
    SET @i = 0;

    WHILE (@i < length) DO
        SET @returnStr = CONCAT(@returnStr, substring(allowedChars, FLOOR(RAND() * LENGTH(allowedChars) + 1), 1));
        SET @i = @i + 1;
    END WHILE;

    RETURN @returnStr;
END //




CREATE OR REPLACE PROCEDURE `firstSetupPWGenRandom`()
BEGIN
    if ( (select count(*) from pwgen_precalc where preset_name='wahlschein8')=0) then
        call fill_pwgen_precalc('wahlschein8',8,'0123456789',80000) ;
        call fill_pwgen_precalc('username8',8,'ABCDEFGHJKLMNPRSTUVXYZ123456789',80000)  ;
        call fill_pwgen_precalc('password8',8,'AaBbCcDdEeFfGgHhJKLMmNnPpRrSsTtUuVXxYyZ123456789',80000)  ;
    end if;
END //

call firstSetupPWGenRandom() //