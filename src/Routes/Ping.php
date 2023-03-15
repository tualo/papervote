<?php
namespace Tualo\Office\PaperVote\Routes;

use Exception;
use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\Basic\Route as BasicRoute;
use Tualo\Office\Basic\IRoute;
use Tualo\Office\TualoPGP\TualoApplicationPGP;
use Ramsey\Uuid\Uuid;
use Tualo\Office\PaperVote\APIRequestHelper;

class Ping implements IRoute{
 
    public static function register(){
        BasicRoute::add('/papervote/ping',function($matches){
            App::contenttype('application/json');
            App::result('success',true);
        },['get','post'],true);


        
    }
}