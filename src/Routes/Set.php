<?php
namespace Tualo\Office\PaperVote\Routes;

use Exception;
use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\Basic\Route as BasicRoute;
use Tualo\Office\Basic\IRoute;
use Tualo\Office\TualoPGP\TualoApplicationPGP;

use Ramsey\Uuid\Uuid;

class Set implements IRoute{
 
    public static function register(){
        
        BasicRoute::add('/papervote/set',function( ){
            App::contenttype('application/json');
            try{
                $db = App::get('session')->getDB();

                $remote_public_key = $db->singleValue("select property FROM system_settings WHERE system_settings_id = 'remote-erp/public'",[],'property');
                if(!isset($_REQUEST['voter_id'])) throw new Exception("voter_id missed");
                if(!isset($_REQUEST['signature']))  throw new Exception("signature missed");
                if(!isset($_REQUEST['ballotpaper_id']))  throw new Exception("ballotpaper_id missed");
                if(!TualoApplicationPGP::verify($remote_public_key,$_REQUEST['voter_id'], $_REQUEST['signature'])) throw new Exception("Verification failed");

                $sql='select * from wahlschein where id={voter_id} and stimmzettel in (select ridx from stimmzettel where id = {ballotpaper_id}) and wahlscheinstatus in ("1|0")';
                $data = $db->singleRow($sql,$_REQUEST);

                if ($data!==false){
                    $db->direct("update wahlschein set wahlscheinstatus='2|0', abgabetyp='2|0' where id={voter_id}  and stimmzettel={stimmzettel} ",[
                        'voter_id'      =>  $_REQUEST['voter_id'],
                        'stimmzettel'   =>  $db->singleValue('select ridx from stimmzettel where id = {ballotpaper_id}',$_REQUEST,'ridx')
                    ]);

                    $sql='select * from wahlschein where id={voter_id} and stimmzettel in (select ridx from stimmzettel where id = {ballotpaper_id}) and wahlscheinstatus="2|0" and abgabetyp="2|0"';
                    $data = $db->singleRow($sql,$_REQUEST);
                    if ($data!==false) App::result('success', true);
                    
                }else{
                    App::result('success', false);
                    App::result('msg',($data === false)?'Konnte nicht gespeichert werden':'');
                }
            }catch(\Exception $e){

                App::result('last_sql', $db->last_sql);
                App::result('msg', $e->getMessage());
            }
        },['post'],true);


    }
}