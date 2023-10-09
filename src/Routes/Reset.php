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
                    App::result('msg', "Der Rücklauf ist zurückgesetzt");
                    

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
                    ResetClass::Wahlberechtigte();
                    ResetClass::WahlberechtigteCleanDS();
                    App::result('A', "A");
                    ResetClass::WahlberechtigteAnlageCreateDS();    
                    App::result('B', "B");

                    App::result('success', true);

                    App::result('msg', "Wahlberechtigte sind gelöscht");

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
                    App::result('msg', "Tans sind zurückgesetzt");

                }catch(\Exception $e){
                    App::result('msg', $e->getMessage());
                }
            }else{
                App::result('msg', 'Keine Berechtigung');
            }
        },['get'],true);

        BasicRoute::add('/papervote/reset/zaehldaten',function($matches){
            App::contenttype('application/json');
            if(isset($_SESSION['tualoapplication']) && isset($_SESSION['tualoapplication']['typ']) && ($_SESSION['tualoapplication']['typ']=='master')){
                
                try{
                    ResetClass::Zaehldaten();
                    App::result('success', true);
                    App::result('msg', "Zähldaten sind gelöscht");

                }catch(\Exception $e){
                    App::result('msg', $e->getMessage());
                }
                
            }else{
                App::result('msg', 'Keine Berechtigung');
            }
        },['get'],true);

        BasicRoute::add('/papervote/reset/kandidaten',function($matches){
            App::contenttype('application/json');
            if(isset($_SESSION['tualoapplication']) && isset($_SESSION['tualoapplication']['typ']) && ($_SESSION['tualoapplication']['typ']=='master')){
                try{
                    ResetClass::Kandidaten();
                    App::result('success', true);
                    App::result('msg', "Kandidaten sind gelöscht");

                }catch(\Exception $e){
                    App::result('msg', $e->getMessage());
                }
            }else{
                App::result('msg', 'Keine Berechtigung');
            }
        },['get'],true);

        BasicRoute::add('/papervote/reset/onlinekandidaten',function($matches){
            App::contenttype('application/json');
            if(isset($_SESSION['tualoapplication']) && isset($_SESSION['tualoapplication']['typ']) && ($_SESSION['tualoapplication']['typ']=='master')){
                
                try{
                    ResetClass::Onlinekandidaten();
                    App::result('success', true);
                    App::result('msg', "Onlinekandidaten sind gelöscht");

                }catch(\Exception $e){
                    App::result('msg', $e->getMessage());
                }
                
            }else{
                App::result('msg', 'Keine Berechtigung');
            }
        },['get'],true);


        BasicRoute::add('/papervote/reset/wahlgruppen',function($matches){
            App::contenttype('application/json');
            if(isset($_SESSION['tualoapplication']) && isset($_SESSION['tualoapplication']['typ']) && ($_SESSION['tualoapplication']['typ']=='master')){
                
                try{
                    ResetClass::WahlgruppenWahlbezirke();
                    App::result('success', true);
                    App::result('msg', "Wahlgruppen und Bezirke sind gelöscht");
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
                    App::result('msg', "Die Wahlzeichnungsberechtigten sind gelöscht");

                }catch(\Exception $e){
                    App::result('msg', $e->getMessage());
                }
            }else{
                App::result('msg', 'Keine Berechtigung');
            }
        },['get'],true);

        
    }
}