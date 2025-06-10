<?php

namespace Tualo\Office\PaperVote\Routes;

use Exception;
use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\Basic\Route as BasicRoute;
use Tualo\Office\Basic\IRoute;
use Tualo\Office\TualoPGP\TualoApplicationPGP;
use Tualo\Office\DS\DSReadRoute;
use Ramsey\Uuid\Uuid;
use Tualo\Office\DS\DSTable;

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
            }

            BasicRoute::$finished = true;
            App::contenttype('application/json');
        }, ['get'], true);



        BasicRoute::add('/papervote/(?P<tablename>\w+)/create', function ($matches) {
            App::contenttype('application/json');

            $db = App::get('session')->getDB();
            $db->tinyIntAsBoolean(true);
            $db->direct('SET SESSION group_concat_max_len = 4294967295;');

            $tablename = $matches['tablename'];
            try {

                $allowedTables = ['ballotbox_decrypted_sum', 'onlinekandidaten'];
                if (!in_array($tablename, $allowedTables)) {
                    throw new Exception('Invalid DS access');
                }


                $input = json_decode(file_get_contents('php://input'), true);
                if (is_null($input)) throw new Exception("Error Processing Request", 1);
                $table = new DSTable($db, $tablename);
                if (($result = $table->insert($input)) !== false) {
                    if ($table->error()) {
                        throw new \Exception($table->errorMessage());
                    }

                    App::result('warnings', $table->warnings());
                    App::result('moreResults', $table->moreResults());

                    App::result('temp_dsx_rest_data', $db->direct('select * from temp_dsx_rest_data'));
                    App::result('insret_result', $db->direct('select * from temp_dsx_rest_data'));



                    App::deferredTrigger();
                    if (isset($result['data'])) App::result('data', $table->prepareRecords($result['data']));
                    App::result('success', true);

                    $read = DSReadRoute::read($db, $tablename, [
                        'tablename' => $tablename,
                        'concat_set_table' => 1
                    ]);
                    App::result('data', $read['data']);
                } else {
                    App::result('success', false);
                    App::result('warnings', $table->warnings());
                    App::result('moreResults', $table->moreResults());
                    App::result('msg', $table->errorMessage());
                }
            } catch (\Exception $e) {

                App::result('msg', $e->getMessage());
            }
            BasicRoute::$finished = true;
        }, ['post'], true);
    }
}
