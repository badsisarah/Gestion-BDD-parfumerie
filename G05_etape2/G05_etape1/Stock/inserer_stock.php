<?php
require 'fonctions_stock.php';


if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $stockData = [
        "flacon_id" => trim($_POST['flacon_id']),
        "mag_id" => trim($_POST['mag_id']),
        "quantite" => trim($_POST['quantite'])
    ];

    $result = insertStock($stockData);

    echo "<h2>Résultat de l'insertion :</h2>";
    if (isset($result['error'])) {
        echo "<p style='color:red'><strong>Erreur :</strong> " . $result['error'] . "</p>";
    } else {
        echo "<p style='color:green'>Stock inséré avec succès :</p>";
        
    }
}

?>
