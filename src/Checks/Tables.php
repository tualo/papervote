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
            'view_readtable_kandidaten_bilder'=>[
                'columns'=>[
                    'id'=>'varchar(36)',
                    // 'file_id'=>'varchar(36)',
                    'kandidat'=>'varchar(12)',
                    'typ'=>'varchar(12)',
                    '__file_name'=>'varchar(255)',
                    'path'=>'varchar(255)',
                    '__file_size'=>'int(11)',
                    'mtime'=>'datetime',
                    'ctime'=>'datetime',
                    '__file_type'=>'varchar(255)',
                    '__file_id'=>'varchar(36)',
                    'hash'=>'varchar(36)',
                    '__file_data'=>'char(0)'
                ]
            ],
            'wahlscheinstatus_online_erlaubt'=>[
                'columns'=>[
                    'wahlscheinstatus'=>'varchar(12)',
                    'abgabetyp'=>'varchar(12)'
                ]
            ],
            'wahlberechtigte'=>[],
            'wahlberechtigte_anlage'=>[],
            'wahlschein'=>[],
            'abgabetyp'=>[],
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
            'reportfiles'=>[],
            'view_blocksystem_status'=>[],
            'view_blocksystem_status_blocks'=>[],
            'view_blocksystem_status_blocks_wahlscheine'=>[],
            'view_double_voter'=>[],
            'view_beteiligung_stimmzettel'=>[],
            'wahlschein_status_import'=>[],
            'view_lose_untergruppen'=>[],
            'kandidaten_stimmenanzahl_losentscheid_stimmzettel'=>[],
            'kandidaten_stimmenanzahl_liste'=>[],
            'ballotbox_decrypted_sum'=>[],
            'wm_auswertungen'=>[],
            
        ];
        self::tableCheck('papervote',$tables,
            "please run the following command: `./tm install-sql-papervote --client ".$clientdb->dbname."`",
            "please run the following command: `./tm install-sql-papervote --client ".$clientdb->dbname."`"

        );
    }
}