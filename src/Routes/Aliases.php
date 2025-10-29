<?php

namespace Tualo\Office\PaperVote\Routes;

use Tualo\Office\Basic\Route;
use Tualo\Office\Basic\IRoute;


class Aliases extends \Tualo\Office\Basic\RouteWrapper
{
    public static function register()
    {
        Route::alias('/papervote/(?P<tablename>\w+)/create', '/ds/(?P<tablename>\w+)/create');
        Route::alias('/papervote/(?P<tablename>\w+)/update', '/ds/(?P<tablename>\w+)/update');
        Route::alias('/papervote/(?P<tablename>\w+)/read', '/ds/(?P<tablename>\w+)/read');
    }
}
