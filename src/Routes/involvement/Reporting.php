<?php

namespace Tualo\Office\PaperVote\Routes\involvement;

use Exception;
use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\Basic\Route as BasicRoute;
use Tualo\Office\Basic\IRoute;
use Tualo\Office\DS\DSExporterHelper;

use PhpOffice\PhpSpreadsheet;
use PhpOffice\PhpSpreadsheet\Spreadsheet;
use PhpOffice\PhpSpreadsheet\Cell\Coordinate;
use PhpOffice\PhpSpreadsheet\Worksheet\Worksheet;
use PhpOffice\PhpSpreadsheet\IOFactory;

use Ramsey\Uuid\Uuid;
use Tualo\Office\Report\Routes\Report;

class Reporting extends \Tualo\Office\Basic\RouteWrapper
{
    public static function scope(): string
    {
        return 'papervote.involvement.reporting';
    }

    public static function getHeaders(): array
    {
        try {
            $db = App::get('session')->getDB();
            $res = $db->direct('
                    select 
                        -1 id,
                        concat("use_name") column_name,
                        "Use Name" as column_title
                    union 
                    select 
                        id,
                        concat("wb_",wahlbeteiligung_bericht.id) column_name,
                        wahlbeteiligung_bericht.name as column_title
                    from wahlbeteiligung_bericht where aktiv=1 
                    
                    union 

                    select 
                        wahlbeteiligung_bericht.id*10000+ abgabetyp.id as id,
                        concat("wb_",wahlbeteiligung_bericht.id,"_",abgabetyp.id) column_name,
                        concat(wahlbeteiligung_bericht.name, " ", abgabetyp.name) as column_title
                    from wahlbeteiligung_bericht
                        join abgabetyp on 1=1
                    where wahlbeteiligung_bericht.aktiv=1 
                    
                    
                    order by id
                    
                    ');
            return $res;
        } catch (Exception $e) {
            echo $e->getMessage();
            return [];
        }
    }

    public static function getReportData(): array
    {
        try {
            $db = App::get('session')->getDB();
            $res = $db->direct('select * from view_wahlbeteiligung_base_pivot');
            return $res;
        } catch (Exception $e) {
            echo $e->getMessage();
            return [];
        }
    }


    public static function getExcel($name = 'Beteiligungsbericht.xlsx')
    {
        try {
            $db = App::get('session')->getDB();

            $objPHPExcel = new Spreadsheet();
            $sheet = $objPHPExcel->getActiveSheet();
            $sheet->setTitle('Beteiligungsbericht');

            $sheet->SetCellValue('A2', 'Stimmzettel');
            $sheet->getStyle('A2')->getFont()->setBold(true);
            $writer = IOFactory::createWriter($objPHPExcel, 'Xlsx');

            $data = self::getReportData();
            $headers_unclean = self::getHeaders();
            $headers = [];
            foreach ($headers_unclean as $header) {
                if (isset($data[0]) && isset($data[0][$header['column_name']])) {
                    $headers[] = $header;
                }
            }
            $start_spalte = 1;
            foreach ($headers as $header) {
                $sheet->SetCellValue(Coordinate::stringFromColumnIndex($start_spalte) . '2', $header['column_title']);
                $sheet->getStyle(Coordinate::stringFromColumnIndex($start_spalte) . '2')->getFont()->setBold(true);
                $start_spalte++;
            }
            $zeile = 3;
            foreach ($data as $datensatz) {
                $start_spalte = 1;
                $sheet->SetCellValue(Coordinate::stringFromColumnIndex($start_spalte) . '1', $datensatz['use_name']);
                $sheet->getStyle(Coordinate::stringFromColumnIndex($start_spalte) . '1')->getFont()->setBold(true);
                foreach ($headers as $header) {
                    $sheet->SetCellValue(Coordinate::stringFromColumnIndex($start_spalte) . $zeile, $datensatz[$header['column_name']]);
                    $start_spalte++;
                }
                $zeile++;
            }

            // $writer->setPreCalculateFormulas(false);
            $writer->save(App::get('tempPath') . '/' . $name);
            return $name;
        } catch (Exception $e) {
            echo $e->getMessage();
            return '';
        }
    }




    public static function register()
    {

        BasicRoute::add(
            '/papervote/involvement/reportingHeaders',
            function () {
                $db = App::get('session')->getDB();
                try {


                    //App::result('data', Reporting::getData());

                    App::result('data', self::getHeaders());

                    App::result('success', true);
                } catch (Exception $e) {

                    App::result('x', $db->last_sql);
                    App::result('msg', $e->getMessage());
                }
                App::contenttype('application/json');
            },
            [
                'post',
                'get'
            ],
            true,
            [
                'errorOnUnexpected' => true,
                'errorOnInvalid' => true,
                'fields' =>  [
                    'typ' => [
                        'required' => true,
                        'type' => 'int',
                        'min' => 0,
                        'max' => 10000000
                    ],
                    '_dc' => [
                        'required' => false,
                        'type' => 'string',
                        'minlength' => 0,
                        'maxlength' => 10000
                    ]
                ]
            ],
            self::scope()

        );

        BasicRoute::add(
            '/papervote/involvement/reporting',
            function () {
                $db = App::get('session')->getDB();
                try {


                    //App::result('data', Reporting::getData());

                    App::result('data', self::getReportData());

                    App::result('success', true);
                } catch (Exception $e) {

                    App::result('x', $db->last_sql);
                    App::result('msg', $e->getMessage());
                }
                App::contenttype('application/json');
            },
            [
                'post',
                'get'
            ],
            true,
            [
                'errorOnUnexpected' => true,
                'errorOnInvalid' => true,
                'fields' =>  [
                    'typ' => [
                        'required' => true,
                        'type' => 'int',
                        'min' => 0,
                        'max' => 10000000
                    ],
                    '_dc' => [
                        'required' => false,
                        'type' => 'string',
                        'minlength' => 0,
                        'maxlength' => 10000
                    ],
                    'abgabetyp' => [
                        'required' => false,
                        'type' => 'string',
                        'minlength' => 0,
                        'maxlength' => 100
                    ],
                    'testdaten' => [
                        'required' => false,
                        'type' => 'int',
                        'min' => 0,
                        'max' => 1
                    ],
                    'base' => [
                        'required' => false,
                        'type' => 'string',
                        'minlength' => 0,
                        'maxlength' => 50
                    ],
                    'join_fld' => [
                        'required' => false,
                        'type' => 'string',
                        'minlength' => 0,
                        'maxlength' => 50
                    ],
                    'page' => [
                        'required' => false,
                        'type' => 'int',
                        'minlength' => 0,
                        'maxlength' => 1000000
                    ],
                    'start' => [
                        'required' => false,
                        'type' => 'int',
                        'minlength' => 0,
                        'maxlength' => 1000000
                    ],
                    'limit' => [
                        'required' => false,
                        'type' => 'int',
                        'minlength' => 0,
                        'maxlength' => 1000000
                    ]
                ]
            ],
            self::scope()
        );

        BasicRoute::add('/papervote/involvement/reporting/export', function () {
            $db = App::get('session')->getDB();
            try {
                $fname = Reporting::getExcel();
                App::result('file', $fname);
                App::result('success', true);
            } catch (Exception $e) {
                App::result('msg', $e->getMessage());
            }
            App::contenttype('application/json');
        }, array('get', 'post'), true, [], self::scope());
    }
}
