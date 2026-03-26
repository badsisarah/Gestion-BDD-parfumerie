<?php
session_start();
require 'MonEnv.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_SESSION['selected_table'])) {
    $selected_table = $_SESSION['selected_table'];

    switch ($selected_table) {
        case 'g09_flacon':
            require 'Flacon/fonctions_flacon.php';
            updateFlacon($_POST);
            break;

        case 'g09_magasin':
            require 'Magasin/fonctions_magasin.php';
            updateMag($_POST);
            break;

        case 'g09_parfum':
            require 'Parfum/fonctions_parfum.php';
            updateParfum($_POST);
            break;

        case 'g09_stock':
            require 'Stock/fonctions_stock.php';
            if (isset($_POST['flacon_id']) && isset($_POST['mag_id'])) {
                updateStock($_POST);
            }
            break;

        default:
            header("Location: index.php");
            exit;
    }

    // Redirection vers la page d'affichage après modification
    header("Location: Accueil.php");
    exit;
} else {
    header("Location: index.php");
    exit;
}

