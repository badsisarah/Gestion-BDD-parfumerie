<?php

require_once 'MonEnv.php';
require_once 'fonctions_magasin.php';


/* Test de getMagById() */
echo "<h2>Test de getMagById()</h2>";
echo " Test de getMagById() pour mag_id = 5 <br />";
print_r(getMagById(5));
echo " <br />";
echo " Test de getMagById() pour mag_id = 10 <br />";
print_r(getMagById(10));
echo " <br />";

/*Test de getAllMag()*/
echo "<h2> Test de getAllMag() </h2>";
print_r(getAllMag());
echo " <br />"; 

/* Test de insertMag() */
echo "<h2>Test de insertMag()</h2>";
$magasin['mag_nom'] = 'test';
$magasin['mag_adresse'] = 'Avenue test';
$magasin['mag_telephone'] = '0000000000';
$magasin['mag_ville'] = "test";
$magasin['mag_email'] = 'test@sephora.fr';
print_r(insertMag($magasin));
echo " <br />";



/* Test de updateMag() */
echo "<h2>Test de updateMag()</h2>";
$magasin = getMagById(6);
print_r($magasin);
$magasin['mag_nom'] = 'Sephora';
$magasin['mag_adresse'] = 'Avenue du Camp Dolent';
$magasin['mag_telephone'] = '0235552590';
$magasin['mag_mag_ville'] = "Gonfreville-l'Orcher";
$magasin['mag_mag_email'] = 'privacy@sephora.fr';
print_r(updateMag($magasin));
echo " <br />";

 
 /*Test de deleteMagasin() */
echo "<h2>Test de deleteMagasin()</h2>";
deleteMag(4);
print_r(getMagById(4));
echo " <br />";




?>
