<?php

namespace Tualo\Office\PaperVote\Routes;

use Exception;
use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\Basic\Route as BasicRoute;
use Tualo\Office\Basic\IRoute;
use Tualo\Office\TualoPGP\TualoApplicationPGP;
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
            $session = App::get('session');
            if (
                $session->isMaster()
            ) {
                try {
                    ResetClass::Ruecklauf();
                    App::result('success', true);
                    App::result('msg', "Der Rücklauf ist zurückgesetzt");
                } catch (\Exception $e) {
                    App::result('msg', $e->getMessage());
                }
            } else {
                App::result('msg', 'Keine Berechtigung');
            }
        }, ['get'], true, [], self::scope());

        BasicRoute::add('/papervote/reset/wahlberechtigte', function ($matches) {
            App::contenttype('application/json');
            $session = App::get('session');
            if (
                $session->isMaster()
            ) {
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
                App::result('msg', 'Keine Berechtigung');
            }
        }, ['get'], true, [], self::scope());


        BasicRoute::add('/papervote/reset/tan', function ($matches) {
            App::contenttype('application/json');
            $session = App::get('session');
            if (
                $session->isMaster()
            ) {
                try {
                    ResetClass::Tan();
                    App::result('success', true);
                    App::result('msg', "Tans sind zurückgesetzt");
                } catch (\Exception $e) {
                    App::result('msg', $e->getMessage());
                }
            } else {
                App::result('msg', 'Keine Berechtigung');
            }
        }, ['get'], true, [], self::scope());

        BasicRoute::add('/papervote/reset/zaehldaten', function ($matches) {
            App::contenttype('application/json');
            $session = App::get('session');
            if (
                $session->isMaster()
            ) {

                try {
                    ResetClass::Zaehldaten();
                    App::result('success', true);
                    App::result('msg', "Zähldaten sind gelöscht");
                } catch (\Exception $e) {
                    App::result('msg', $e->getMessage());
                }
            } else {
                App::result('msg', 'Keine Berechtigung');
            }
        }, ['get'], true, [], self::scope());

        BasicRoute::add('/papervote/reset/kandidaten', function ($matches) {
            App::contenttype('application/json');
            $session = App::get('session');
            if (
                $session->isMaster()
            ) {
                try {
                    ResetClass::Kandidaten();
                    App::result('success', true);
                    App::result('msg', "Kandidaten sind gelöscht");
                } catch (\Exception $e) {
                    App::result('msg', $e->getMessage());
                }
            } else {
                App::result('msg', 'Keine Berechtigung');
            }
        }, ['get'], true, [], self::scope());

        BasicRoute::add('/papervote/reset/onlinekandidaten', function ($matches) {
            App::contenttype('application/json');
            $session = App::get('session');
            if (
                $session->isMaster()
            ) {

                try {
                    ResetClass::Onlinekandidaten();
                    ResetClass::Onlinestimmzettel();
                    App::result('success', true);
                    App::result('msg', "Onlinekandidaten sind gelöscht");
                } catch (\Exception $e) {
                    App::result('msg', $e->getMessage());
                }
            } else {
                App::result('msg', 'Keine Berechtigung');
            }
        }, ['get'], true, [], self::scope());



        BasicRoute::add('/papervote/reset/onlinestimmzettel', function ($matches) {
            App::contenttype('application/json');
            $session = App::get('session');
            if (
                $session->isMaster()
            ) {

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


        BasicRoute::add('/papervote/reset/wahlgruppen', function ($matches) {
            App::contenttype('application/json');
            $session = App::get('session');
            if (
                $session->isMaster()
            ) {

                try {
                    ResetClass::WahlgruppenWahlbezirke();
                    App::result('success', true);
                    App::result('msg', "Wahlgruppen und Bezirke sind gelöscht");
                } catch (\Exception $e) {
                    App::result('msg', $e->getMessage());
                }
            } else {
                App::result('msg', 'Keine Berechtigung');
            }
        }, ['get'], true, [], self::scope());



        BasicRoute::add('/papervote/reset/wahlzeichnungsberechtigter', function ($matches) {
            App::contenttype('application/json');
            $session = App::get('session');
            if (
                $session->isMaster()
            ) {
                try {
                    ResetClass::Wahlzeichnungsberechtigter();
                    App::result('success', true);
                    App::result('msg', "Die Wahlzeichnungsberechtigten sind gelöscht");
                } catch (\Exception $e) {
                    App::result('msg', $e->getMessage());
                }
            } else {
                App::result('msg', 'Keine Berechtigung');
            }
        }, ['get'], true, [], self::scope());
    }
}
