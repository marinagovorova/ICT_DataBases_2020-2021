<?php
// 	$Boolean = true;
// 	$Integer = 100;
// 	$Float = 0.0111;
// 	$str = 'Text';

// 	$str = $str.'123';

// define('TEST', 123);

// echo TEST;

// $a = 1;
// $b = '1';

// echo '<br>'.($a !== $b);


session_start();
$arr = array(0,1,2,3,4);

writeln("Array:");
var_dump($arr);

echo '<br>';

for ($i = 0; $i < 5; $i++) {
	$arr[$i] += 2;
	writeln("Changed elem $i to $arr[$i]");
}

var_dump($arr);

echo '<br>';

foreach ($arr as $elem) {
	switch($elem) {
		case 0: writeln($elem." zero");  break;
		case 1: writeln($elem." one"); break;
		case 2: writeln($elem." two"); break;
		case 3: writeln($elem." three"); break;
		default: writeln($elem.' more than three'); break;
	}
	
	$b = ($elem > 5);

	if ($b) {
		writeln($elem.' more than five');
	}
	elseif ($elem > 4) {
		writeln($elem.' five');
	}
}


function writeln($str) {
	echo "$str<br>";
}
$_SESSION['arr'] = $arr;

?>
