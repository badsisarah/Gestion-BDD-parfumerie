<?php
session_start();
require_once('MonEnv.php');

// Liste des tables autorisées
$table_identifiers = ['g09_flacon', 'g09_magasin', 'g09_stock', 'g09_parfum'];

// Vérifie si une table valide a bien été sélectionnée
if (!isset($_SESSION['selected_table']) || !in_array($_SESSION['selected_table'], $table_identifiers)) {
    echo "Aucune table valide sélectionnée.";
    exit;
}

// Récupère la table sélectionnée via la session
$selected_table = $_SESSION['selected_table'];

// Décrit les identifiants et champs de chaque table
$table_identifiers = [
    'g09_flacon' => ['id' => 'flacon_id', 'fields' => ['flacon_volume', 'flacon_prix', 'parfum_id']],
    'g09_magasin' => ['id' => 'mag_id', 'fields' => ['mag_nom', 'mag_adresse','mag_telephone','mag_ville','mag_email']],
    'g09_stock'   => ['id' => ['flacon_id', 'mag_id'], 'fields' => ['quantite']],
    'g09_parfum'  => ['id' => 'parfum_id', 'fields' => ['parfum_nom', 'parfum_description', 'parfum_type', 'parfum_marque']]
];

// Décrit les clés étrangères à masquer dans l'affichage
$foreign_keys = [
    'g09_flacon' => ['parfum_id'],
    'g09_magasin' => ['mag_id'],
    'g09_stock' => ['flacon_id', 'mag_id'],
    'g09_parfum' => ['parfum_id']
];

// Fonction pour récupérer tous les enregistrements d’une table donnée
function getRecords($table) {

// Fichiers à inclure selon la table
      $functions = [
        'g09_flacon' => 'Flacon/fonctions_flacon.php',
        'g09_magasin' => 'Magasin/fonctions_magasin.php',
        'g09_stock' => 'Stock/fonctions_stock.php',
        'g09_parfum' => 'Parfum/fonctions_parfum.php'
    ];

    if (!isset($functions[$table])) {
        die("Aucune fonction définie pour la table : " . htmlspecialchars($table));
    }

    // Inclut le fichier correspondant à la table
    require_once $functions[$table];
    
    // Appelle la fonction adéquate pour récupérer les enregistrements
    switch ($table) {
        case 'g09_flacon': return getAllFlacon();
        case 'g09_magasin': return getAllMag();
        case 'g09_stock': return getAllStock();
        case 'g09_parfum': return getAllParfum();
        default: return [];
    }
}

// Récupère tous les enregistrements de la table sélectionnée
$allRecords = getRecords($selected_table);

// Récupère les informations nécessaires sur les identifiants et champs
$identifier = $table_identifiers[$selected_table]['id'];
$fields = $table_identifiers[$selected_table]['fields'];
$foreign = $foreign_keys[$selected_table] ?? [];
?>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Affichage - <?= htmlspecialchars($selected_table); ?></title>
    <style>
    /* Style global de la page */
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(to right, #fff5e1, #fcdada);
            margin: 0;
            padding: 20px;
        }
        h1 {
            text-align: center;
            color: #800040;
        }
        .container {
            background-color: white;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
            max-width: 1200px;
            margin: auto;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background-color: white;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #d8758a;
            color: white;
        }
        tr:hover {
            background-color: #fff0f5;
        }
        form {
            display: inline;
        }
        button, input[type="submit"] {
            background-color: #d8758a;
            color: white;
            border: none;
            padding: 8px 12px;
            border-radius: 6px;
            cursor: pointer;
        }
        button:hover, input[type="submit"]:hover {
            background-color: #d8758a;
        }
        a {
            display: inline-block;
            margin-top: 10px;
            color: #800040;
            text-decoration: none;
            font-weight: bold;
        }
        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div class="container">
  <!-- Titre dynamique selon la table -->
    <h1>Affichage de la table : <?= htmlspecialchars($selected_table); ?></h1>
    <a href="index.php">Retour à l'accueil</a><br/>
    
    <!-- Formulaire vers la page d'insertion -->
    <form action="insertion.php" method="post">
        <input type="submit" value="Insertion d'un nouvel enregistrement">
    </form>

     <!-- Vérifie s’il y a des enregistrements à afficher -->
    <?php if (!empty($allRecords)) { ?>
        <table>
            <tr>
                <!-- Colonnes spécifiques selon la table -->
                <?php if ($selected_table === 'g09_flacon') { ?>
                    <th>Nom du parfum</th>
                <?php } elseif ($selected_table === 'g09_stock') { ?>
                    <th>Nom du parfum</th>
                    <th>Nom du magasin</th>
                <?php } elseif ($selected_table === 'g09_magasin') { ?>
                    <!-- Ne rien afficher pour mag_id -->
                <?php } elseif ($selected_table === 'g09_parfum') { ?>
                    <!-- Ne rien afficher pour parfum_id -->
                <?php } else {
                    foreach ((array) $identifier as $id) {
                        echo "<th>" . htmlspecialchars($id) . "</th>";
                    }
                } ?>
                <?php foreach ($fields as $field) {
                    if (!in_array($field, $foreign)) {
                        echo "<th>" . htmlspecialchars($field) . "</th>";
                    }
                } ?>
                <th>Détails</th>
                <th>Modifier</th>
                <th>Supprimer</th>
            </tr>

            <?php foreach ($allRecords as $record) { ?>
                <tr>
                    <?php if ($selected_table === 'g09_flacon') { ?>
                        <td><?= htmlspecialchars($record['parfum_nom']) ?></td>
                    <?php } elseif ($selected_table === 'g09_stock') { ?>
                        <td><?= htmlspecialchars($record['parfum_nom']) ?></td>
                        <td><?= htmlspecialchars($record['mag_nom']) ?></td>
                    <?php } elseif ($selected_table === 'g09_magasin' || $selected_table === 'g09_parfum') {
                        // Ne pas afficher les IDs
                    } else {
                        foreach ((array) $identifier as $id) {
                            echo "<td>" . htmlspecialchars($record[$id] ?? '') . "</td>";
                        }
                    } ?>
                    
                    <!-- Affiche les champs qui ne sont pas des clés étrangères -->
                    <?php foreach ($fields as $field) {
                        if (!in_array($field, $foreign)) {
                            echo "<td>" . htmlspecialchars($record[$field] ?? '') . "</td>";
                        }
                    } ?>

                    <td>
                        <form action="details.php" method="post">
                            <?php foreach ((array) $identifier as $id) { ?>
                                <input type="hidden" name="<?= $id ?>" value="<?= htmlspecialchars($record[$id] ?? '') ?>">
                            <?php } ?>
                            <button type="submit">Détails</button>
                        </form>
                    </td>

                    <td>
                        <form action="modifier.php" method="post">
                            <?php $idx = 1;
                            foreach ((array) $identifier as $id) { ?>
                                <input type="hidden" name="id<?= $idx++ ?>" value="<?= htmlspecialchars($record[$id] ?? '') ?>">
                            <?php } ?>
                            <button type="submit">Modifier</button>
                        </form>
                    </td>

                    <td>
                        <form action="supprimer.php" method="post" onsubmit="return confirm('Confirmer la suppression ?');">
                            <?php $idx = 1;
                            foreach ((array) $identifier as $id) { ?>
                                <input type="hidden" name="id<?= $idx++ ?>" value="<?= htmlspecialchars($record[$id] ?? '') ?>">
                            <?php } ?>
                            <button type="submit">Supprimer</button>
                        </form>
                    </td>
                </tr>
            <?php } ?>
        </table>
    <?php } else { ?>
        <p>Aucun enregistrement trouvé.</p>
    <?php } ?>
</div>
</body>
</html>