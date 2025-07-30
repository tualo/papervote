<?php

namespace Tualo\Office\PaperVote\Commands;

use Garden\Cli\Cli;
use Garden\Cli\Args;

use Tualo\Office\DS\Commandline\Setup as BaseSetup;

class Setup extends BaseSetup
{

    public static function getCommandName(): string
    {
        return 'papervote';
    }
    public static function getCommandDescription(): string
    {
        return 'perform a complete papervote setup';
    }
    public static function setup(Cli $cli)
    {
        $cli->command(self::getCommandName())
            ->description(self::getCommandDescription())
            ->opt('client', 'only use this client', true, 'string');
    }

    public static function getHeadLine(): string
    {
        return 'PaperVote Setup Command';
    }
    public static function getCommands(Args $args): array
    {
        $parentCommands = parent::getCommands($args);
        return [
            ...$parentCommands,

            'install-sql-tualojs',
            'install-sql-monaco',
            'install-sql-dashboard',
            'install-sql-bootstrap',
            'install-sql-papervote-menu',
            'install-sql-papervote-ddl',
            'install-sql-papervote-report-ddl',
            'install-sql-papervote-ds',
        ];
    }
}
