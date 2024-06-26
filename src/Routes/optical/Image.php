<?php

namespace Tualo\Office\PaperVote\Routes\optical;

use Exception;
use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\Basic\Route as BasicRoute;
use Tualo\Office\Basic\IRoute;
use Tualo\Office\TualoPGP\TualoApplicationPGP;
use Tualo\Office\DS\DataRenderer;
use Ramsey\Uuid\Uuid;

class Image implements IRoute
{



    public static function register()
    {
        BasicRoute::add('/papervote/opticalimagesvg/(?P<id>[\/.\w\d\-\_\.]+)', function ($matches) {
            try{
            $db = App::get('session')->getDB();
            $imagedata = $db->singleValue('select replace(data," ","+") data from papervote_optical_data where pagination_id={id}', ['id' => $matches['id']], 'data');
            if ($imagedata === false) {
                http_response_code(404);
                BasicRoute::$finished = true;
                exit();
            }
            list($mime, $data) =  explode(',', $imagedata);
            $size = (getimagesizefromstring(base64_decode($data)));

            $ballotpaper_id = $db->singleValue('select ballotpaper_id from papervote_optical where pagination_id={id}', ['id' => $matches['id']], 'ballotpaper_id');
// alter table kandidaten add bp_column integer default 0;
// alter table sz_rois add item_height integer default 20;
// alter table sz_rois add item_cap_y decimal(15,5) default 0.5;

            $result = $db->direct('select * from view_papervote_optical_result where pagination_id={id}', ['id' => $matches['id']]);

            $sql ='select 
                RANK() OVER (
                    PARTITION BY stimmzettel.id
                    ORDER BY sz_rois.x
                ) bp_column,
                sz_rois.id roi_id,
                sz_rois.name roi_name,
                sz_rois.x   roi_x,
                sz_rois.y   roi_y,
                sz_rois.width roi_width,
                sz_rois.height roi_height,
                sz_rois.item_height roi_item_height,
                sz_rois.item_cap_y roi_item_cap_y,
                sz_page_sizes.width page_width,
                sz_page_sizes.height page_height
            from 
                stimmzettel 
                join stimmzettel_roi on stimmzettel_roi.stimmzettel_id = stimmzettel.id
                join sz_rois on stimmzettel_roi.sz_rois_id = sz_rois.id
                join sz_to_region on sz_to_region.id_sz = stimmzettel.id
                join sz_titel_regions on  sz_titel_regions.id = sz_to_region.id_sz_titel_regions
                join sz_to_page_sizes on sz_to_page_sizes.id_sz = stimmzettel.id
                join sz_page_sizes on  sz_to_page_sizes.id_sz_page_sizes = sz_page_sizes.id
            where 
                stimmzettel.id={ballotpaper_id}';
            $data = $db->direct($sql, ['ballotpaper_id'=>$ballotpaper_id]);

            /*
            echo $db->last_sql;
            exit();
            */

            $roisRegionSVG = [];
            $fields = [];
            $index =0;
            foreach($data as $row){
                $scale_x = $size[0]/$row['page_width'];
                $scale_y = $size[1]/$row['page_height'];
                $roi_x = ($row['roi_x']*$scale_x);
                $roi_y = ($row['roi_y']*$scale_y);
                $cap = $row['roi_item_cap_y'];

                $roisRegionSVG[] = '<g class="hover_group" opacity="0.1">
                    <text x="'.$roi_x.'" y="'.($roi_y + ($row['roi_height']*$scale_y) ).'" font-size="20">'.$row['roi_name'].' '.$row['bp_column'].'</text>
                    <rect x="'.$roi_x.'" y="'.$roi_y.'" opacity="0.5" fill="#0000FF" width="'.($row['roi_width']*$scale_x).'" height="'.($row['roi_height']*$scale_y).'"></rect>
                </g>';

                foreach($result as $result_row){
                    if( $result_row['bp_column']!=$row['bp_column']) continue;

                    $color = '#FF0000';
                    if ($result_row['marked'] == 'X') $color = '#00FF00';
                    $offset = ($result_row['bp_pos'] -1 )*$row['roi_item_height'] + ($result_row['bp_pos'] -1 )* $cap ;
                    $fields[] = '<g class="hover_group" opacity="0.6">
                    <a href="#papervote/opticalscanclick/svg/'.$index.'" data-attr="'.$result_row['anzeige_name'].'">
                        <text x="'.$roi_x.'" y="'.$roi_y + $offset*$scale_y.'" font-size="20">'.$result_row['anzeige_name'].' '. $result_row['bp_column'].'</text>
                        <rect x="'.$roi_x.'" y="'.$roi_y + $offset*$scale_y.'" opacity="0.5" fill="'.$color.'" width="'.($row['roi_width']*$scale_x).'" height="'.($row['roi_item_height']*$scale_y - $cap*$scale_y).'"></rect>
                    </a>
                    </g>';
                    $index++;
                }
            }
            



            App::contenttype('image/svg+xml');
            $svg = file_get_contents(__DIR__.'/svg_template.svg');
            App::body(
                DataRenderer::renderTemplate($svg, [
                    'rois_svg' => implode("\n",$roisRegionSVG),
                    'fields' => implode("\n",$fields),
                    'imageurl' => $imagedata,
                    'width' => $size[0],
                    'height' => $size[1]
                ])
            );
            BasicRoute::$finished = true;
            http_response_code(200);
        }catch(Exception $e){
            echo $e->getMessage();
            http_response_code(500);
            BasicRoute::$finished = true;
            exit();
        }
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
