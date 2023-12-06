<?php

namespace Tualo\Office\PaperVote\Routes\combine;

use Exception;
use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\Basic\Route as BasicRoute;
use Tualo\Office\Basic\IRoute;
use Tualo\Office\TualoPGP\TualoApplicationPGP;

use Ramsey\Uuid\Uuid;

class ReverseCheck implements IRoute
{
    public static function register()
    {
        BasicRoute::add('/papervote/combine/reversecheck/(?P<barcode>[\w\-\_\d]+)',function($matches){

            App::contenttype('application/json');
            $db = App::get('session')->getDB();
            
            try {
                $sql = 'select count(*) c 
                from   wahlberechtigte join wahlschein on wahlberechtigte.ridx = wahlschein.wahlberechtigte
                where 
                    wahlschein.kombiniert = {barcode}
                    and wahlberechtigte.identnummer<>wahlschein.kombiniert
                ';
                $count = $db->singleValue($sql, $matches,'c');
                if ($count !=0 ) { throw new Exception('Es sind bereits Kombinationen vorhanden'); }
                App::result('success', true);
                

            } catch (Exception $e) {
                App::result('last_sql', $db->last_sql);
                App::result('msg', $e->getMessage());
            }
        }, ['get'], true);
    }
}
