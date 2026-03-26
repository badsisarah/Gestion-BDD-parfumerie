<?php
require_once __DIR__ . '/../Flacon/fonctions_flacon.php';
require_once __DIR__ . '/../Magasin/fonctions_magasin.php';

$flacons = getAllFlacon();
$magasins = getAllMag();
?>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Insertion Stock</title>
    <style>
        /* Ton style existant, inchangé */
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
        form input[type="submit"] {
            width: 100%;
            background-color: #e91e63;
            color: white;
            padding: 12px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            cursor: pointer;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Ajouter un stock</h1>

    <form action="inserer.php" method="POST">

        <!-- Liste des flacons avec nom de parfum -->
        <label for="flacon_id">Parfum (flacon) :</label>
        <select name="flacon_id" id="flacon_id" required>
            <option value="">-- Sélectionner un flacon --</option>
            <?php foreach ($flacons as $f): ?>
                <option value="<?= $f['flacon_id'] ?>">
                    <?= htmlspecialchars($f['parfum_nom']) ?> - <?= $f['flacon_volume'] ?>ml (<?= $f['flacon_prix'] ?> €)
                </option>
            <?php endforeach; ?>
        </select>

        <!-- Liste des magasins -->
        <label for="mag_id">Magasin :</label>
        <select name="mag_id" id="mag_id" required>
            <option value="">-- Sélectionner un magasin --</option>
            <?php foreach ($magasins as $m): ?>
                <option value="<?= $m['mag_id'] ?>">
                    <?= htmlspecialchars($m['mag_nom']) ?> - <?= $m['mag_ville'] ?>
                </option>
            <?php endforeach; ?>
        </select>

        <label for="quantite">Quantité :</label>
        <input type="number" name="quantite" min="0" required>

        <input type="submit" value="Ajouter le stock">
    </form>
</div>
</body>
</html>
