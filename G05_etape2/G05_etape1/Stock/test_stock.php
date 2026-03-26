<?php
require_once '../config/MonEnv.php';
require_once 'fonctions_stock.php';

/* Test de getStockById()   */
echo "<h2>Test de getStockById()</h2>";
echo " Test de getStockById() pour flacon_id=13 et mag_id=1   <br />";
print_r(getStockById(13,1));
echo " <br />";
echo " Test de getStockById() pour flacon_id=36 et mag_id=2   <br />";
print_r(getStockById(36,2));
echo " <br />";

/*Test de getAllStock()    */
echo "<h2>Test de getAllStock()</h2>";
print_r(getAllStock());
echo " <br />"; 


/* Test de insertStock() */
echo "<h2>Test de insertStock()</h2>";
$stock['quantite'] = 50;
$stock['flacon_id'] = 27; 
$stock['mag_id'] = 13; 
echo " <br />";    
$insertedStock = insertStock($stock);
print_r($insertedStock);
echo " <br />";

echo "<h2>Test de updateStock()</h2>";
$stock=getStockById(13,1);
print_r($stock);
echo " <br />";
$stock['quantite'] = 75;
$updatedStock = updateStock($stock);
print_r($updatedStock);
echo "<br><br>";


/*Test de deleteParfum() */
echo "<h2>Test de deleteStock()</h2>";
deleteStock(16,1);
echo " <br />";
print_r(getStockById(16,1));
echo " <br />";



?>

