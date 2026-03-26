<?php
session_start();

if (!isset($_SESSION['selected_table'])) {
    header("Location: index.php");
    exit;
}

$table = $_SESSION['selected_table'];

switch ($table) {
    case 'g09_magasin':
        include 'Magasin/insertion_magasin.html';
        break;
    case 'g09_flacon':
        include 'Flacon/insertion_flacon.php';
        break;
    case 'g09_parfum':
        include 'Parfum/insertion_parfum.html';
        break;
    case 'g09_stock':
        include 'Stock/insertion_stock.php';
        break;
    default:
        echo "Table non reconnue.";
}
?>
