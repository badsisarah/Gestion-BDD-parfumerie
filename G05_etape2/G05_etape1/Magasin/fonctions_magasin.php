<?php
require_once '../config/MonEnv.php';

function connexion() {
    $dbHost = $_ENV['dbHost'];
    $dbName = $_ENV['dbName'];
    $dbUser = $_ENV['dbUser'];
    $dbPassword = $_ENV['dbPasswd'];
    $strConnex = "host=$dbHost dbname=$dbName user=$dbUser password=$dbPassword";
    $ptrDB = pg_connect($strConnex);

    if (!$ptrDB) {
        die('<h1>Erreur de connexion à la base</h1>');
    }
    return $ptrDB;
}

function getMagById(int $mag_id): array {
    $conn = connexion();
    $sql = "SELECT * FROM G09_magasin WHERE mag_id = $1";
    pg_prepare($conn, "get_magasin_by_id", $sql);
    $result = pg_execute($conn, "get_magasin_by_id", [$mag_id]);

    if ($result && pg_num_rows($result) > 0) {
        $mag = pg_fetch_assoc($result);
    } else {
        $mag = ["error" => "Magasin non trouvé avec l'ID $mag_id"];
    }

    pg_free_result($result);
    pg_close($conn);
    return $mag;
}

function getAllMag(): array {
    $conn = connexion();
    $sql = "SELECT * FROM G09_magasin ORDER BY mag_id";
    pg_prepare($conn, "get_all_mag", $sql);
    $result = pg_execute($conn, "get_all_mag", []);

    $magasins = [];

       while ($row = pg_fetch_assoc($result)) {
        $magasins[] = $row;
        
    }
    
    pg_free_result($result);
    pg_close($conn);
    return $magasins;
}

function insertMag(array $mag): array {
    $conn = connexion();
    $sql = "INSERT INTO g09_magasin (mag_nom, mag_adresse, mag_telephone, mag_ville, mag_email)
            VALUES ($1, $2, $3, $4, $5) RETURNING *";
    pg_prepare($conn, "insert_mag", $sql);
    $result = pg_execute($conn, "insert_mag", [
        $mag['mag_nom'],
        $mag['mag_adresse'],
        $mag['mag_telephone'],
        $mag['mag_ville'],
        $mag['mag_email']
    ]);

    $res = ($result && pg_num_rows($result) > 0)
        ? pg_fetch_assoc($result)
        : ["error" => "L'insertion du magasin a échoué."];

    pg_close($conn);
    return $res;
}

function updateMag(array $mag): array {
    $conn = connexion();
    $sql = "UPDATE G09_magasin 
            SET mag_nom = $1, mag_adresse = $2, mag_telephone = $3, mag_ville = $4, mag_email = $5 
            WHERE mag_id = $6 RETURNING *";
    pg_prepare($conn, "update_mag", $sql);
    $result = pg_execute($conn, "update_mag", [
        $mag['mag_nom'],
        $mag['mag_adresse'],
        $mag['mag_telephone'],
        $mag['mag_ville'],
        $mag['mag_email'],
        $mag['mag_id']
    ]);

    return ($result && pg_num_rows($result) > 0)
        ? pg_fetch_assoc($result)
        : ["error" => "La mise à jour du magasin a échoué."];
}

function deleteMag(int $mag_id): void {
    $conn = connexion();

    //Vérifier si le magasin existe
    $sqlCheck = "SELECT 1 FROM G09_magasin WHERE mag_id = $1";
    pg_prepare($conn, "check_mag", $sqlCheck);
    $resCheck = pg_execute($conn, "check_mag", [$mag_id]);

    if (!$resCheck || pg_num_rows($resCheck) === 0) {
        echo "<p style='color:red'>Le magasin avec l'ID $mag_id n'existe pas.</p>";
        pg_close($conn);
        return;
    }

    //Supprimer les stocks liés à ce magasin
    $sqlStock = "DELETE FROM G09_stock WHERE mag_id = $1";
    pg_prepare($conn, "delete_mag_stock", $sqlStock);
    pg_execute($conn, "delete_mag_stock", [$mag_id]);

    //Supprimer le magasin
    $sql = "DELETE FROM G09_magasin WHERE mag_id = $1";
    pg_prepare($conn, "delete_mag", $sql);
    $result = pg_execute($conn, "delete_mag", [$mag_id]);

    if ($result) {
        echo "<p style='color:green'>Magasin ID $mag_id supprimé avec succès (et les stocks liés également).</p>";
    } else {
        echo "<p style='color:red'>Échec de la suppression du magasin ID $mag_id.</p>";
    }

    pg_close($conn);
}

?>
