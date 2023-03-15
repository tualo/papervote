<?php
namespace Tualo\Office\PaperVote\Routes;

use Exception;
use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\Basic\Route as BasicRoute;
use Tualo\Office\Basic\IRoute;
use Tualo\Office\TualoPGP\TualoApplicationPGP;
use Ramsey\Uuid\Uuid;
use Tualo\Office\PaperVote\APIRequestHelper;
use phpseclib3\Crypt\RSA;



class Ping implements IRoute{
 
    public static function register(){
        BasicRoute::add('/papervote/ping',function($matches){
            App::contenttype('application/json');
            
            try{

               if (
                    isset($_REQUEST['signature']) &&
                    isset($_REQUEST['message'])
                ){
                    $db = App::get('session')->getDB();
                    $pem = $db->singleValue("select property FROM system_settings WHERE system_settings_id = 'remote-erp/public'",[],'property');
                    App::result('success',true);
                    App::result('signature_success',RSA::load($pem)->verify($_REQUEST['message'], $_REQUEST['signature']) );
                }else{
                    App::result('success',true);
                }

            }catch(\Exception $e){

                App::result('last_sql', $db->last_sql);
                App::result('msg', $e->getMessage());
            }
        },['get','post'],true);


        
    }
}