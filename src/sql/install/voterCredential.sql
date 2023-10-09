DELIMITER //

CREATE OR REPLACE FUNCTION `voterCredential`(usern varchar(36)) RETURNS JSON 
    DETERMINISTIC
BEGIN

  DECLARE res JSON;

  select 

JSON_OBJECT(
  'success',1,
  'data',JSON_OBJECT(
	  'canvote',1,
    'state','1|0',
    'id',id,
    'allowed',1,
    'voted',0,
    'ballotpaper',ballotpaper_id,
    'ballotpaper_id',ballotpaper_id,
    'username',username,
    'pwhash',pwhash
  )
) o
into res
from voter_credentials where username =usern;

  RETURN res;
END //