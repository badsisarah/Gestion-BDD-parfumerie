<?php
require_once 'MonEnv.php';

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

//Récupération par ID
function getParfumById(int $parfum_id): array {
    $conn = connexion();
    $sql = "SELECT * FROM G09_Parfum WHERE parfum_id = $1";
    pg_prepare($conn, "get_parfum_by_id", $sql);
    $result = pg_execute($conn, "get_parfum_by_id", array($parfum_id));

    if ($result && pg_num_rows($result) > 0) {
        $parfum = pg_fetch_assoc($result);
    } else {
        $parfum = ["error" => "Parfum non trouvé avec l'ID $parfum_id"];
    }

    pg_free_result($result);
    pg_close($conn);
    return $parfum;
}

//Récupérer tous les parfums
function getAllParfum(): array {
    $conn = connexion();
    $sql = "SELECT * FROM G09_Parfum  ORDER BY parfum_id";
    $result=pg_prepare($conn, "get_all_parfums", $sql);
    $result=pg_execute($conn, "get_all_parfums", []);

    $parfums = [];
    while ($row = pg_fetch_assoc($result)) {
        $parfums[] = $row;
    }

    pg_free_result($result);
    pg_close($conn);
    return $parfums;
}

//Insertion (sans fournir l’ID, car il est en SERIAL)
function insertParfum(array $parfum): array {
    $conn = connexion();
    $sql = "INSERT INTO G09_Parfum (parfum_type, parfum_nom, parfum_description, parfum_marque)
            VALUES ($1, $2, $3, $4)
            RETURNING *"; // on récupère l'enregistrement inséré
    pg_prepare($conn, "insert_parfum", $sql);
    $result = pg_execute($conn, "insert_parfum", array(
        $parfum['parfum_type'],
        $parfum['parfum_nom'],
        $parfum['parfum_description'],
        $parfum['parfum_marque']
    ));

    if ($result && pg_num_rows($result) > 0) {
        $inserted = pg_fetch_assoc($result);
    } else {
        $inserted = ["error" => "L'insertion du parfum a échoué."];
    }

    pg_free_result($result);
    pg_close($conn);
    return $inserted;
}

function updateParfum(array $parfum): array {
    $conn = connexion();
    $sql = "UPDATE G09_Parfum 
            SET parfum_type = $1, parfum_nom = $2, parfum_description = $3, parfum_marque = $4 
            WHERE parfum_id = $5";
    
    $result = pg_prepare($conn, "update_parfum", $sql);
    $result = pg_execute($conn, "update_parfum", array(
        $parfum['parfum_type'], 
        $parfum['parfum_nom'], 
        $parfum['parfum_description'], 
        $parfum['parfum_marque'], 
        $parfum['parfum_id']
    ));

    if ($result) {
        return getParfumById($parfum['parfum_id']);
    } else {
        return ["error" => "La mise à jour du parfum a échoué"];
    }
}
//Suppression (ordre : stock → flacon → parfum)
function deleteParfum($parfum_id): void {
    $conn = connexion();

    //Vérifier si le parfum existe
    $sqlCheck = "SELECT 1 FROM G09_Parfum WHERE parfum_id = $1";
    $resCheck = pg_prepare($conn, "check_parfum", $sqlCheck);
    $resCheck = pg_execute($conn, "check_parfum", [$parfum_id]);

    if (!$resCheck || pg_num_rows($resCheck) === 0) {
        echo "<p style='color:red'>Le parfum avec l'ID $parfum_id n'existe pas.</p>";
        pg_close($conn);
        return;
    }

    //Supprimer les stocks liés aux flacons de ce parfum
    $sqlStock = "DELETE FROM G09_Stock WHERE flacon_id IN (
        SELECT flacon_id FROM G09_Flacon WHERE parfum_id = $1
    )";
    pg_prepare($conn, "delete_parfum_stock", $sqlStock);
    pg_execute($conn, "delete_parfum_stock", [$parfum_id]);

    // Supprimer les flacons liés à ce parfum 
    $sqlFlacon = "DELETE FROM G09_Flacon WHERE parfum_id = $1";
    pg_prepare($conn, "delete_parfum_flacons", $sqlFlacon);
    pg_execute($conn, "delete_parfum_flacons", [$parfum_id]);

    //Supprimer le parfum lui-même
    $sqlParfum = "DELETE FROM G09_Parfum WHERE parfum_id = $1";
    pg_prepare($conn, "delete_parfum", $sqlParfum);
    $resultParfum = pg_execute($conn, "delete_parfum", [$parfum_id]);

    if ($resultParfum) {
        echo "<p style='color:green'>Parfum ID $parfum_id et ses dépendances ont été supprimés avec succès.</p>";
    } else {
        echo "<p style='color:red'>Erreur lors de la suppression du parfum.</p>";
    }

    pg_close($conn);
}

?>
