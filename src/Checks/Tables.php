<?php
namespace Tualo\Office\Papervote\Checks;

use Tualo\Office\Basic\Middleware\Session;
use Tualo\Office\Basic\PostCheck;
use Tualo\Office\Basic\TualoApplication as App;


class Tables  extends PostCheck {
    
    public static function test(array $config){
        $clientdb = App::get('clientDB');
        if (is_null($clientdb)) return;
        $tables = [
            'ds'=>[
                'columns'=>[
                    'table_name'=>'varchar(128)'
                ]
            ],
            'wahlberechtigte'=>[],
            'wahlberechtigte_anlage'=>[],
            'wahlschein'=>[],
            'abgabetyp'=>[],
            'wahlscheinstatus_online_erlaubt'=>[],
            'blocked_voters'=>[],
            'wm_tanboegen'=>[],
            'briefwahlkandidaten'=>[],
            'kisten1'=>[],
            'kisten2'=>[],
            'stimmzettel'=>[],
            'stimmzettel1'=>[],
            'stimmzettel2'=>[],
            'stapel1'=>[],
            'stapel2'=>[],
            'kandidaten_bilder'=>[],
            'kandidaten_stimmenanzahl'=>[],
            'kandidaten'=>[],
            'ohne_wahlberechtigten' => [],
            'onlinekandidaten' => [],
            'onlinestimmzettel' => [],
            'ruecklauffelder' => [],
            'stimmzettel_stimmzettel_fusstexte' => [],
            'stimmzettel_fusstexte' => [],
            'stimmzettelgruppen' => [],
        ];
        self::tableCheck('ds',$tables,
            "please run the following command: `./tm install-sql-papervote --client ".$clientdb->dbname."`",
            "please run the following command: `./tm install-sql-papervote --client ".$clientdb->dbname."`"

        );
    }
}