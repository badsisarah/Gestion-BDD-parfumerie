<?php
require_once '../config/MonEnv.php';
require_once 'fonctions_parfum.php';

/* Test de getParfumById()   */
echo "<h2>Test de getParfumById()</h2>";
echo " Test de getParfumById() pour  parfum_id=3 <br />";
print_r(getParfumById(3));
echo " <br />";
echo " Test de getParfumById() pour  parfum_id=8 <br />";
print_r(getParfumById(8));
echo " <br />";

/*Test de getAllParfum()    */
echo "<h2>Test de getAllParfum()</h2>";

print_r(getAllParfum());
echo " <br />"; 


/* Test de insertParfum() */
echo "<h2>Test de insertParfum()</h2>";
$parfum['parfum_type']='Eau de parfum';
$parfum['parfum_nom']='Gardenia';
$parfum['parfum_description']='Florel à la vanille';
$parfum['parfum_marque']='Zara';
print_r(insertParfum($parfum));
echo " <br />";


/* Test de updateParfum() */
echo "<h2>Test de updateParfum()</h2>";
$parfum = getParfumById(6);
print_r($parfum);
echo " <br />";
$parfum['parfum_type']='Eau de toilette';
$parfum['parfum_nom']='Orchide';
$parfum['parfum_description']='Florel à la vanille';
$parfum['parfum_marque']='Zara';
print_r(updateParfum($parfum));
echo " <br />";


/* Test de deleteParfum() */
echo "<h2>Test de deleteParfum()</h2>";
echo " Test de deleteParfum pour parfum_id=19 <br />";
deleteParfum(19);
echo " <br />";
print_r(getParfumById(19));
echo " <br />";


?>

