<?php

namespace Tualo\Office\PaperVote\Routes\combine;

use Exception;
use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\Basic\Route as BasicRoute;
use Tualo\Office\Basic\RouteWrapper;
use Tualo\Office\TualoPGP\TualoApplicationPGP;

use Ramsey\Uuid\Uuid;

class Reset extends RouteWrapper
{
    public static function scope(): string
    {
        return 'papervote.combine';
    }

    public static function isAllowed(): bool|null
    {

        return null;
    }

    public static function register()
    {
        BasicRoute::add('/papervote/combine/reset/(?P<barcode>[\d]+)', function ($matches) {

            App::contenttype('application/json');
            $db = App::get('session')->getDB();
            $db->autoCommit(false);
            try {



                $sql = '
                select count(*) c from (
                    select 
                    wahlschein.id, wahlberechtigte.identnummer , wahlschein.username , wahlschein.kombiniert, wahlscheinstatus 

                    from     wahlberechtigte join wahlschein  on wahlberechtigte.id = wahlschein.wahlberechtigte
                    and wahlberechtigte.identnummer in (
                    select wahlschein.kombiniert from 
                    wahlberechtigte join wahlschein on wahlberechtigte.id = wahlschein.wahlberechtigte
                    and wahlberechtigte.identnummer<>wahlschein.kombiniert
                    union all
                    select wahlberechtigte.identnummer from 
                    wahlberechtigte join wahlschein on wahlberechtigte.id = wahlschein.wahlberechtigte
                    and wahlberechtigte.identnummer<>wahlschein.kombiniert
                    ) 
                    and wahlberechtigte.identnummer<>wahlschein.kombiniert
                    and wahlschein.wahlscheinstatus = 1
                    and wahlberechtigte.identnummer = {barcode}
                ) a
                ';
                $wsCount = $db->singleValue($sql, $matches, 'c');
                if ($wsCount != 1) {
                    throw new Exception('Für diesen Wähler nicht erlaubt');
                }

                $sql = '
                update 
                    wahlschein
                set
                    kombiniert = {barcode},
                    wahlscheinstatus = 16,
                    login = getSessionUser()
                where
                    wahlschein.id in (
                        select wahlschein.id from (
                            select 
                            wahlschein.id, wahlberechtigte.identnummer , wahlschein.username , wahlschein.kombiniert, wahlscheinstatus 
        
                            from     wahlberechtigte join wahlschein  on wahlberechtigte.id = wahlschein.wahlberechtigte
                            and wahlberechtigte.identnummer in (
                            select wahlschein.kombiniert from 
                            wahlberechtigte join wahlschein on wahlberechtigte.id = wahlschein.wahlberechtigte
                            and wahlberechtigte.identnummer<>wahlschein.kombiniert
                            union all
                            select wahlberechtigte.identnummer from 
                            wahlberechtigte join wahlschein on wahlberechtigte.id = wahlschein.wahlberechtigte
                            and wahlberechtigte.identnummer<>wahlschein.kombiniert
                            ) 
                            and wahlberechtigte.identnummer<>wahlschein.kombiniert
                            and wahlschein.wahlscheinstatus = 1
                            and wahlberechtigte.identnummer = {barcode}
                        ) a
                    )
                    and wahlschein.wahlscheinstatus=1
                ';
                $db->direct($sql, $matches);

                App::result('success', true);
                $db->execute('commit');
                $db->commit();
                // $db->rollback();


            } catch (Exception $e) {
                $db->rollback();
                App::result('last_sql', $db->last_sql);
                App::result('msg', $e->getMessage());
            }
        }, ['get'], true, [], self::scope());
    }
}
