<?php

namespace Tualo\Office\PaperVote\Routes;

use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\Basic\Route as BasicRoute;
use Tualo\Office\Basic\IRoute;

class Status implements IRoute
{

    public static function register()
    {
        BasicRoute::add('/papervote/status',function($matches){
            App::contenttype('application/json');
            App::result('basistyp',App::configuration('papervote','basistyp','stimmzettel'));
            App::result('success',true);
        }, ['get'], true);
    }
}
