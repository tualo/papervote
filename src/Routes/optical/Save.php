<?php

namespace Tualo\Office\PaperVote\Routes\optical;

use Exception;
use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\Basic\Route as BasicRoute;
use Tualo\Office\Basic\IRoute;
use Tualo\Office\TualoPGP\TualoApplicationPGP;

use Ramsey\Uuid\Uuid;

class Save implements IRoute
{



    public static function register()
    {
        BasicRoute::add('/papervote/opticaldata', function ($matches) {

            App::contenttype('application/json');
            $db = App::get('session')->getDB();
            App::result('success', false);

            $db->autoCommit(false);
            try {
                if (!isset($_POST['boxbarcode'])) {
                    throw new Exception('boxbarcode is missing');
                }
                if (!isset($_POST['stackbarcode'])) {
                    throw new Exception('stackbarcode is missing');
                }
                if (!isset($_POST['barcode'])) {
                    throw new Exception('barcode is missing');
                }
                if (!isset($_POST['id'])) {
                    throw new Exception('id is missing');
                }
                if (!isset($_POST['marks'])) {
                    throw new Exception('marks is missing');
                }
                /*
                if (!isset($_POST['image'])) {
                    throw new Exception('image is missing');
                }*/
                $sql = 'insert into papervote_optical (pagination_id, box_id, stack_id, ballotpaper_id, marks) values ({barcode}, {boxbarcode}, {stackbarcode}, {id}, {marks})';
                $db->direct($sql, [
                    'barcode' => $_POST['barcode'],
                    'boxbarcode' => $_POST['boxbarcode'],
                    'stackbarcode' => $_POST['stackbarcode'],
                    'id' => $_POST['id'],
                    'marks' => $_POST['marks']
                ]);
                App::result('success', true);
            } catch (Exception $e) {
                $db->rollback();
                
                App::result('msg', $e->getMessage());
            }
            App::result('msg',$db->last_sql);
        }, ['post'], true);
    }
}
