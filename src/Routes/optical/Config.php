<?php

namespace Tualo\Office\PaperVote\Routes\optical;

use Exception;
use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\Basic\Route as BasicRoute;
use Tualo\Office\Basic\IRoute;
use Tualo\Office\TualoPGP\TualoApplicationPGP;

use Ramsey\Uuid\Uuid;

class Config implements IRoute
{



    public static function register()
    {
        BasicRoute::add('/papervote/opticaldata/config', function ($matches) {

            App::contenttype('application/json');
            
            $data = file_get_contents('sample.json');
            echo $data;
            BasicRoute::$finished = true;
            http_response_code(200);
            exit();
        }, ['get'], true);
    }
}
