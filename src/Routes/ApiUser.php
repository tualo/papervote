<?php
namespace Tualo\Office\PaperVote\Routes;

use Exception;
use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\Basic\Route as BasicRoute;
use Tualo\Office\Basic\IRoute;
use Tualo\Office\TualoPGP\TualoApplicationPGP;
use Tualo\Office\PaperVote\Routes\Query;

use Ramsey\Uuid\Uuid;

class ApiUser implements IRoute{
 
    public static function register(){




        BasicRoute::add('/papervote/get',function( ){
            App::contenttype('application/json');
            try{
                $db = App::get('session')->getDB();

                $remote_public_key = $db->singleValue("select property FROM system_settings WHERE system_settings_id = 'remote-erp/public'",[],'property');
                $local_private_key = $db->singleValue("select property FROM system_settings WHERE system_settings_id = 'erp/privatekey'",[],'property');
                if(!isset($_REQUEST['username'])) throw new Exception("username missed");
                if(!isset($_REQUEST['signature']))  throw new Exception("signature missed");
                if(!TualoApplicationPGP::verify($remote_public_key,$_REQUEST['username'], $_REQUEST['signature'])) throw new Exception("Verification failed");


                
                $sql='select * from view_voters_by_username_api where username={username}';
                $data = $db->singleRow($sql,[
                    'username'=>$_REQUEST['username']
                ]);

                if ($data !== false){
                    if (is_string($data['possible_ballotpapers'])){
                        $data['possible_ballotpapers'] = json_decode($data['possible_ballotpapers'],true);
                    }

                    
                    foreach( $data['possible_ballotpapers'] as &$ballotpaper){
                        $hash = [
                            'voter_id'=>$ballotpaper['voter_id'],
                            'ballotpaper_ridx' => $ballotpaper['ballotpaper_id'].'|0',
                            'secret_token' => Uuid::uuid4()->toString()
                        ];
                        if ($ballotpaper['canvote']==1){
                            $db->direct('
                            insert into wm_wahlschein_register (
                                id,
                                stimmzettel,
                                createdate,
                                token
                            ) values (
                                {voter_id},
                                {ballotpaper_ridx},
                                now(),
                                {secret_token}
                            ) on duplicate key update token=values(token)
                            ',$hash);
                        }
                        $ballotpaper['secret_token'] =  TualoApplicationPGP::enarmor(TualoApplicationPGP::encrypt($remote_public_key,$hash['secret_token']));
                    }
                    try{
                        $data['wahlzeichnungsberechtigter'] = $db->direct('select * from wahlzeichnungsberechtigter  where aktiv=1 and wahlberechtigte in (
                            select wahlberechtigte where username={username}
                        )',[
                            'username'=>$_REQUEST['username']
                        ]);

                    }catch(Exception $e){

                    }

                    // App::result('last_state',  $$db->direct('select wahlscheinstatus,abgabetyp from wahlschein ' );

                }

                App::result('data',  $data );
                App::result('success',$data !== false);
                App::result('msg',($data === false)?'Der Wähler wurde nicht gefunden.':'');
            }catch(\Exception $e){

                App::result('last_sql', $db->last_sql);
                App::result('msg', $e->getMessage());
            }
        },['post'],true);


        
    }
}