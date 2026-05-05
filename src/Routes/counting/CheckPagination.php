<?php

namespace Tualo\Office\PaperVote\Routes\counting;

use Exception;
use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\Basic\Route as BasicRoute;
use Tualo\Office\Basic\IRoute;
use Tualo\Office\TualoPGP\TualoApplicationPGP;

use Ramsey\Uuid\Uuid;

class CheckPagination extends \Tualo\Office\Basic\RouteWrapper
{
    public static function scope(): string
    {
        return 'papervote.counting';
    }

    public static function register()
    {
        BasicRoute::add('/papervote/counting/checkpagination/(?P<stack>[\w\-\_\d]+)/(?P<pagination>[\w\-\_\d]+)', function ($matches) {

            App::contenttype('application/json');
            $db = App::get('session')->getDB();
            App::result('success', false);

            try {
                $stack = $matches['stack'];
                $pagination = $matches['pagination'];
                $data = $db->singleValue('select count(1) c from papervote_optical where stack_id = {stack_id} and pagination_id = {pagination_id}', ['stack_id' => $stack, 'pagination_id' => $pagination], 'c');
                if ($data == 0) {
                    throw new Exception("Der Stimmzettel ist nicht in der optischen Lesung zu finden. (kann entnommmen werden)");
                }
                $data = $db->singleValue('select count(1) c from stimmzettel1 where stapel1 = {stack_id} and id = {pagination_id}', ['stack_id' => $stack, 'pagination_id' => $pagination], 'c');
                if ($data == 0) {
                    throw new Exception("Der Stimmzettel wurde nicht in der ersten Zählung gefunden. (kann entnommmen werden)");
                }
                $data = $db->singleValue('select count(1) c from stimmzettel1 where stapel1 = {stack_id} and id = {pagination_id} and abgebrochen=1', ['stack_id' => $stack, 'pagination_id' => $pagination], 'c');
                if ($data == 1) {
                    throw new Exception("Der Stimmzettel wurde in der ersten Zählung abgebrochen. (kann entnommmen werden)");
                }
                $data = $db->singleValue('select count(1) c from stimmzettel1 where stapel1 <> {stack_id} and id = {pagination_id}', ['stack_id' => $stack, 'pagination_id' => $pagination], 'c');
                if ($data == 1) {
                    throw new Exception("Der Stimmzettel gehört zu einem anderen Stapel. (kann entnommmen werden)");
                }
                App::result('success', true);
            } catch (Exception $e) {
                App::result('success', false);
                App::result('msg', $e->getMessage());
            }
        });
    }
}
