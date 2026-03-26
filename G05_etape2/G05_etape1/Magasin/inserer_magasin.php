<?php
require_once 'fonctions_magasin.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $data = [
        'mag_nom' => trim($_POST['mag_nom']),
        'mag_adresse' => trim($_POST['mag_adresse']),
        'mag_telephone' => trim($_POST['mag_telephone']),
        'mag_ville' => trim($_POST['mag_ville']),
        'mag_email' => trim($_POST['mag_email'])
    ];

    $result = insertMag($data);

    if (isset($result['error'])) {
        echo "<p style='color:red'>Erreur : " . $result['error'] . "</p>";
    } else {
        echo "<p style='color:green'>Magasin ajouté avec succès ! ID : " . $result['mag_id'] . "</p>";
    }
}
?>
