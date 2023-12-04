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
            'createRandomList'=>'3c1a32b3abe38f0766fc492abdf90e11',
            'randomString'=>'3c1a32b3abe38f0766fc492abdf90e11',
            'canChangeValue'=>'b2e2b2b2b2b2b2b2b2b2b2b2b2b2b2b2',
            'getBallotpaper'=>'wfwef'
        ];
        self::procedureCheck(
            'ds',
            $def,
            "please run the following command: `./tm install-sql-papervote --client ".$clientdb->dbname."`",
            "please run the following command: `./tm install-sql-papervote --client ".$clientdb->dbname."`"
        );
        
    }
}