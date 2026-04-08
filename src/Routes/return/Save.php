<?php

namespace Tualo\Office\PaperVote\Routes\return;

use DateTime;
use Exception;
use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\Basic\Route as BasicRoute;
use Tualo\Office\Basic\IRoute;
use Tualo\Office\PaperVote\Routes\Query;

use Tualo\Office\TualoPGP\TualoApplicationPGP;
use Tualo\Office\PaperVote\WMTualoRequestHelper;

use Tualo\Office\DS\DSTable;

class Save extends \Tualo\Office\Basic\RouteWrapper
{
    private static $time_start = 0;
    private static $total_time_start = 0;
    private static $timing_result = [];
    public static function scope(): string
    {
        return 'papervote.return';
    }

    public static function timing(string $key, $data = null)
    {
        if (self::$time_start == 0) self::$time_start = microtime(true);
        if (self::$total_time_start == 0) self::$total_time_start = microtime(true);
        $time_end = microtime(true);
        self::$timing_result[] = array('key' => $key, 'total' => $time_end - self::$total_time_start, 'last' => $time_end - self::$time_start, 'data' => $data);
        //if (self::configuration('logger-options', 'TualoApplicationTiming', '0') == '1') {
        App::logger('PaperVoteSave')->info(number_format($time_end - self::$total_time_start, 5) . "s " . number_format($time_end - self::$time_start, 5) . "s (" . $key . ")");
        //}
        self::$time_start = $time_end;
    }
    public static function register()
    {
        BasicRoute::add('/papervote/return/save', function () {
            $db = App::get('session')->getDB();
            try {
                Save::timing('start');
                $input = json_decode(file_get_contents('php://input'), true);
                if (is_null($input)) throw new Exception("Error Processing Request", 1);
                $status = json_decode($input['status'], true);
                $liste = json_decode($input['liste'], true);
                $USE_TUALO = 0;
                $USE_TUALO_URL = 0;
                $system_settings = $db->direct("select property,system_settings_id FROM system_settings ", [], 'system_settings_id');

                $usedate = isset($input['use_date']) ? $input['use_date'] : (new DateTime())->format('Y-m-d');

                if (is_null($status)) throw new Exception("Error Processing Request", 1);
                if (is_null($liste)) throw new Exception("Error Processing Request", 1);


                $blocknumber = isset($input['blocknumber']) ? $input['blocknumber'] : '0';

                if (App::configuration('papervote', 'force_blocknumber', '0') == '1') {
                    if ($blocknumber == '0') throw new Exception("Eine Bocknummer wird erwartet.");
                }

                $db->direct("insert into wahlschein_blocknumbers (blocknumber  ,login,lastlogin , createtime ,lastinsert) values ({blocknumber},getSessionUser(),getSessionUser(),now(),now() ) on duplicate key update lastlogin=values(lastlogin),lastinsert=values(lastinsert) ", ['blocknumber' => $blocknumber]);
                Save::timing('wahlschein_blocknumbers', __LINE__);

                foreach ($liste as $wert) {

                    $wahlschein = DSTable::instance('wahlschein');
                    $ws_read = $wahlschein->f('id', 'eq', $wert)->read();
                    if ($ws_read->empty()) throw new Exception("Der Wahlschein *" . $wert . "* wurde nicht gefunden");
                    $ws = $ws_read->getSingle();
                    // try load WS
                    Save::timing('DSTable::instance(wahlschein)', __LINE__);

                    $loadWS = Query::get('wahlscheinnummer', $ws['wahlscheinnummer']);
                    if (count($loadWS) == 0) throw new Exception("Der Wahlschein *" . $wert . "* wurde nicht gefunden");
                    Save::timing('Query::get(wahlscheinnummer)', __LINE__);

                    $useStatus = null;
                    foreach ($status as $val) {
                        if (!isset($val['feld'])) $val['feld'] = 'wahlscheinstatus';


                        if (($ws['' . $val['feld']] == 6)) throw new Exception("Der Status darf nicht überschrieben werden.");

                        if (in_array($ws['' . $val['feld']], [1, -1])) {
                            // nimmt nicht teil kann nicht überschrieben werden!
                            $ws['' . $val['feld']] = $val['status'];
                            $ws['' . $val['feld'] . '_grund'] = isset($val['grund']) ? $val['grund'] : '';
                            // $set_state = $ws[''.$val['feld']];
                            $useStatus = $val['status'];
                        } else {
                            throw new Exception("Der Wahlschein befindet sich in einem ungültigen Zustand.");
                        }
                    }
                    if (isset($system_settings['remote-erp/url'])  && strlen($system_settings['remote-erp/url']['property']) > 6) {

                        App::logger('SAVE')->debug($system_settings['remote-erp/url']['property'] . '/~/' . $system_settings['remote-erp/token']['property'] . '/onlinevote/get/' . $ws['id']);
                        $online_result = WMTualoRequestHelper::query($system_settings['remote-erp/url']['property'] . '/~/' . $system_settings['remote-erp/token']['property'] . '/onlinevote/get/' . $ws['id']);
                        Save::timing('WMTualoRequestHelper::query(wahlscheinnummer)', __LINE__);
                        if ($online_result === false) {
                            throw new Exception("Der Wähler ist derzeit online angemeldet. Bitte warten Sie bis der Wähler sich abgemeldet hat.");
                        }
                        /*
                        $o =  WMTualoRequestHelper::query(str_replace('#identnummer', $ws['id'], $system_settings['remote-erp/url']), [
                            'message' => TualoApplicationPGP::encrypt($keyData['publickey'], 'OK MESSAGE')
                        ]);
                        */
                    }


                    $ws['' . 'usedate'] = $usedate; // Datum übernehmen
                    $ws['' . 'abgabetyp'] = 1; // Briefwahltyp setzen
                    $ws['' . 'blocknumber'] = $blocknumber; // blocknumber


                    Save::timing('before wahlschein->update(wahlscheinnummer)', __LINE__);

                    unset($ws['te']);
                    unset($ws['ts']);



                    //
                    // check deadlock
                    // $wahlschein->update($ws);
                    $db->direct('update wahlschein set 
                        usedate={usedate},
                        abgabetyp={abgabetyp},
                        blocknumber={blocknumber},
                        wahlscheinstatus={wahlscheinstatus}
                    
                    where id={id} and stimmzettel={stimmzettel}', [
                        'usedate' => $ws['usedate'],
                        'abgabetyp' => $ws['abgabetyp'],
                        'blocknumber' => $ws['blocknumber'],
                        'wahlscheinstatus' => $useStatus,
                        'id' => $ws['id'],
                        'stimmzettel' => $ws['stimmzettel']
                    ]);


                    App::result('success', true);
                }
            } catch (Exception $e) {
                App::logger('papervote save')->error($e->getMessage());

                App::result('msg', $e->getMessage());
            }
            Save::timing('wahlschein finished', __LINE__);
            App::contenttype('application/json');
        }, array('get', 'post'), true, [], self::scope());
    }
}
