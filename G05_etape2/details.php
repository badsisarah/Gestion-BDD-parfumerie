<?php
session_start();
require 'MonEnv.php';

// Vérifier si une table a été sélectionnée
if (!isset($_SESSION['selected_table'])) {
    header("Location: index.php");
    exit;
}

// Récupère le nom de la table sélectionnée depuis la session
$selected_table = $_SESSION['selected_table'];
// Initialisation d'un tableau pour stocker les identifiants de l'enregistrement ciblé
$record_ids = [];

// Identifier les clés en fonction de la table
switch ($selected_table) {
    case 'g09_flacon':
    case 'g09_magasin':
    case 'g09_parfum':
        // Un seul identifiant
        $id_key = match ($selected_table) {
            'g09_flacon' => 'flacon_id',
            'g09_magasin' => 'mag_id',
            'g09_parfum' => 'parfum_id',
        };
        // Vérifie que l'identifiant a bien été envoyé via POST
        if (isset($_POST[$id_key])) {
            $record_ids[] = $_POST[$id_key];
        } else {
            die("Identifiant manquant pour $selected_table");
        }
        break;

    case 'g09_stock':
        // Deux identifiants (clé composite)
        if (isset($_POST['flacon_id']) && isset($_POST['mag_id'])) {
            $record_ids[] = $_POST['flacon_id'];
            $record_ids[] = $_POST['mag_id'];
        } else {
            die("Identifiants manquants pour g09_stock.");
        }
        break;

    default:
       //Si la table n'est pas reconnue, on interrompt le script
        die("Table non reconnue.");
}

//Fonction pour récupérer les détails en fonction de la table
function getDetails($table, $record_ids) {
    switch ($table) {
        case 'g09_flacon':
            require 'Flacon/fonctions_flacon.php';
            return getFlaconById($record_ids[0]);

        case 'g09_magasin':
            require 'Magasin/fonctions_magasin.php';
            return getMagById($record_ids[0]);

        case 'g09_parfum':
            require 'Parfum/fonctions_parfum.php';
            return getParfumById($record_ids[0]);

        case 'g09_stock':
            require 'Stock/fonctions_stock.php';
            return getStockById($record_ids[0], $record_ids[1]);

        default:
            return null;
    }
}

//Appelle la fonction pour récupérer les détails de l'enregistrement sélectionné
$details = getDetails($selected_table, $record_ids);

// Affichage
echo "<h1>Détails de l'enregistrement dans $selected_table</h1>";
if (is_array($details)) {
    echo "<ul>";
    //Parcours les champs de l'enregistrement pour les afficher sous forme de liste 
    foreach ($details as $key => $value) {
        echo "<li><strong>" . htmlspecialchars($key) . ":</strong> " . htmlspecialchars($value) . "</li>";
    }
    echo "</ul>";
       //Lien de retour vers la table
    echo '<br><a href="Accueil.php">⬅ Retour à la table</a>';
} else {
    // Si aucune donnée trouvée, affiche un message d'erreur
    echo "<p>Aucun détail trouvé ou erreur de récupération.</p>";
}
?>

