<?php

/* Battle engines
0 - Ogame probabilistic battle engine (Fast, stable, but buggy)
1 - SteemNova; Slow, unstable on big battles, required custom PHP Extensions)
*/

$battle_engine = 1;

if($battle_engine==1) { include("SteemNova.php"); } else { include("OPBE.php"); }