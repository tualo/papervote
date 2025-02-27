delimiter ;

CREATE OR REPLACE VIEW `blocked_voters` AS
select
    `wahlschein`.`id` AS `voter_id`,
    `wahlschein`.`stimmzettel`
from
    `wahlschein`
where
    (
        `wahlschein`.`wahlscheinstatus` <> 2
        and `wahlschein`.`abgabetyp` = 2
    )
    or `wahlschein`.`testdaten` = 1
;

