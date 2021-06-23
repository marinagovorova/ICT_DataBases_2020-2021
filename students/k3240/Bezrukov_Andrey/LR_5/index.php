<?php

#TOEFL
$result_toefl = 87;
if ($result_toefl < 0) echo 'Results are not correct<br/>';
if ($result_toefl > 120) echo 'Results are not correct<br/>';
else if ($result_toefl < 40) echo 'Beginner<br/>';
else if ($result_toefl < 57) echo 'Elementary<br/>';
else if ($result_toefl < 87) echo 'Lower intermediate<br/>';
else if ($result_toefl < 110) echo 'Upper Intermediate<br/>';
else echo 'Advanced<br/>';

#EASTERN SLAVS
$eastern_slavic_country = 'Latvia';
switch ($eastern_slavic_country) {

case 'Russia':
echo 'Moscow<br/>';
break;

case 'Ukraine':
echo 'Kyiv<br/>';
break;

case 'Belarus':
echo 'Minsk<br/>';
break;

default:
echo 'It is not an eastearn slavic country!<br/>';
}

#SCANDINAVIA AND CZECHIA
$scandinavia = array('Norway', 'Sweden', 'Iceland', 'Denmark', 'Finland');
echo $scandinavia[2].' is a scandinavic country! <br/>';


$czechia = array('Bohemia' => 'Prague', 'Moravia' => 'Brno', 'Silezia' => 'Ostrava');
echo $czechia['Silezia'].' is the capital of region. <br/>';

foreach($czechia as $key => $value) {
if ($key == 'Silezia') continue;
echo "$value is the capital of $key<br/>";
}


#PLANETS-GIGANTS
$planets = array(
	'Planet1' => array('name' => 'Jupiter', 'nodal_period_in_years' => 12, 'equator_length_in_megameters' => 439.264),
	'Planet2' => array('name' => 'Saturn', 'nodal_period_in_years' => 29, 'equator_length_in_megameters' => 378.675),
	'Planet3' => array('name' => 'Uranus', 'nodal_period_in_years' => 84, 'equator_length_in_megameters' => 160.59),
	'Planet4' => array('name' => 'Neptun', 'nodal_period_in_years' => 165, 'equator_length_in_megameters' => 155.6)
);
echo $planets['Planet3']['nodal_period_in_years'].'<br/>';



#SQUARE
$i = 0;
echo 'Числа, квадрат которых меньше 1000: ';
while ($i*$i < 1000) {
echo $i++.' ';
}
echo '<br/>';

$k = 0;
echo 'Сами квадраты: ';
do {
echo $k*$k.' ';
$k++;
} while ($k*$k < 1000);
echo '<br/>';

#HYPOTENUSES
echo 'Гипотенузы равнобедренных треугольников: '.'<br/>';
for ($a = 1, $b = 1; $a < 10, $b < 10; $a++, $b++) {
if ($a == 5) break;
echo 'a = '.$a.' c ='.($a*$a + $b*$b)**0.5.'<br/>';
}

#EXAM PONTS
$andrey_points = array('96', '100', '89');
foreach($andrey_points as $value) {
	echo (100 - $value).' б. не хватило до максимума<br/>';
}

#SOCIAL NETWORKS (MILLIONS)
$sn_users_per_month = array('Facebook' => 2498, 'Youtube' => 2000, 'Whatsapp' => 2000, 'Instagram' => 1000, 'Tiktok' => 800, 'Reddit' => 430);

function avg($sum = 0, $count = 0) {
global $sn_users_per_month;
foreach ($sn_users_per_month as $key => $value){
	$sum += $value;
	$count++;
}
echo round($sum/$count).' пользователей в среднем<br/>';
}
avg();

function status() {
global $sn_users_per_month;
foreach ($sn_users_per_month as $key => $value){
	if ($value >= 2000) echo $key.' - очень популярная соцсеть.<br/>';
	else echo $key.' - есть куда расти!<br/>';
}
}
status();


#USSR
define('ussr_collapse_year', 1991);
echo ussr_collapse_year;


define('ussr_union_year', 1922);
echo ' '.ussr_union_year;

#ДОМЕНЫ
session_start();
$_SESSION['United States'] = 'US';
$_SESSION['France'] = 'FR';
$_SESSION['Australia'] = 'AU';



?>

