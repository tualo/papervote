<?php
namespace Tualo\Office\PaperVote\Routes;

use Exception;
use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\Basic\Route as BasicRoute;
use Tualo\Office\Basic\IRoute;
use Tualo\Office\TualoPGP\TualoApplicationPGP;
use Ramsey\Uuid\Uuid;
use Tualo\Office\PaperVote\APIRequestHelper;

class SetupHandshake implements IRoute{
 
    public static function register(){

        BasicRoute::add('/papervote/setuphandshake',function($matches){
            try{
                $db = App::get('session')->getDB();
                App::contenttype('application/json');
                
                
                if (!isset($_REQUEST['publickey'])) throw new \Exception("missing parameter");
                if (!isset($_REQUEST['uri'])) throw new \Exception("missing parameter");
                if (!isset($_REQUEST['token'])) throw new \Exception("missing parameter");
                if (!isset($_REQUEST['message'])) throw new \Exception("missing parameter");

                $token = $_REQUEST['token'];


                $keys = TualoApplicationPGP::keyGen(2048);
                $db->direct("insert into system_settings (system_settings_id,property) values ({system_settings_id},{property}) on duplicate key update property=values(property)",[
                    'system_settings_id'    => 'erp/privatekey',
                    'property'              => $keys['private']
                ]);

                $db->direct("insert into system_settings (system_settings_id,property) values ({system_settings_id},{property}) on duplicate key update property=values(property)",[
                    'system_settings_id'    => 'remote-erp/public',
                    'property'              => $_REQUEST['publickey']
                ]);

                $publickey = $keys['public'];
                $privatekey = $keys['private'];

                if ($ping_result = APIRequestHelper::query( $_REQUEST['uri'].'/~/'.$_REQUEST['token'].'/onlinevote/ping',[

                ] )){
                    if (
                        ($ping_result==false)||
                        (!isset($ping_result['success']))||
                        ($ping_result['success']!==true)
                    ){
                        throw new \Exception("Das Onlinewahlsystem kann nicht angepingt werden.");
                    }else{


                        $mesage_to_send = [
                            'publickey' => $publickey,
                            'token'     => $token,
                            'message_public'   => TualoApplicationPGP::enarmor(TualoApplicationPGP::encrypt($_REQUEST['publickey'],$token)),
                            'message_private'   => TualoApplicationPGP::enarmor(TualoApplicationPGP::encrypt($privatekey,$token))
                        ];
                        App::result('data',  $mesage_to_send );
                        App::result('success', true );
                    }
                }
                
                
            }catch(\Exception $e){

                App::result('last_sql', $db->last_sql);
                App::result('msg', $e->getMessage());
            }
        },['post','get'],true);


        
    }
}