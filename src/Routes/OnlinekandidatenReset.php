<?php

namespace Tualo\Office\PaperVote\Routes;

use Exception;
use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\Basic\Route as BasicRoute;
use Tualo\Office\VoteManager\Votemanager;
use Tualo\Office\VoteManager\VotemanagerPhase;

use Tualo\Office\PaperVote\Reset as ResetClass;

use Ramsey\Uuid\Uuid;

class OnlinekandidatenReset extends \Tualo\Office\Basic\RouteWrapper
{
    public static function scope(): string
    {
        return 'papervote.sync';
    }
    public static function register()
    {

        BasicRoute::add('/papervote/reset/onlinekandidaten', function ($matches) {
            App::contenttype('application/json');
            $session = App::getSession();
            /*
            if (
                $session->isMaster()
            ) {
                if (!Votemanager::isAllowed([VotemanagerPhase::Reset])) {
                    http_response_code(403);
                    App::result('msg', 'In der aktuellen Phase ist kein Onlinekandidaten-Reset erlaubt');
                    return;
                }
                */

            try {
                ResetClass::Onlinekandidaten();
                ResetClass::Onlinestimmzettel();
                App::result('success', true);
                App::result('msg', "Onlinekandidaten sind gelöscht");
            } catch (\Exception $e) {
                App::result('msg', $e->getMessage());
            }
            /*} else {
                http_response_code(403);
                App::result('msg', 'Keine Berechtigung');
            }
            */
        }, ['get'], true, [], self::scope());
    }
}
