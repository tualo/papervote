<?php

namespace Tualo\Office\PaperVote\Routes\optical;

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
        BasicRoute::add('/papervote/opticaldata', function ($matches) {

            App::contenttype('application/json');
            $db = App::get('session')->getDB();
            App::result('success', false);

            $db->autoCommit(false);
            try {
                App::result('success', true);
            } catch (Exception $e) {
                $db->rollback();
                App::result('last_sql', $db->last_sql);
                App::result('msg', $e->getMessage());
            }
        }, ['post'], true);
    }
}
