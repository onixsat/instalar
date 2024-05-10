<?php
require_once("libs/html2txt.php");
$input = file_get_contents($argv[1]);
$html = new \Html2Text\Html2Text($input);

echo $html->getText();  // Hello, "WORLD"
