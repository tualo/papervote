DELIMITER;

create
or replace view `view_wm_wahlbeteiligungwahl_beteiligung_bericht_datenliste` as
select
    `a`.`wahlbeteiligung_bericht_id` AS `wahlbeteiligung_bericht_id`,
    `a`.`stimmzettel` AS `stimmzettel`,
    `a`.`szwahltyp` AS `szwahltyp`,
    `a`.`abgabetyp` AS `abgabetyp`,
    `a`.`sortfield` AS `sortfield`,
    `a`.`name` AS `name`,
    sum(`a`.`c`) AS `wert`
from
    (
        select
            `view_wm_wahlbeteiligungwahl_beteiligung_bericht`.`wahlbeteiligung_bericht_id` AS `wahlbeteiligung_bericht_id`,
            `view_wm_wahlbeteiligungwahl_beteiligung_bericht`.`stimmzettel` AS `stimmzettel`,
            `view_wm_wahlbeteiligungwahl_beteiligung_bericht`.`szwahltyp` AS `szwahltyp`,
            `view_wm_wahlbeteiligungwahl_beteiligung_bericht`.`abgabetyp` AS `abgabetyp`,
            `view_wm_wahlbeteiligungwahl_beteiligung_bericht`.`sortfield` AS `sortfield`,
            `view_wm_wahlbeteiligungwahl_beteiligung_bericht`.`name` AS `name`,
            `view_wm_wahlbeteiligungwahl_beteiligung_bericht`.`c` AS `c`
        from
            `view_wm_wahlbeteiligungwahl_beteiligung_bericht`
        union
        select
            7 AS `wahlbeteiligung_bericht_id`,
            `stimmzettel`.`ridx` AS `stimmzettel`,
            '1|0' AS `abgabetyp`,
            `stimmzettel`.`wahltyp` AS `szwahltyp`,
            7 + 1000000 AS `sortfield`,
            'ohne Wahlschein' AS `name`,
            `stimmzettel`.`anzahl_10` AS `c`
        from
            `stimmzettel`
    ) `a`
group by
    `a`.`wahlbeteiligung_bericht_id`,
    `a`.`szwahltyp`,
    `a`.`stimmzettel`,
    `a`.`abgabetyp`;