<?php
namespace Tualo\Office\PaperVote;

use Tualo\Office\Basic\TualoApplication;
use Tualo\Office\ExtJSCompiler\ICompiler;
use Tualo\Office\ExtJSCompiler\CompilerHelper;

class Compiler implements ICompiler {
    public static function getFiles(){
        return CompilerHelper::getFiles(__DIR__,'papervote',10003);
    }
}