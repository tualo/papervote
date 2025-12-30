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
use Tualo\Office\DS\DSTable;
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
            $use_name_title = DSTable::instance('votemanager_setup')->f('id', 'eq', 'wm_involvement_report_base_title')->getSingleValue('val');
            if ($use_name_title === false) {
                $use_name_title = DSTable::instance('votemanager_setup')->f('id', 'eq', 'wm_involvement_report_base')->getSingleValue('val');
            }

            $wahlbeteiligung_bericht_formel = DSTable::instance('wahlbeteiligung_bericht_formel')->f('aktiv', 'eq', 1)->g();
            foreach ($wahlbeteiligung_bericht_formel as $index => $wb_formel) {
                $wb_formel['nenner_excel'] = [];
                $wb_formel['teiler_excel'] = [];

                foreach (json_decode($wb_formel['nenner'], true) as $value) {
                    $wb_formel['nenner_excel'][] = 'wb_' . $value['id'];
                }
                foreach (json_decode($wb_formel['teiler'], true) as $value) {
                    $wb_formel['teiler_excel'][] = 'wb_' . $value['id'];
                }
                $wahlbeteiligung_bericht_formel[$index]['nenner_excel'] = $wb_formel['nenner_excel'];
                $wahlbeteiligung_bericht_formel[$index]['teiler_excel'] = $wb_formel['teiler_excel'];
            }

            $zeile = 1;
            $objPHPExcel = new Spreadsheet();
            $sheet = $objPHPExcel->getActiveSheet();
            $sheet->setTitle('Beteiligungsbericht');


            $writer = IOFactory::createWriter($objPHPExcel, 'Xlsx');

            $auswertungen = $db->direct('select 0 id,"Allgemein" auswertung_name  
                union all
                select id,name auswertung_name  from wm_auswertungen 
                order by pos,id
            ');
            foreach ($auswertungen as $auswertung) {






                $data = self::getReportData();
                $headers_unclean = self::getHeaders();
                $headers = [];
                foreach ($headers_unclean as $header) {
                    if (isset($data[0]) && isset($data[0][$header['column_name']])) {
                        $headers[] = $header;
                    }
                }
                $start_spalte = 1;

                $sheet->SetCellValue(Coordinate::stringFromColumnIndex($start_spalte) . $zeile, $auswertung['auswertung_name']);
                $sheet->getStyle(Coordinate::stringFromColumnIndex($start_spalte) . $zeile)->getFont()->setBold(true);
                $zeile++;

                foreach ($headers as $header) {

                    if ($header['column_name'] == 'use_name') {
                        $header['column_title'] = $use_name_title;
                    }

                    $sheet->SetCellValue(Coordinate::stringFromColumnIndex($start_spalte) . $zeile, $header['column_title']);
                    $sheet->getStyle(Coordinate::stringFromColumnIndex($start_spalte) . $zeile)->getFont()->setBold(true);
                    $start_spalte++;
                }
                foreach ($wahlbeteiligung_bericht_formel as $wb_formel) {
                    $sheet->SetCellValue(Coordinate::stringFromColumnIndex($start_spalte) . $zeile, $wb_formel['name']);
                    $sheet->getStyle(Coordinate::stringFromColumnIndex($start_spalte) . $zeile)->getFont()->setBold(true);
                    $start_spalte++;
                }
                $zeile++;
                $current_start_zeile = $zeile;
                foreach ($data as $datensatz) {
                    if (!isset($datensatz['use_name']) || $datensatz['use_name'] == '') continue;
                    $start_spalte = 1;

                    // $sheet->SetCellValue(Coordinate::stringFromColumnIndex($start_spalte) . '1', $datensatz['use_name']);
                    // $sheet->getStyle(Coordinate::stringFromColumnIndex($start_spalte) . '1')->getFont()->setBold(true);

                    $coordianates = [];
                    foreach ($headers as $header) {
                        $coordianate = Coordinate::stringFromColumnIndex($start_spalte) . $zeile;
                        $coordianates[$header['column_name']] = $coordianate;
                        $sheet->SetCellValue($coordianate, $datensatz[$header['column_name']]);
                        $start_spalte++;
                    }



                    foreach ($wahlbeteiligung_bericht_formel as $wb_formel) {
                        $nenner = [];
                        foreach ($wb_formel['nenner_excel'] as $n) {
                            $nenner[] = $coordianates[$n];
                        }
                        $teiler = [];
                        foreach ($wb_formel['teiler_excel'] as $t) {
                            $teiler[] = $coordianates[$t];
                        }

                        $coordianate = Coordinate::stringFromColumnIndex($start_spalte) . $zeile;
                        $sheet->SetCellValue($coordianate, '=IF(SUM(' . implode(',', $teiler) . ')=0,0,SUM(' . implode(',', $nenner) . ')/SUM(' . implode(',', $teiler) . '))   ');
                        $start_spalte++;
                        $sheet->getStyle($coordianate)->getNumberFormat()->setFormatCode('0.00%');
                        $sheet->getStyle($coordianate)->getFont()->setBold(true);
                    }
                    $zeile++;
                }

                // Summen einblenden
                $start_spalte = 1;
                foreach ($headers as $header) {
                    /*
                if (!isset($datensatz['use_name']) || $datensatz['use_name'] == '') {
                    $start_spalte++;
                    continue;
                }
                */
                    if ($header['id'] == -1) {
                        $sheet->SetCellValue(
                            Coordinate::stringFromColumnIndex($start_spalte) . $zeile,
                            'Gesamt'
                        );
                        $sheet->getStyle(Coordinate::stringFromColumnIndex($start_spalte) . $zeile)->getFont()->setBold(true);
                        $start_spalte++;
                        continue;
                    }
                    $sheet->SetCellValue(
                        Coordinate::stringFromColumnIndex($start_spalte) . $zeile,

                        "=SUM(" . Coordinate::stringFromColumnIndex($start_spalte) . $current_start_zeile . ':' . Coordinate::stringFromColumnIndex($start_spalte) . ($zeile - 1) . ')'
                    );
                    $sheet->getStyle(Coordinate::stringFromColumnIndex($start_spalte) . $zeile)->getFont()->setBold(true);
                    $start_spalte++;
                }
                foreach ($wahlbeteiligung_bericht_formel as $wb_formel) {
                    $nenner = [];
                    foreach ($wb_formel['nenner_excel'] as $n) {
                        $nenner[] = $coordianates[$n];
                    }
                    $teiler = [];
                    foreach ($wb_formel['teiler_excel'] as $t) {
                        $teiler[] = $coordianates[$t];
                    }

                    $coordianate = Coordinate::stringFromColumnIndex($start_spalte) . $zeile;
                    $sheet->SetCellValue($coordianate, '=IF(SUM(' . implode(',', $teiler) . ')=0,0,SUM(' . implode(',', $nenner) . ')/SUM(' . implode(',', $teiler) . '))   ');
                    $start_spalte++;
                    $sheet->getStyle($coordianate)->getNumberFormat()->setFormatCode('0.00%');
                    $sheet->getStyle($coordianate)->getFont()->setBold(true);
                }
                $zeile++;
                $zeile++;
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
