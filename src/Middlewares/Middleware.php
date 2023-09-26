<?php

namespace Tualo\Office\PaperVote\Middlewares;
use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\Basic\IMiddleware;

class Middleware implements IMiddleware{
    public static function register(){
        App::use('PaperVote',function(){
            
            try{
                // App::javascript('papervote_bcrypt', './papervotelibrary/bcrypt.js',[],0);
            }catch(\Exception $e){
                App::set('maintanceMode','on');
                App::addError($e->getMessage());
            }
        
        },-100);
    }
}