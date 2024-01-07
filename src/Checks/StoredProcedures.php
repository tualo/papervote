<?php

namespace Tualo\Office\Papervote\Checks;

use Tualo\Office\Basic\Middleware\Session;
use Tualo\Office\Basic\PostCheck;
use Tualo\Office\Basic\TualoApplication as App;


class StoredProcedures extends PostCheck {

    
    public static function test(array $config){
        $clientdb = App::get('clientDB');
        if (is_null($clientdb)) return;
        $def = [
            'createRandomList'=>'cbad8a5173ea90b446e3061b788dd5f8',
            'randomString'=>'c327855664249e78a33f0370a38e4981',
            'canChangeValue'=>'26dd4e31c0ca9e056cddb7f27102fb85',
            'getBallotpaper'=>'2637d349dcbaa0307cdb28f7cb8e0652',
            'fix_testdaten_flag'=>'08e596c9b49dc1f9ff03d29c4ec28089'
        ];
        self::procedureCheck(
            'ds',
            $def,
            "please run the following command: `./tm install-sql-papervote --client ".$clientdb->dbname."`",
            "please run the following command: `./tm install-sql-papervote --client ".$clientdb->dbname."`"
        );
        
    }
}