<?php
session_start();
require_once 'MonEnv.php';

// Vérifie que la table sélectionnée est bien définie dans la session
if (!isset($_SESSION['selected_table'])) {
    header("Location: index.php");
    exit;
}

// Récupère le nom de la table sélectionnée
$table = $_SESSION['selected_table'];

//En fonction de la table sélectionnée, appelle la fonction d'insertion correspondante
switch ($table) {
    case 'g09_magasin':
        require_once 'Magasin/fonctions_magasin.php';
        $result = insertMag($_POST);
        break;

    case 'g09_flacon':
        require_once 'Flacon/fonctions_flacon.php';
        $result = insertFlacon($_POST);
        break;

    case 'g09_parfum':
        require_once 'Parfum/fonctions_parfum.php';
        $result = insertParfum($_POST);
        break;

    case 'g09_stock':
        require_once 'Stock/fonctions_stock.php';
        $result = insertStock($_POST);
        break;

    default:
        echo "Table inconnue.";
        exit;
}

//Si l'insertion s'est bien déroulée (pas d'erreur), on redirige vers la page d'accueil
if (!isset($result['error'])) {
    header("Location: Accueil.php");
    exit;
} else {
//Sinon, on affiche l'erreur et un lien pour revenir au formulaire d'insertion
    echo "<p style='color:red'>Erreur : " . htmlspecialchars($result['error']) . "</p>";
    echo '<br><a href="insertion.php">Retour</a>';
}
?>
