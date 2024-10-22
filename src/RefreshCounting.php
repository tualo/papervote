<?php

namespace Tualo\Office\PaperVote;

use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\DS\DSTable;
use Exception;

class RefreshCounting
{
    // \Tualo\Office\PaperVote\RefreshCounting::run();
    public static function run(){
        $db = App::get('session')->getDB();
        $db->execute('call proc_briefwahlkandidaten()');
    }
}