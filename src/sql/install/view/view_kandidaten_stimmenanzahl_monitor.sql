delimiter ;

create or replace view view_kandidaten_stimmenanzahl_monitor as
select 
    use_id,
    use_name,
    use_sitze,


    max(onlinestimmzettel_erwartet) as onlinestimmzettel_erwartet,
    max(onlinestimmzettel_anzahl) as onlinestimmzettel_anzahl,


    
    max(briefwahlstimmzettel_erwartet) as briefwahlstimmzettel_erwartet,
    max(briefwahlstimmzettel_anzahl) as briefwahlstimmzettel_anzahl,


    max(onlinestimmzettel_anzahl) /    max(onlinestimmzettel_erwartet) `onlinewahl_quote`,
    max(briefwahlstimmzettel_anzahl) /    max(briefwahlstimmzettel_erwartet) `briefwahl_quote`
from 
    view_kandidaten_stimmenanzahl
group by     
    use_id,
    use_name