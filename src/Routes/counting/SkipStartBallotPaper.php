<?php

namespace Tualo\Office\PaperVote\Routes\counting;

use Exception;
use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\Basic\Route as BasicRoute;
use Tualo\Office\Basic\IRoute;
use Tualo\Office\TualoPGP\TualoApplicationPGP;

use Ramsey\Uuid\Uuid;

class SkipStartBallotPaper extends \Tualo\Office\Basic\RouteWrapper
{
    public static function scope(): string
    {
        return 'papervote.counting';
    }

    public static function register()
    {
        BasicRoute::add('/papervote/skipStartBallotpaper', function ($matches) {
            $db = App::get('session')->getDB();

            try {
                App::result('success', false);
                /*
                $v = $db->singleValue('select getSetup({cmp},{id}) v ', array('cmp' => 'cmp_wm_erstzaehlung1', 'id' => 'SKIPSTARTBALLOTPAPER'), 'v');
                App::result('success',  $v == '1');
                */
            } catch (Exception $e) {
                App::result('msg', $e->getMessage());
            }
            App::contenttype('application/json');
        }, ['get'], true);
    }
}
