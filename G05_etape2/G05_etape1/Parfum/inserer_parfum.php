<?php
require 'fonctions_parfum.php';

if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $parfum_type = trim($_POST['parfum_type']);
    $parfum_nom = trim($_POST['parfum_nom']);
    $parfum_description = trim($_POST['parfum_description']);
    $parfum_marque = trim($_POST['parfum_marque']);

    // Sécurité de base : vérifier que les champs ne sont pas vides
    if ($parfum_type && $parfum_nom && $parfum_description && $parfum_marque) {
        $parfum = [
            "parfum_type" => $parfum_type,
            "parfum_nom" => $parfum_nom,
            "parfum_description" => $parfum_description,
            "parfum_marque" => $parfum_marque
        ];

        $res = insertParfum($parfum);

        if (isset($res['error'])) {
            echo "<p style='color:red'><strong>Erreur :</strong> " . $res['error'] . "</p>";
        } else {
            echo "<p style='color:green'><strong>Parfum ajouté avec succès ! ID : </strong>" . $res['parfum_id'] . "</p>";
        }
    } else {
        echo "<p style='color:red'>Tous les champs sont obligatoires.</p>";
    }
}
?>
