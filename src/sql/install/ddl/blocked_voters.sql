delimiter ;

CREATE OR REPLACE VIEW `blocked_voters` AS
select
    `wahlschein`.`id` AS `voter_id`,
    `wahlschein`.`stimmzettel`
from
    `wahlschein`
    join voting_state
where
    (
        `wahlschein`.`wahlscheinstatus` <> 2
        and `wahlschein`.`abgabetyp` = 2
    )
    or 
    (
        voting_state.phase in ('production_phase', 'council_phase','setup_phase','reset_phase')
        and 
        `wahlschein`.`testdaten` = 1
    )
    ;