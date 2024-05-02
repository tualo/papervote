<?php

namespace Tualo\Office\PaperVote\Routes\optical;

use Exception;
use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\Basic\Route as BasicRoute;
use Tualo\Office\Basic\IRoute;
use Tualo\Office\TualoPGP\TualoApplicationPGP;

use Ramsey\Uuid\Uuid;

class Image implements IRoute
{



    public static function register()
    {
        BasicRoute::add('/papervote/opticalimagesvg/(?P<id>[\/.\w\d\-\_\.]+)', function ($matches) {

            $db = App::get('session')->getDB();
            $imagedata = $db->singleValue('select replace(data," ","+") data from papervote_optical_data where pagination_id={id}', ['id' => $matches['id']], 'data');
            if ($imagedata === false) {
                http_response_code(404);
                BasicRoute::$finished = true;
                exit();
            }
            list($mime, $data) =  explode(',', $imagedata);
            $size = (getimagesizefromstring(base64_decode($data)));

            App::contenttype('image/svg+xml');
            $svg = '<?xml version="1.0" encoding="UTF-8"?>
<svg version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 '.$size[0].' '.$size[1].'" preserveAspectRatio="xMinYMin meet">

<!-- set your background image -->
<image width="'.$size[0].'" height="'.$size[1].'" xlink:href="http://localhost/server/papervote/opticalimage/'.$matches['id'].'" />

<g>
    <rect x="0" y="0" width="'.$size[0].'" height="'.$size[1].'" fill="none" stroke="black" stroke-width="1"/>
</g>

<!-- create the regions -->
<g class="hover_group" opacity="0.5">
    <a xlink:href="https://example.com/link1.html">
    <text x="652" y="706.9" font-size="20">First zone</text>
    <rect x="572" y="324.1" opacity="0.5" fill="#FF0000" width="264.6" height="387.8"></rect>
    </a>
</g>
<g class="hover_group" opacity="0.5">
    <a xlink:href="https://example.com/link2.html">
    <text x="1230.7" y="952" font-size="20">Second zone</text>
    <rect x="1081.7" y="507" opacity="0.5" fill="#FFFFFF" width="390.2" height="450"></rect>
    </a>
</g>
</svg>
            ';
            App::body($svg);
            BasicRoute::$finished = true;
            http_response_code(200);
        }, ['get'], true);

        BasicRoute::add('/papervote/opticalimage/(?P<id>[\/.\w\d\-\_\.]+)', function ($matches) {

            App::contenttype('application/json');

            $db = App::get('session')->getDB();
            $imagedata = $db->singleValue('select replace(data," ","+") data from papervote_optical_data where pagination_id={id}', ['id' => $matches['id']], 'data');
            if ($imagedata === false) {
                http_response_code(404);
                BasicRoute::$finished = true;
                exit();
            }
            
            BasicRoute::$finished = true;
            http_response_code(200);

            list($mime, $data) =  explode(',', $imagedata);
            $etag = md5($data);
            App::contenttype(str_replace('data:', '', $mime));

            header("Etag: $etag");
            header('Cache-Control: public');

            if (
                (isset($_SERVER['HTTP_IF_NONE_MATCH']) && (trim($_SERVER['HTTP_IF_NONE_MATCH']) == $etag))
            ) {
                header("HTTP/1.1 304 Not Modified");
                exit;
            }

            App::body(base64_decode($data));
            BasicRoute::$finished = true;
            http_response_code(200);
        },['get'],true);
    }
}
