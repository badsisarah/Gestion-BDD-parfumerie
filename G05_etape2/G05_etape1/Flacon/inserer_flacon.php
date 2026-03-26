<?php
require_once 'fonctions_flacon.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {

/*Récupère les données envoyées par le formulaire via la méthode POST et les nettoie avec trim()*/
    $data = [
        'flacon_volume' => trim($_POST['flacon_volume']),
        'flacon_prix' => trim($_POST['flacon_prix']),
        'parfum_id' => trim($_POST['parfum_id'])
    ];

    $result = insertFlacon($data);

/*Vérifie si une erreur s'est produite lors de l'insertion*/
    if (isset($result['error'])) {
        echo "<p style='color:red'>Erreur : " . $result['error'] . "</p>";
    } else {
        echo "<p style='color:green'>Flacon ajouté avec succès ! ID : " . $result['flacon_id'] . "</p>";
    }
}
?>

