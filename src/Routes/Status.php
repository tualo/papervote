<?php

namespace Tualo\Office\PaperVote\Routes;

use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\Basic\Route as BasicRoute;
use Tualo\Office\Basic\IRoute;
use Tualo\Office\PaperVote\APIRequestHelper;

class Status implements IRoute
{

    public static function register()
    {
        BasicRoute::add('/papervote/status',function($matches){
            App::contenttype('application/json');
            App::result('basistyp',App::configuration('papervote','basistyp','stimmzettel'));
            App::result('force_blocknumber',App::configuration('papervote','force_blocknumber','0'));
            
            // /onlinevote/state
            $db = App::get('session')->getDB();
            $o = $db->directMap("
                select if(property<>'',1,0) v,'api' text FROM system_settings WHERE system_settings_id = 'remote-erp/url' 
                union all
                select property v,'api_url' text FROM system_settings WHERE system_settings_id = 'remote-erp/url'
                union all
                select property v,'api_token' text FROM system_settings WHERE system_settings_id = 'remote-erp/token'
                union all
                select property v,'api_private' text FROM system_settings WHERE system_settings_id = 'erp/privatekey'
            ",[],'text','v');
            
            if (isset($o['api_url'])){
                $ping_result = APIRequestHelper::query( $o['api_url'].'/~/'.$o['api_token'].'/onlinevote/state',[] );
                if($ping_result===false){
                    $ping_result = [
                        'remoteError'=>true,
                    ];
                }else{
                    App::result('owstate',$ping_result);
                }
            }else{
                App::result('owstate',[
                    'remoteError'=>true,
                ]);
            }
            
            App::result('success',true);
        }, ['get'], true);
    }
}
