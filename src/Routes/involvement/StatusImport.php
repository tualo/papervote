<?php

namespace Tualo\Office\PaperVote\Routes\involvement;

use Exception;
use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\Basic\Route as BasicRoute;
use Tualo\Office\Basic\IRoute;

class StatusImport implements IRoute
{

    public static function register()
    {
        BasicRoute::add('/papervote/involvement/wmstatusimport', function () {
            $session = App::get('session');
            $db = $session->getDB();
            try{
                $db->execute('call set_wahlschein_status()');
                App::result('success', true);
            }catch(Exception $e){
                App::result('msg', $e->getMessage());
            }
            App::contenttype('application/json');
        }, array('get', 'post'), true);
    }
}
