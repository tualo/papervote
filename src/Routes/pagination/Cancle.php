<?php

namespace Tualo\Office\PaperVote\Routes\pagination;

use Exception;
use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\Basic\Route as BasicRoute;
use Tualo\Office\Basic\IRoute;
use Tualo\Office\TualoPGP\TualoApplicationPGP;
use phpseclib\Net\SFTP;
use \PhpOffice\PhpSpreadsheet\Spreadsheet;
use \PhpOffice\PhpSpreadsheet\IOFactory;

use Ramsey\Uuid\Uuid;

class Cancle extends \Tualo\Office\Basic\RouteWrapper
{
    public static function scope(): string
    {
        return 'papervote.stacks';
    }
    public static function register()
    {
        BasicRoute::add('/papervote/pagination/cancle/(?P<id>[\w.\/\-]+)', function ($matches) {
            $db = App::get('session')->getDB();
            try {

                $sql = "select 
                    stimmzettel1.*,
                    stapel1.kisten1
                    from 
                    stimmzettel1 
                    join stapel1 on stimmzettel1.stapel1=stapel1.id

                    left join stimmzettel2 on stimmzettel1.id=stimmzettel2.id 
                where 
                    stimmzettel2.id is null 
                    and stimmzettel1.abgebrochen=0
                    and stimmzettel1.id={id}";
                $item = $db->singleRow($sql, [
                    'id' => $matches['id']
                ]);

                if (!$item) {
                    throw new Exception('Stimmzettel nicht gefunden');
                }

                $sql = "update stimmzettel1 set abgebrochen =1 where id={id}";
                $db->direct($sql, $matches);
                $sql = "update stimmzettel2 set abgebrochen =1 where id={id}";
                $db->direct($sql, $matches);


                App::result('success', true);
            } catch (Exception $e) {
                App::result('msg', $e->getMessage());
            }
            App::contenttype('application/json');
        }, array('get', 'post'), true, [], self::scope());
    }
}
