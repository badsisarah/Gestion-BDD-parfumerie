<?php
require_once __DIR__ . '/../Parfum/fonctions_parfum.php';
$parfums = getAllParfum();
?>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Insertion flacon</title>
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
        <h1>Ajouter un flacon</h1>
        <form method="POST" action="inserer.php">
            <label for="flacon_volume">Volume (ml) :</label>
            <input type="number" name="flacon_volume" id="flacon_volume" required>

            <label for="flacon_prix">Prix (€) :</label>
            <input type="number" name="flacon_prix" id="flacon_prix" step="0.01" min="0" required>

            <label for="parfum_id">Parfum associé :</label>
            <select name="parfum_id" id="parfum_id" required>
                <option value="">-- Sélectionner un parfum --</option>
                <?php foreach ($parfums as $parfum): ?>
                    <option value="<?= $parfum['parfum_id'] ?>">
                        <?= htmlspecialchars($parfum['parfum_nom']) ?>
                    </option>
                <?php endforeach; ?>
            </select>

            <input type="submit" value="Ajouter le flacon">
        </form>
    </div>
</body>
</html>