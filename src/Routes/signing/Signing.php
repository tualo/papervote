<?php

namespace Tualo\Office\PaperVote\Routes\signing;

use DateTime;
use Exception;
use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\Basic\Route as BasicRoute;
use Tualo\Office\Basic\IRoute;
use Tualo\Office\PaperVote\Routes\Query;

use Tualo\Office\TualoPGP\TualoApplicationPGP;
use Tualo\Office\PaperVote\WMTualoRequestHelper;

use Tualo\Office\DS\DSTable;

class Signing implements IRoute
{

    public static function register()
    {
        BasicRoute::add('/papervote/signing/save', function () {
            $db = App::get('session')->getDB();
            try {
                $input = json_decode(file_get_contents('php://input'), true);
                if (is_null($input)) throw new Exception("Error Processing Request", 1);

                $status = $input['wahlscheinstatus'];
                $wahlschein_id = $input['wahlschein_id'];


                $db->direct('set @allow_signing_wahlschein = 1;');
                $wahlschein = DSTable::instance('wahlschein');
                $ws_read = $wahlschein->f('id', 'eq', $wahlschein_id)->read();
                if ($ws_read->empty()) throw new Exception("Der Wahlschein *" . $wahlschein_id . "* wurde nicht gefunden");
                $ws = $ws_read->getSingle();
                // try load WS
                $loadWS = Query::get('wahlscheinnummer', $ws['wahlscheinnummer']);
                if (count($loadWS) == 0) throw new Exception("Der Wahlschein *" . $wahlschein_id . "* wurde nicht gefunden");


                if (($ws['wahlscheinstatus'] != 8) && ($ws['wahlscheinstatus'] != -8)) throw new Exception("Der Wahlschein befindet sich in einem ungültigen Zustand. " . $ws['wahlscheinstatus']);
                $ws['wahlscheinstatus'] = $status;
                unset($ws['te']);
                unset($ws['ts']);
                $wahlschein->update($ws);
                if ($wahlschein->error()) {
                    App::result('msg', $wahlschein->errorMessage());
                } else {
                    App::result('success', true);
                }
            } catch (Exception $e) {
                App::result('msg', $e->getMessage());
            }
            App::contenttype('application/json');
        }, ['post'], true);
    }
}
