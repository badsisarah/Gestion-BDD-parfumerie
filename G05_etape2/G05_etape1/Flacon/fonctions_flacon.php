<?php
require_once '../config/MonEnv.php';

/* Fonction de connexion à la base de données*/
function connexion() {
    /*Utiliser directement les variables d'environnement définies dans $_ENV*/
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

/*Fonction pour récupérer un flacon par son ID*/
function getFlaconById(int $flacon_id): array {
    $conn = connexion();
    $sql = "SELECT * FROM g09_flacon WHERE flacon_id = $1";
    pg_prepare($conn, "get_flacon_by_id", $sql);
    $result = pg_execute($conn, "get_flacon_by_id", [$flacon_id]);

 /*Vérification si un flacon a été trouvé*/
    if ($result && pg_num_rows($result) > 0) {
        $flacon = pg_fetch_assoc($result);
    } else {
        $flacon = ["error" => "Flacon non trouvé avec l'ID $flacon_id"];
    }

    pg_free_result($result);
    pg_close($conn);
    return $flacon;
}

/*Fonction pour récupérer tous les flacons*/
function getAllFlacon(): array {
    $conn = connexion();
    $sql = "SELECT * FROM g09_flacon ORDER BY flacon_id";
    pg_prepare($conn, "get_all_flacons", $sql);
    $result = pg_execute($conn, "get_all_flacons", []);

    /*Tableau pour stocker tous les flacons récupérés*/
    $flacons = [];
    while ($row = pg_fetch_assoc($result)) {
        $flacons[] = $row;
    }

    pg_free_result($result);
    pg_close($conn);
    return $flacons;
}

/*Fonction pour insérer un flacon dans la base de données*/
function insertFlacon(array $flacon): array {
    $conn = connexion();

    /*Vérifier que le parfum référencé existe avant l'insertion du flacon*/
    $checkParfum = pg_prepare($conn, "check_parfum", "SELECT * FROM g09_parfum WHERE parfum_id = $1");
    $resCheck = pg_execute($conn, "check_parfum", [$flacon['parfum_id']]);
    if (pg_num_rows($resCheck) === 0) {
        return ["error" => "Le parfum avec l'ID " . $flacon['parfum_id'] . " n'existe pas."];
    }

    $sql = "INSERT INTO g09_flacon (flacon_volume, flacon_prix, parfum_id)
            VALUES ($1, $2, $3) RETURNING *";
    pg_prepare($conn, "insert_flacon", $sql);
    $result = pg_execute($conn, "insert_flacon", [
        $flacon['flacon_volume'],
        $flacon['flacon_prix'],
        $flacon['parfum_id']
    ]);

    /*Vérification si l'insertion a réussi*/
    $res = ($result && pg_num_rows($result) > 0)
        ? pg_fetch_assoc($result)
        : ["error" => "L'insertion du flacon a échoué."];

    pg_close($conn);
    return $res;
}

/*Fonction pour mettre à jour un flacon existant*/
function updateFlacon(array $flacon): array {
    $conn = connexion();
    $sql = "UPDATE g09_flacon SET flacon_volume = $1, flacon_prix = $2 WHERE flacon_id = $3 RETURNING *";
    pg_prepare($conn, "update_flacon", $sql);
    $result = pg_execute($conn, "update_flacon", [
        $flacon['flacon_volume'],
        $flacon['flacon_prix'],
        $flacon['flacon_id']
    ]);
    
    /*Vérification si la mise à jour a réussi*/
    $res = ($result && pg_num_rows($result) > 0)
        ? pg_fetch_assoc($result)
        : ["error" => "La mise à jour du flacon a échoué."];

    pg_close($conn);
    return $res;
}

/*Fonction pour supprimer un flacon de la base de données*/
function deleteFlacon(int $flacon_id): void {
    $conn = connexion();

    /*Vérifier si le flacon existe*/
    $sqlCheck = "SELECT 1 FROM G09_flacon WHERE flacon_id = $1";
    pg_prepare($conn, "check_flacon", $sqlCheck);
    $resCheck = pg_execute($conn, "check_flacon", [$flacon_id]);

    if (!$resCheck || pg_num_rows($resCheck) === 0) {
        echo "<p style='color:red'>Le flacon avec l'ID $flacon_id n'existe pas.</p>";
        pg_close($conn);
        return;
    }

    /*Supprimer les stocks liés à ce flacon*/
    $sqlStock = "DELETE FROM G09_stock WHERE flacon_id = $1";
    pg_prepare($conn, "delete_stock_flacon", $sqlStock);
    pg_execute($conn, "delete_stock_flacon", [$flacon_id]);

    /*Supprimer le flacon lui-même*/
    $sql = "DELETE FROM G09_flacon WHERE flacon_id = $1";
    pg_prepare($conn, "delete_flacon", $sql);
    $result = pg_execute($conn, "delete_flacon", [$flacon_id]);

    if ($result) {
        echo "<p style='color:green'>Flacon ID $flacon_id supprimé avec succès (et stocks associés aussi).</p>";
    } else {
        echo "<p style='color:red'>Échec de la suppression du flacon ID $flacon_id.</p>";
    }

    pg_close($conn);
}

?>
