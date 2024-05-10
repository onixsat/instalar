<?php
require_once("libs/html2txt.php");
//$input = "<html><title>Ignored Title</title><body><h1>Hello, World!</h1></body></html>";
$input = file_get_contents($argv[1]);

function getAfter($string, $afterWhat){
	return substr($string, strpos($string, $afterWhat) + 1);
}

$nome = getAfter($argv[1], '/'); // Output: test
$nome = strstr($nome,  '.', true);

$html = new Html2Text($input);

$data = $html->getText();

$file = "logs/$nome.txt";
$current = file_get_contents($file);
$current .= "$data";
file_put_contents($file, $current);

exit("");
