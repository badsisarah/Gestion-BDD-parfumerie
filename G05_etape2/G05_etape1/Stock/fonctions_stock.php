<?php
require_once '../config/MonEnv.php';

function connexion() {
  // Utiliser directement les variables d'environnement définies dans $_ENV
  $dbHost = $_ENV['dbHost'];
  $dbName = $_ENV['dbName'];
  $dbUser = $_ENV['dbUser'];
  $dbPassword = $_ENV['dbPasswd'];
  $strConnex = "host=$dbHost dbname=$dbName  user=$dbUser password=$dbPassword";
  $ptrDB = pg_connect($strConnex);
  if ($ptrDB) {

  return $ptrDB;
  } else {
  print '<h1>Erreur lors de la connexion ...</h1>';
  exit;
  }
}
function getStockById($flacon_id, $mag_id): array {
    $conn = connexion();
    $sql = "SELECT * FROM G09_stock WHERE flacon_id = $1 AND mag_id = $2";
    $result = pg_prepare($conn, "get_stock_by_id", $sql);
    $result = pg_execute($conn, "get_stock_by_id", [$flacon_id, $mag_id]);

    if ($result && pg_num_rows($result) > 0) {
        $stock = pg_fetch_assoc($result);
    } else {
        $stock = ["error" => "Stock non trouvé pour flacon_id=$flacon_id et mag_id=$mag_id"];
    }

    pg_free_result($result);
    pg_close($conn);
    return $stock;
}

function getAllStock(): array {
    $conn = connexion();
    $sql = "SELECT * FROM G09_stock ORDER BY mag_id, flacon_id";
    pg_prepare($conn, "get_all_stock", $sql);
    $result = pg_execute($conn, "get_all_stock", []);

    $stocks = [];
    while ($row = pg_fetch_assoc($result)) {
        $stocks[] = $row;
    }

    pg_free_result($result);
    pg_close($conn);
    return $stocks;
}

function insertStock(array $stock): array {
    $conn = connexion();

    // Vérifier que le flacon existe
    $checkFlacon = pg_query_params($conn, "SELECT 1 FROM G09_flacon WHERE flacon_id = $1", [$stock['flacon_id']]);
    if (pg_num_rows($checkFlacon) === 0) {
        return ["error" => "Le flacon ID " . $stock['flacon_id'] . " n'existe pas"];
    }

    // Vérifier que le magasin existe
    $checkMagasin = pg_query_params($conn, "SELECT 1 FROM G09_magasin WHERE mag_id = $1", [$stock['mag_id']]);
    if (pg_num_rows($checkMagasin) === 0) {
        return ["error" => "Le magasin ID " . $stock['mag_id'] . " n'existe pas"];
    }

    // Insertion
    $sql = "INSERT INTO G09_stock (quantite, flacon_id, mag_id) VALUES ($1, $2, $3) RETURNING flacon_id, mag_id";
    pg_prepare($conn, "insert_stock", $sql);
    $result = pg_execute($conn, "insert_stock", [
        $stock['quantite'],
        $stock['flacon_id'],
        $stock['mag_id']
    ]);

    if ($result && pg_num_rows($result) > 0) {
        $inserted = pg_fetch_assoc($result);
        pg_close($conn);
        return getStockById($inserted['flacon_id'], $inserted['mag_id']);
    } else {
        return ["error" => "Échec lors de l'insertion du stock"];
    }
}

function updateStock(array $stock): array {
    $conn = connexion();
    $sql = "UPDATE G09_stock SET quantite = $1 WHERE flacon_id = $2 AND mag_id = $3 RETURNING *";
    pg_prepare($conn, "update_stock", $sql);
    $result = pg_execute($conn, "update_stock", [
        $stock['quantite'],
        $stock['flacon_id'],
        $stock['mag_id']
    ]);

    if ($result && pg_num_rows($result) > 0) {
        return pg_fetch_assoc($result);
    } else {
        return ["error" => "La mise à jour a échoué"];
    }
}

function deleteStock($flacon_id, $mag_id): void {
  $conn = connexion();

  // Vérifier si la ligne de stock existe
  $checkSql = "SELECT flacon_id,mag_id FROM G09_stock WHERE flacon_id = $1 AND mag_id = $2";
  pg_prepare($conn, "check_stock_exist", $checkSql);
  $checkResult = pg_execute($conn, "check_stock_exist", [$flacon_id, $mag_id]);

  if (!$checkResult || pg_num_rows($checkResult) === 0) {
      echo "<p style='color:red'>Aucun stock trouvé avec flacon_id = $flacon_id et mag_id = $mag_id</p>";
      pg_close($conn);
      return;
  }

  // Si la ligne existe, on la supprime
  $sql = "DELETE FROM G09_stock WHERE flacon_id = $1 AND mag_id = $2";
  pg_prepare($conn, "delete_stock", $sql);
  $result = pg_execute($conn, "delete_stock", [$flacon_id, $mag_id]);

  if (!$result) {
      echo "<p style='color:red'>Échec de la suppression du stock</p>";
  } else {
      echo "<p style='color:green'>Stock supprimé avec succès (flacon_id = $flacon_id, mag_id = $mag_id)</p>";
  }

  pg_close($conn);
}

?>
