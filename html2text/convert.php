<?php
/**
 * This file allows you to convert through the command line.
 * Usage:
 *   php -f convert.php [input file]
 */

if (count($argv) < 2) {
	throw new \InvalidArgumentException("Expected: php -f convert.php [input file]");
}

if (!file_exists($argv[1])) {
	throw new \InvalidArgumentException("'" . $argv[1] . "' does not exist");
}

$input = file_get_contents($argv[1]);
$nome = substr($input, strpos($input, "/") + 1);
$nome = strstr($nome,  '.', true);

require_once(__DIR__ . "/html2text/src/Html2Text.php");
require_once(__DIR__ . "/html2text/src/Html2TextException.php");

function convert_html_to_text($html, $ignore_error = false) {
        return Soundasleep\Html2Text::convert($html, $ignore_error);
}

$options = array(
  'ignore_errors' => false,
	'drop_links' => true
);

$data =convert_html_to_text($input,$options);

$filename= __DIR__ . "/logs/$nome.txt";
if (file_exists($filename)){
    $newFile= fopen($filename, 'w+');
    fwrite($newFile, $data);
    fclose($newFile);
} else {
    $newFile= fopen($filename, 'w+');
    fwrite($newFile, $data);
    fclose($newFile);
    chmod($filename, 0777);
}
