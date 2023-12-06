<?php

namespace Tualo\Office\PaperVote\Routes\combine;

use Exception;
use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\Basic\Route as BasicRoute;
use Tualo\Office\Basic\IRoute;
use Tualo\Office\TualoPGP\TualoApplicationPGP;

use Ramsey\Uuid\Uuid;

class Save implements IRoute
{
    public static function register()
    {
        BasicRoute::add('/papervote/combine/save', function ($matches) {

            App::contenttype('application/json');
            $db = App::get('session')->getDB();
            $db->autoCommit(false);
            try {
                $data = json_decode(file_get_contents('php://input'), true);
                if (is_null($data)) {
                    throw new Exception('no data');
                }
                if (!isset($data['primaryIdentnummer'])) {
                    throw new Exception('missing parameter');
                }
                if (!isset($data['identnummern']) && !is_array($data['identnummern'])) {
                    throw new Exception('missing parameter');
                }
                $list = $data['identnummern'];
                $list[] = $data['primaryIdentnummer'];

                $sql = '
                select 
                    count(distinct  wahlschein.wahlscheinstatus) as c
                from 
                    wahlberechtigte join wahlschein 
                        on wahlberechtigte.ridx = wahlschein.wahlberechtigte 
                where 
                    wahlberechtigte.identnummer in ({list})
                    and wahlschein.wahlscheinstatus<>"1|0"
                ';
                $wsCount = $db->singleValue($sql, ['list' => '"'.implode('","', $list )."'" ],'c');
                if ($wsCount !=0 ) { throw new Exception('Wahlscheinstatus ist nicht 1'); }

                $sql = '
                select 
                    count(distinct  wahlschein.wahlscheinstatus) as c
                from 
                    wahlberechtigte join wahlschein 
                        on wahlberechtigte.ridx = wahlschein.wahlberechtigte 
                where 
                    wahlberechtigte.identnummer in ({list})
                    and wahlberechtigte.identnummer=wahlschein.kombiniert
                ';
                $wsCount = $db->singleValue($sql, ['list' => '"'.implode('","', $list)."'" ],'c');
                if ($wsCount !=0 ) { throw new Exception('Es sind bereits Kombinationen vorhanden'); }

                $sql = '
                update 
                    wahlschein
                set
                    kombiniert = {primaryIdentnummer}
                where
                    wahlberechtigte in (select ridx from wahlberechtigte where identnummer in ({list}))
                    and wahlschein.wahlscheinstatus="1|0"
                ';
                $db->direct($sql, ['list' => '"'.implode('","', $list)."'" ]);

                App::result('success', true);
                $db->execute('commit');
                $db->commit();
                // $db->rollback();
        

            } catch (Exception $e) {
                $db->rollback();
                App::result('last_sql', $db->last_sql);
                App::result('msg', $e->getMessage());
            }
        }, ['post'], true);
    }
}
