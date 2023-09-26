<?php
namespace Tualo\Office\PaperVote\Routes;

use Exception;
use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\Basic\Route as BasicRoute;
use Tualo\Office\Basic\IRoute;
use Tualo\Office\TualoPGP\TualoApplicationPGP;
use Tualo\Office\PaperVote\Reset as ResetClass;

use Ramsey\Uuid\Uuid;

class Reset implements IRoute{
    public static function register(){
        BasicRoute::add('/papervote/reset/ruecklauf',function($matches){
            App::contenttype('application/json');
            if(isset($_SESSION['tualoapplication']) && isset($_SESSION['tualoapplication']['typ']) && ($_SESSION['tualoapplication']['typ']=='master')){
                try{
                    ResetClass::Ruecklauf();
                    App::result('success', true);

                }catch(\Exception $e){
                    App::result('msg', $e->getMessage());
                }
            }else{
                App::result('msg', 'Keine Berechtigung');
            }
        },['get'],true);

        BasicRoute::add('/papervote/reset/wahlberechtigte',function($matches){
            App::contenttype('application/json');
            if(isset($_SESSION['tualoapplication']) && isset($_SESSION['tualoapplication']['typ']) && ($_SESSION['tualoapplication']['typ']=='master')){
                try{
                    ResetClass::WahlberechtigteCleanDS();
                    ResetClass::WahlberechtigteAnlageCreateDS();    

                    App::result('success', true);
                }catch(\Exception $e){
                    App::result('msg', $e->getMessage());
                }   
            }else{
                App::result('msg', 'Keine Berechtigung');
            } 
        },['get'],true);


        BasicRoute::add('/papervote/reset/tan',function($matches){
            App::contenttype('application/json');
            if(isset($_SESSION['tualoapplication']) && isset($_SESSION['tualoapplication']['typ']) && ($_SESSION['tualoapplication']['typ']=='master')){
                try{
                    ResetClass::Tan();
                    App::result('success', true);

                }catch(\Exception $e){
                    App::result('msg', $e->getMessage());
                }
            }else{
                App::result('msg', 'Keine Berechtigung');
            }
        },['get'],true);


        BasicRoute::add('/papervote/reset/wahlzeichnungsberechtigter',function($matches){
            App::contenttype('application/json');
            if(isset($_SESSION['tualoapplication']) && isset($_SESSION['tualoapplication']['typ']) && ($_SESSION['tualoapplication']['typ']=='master')){
                try{
                    ResetClass::Wahlzeichnungsberechtigter();
                    App::result('success', true);

                }catch(\Exception $e){
                    App::result('msg', $e->getMessage());
                }
            }else{
                App::result('msg', 'Keine Berechtigung');
            }
        },['get'],true);

        
    }
}