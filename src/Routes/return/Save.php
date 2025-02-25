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

class Save implements IRoute
{

    public static function register()
    {
        BasicRoute::add('/papervote/return/save', function () {
            $db = App::get('session')->getDB();
            try {
                $input = json_decode(file_get_contents('php://input'),true);
                if (is_null( $input )) throw new Exception("Error Processing Request", 1);
                $status = json_decode($input['status'], true);
                $liste = json_decode($input['liste'], true);
                $USE_TUALO = 0;
                $USE_TUALO_URL = 0;

                $usedate = isset($input['use_date'])?$input['use_date']:(new DateTime())->format('Y-m-d');

                if (is_null( $status )) throw new Exception("Error Processing Request", 1);
                if (is_null( $liste )) throw new Exception("Error Processing Request", 1);

                
                $blocknumber = isset($input['blocknumber'])?$input['blocknumber']:'0';

                if(App::configuration('papervote','force_blocknumber','0')=='1'){
                    if ($blocknumber=='0') throw new Exception("Eine Bocknummer wird erwartet.");
                }

                $db->direct("insert into wahlschein_blocknumbers (blocknumber  ,login,lastlogin , createtime ,lastinsert) values ({blocknumber},getSessionUser(),getSessionUser(),now(),now() ) on duplicate key update lastlogin=values(lastlogin),lastinsert=values(lastinsert) ",['blocknumber'=>$blocknumber]);

                foreach ($liste as $wert) {

                    $wahlschein = DSTable::instance('wahlschein');
                    $ws_read = $wahlschein->f('ridx','eq',$wert)->read();
                    if ($ws_read->empty()) throw new Exception("Der Wahlschein *".$wert."* wurde nicht gefunden");
                    $ws = $ws_read->getSingle();
                    // try load WS
                    $loadWS = Query::get('wahlscheinnummer',$ws['wahlscheinnummer']);
                    if (count($loadWS)==0) throw new Exception("Der Wahlschein *".$wert."* wurde nicht gefunden");

                    // $set_state = '1|0';
                    foreach ($status as $val) {
                        if (($ws[''.$val['feld']] == '6|0')) throw new Exception("Der Status darf nicht überschrieben werden.");

                        if ( in_array($ws[''.$val['feld']],['1|0','-1|0']) ) { 
                            // nimmt nicht teil kann nicht überschrieben werden!
                            $ws[''.$val['feld']] = $val['status'];
                            $ws[''.$val['feld'].'_grund'] = isset($val['grund']) ? $val['grund'] : '';
                            // $set_state = $ws[''.$val['feld']];
                        }else{
                            throw new Exception("Der Wahlschein befindet sich in einem ungültigen Zustand.");
                        }
                    }
                    if ($USE_TUALO){
                        $keyData = $db->singleRow("select  publickey from wm_pgp_pubkey where id=0 ",[]);
                        $o =  WMTualoRequestHelper::query( str_replace('#identnummer',$ws['id'],$USE_TUALO_URL) ,[
                            'message' =>TualoApplicationPGP::encrypt($keyData['publickey'],'OK MESSAGE')
                        ]) ;
                    }

                    $ws[''.'usedate'] = $usedate; // Datum übernehmen
                    $ws[''.'abgabetyp'] = '1|0'; // Briefwahltyp setzen
                    $ws[''.'blocknumber'] = $blocknumber; // blocknumber

                    $wahlschein->update($ws);
                    if ($wahlschein->error()){
                        App::result('msg', $wahlschein->errorMessage());
                    }else{
                        App::result('success', true);
                    }

                }

            } catch (Exception $e) {
                App::result('msg', $e->getMessage());
            }
            App::contenttype('application/json');
        }, array('get', 'post'), true);
    }
}
