<?php

namespace Tualo\Office\PaperVote\Routes;

use Exception;
use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\Basic\Route as BasicRoute;
use Tualo\Office\Basic\IRoute;
use Tualo\Office\TualoPGP\TualoApplicationPGP;
use Ramsey\Uuid\Uuid;
use Tualo\Office\PaperVote\APIRequestHelper;

class SetupHandshake extends \Tualo\Office\Basic\RouteWrapper
{

    public static function register()
    {

        BasicRoute::add(
            '/papervote/setuphandshake',
            function ($matches) {
                try {
                    $session = App::get('session');
                    $db = $session->getDB();
                    App::contenttype('application/json');


                    if (!isset($_REQUEST['publickey'])) throw new \Exception("missing parameter");
                    if (!isset($_REQUEST['uri'])) throw new \Exception("missing parameter");
                    if (!isset($_REQUEST['token'])) throw new \Exception("missing parameter");
                    if (!isset($_REQUEST['message'])) throw new \Exception("missing parameter");


                    $ping_result = false;
                    if ($_REQUEST['domain'] == 'localhost') {


                        $keys = TualoApplicationPGP::keyGen(2048);
                        $db->direct("insert into system_settings (system_settings_id,property) values ({system_settings_id},{property}) on duplicate key update property=values(property)", [
                            'system_settings_id'    => 'erp/privatekey',
                            'property'              => $keys['private']
                        ]);

                        $db->direct("insert into system_settings (system_settings_id,property) values ({system_settings_id},{property}) on duplicate key update property=values(property)", [
                            'system_settings_id'    => 'remote-erp/public',
                            'property'              => $_REQUEST['publickey']
                        ]);

                        $db->direct("insert into system_settings (system_settings_id,property) values ({system_settings_id},{property}) on duplicate key update property=values(property)", [
                            'system_settings_id'    => 'remote-erp/url',
                            'property'              => $_REQUEST['uri']
                        ]);

                        $db->direct("insert into system_settings (system_settings_id,property) values ({system_settings_id},{property}) on duplicate key update property=values(property)", [
                            'system_settings_id'    => 'remote-erp/token',
                            'property'              => $_REQUEST['token']
                        ]);

                        $token = $session->registerOAuth(
                            // $params     =   [], removed because it is not used
                            $force      =   true,
                            $anyclient  =   false,
                            $path       =   '/papervote/*'
                        );
                        $session->oauthValidDays($token, 365);

                        App::result('publickey', $keys['public']);
                        App::result('token', $token);
                        App::result('message_public', TualoApplicationPGP::enarmor(TualoApplicationPGP::encrypt($_REQUEST['publickey'], $token)));
                        App::result('success', true);
                    } else if (
                        $ping_result = APIRequestHelper::query($_REQUEST['uri'] . '/~/' . $_REQUEST['token'] . '/onlinevote/ping', [])
                    ) {
                        if (
                            ($ping_result == false) ||
                            (!isset($ping_result['success'])) ||
                            ($ping_result['success'] !== true)
                        ) {
                            throw new \Exception("Das Onlinewahlsystem kann nicht angepingt werden.");
                        } else {


                            $keys = TualoApplicationPGP::keyGen(2048);
                            $db->direct("insert into system_settings (system_settings_id,property) values ({system_settings_id},{property}) on duplicate key update property=values(property)", [
                                'system_settings_id'    => 'erp/privatekey',
                                'property'              => $keys['private']
                            ]);

                            $db->direct("insert into system_settings (system_settings_id,property) values ({system_settings_id},{property}) on duplicate key update property=values(property)", [
                                'system_settings_id'    => 'remote-erp/public',
                                'property'              => $_REQUEST['publickey']
                            ]);

                            $db->direct("insert into system_settings (system_settings_id,property) values ({system_settings_id},{property}) on duplicate key update property=values(property)", [
                                'system_settings_id'    => 'remote-erp/url',
                                'property'              => $_REQUEST['uri']
                            ]);

                            $db->direct("insert into system_settings (system_settings_id,property) values ({system_settings_id},{property}) on duplicate key update property=values(property)", [
                                'system_settings_id'    => 'remote-erp/token',
                                'property'              => $_REQUEST['token']
                            ]);

                            $token = $session->registerOAuth(
                                $force      =   true,
                                $anyclient  =   false,
                                $path       =   '/papervote/*'
                            );
                            $session->oauthValidDays($token, 365);

                            App::result('publickey', $keys['public']);
                            App::result('token', $token);
                            App::result('message_public', TualoApplicationPGP::enarmor(TualoApplicationPGP::encrypt($_REQUEST['publickey'], $token)));
                            App::result('success', true);
                        }
                    } else {
                        throw new \Exception("Das Onlinewahlsystem kann nicht angepingt werden. (2) ");
                    }
                } catch (\Exception $e) {

                    App::result('last_sql', $db->last_sql);
                    App::result('msg', $e->getMessage());
                }
            },
            ['post', 'get'],
            true,
            [
                'errorOnUnexpected' => false,
                'errorOnInvalid' => false,
                'fields' => [

                    'token' => [
                        'required' => true,
                        'type' => 'string',
                        'min' => 0,
                        'max' => 1000000
                    ],
                    'publickey' => [
                        'required' => true,
                        'type' => 'string',
                        'min' => 0,
                        'max' => 1000000
                    ],
                    'uri' => [
                        'required' => true,
                        'type' => 'string',
                        'min' => 0,
                        'max' => 1000000
                    ],
                    'message' => [
                        'required' => true,
                        'type' => 'string',
                        'min' => 0,
                        'max' => 1000000
                    ],
                    'domain' => [
                        'required' => true,
                        'type' => 'string',
                        'min' => 0,
                        'max' => 1000000
                    ],

                ]

            ]
        );
    }
}
