
<?php
class connection{
    private static $instance = null;
    private $host = "localhost";
    private $user = "root";
    private $pass = "";
    private $db   = "vintagestore";
    private $pdo;
   
    public function __construct(){
        $this->connect();
    }

    public static function getInstance(){
        if (self::$instance === null){
            self::$instance = new self();
        }
        return self::$instance;
    }

    private function connect() {
        try {
            $this->pdo = new PDO(
                "mysql:host={$this->host};dbname={$this->db}",
                $this->user,
                $this->pass,
                [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION]
            );
        } catch (PDOException $e) {
            echo 'Conexión fallida: ', $e->getMessage();
            exit; 
        }
    }
    public function getPDO() {
        return $this->pdo;
    }
}

?>


