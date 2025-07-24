<?php

namespace Tualo\Office\PaperVote\Routes;

use Exception;
use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\Basic\Route as BasicRoute;
use Tualo\Office\Basic\IRoute;
use Tualo\Office\TualoPGP\TualoApplicationPGP;
use Tualo\Office\DS\DSReadRoute;
use Ramsey\Uuid\Uuid;

class DSReplacement implements IRoute
{

    public static function register()
    {
        BasicRoute::add('/papervote/(?P<tablename>\w+)/read', function ($matches) {

            $db = App::get('session')->getDB();
            $db->tinyIntAsBoolean(true);
            $tablename = $matches['tablename'];

            ini_set('memory_limit', '8G');
            try {
                $allowedTables = $db->directArray('select table_name from wm_sync_tables', [], 'table_name');
                if (!in_array($tablename, $allowedTables)) {
                    throw new Exception('Invalid DS access');
                }

                $db->direct('SET SESSION group_concat_max_len = 4294967295;');

                $input = $_REQUEST;

                $read = DSReadRoute::read($db, $tablename, $input);

                App::result('data', $read['data']);
                App::result('total', $read['total']);
                App::result('success', true);
            } catch (\Exception $e) {

                App::result('last_sql', $db->last_sql);
                App::result('msg', $e->getMessage());
                //App::result('dq', implode("\n",$GLOBALS['debug_query']));

            }

            BasicRoute::$finished = true;
            App::contenttype('application/json');
        }, ['get', 'post'], true);
    }
}
