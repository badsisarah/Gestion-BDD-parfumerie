<?php
session_start();
require 'MonEnv.php';

// Vérifie que la requête est bien une méthode POST et qu'une table est sélectionnée
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_SESSION['selected_table'])) {
    $selected_table = $_SESSION['selected_table'];

// Selon la table sélectionnée, on charge les fonctions et on supprime l'enregistrement
    switch ($selected_table) {
        case 'g09_flacon':
            require_once 'Flacon/fonctions_flacon.php';
            if (!empty($_POST['id1'])) {
                deleteFlacon($_POST['id1']);
            }
            break;

        case 'g09_magasin':
            require_once 'Magasin/fonctions_magasin.php';
            // Si l'identifiant du magasin est présent, on le supprime
            if (!empty($_POST['id1'])) {
                deleteMag($_POST['id1']);
            }
            break;

        case 'g09_parfum':
            require_once 'Parfum/fonctions_parfum.php';
            // Si l'identifiant du parfum est présent, on le supprime
            if (!empty($_POST['id1'])) {
                deleteParfum($_POST['id1']);
            }
            break;

        case 'g09_stock':
            require_once 'Stock/fonctions_stock.php';
            // Pour le stock, il faut deux identifiants (clé composée) : flacon_id et mag_id
            if (!empty($_POST['id1']) && !empty($_POST['id2'])) {
                deleteStock($_POST['id1'], $_POST['id2']); // id1 = flacon_id, id2 = mag_id
            }
            break;

        default:
        // Si aucune table valide, on retourne à l'accueil
            header("Location: index.php");
            exit;
    }

    header("Location: Accueil.php");
    exit;
} else {
    // Si la requête est invalide ou qu'aucune table n'est définie, on redirige vers l'accueil
    header("Location: index.php");
    exit;
}
