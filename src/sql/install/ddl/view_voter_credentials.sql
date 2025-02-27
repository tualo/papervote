DELIMITER //
create or replace view view_voter_credentials as
select 
  wahlschein.id,
  stimmzettel.id ballotpaper_id,
  wahlschein.username,
  wahlschein.pwhash
from wahlschein join stimmzettel on wahlschein.stimmzettel = stimmzettel.id

//
