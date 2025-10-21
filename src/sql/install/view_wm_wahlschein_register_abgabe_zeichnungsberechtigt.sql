delimiter ;


create or replace view view_wm_wahlschein_register_abgabe_zeichnungsberechtigt_single as
select 
        wahlschein.id,

        JSON_VALUE(wm_wahlschein_register.formdata,'$.first_name') fn,
        JSON_VALUE(wm_wahlschein_register.formdata,'$.last_name') ln,
        wahlzeichnungsberechtigter.personenident,
        wahlzeichnungsberechtigter.vorname,
        wahlzeichnungsberechtigter.nachname,
        wahlzeichnungsberechtigter.funktion,
        wahlberechtigte.identnummer,
        if (
            (
                (
                    JSON_VALUE(wm_wahlschein_register.formdata,'$.first_name') = wahlzeichnungsberechtigter.vorname
                    and JSON_VALUE(wm_wahlschein_register.formdata,'$.last_name') = wahlzeichnungsberechtigter.nachname
                ) or

                (
                    JSON_VALUE(wm_wahlschein_register.formdata,'$.first_name') = wahlzeichnungsberechtigter.nachname
                    and JSON_VALUE(wm_wahlschein_register.formdata,'$.last_name') = wahlzeichnungsberechtigter.vorname

                )
                ),
                'match',
                'no match'
        ) status,
        wm_wahlschein_register.formdata,
        wm_wahlschein_register.createdate,
        wahlschein.wahlscheinstatus
      from
        wm_wahlschein_register
        join
        wahlschein
          on wm_wahlschein_register.id = wahlschein.id
        join 
          wahlberechtigte
          on wahlberechtigte.id = wahlschein.wahlberechtigte
        left join 
          wahlzeichnungsberechtigter
          on 
            wahlberechtigte.id = wahlzeichnungsberechtigter.wahlberechtigte

where wahlscheinstatus in (-8,8) and abgabetyp=2
;
call fill_ds('view_wm_wahlschein_register_abgabe_zeichnungsberechtigt_single');
call fill_ds_column('view_wm_wahlschein_register_abgabe_zeichnungsberechtigt_single');


create or replace view view_wm_wahlschein_register_abgabe_zeichnungsberechtigt as
select 
    w.id,
    max(w.fn) as vorname,
    max(w.ln) as nachname,
    max(w.identnummer) as identnummer,
    max(w.wahlscheinstatus) as wahlscheinstatus

from view_wm_wahlschein_register_abgabe_zeichnungsberechtigt_single w
group by w.id;

call fill_ds('view_wm_wahlschein_register_abgabe_zeichnungsberechtigt');
call fill_ds_column('view_wm_wahlschein_register_abgabe_zeichnungsberechtigt');
