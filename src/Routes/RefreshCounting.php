<?php

namespace Tualo\Office\PaperVote\Routes;

use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\Basic\Route as BasicRoute;
use Tualo\Office\Basic\IRoute;
use Tualo\Office\PaperVote\APIRequestHelper;

class RefreshCounting extends \Tualo\Office\Basic\RouteWrapper
{

    public static function scope(): string
    {
        return 'papervote.counting.refresh';
    }
    public static function register()
    {
        BasicRoute::add('/papervote/refreshCounting', function ($matches) {
            App::contenttype('application/json');
            try {
                \Tualo\Office\PaperVote\RefreshCounting::run();
                App::result('success', true);
            } catch (\Exception $e) {
                //App::result('last_sql', $db->last_sql);
                App::result('msg', $e->getMessage());
            }
        }, ['get'], true, [], self::scope());
    }
}
