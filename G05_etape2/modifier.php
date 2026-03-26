<?php
session_start();
// Vérifie si une table est sélectionnée, sinon redirige vers l'accueil
if (!isset($_SESSION['selected_table'])) {
    $_SESSION['error_message'] = "Aucune table sélectionnée.";
    header("Location: Acceuil.php");
    exit;
}

$selected_table = $_SESSION['selected_table'];

// Charge le fichier de fonctions correspondant à la table sélectionnée
switch ($selected_table) {
    case 'g09_magasin':
        require_once('Magasin/fonctions_magasin.php');
        break;
    case 'g09_flacon':
        require_once('Flacon/fonctions_flacon.php');
        break;
    case 'g09_parfum':
        require_once('Parfum/fonctions_parfum.php');
        break;
    case 'g09_stock':
        require_once('Stock/fonctions_stock.php');
        break;
}

// Structure contenant les identifiants et champs de chaque table
$table_identifiers = [
    'g09_flacon' => ['id' => 'flacon_id', 'fields' => ['flacon_volume', 'flacon_prix']],
    'g09_magasin' => ['id' => 'mag_id', 'fields' => ['mag_nom', 'mag_adresse','mag_telephone','mag_ville','mag_email']],
    'g09_stock'   => ['id' => ['flacon_id', 'mag_id'], 'fields' => ['quantite']],
    'g09_parfum'  => ['id' => 'parfum_id', 'fields' => ['parfum_nom', 'parfum_description', 'parfum_type', 'parfum_marque']]
];

// Récupère les identifiants selon la table stock (clé composée) ou autre
if ($selected_table === 'g09_stock') {
    $record_id = $_POST['id1'] ?? null;
    $id1 = $_POST['id2'] ?? null;
    $recordDetails = getRecordById([$record_id, $id1], $selected_table);
} else {
    $record_id = $_POST['id1'] ?? $_GET['id1'] ?? null;
    $recordDetails = getRecordById($record_id, $selected_table);
}

// Si aucun enregistrement n’est trouvé, retour à l’accueil avec message d’erreur
if (!$recordDetails) {
    $_SESSION['error_message'] = "L'enregistrement à modifier n'a pas été trouvé.";
    header("Location: Acceuil.php");
    exit;
}

// Fonction qui retourne l'enregistrement selon la table et l'ID (ou IDs pour stock)
function getRecordById($id, $table)
{
    switch ($table) {
        case 'g09_magasin':
            return getMagById($id);
        case 'g09_flacon':
            return getFlaconById($id);
        case 'g09_parfum':
            return getParfumById($id);
        case 'g09_stock':
            $mag_id = $id[0];
            $flacon_id = $id[1];
            return getStockById($mag_id, $flacon_id);
        default:
            return null;
    }
}
?>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Modification de <?= htmlspecialchars($selected_table); ?></title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(to right, #ffe4ec, #f8d7dd);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .container {
            background-color: white;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
            width: 100%;
            max-width: 400px;
        }
        h1 {
            font-weight: bold;
            text-align: center;
            margin-bottom: 24px;
            color: #800040;
        }
        form label {
            display: block;
            margin-bottom: 6px;
            font-weight: 500;
            color: #800040;
        }
        form input[type="text"],
        form input[type="email"],
        form input[type="number"],
        form select {
            width: 100%;
            padding: 10px;
            margin-bottom: 16px;
            border: 1px solid #ccc;
            border-radius: 8px;
            box-sizing: border-box;
            background-color: #fff0f5;
        }
        button {
            width: 100%;
            background-color: #e91e63;
            color: white;
            padding: 12px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            cursor: pointer;
        }
        button:hover {
            background-color: #c2185b;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Modification de <?= htmlspecialchars($selected_table); ?></h1>
    <form action="modification.php" method="post">
        <?php foreach ($recordDetails as $field => $value) {
            if (preg_match('/_id$/', $field)) {
                echo "<input type='hidden' name='" . htmlspecialchars($field) . "' value='" . htmlspecialchars($value) . "'>";
                continue;
            }

            if ($selected_table === 'g09_flacon' && !in_array($field, ['flacon_volume', 'flacon_prix'])) {
                continue;
            }
        ?>
            <label for="<?= htmlspecialchars($field); ?>"><?= htmlspecialchars($field); ?> :</label>
            <input type="text" name="<?= htmlspecialchars($field); ?>" value="<?= htmlspecialchars($value); ?>" required><br>
        <?php } ?>
        <button type="submit">Modifier</button>
    </form>
</div>
</body>
</html>
