<?php
require_once 'MonEnv.php';
require_once 'fonctions_flacon.php';


/* Test de getFlaconById() */
echo "<h2>Test de getFlaconById()</h2>";
echo " Test de getFlaconById() pour flacon_id = 3 <br />";
print_r(getFlaconById(3));
echo " <br />";
echo " Test de getFlaconById() pour flacon_id = 13 <br />";
print_r(getFlaconById(13));
echo " <br />";


/*Test de getAllFlacon()*/
echo "<h2>Test de getAllFlacon()</h2>";
print_r(getAllFlacon());
echo " <br />"; 



/* Test de insertFlacon() */
echo "<h2>Test de insertFlacon()</h2>";
$flacon['flacon_volume'] = '559';
$flacon['flacon_prix'] = '187';
$flacon['parfum_id'] = "5";
print_r(insertFlacon($flacon));
echo " <br />";



/* Test de updateFlacon() */
echo "<h2>Test de updateFlacon()</h2>";
echo "Test de updateFlacon() pour flacon_id = 3";
echo " <br />";
$flacon = getFlaconById(3);
print_r($flacon);
echo " <br />";
$flacon['flacon_volume'] = 120;
$flacon['flacon_prix'] = 400;
print_r(updateFlacon($flacon));
echo " <br />";

 
 /*Test de deleteFlacon() */
echo "<h2>Test de deleteFlacon() </h2>";
echo " Test de deleteFlacon pour flacon_id = 4 <br /> ";

deleteFlacon(4);
print_r(getFlaconById(4));
echo " <br />";



?>
