DELIMITER //

CREATE FUNCTION IF NOT EXISTS `getBallotpaper`(in_ridx VARCHAR(12)) RETURNS varchar(255) CHARSET utf8
    DETERMINISTIC
BEGIN


DECLARE `result` varchar(255);

select name into result from stimmzettel where ridx=in_ridx;
IF result is null THEN
    SET result = concat('nicht gesetzt');
END IF;

RETURN result;
END //