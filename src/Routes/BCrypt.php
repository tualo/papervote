<?php

namespace Tualo\Office\PaperVote\Route;

use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\Basic\Route as BasicRoute;
use Tualo\Office\Basic\IRoute;


class BCrypt extends \Tualo\Office\Basic\RouteWrapper
{
    public static function register()
    {
        BasicRoute::add('/papervotelibrary/bcrypt.js' . '', function ($matches) {
            if (file_exists(dirname(__DIR__, 1) . '/js/bcrypt/bcrypt.min.js')) {
                App::etagFile(dirname(__DIR__, 1) . '/js/bcrypt/bcrypt.min.js', true);
                BasicRoute::$finished = true;
                http_response_code(200);
            }
        }, ['get'], false);
    }
}
