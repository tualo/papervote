<?php

namespace Tualo\Office\PaperVote\Routes;

use Exception;
use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\Basic\Route as BasicRoute;
use Tualo\Office\VoteManager\Votemanager;
use Tualo\Office\VoteManager\VotemanagerPhase;

use Tualo\Office\PaperVote\Reset as ResetClass;

use Ramsey\Uuid\Uuid;

class Reset extends \Tualo\Office\Basic\RouteWrapper
{
    public static function scope(): string
    {
        return 'papervote.reset';
    }
    public static function register()
    {
        BasicRoute::add('/papervote/reset/ruecklauf', function ($matches) {
            App::contenttype('application/json');
            $session = App::getSession();
            if (
                $session->isMaster()
            ) {
                if (!Votemanager::isAllowed([VotemanagerPhase::Reset])) {
                    http_response_code(403);
                    App::result('msg', 'In der aktuellen Phase ist kein Rücklauf-Reset erlaubt');
                    return;
                }
                try {
                    ResetClass::Ruecklauf();
                    App::result('success', true);
                    App::result('msg', "Der Rücklauf ist zurückgesetzt");
                } catch (\Exception $e) {
                    App::result('msg', $e->getMessage());
                }
            } else {
                http_response_code(403);
                App::result('msg', 'Keine Berechtigung');
            }
        }, ['get'], true, [], self::scope());

        BasicRoute::add('/papervote/reset/wahlberechtigte', function ($matches) {
            App::contenttype('application/json');
            $session = App::getSession();
            if (
                $session->isMaster()
            ) {
                if (!Votemanager::isAllowed([VotemanagerPhase::Reset])) {
                    http_response_code(403);
                    App::result('msg', 'In der aktuellen Phase ist kein Wahlberechtigten-Reset erlaubt');
                    return;
                }
                try {
                    set_time_limit(0);
                    ResetClass::Wahlberechtigte();
                    App::result('A', "A");
                    ResetClass::WahlberechtigteCleanDS();
                    App::result('B', "B");
                    ResetClass::WahlberechtigteAnlageCreateDS();
                    App::result('C', "C");

                    App::result('success', true);

                    App::result('msg', "Wahlberechtigte sind gelöscht");
                } catch (\Exception $e) {
                    App::result('msg', $e->getMessage());
                }
            } else {
                http_response_code(403);
                App::result('msg', 'Keine Berechtigung');
            }
        }, ['get'], true, [], self::scope());


        BasicRoute::add('/papervote/reset/tan', function ($matches) {
            App::contenttype('application/json');
            $session = App::getSession();
            if (
                $session->isMaster()
            ) {
                if (!Votemanager::isAllowed([VotemanagerPhase::Reset])) {
                    http_response_code(403);
                    App::result('msg', 'In der aktuellen Phase ist kein TAN-Reset erlaubt');
                    return;
                }
                try {
                    ResetClass::Tan();
                    App::result('success', true);
                    App::result('msg', "Tans sind zurückgesetzt");
                } catch (\Exception $e) {
                    App::result('msg', $e->getMessage());
                }
            } else {
                http_response_code(403);
                App::result('msg', 'Keine Berechtigung');
            }
        }, ['get'], true, [], self::scope());

        BasicRoute::add('/papervote/reset/zaehldaten', function ($matches) {
            App::contenttype('application/json');
            $session = App::getSession();
            if (
                $session->isMaster()
            ) {
                if (!Votemanager::isAllowed([VotemanagerPhase::Reset])) {
                    http_response_code(403);
                    App::result('msg', 'In der aktuellen Phase ist kein Zähldaten-Reset erlaubt');
                    return;
                }

                try {
                    ResetClass::Zaehldaten();
                    App::result('success', true);
                    App::result('msg', "Zähldaten sind gelöscht");
                } catch (\Exception $e) {
                    App::result('msg', $e->getMessage());
                }
            } else {
                http_response_code(403);
                App::result('msg', 'Keine Berechtigung');
            }
        }, ['get'], true, [], self::scope());

        BasicRoute::add('/papervote/reset/kandidaten', function ($matches) {
            App::contenttype('application/json');
            $session = App::getSession();
            if (
                $session->isMaster()
            ) {
                if (!Votemanager::isAllowed([VotemanagerPhase::Reset])) {
                    http_response_code(403);
                    App::result('msg', 'In der aktuellen Phase ist kein Kandidaten-Reset erlaubt');
                    return;
                }

                try {
                    ResetClass::Kandidaten();
                    App::result('success', true);
                    App::result('msg', "Kandidaten sind gelöscht");
                } catch (\Exception $e) {
                    App::result('msg', $e->getMessage());
                }
            } else {
                http_response_code(403);
                App::result('msg', 'Keine Berechtigung');
            }
        }, ['get'], true, [], self::scope());




        BasicRoute::add('/papervote/reset/onlinestimmzettel', function ($matches) {
            App::contenttype('application/json');
            $session = App::getSession();
            if (
                $session->isMaster()
            ) {
                if (!Votemanager::isAllowed([VotemanagerPhase::Reset])) {
                    http_response_code(403);
                    App::result('msg', 'In der aktuellen Phase ist kein Onlinestimmzettel-Reset erlaubt');
                    return;
                }

                try {
                    ResetClass::Onlinestimmzettel();
                    App::result('success', true);
                    App::result('msg', "Onlinestimmzettel sind gelöscht");
                } catch (\Exception $e) {
                    App::result('msg', $e->getMessage());
                }
            } else {
                App::result('msg', 'Keine Berechtigung');
            }
        }, ['get'], true, [], self::scope());


        BasicRoute::add('/papervote/reset/onlinewahl', function ($matches) {
            App::contenttype('application/json');
            $session = App::getSession();
            if (
                $session->isMaster()
            ) {
                if (!Votemanager::isAllowed([VotemanagerPhase::Reset])) {
                    http_response_code(403);
                    App::result('msg', 'In der aktuellen Phase ist kein Onlinewahl-Reset erlaubt');
                    return;
                }

                try {
                    ResetClass::Onlinewahl();
                    App::result('success', true);
                    App::result('msg', "Onlinewahl-Daten sind gelöscht");
                } catch (\Exception $e) {
                    App::result('msg', $e->getMessage());
                }
            } else {
                App::result('msg', 'Keine Berechtigung');
            }
        }, ['get'], true, [], self::scope());

        BasicRoute::add('/papervote/reset/wahlgruppen', function ($matches) {
            App::contenttype('application/json');
            $session = App::getSession();
            if (
                $session->isMaster()
            ) {
                if (!Votemanager::isAllowed([VotemanagerPhase::Reset])) {
                    http_response_code(403);
                    App::result('msg', 'In der aktuellen Phase ist kein Wahlgruppen-Reset erlaubt');
                    return;
                }

                try {
                    ResetClass::WahlgruppenWahlbezirke();
                    App::result('success', true);
                    App::result('msg', "Wahlgruppen und Bezirke sind gelöscht");
                } catch (\Exception $e) {
                    App::result('msg', $e->getMessage());
                }
            } else {
                http_response_code(403);
                App::result('msg', 'Keine Berechtigung');
            }
        }, ['get'], true, [], self::scope());



        BasicRoute::add('/papervote/reset/wahlzeichnungsberechtigter', function ($matches) {
            App::contenttype('application/json');
            $session = App::getSession();
            if (
                $session->isMaster()
            ) {
                if (!Votemanager::isAllowed([VotemanagerPhase::Reset])) {
                    http_response_code(403);
                    App::result('msg', 'In der aktuellen Phase ist kein Wahlzeichnungsberechtigten-Reset erlaubt');
                    return;
                }
                try {
                    ResetClass::Wahlzeichnungsberechtigter();
                    App::result('success', true);
                    App::result('msg', "Die Wahlzeichnungsberechtigten sind gelöscht");
                } catch (\Exception $e) {
                    App::result('msg', $e->getMessage());
                }
            } else {
                http_response_code(403);
                App::result('msg', 'Keine Berechtigung');
            }
        }, ['get'], true, [], self::scope());
    }
}
