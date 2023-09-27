<?php
namespace Tualo\Office\PaperVote;
use Exception;

use Tualo\Office\Basic\TualoApplication;

class WMTualoRequestHelper {
    public static $last_error_nr = 0;
    public static $last_error_message = '';
    public static $last_msg = '';
    
    public static function query($url,  $post=NULL){

        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_HEADER, FALSE);
        curl_setopt($ch, CURLOPT_NOBODY, FALSE);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);
        if ( !is_null($post) ) curl_setopt($ch, CURLOPT_POSTFIELDS, $post);

        $cookie_file = TualoApplication::get('tempPath').'/api_cookie';
        curl_setopt($ch, CURLOPT_COOKIEJAR, $cookie_file);
        if (file_exists($cookie_file)) curl_setopt($ch, CURLOPT_COOKIEFILE, $cookie_file);

        $data = curl_exec($ch);
        self::$last_msg = $data;
        $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);

        curl_close($ch);
        if ($httpCode!==200){
            self::$last_error_nr = $httpCode;
            self::$last_error_message = "Backend server problems";
            return false;
        }else{

            $object = json_decode($data,true);
            if (
                !is_null($object) && 
                isset($object["success"]) &&
                ($object["success"]===true)

            ){
                return $object;
            }else if (
                !is_null($object) && 
                isset($object["success"]) &&
                ($object["success"]===false)

            ){
                self::$last_error_nr = 100;
                self::$last_error_message = $object["msg"];
                return false;
            }else{
                self::log('error','Code 2'."\API:".$url."\nResult:".$data);
                self::$last_error_nr = -100;
                self::$last_error_message = "Backend server false response";
                return false;
            }
        }
    }

    public static function querySingleItem($url){
        $object = self::query($url);
        if (
            isset($object["data"]) &&
            count($object["data"])==1
        ){
            return $object["data"][0];
        }else{
            self::log('error','Code 3'."\API:".$url."\nResult:".$object["data"]);
            self::$last_error_nr = -101;
            self::$last_error_message = "Backend server false response (querySingleItem) ";
            return false;
        }
    }


    public static function log($type,$data){
        $db = TualoApplication::get('session')->getDB();
        try{
            /* 
            */

            $db->direct(
                '
                    insert into wm_tualo_api_logfile (
                        id,
                        createtime,
                        uri,
                        type,
                        data
                    ) values (
                        uuid(),
                        current_timestamp,
                        {uri},
                        {type},
                        {data}
                        
                    )
                ',array(
                    'uri'=>$_SERVER['REQUEST_URL'],
                    'data'=>$data,
                    'type'=>$type
                )
            );
        }catch(Exception $e){
            
        }
    }
}