<?php

namespace Tualo\Office\PaperVote\Routes;

use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\Basic\Route as BasicRoute;
use Tualo\Office\Basic\IRoute;

class Sounds implements IRoute
{

    public static function register()
    {
        BasicRoute::add('/papervote/sounds/(?P<file>[\w.\/\-]+).mp3',function($matches){
            App::contenttype('application/javascript');
            App::body(file_get_contents( dirname(__DIR__,1).'/sounds/'.$matches['file'].'.mp3' ));
            BasicRoute::$finished=true;
        }, ['get'], true);
    }
}
