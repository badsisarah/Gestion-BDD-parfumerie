<?php
session_start();
require 'MonEnv.php';

/// Tableau contenant les noms des tables disponibles à sélectionner
$tables = [
    "g09_flacon" => "Flacon",
    "g09_magasin" => "Magasin",
    "g09_stock" => "Stock",
    "g09_parfum" => "Parfum"
];

// Vérifie que le formulaire a été soumis par méthode POST et qu'une table a été choisie
if ($_SERVER["REQUEST_METHOD"] === "POST" && isset($_POST['table'])) {
    $_SESSION['selected_table'] = $_POST['table'];
    header("Location: Accueil.php");
    exit;
}
?>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8" />
    <title>Accueil</title>
    <link rel="stylesheet" href="Accueil.css?v=1" type="text/css" />
</head>
<body>
    <div class="conteneur-boutons">
        <h1>Choisissez une table :</h1>
        <?php foreach ($tables as $tableName => $displayName) { ?>
            <form method="post">
                <input type="hidden" name="table" value="<?= htmlspecialchars($tableName) ?>">
                <input type="submit" value="<?= htmlspecialchars($displayName) ?>">
            </form>
        <?php } ?>
    </div>
</body>
</html>
