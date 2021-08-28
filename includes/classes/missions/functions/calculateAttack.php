<?php

/* Battle engines

0 - Ogame probabilistic battle engine (Fast, stable, but buggy)
1 - SteemNova; Slow, unstable on big battles, required custom PHP Extension)
2 - Hybrid; Below 200000 ships SteemNova, Above OPBE
999 - SteemNova's Battle Engine based on Arrays; Very slow, not recommended
*/

$battle_engine = 2;


/*
DON'T MODIFY ↓
*/

require_once("OPBE.php");
/*
if($battle_engine == 2 && !empty($attackers[0]["unit"]) && !empty($defenders[0]["unit"])) {
$ships = 0;
foreach($attackers[0]["unit"] as $units) {
$ships = $ships + $units;
}

foreach($defenders[0]["unit"] as $units) {
$ships = $ships + $units;
}

if($ships<=200000 && extension_loaded('ds')) {include("SteemNova.php");}
else if($ships<=20000 AND !extension_loaded('ds')) {include("SteemNova_Array.php");}
else {include("OPBE.php");}

} else if($battle_engine == 1) {include("SteemNova.php");}
else if($battle_engine == 999) {include("SteemNova_Array.php");}
else {include("OPBE.php");}*/