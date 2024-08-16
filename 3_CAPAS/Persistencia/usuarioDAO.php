<?php
 
require_once 'usuarioDTO.php';
require_once 'conexion.php';

class UsuarioDAO {  
    private $conn;

    public function __construct() {
        $this->conn = connection::getInstance()->getPDO();
    }

    public function existeCedula($cedula) {
        $sql = "SELECT COUNT(*) FROM usuario WHERE cedula = :cedula";
        $stmt = $this->conn->prepare($sql);
        $stmt->bindParam(':cedula', $cedula);
        $stmt->execute();
        return $stmt->fetchColumn() > 0;
    }

    public function existeEmail($email) {
        $sql = "SELECT COUNT(*) FROM usuario WHERE email = :email";
        $stmt = $this->conn->prepare($sql);
        $stmt->bindParam(':email', $email);
        $stmt->execute();
        return $stmt->fetchColumn() > 0;
    }
    
    public function getId($id) {
        $sql = "SELECT * FROM usuario WHERE id = :id";
        $stmt = $this->conn->prepare($sql);
        $stmt->bindParam(':id', $id);
        $stmt->execute();
        $row = $stmt->fetch(PDO::FETCH_ASSOC);

        if ($row) {
            return new UsuarioDTO(
                $row['id'],
                $row['nombre'],
                $row['cedula'],
                $row['ciudad'],
                $row['email'],
                $row['contrasena'],
                $row['rol']
            );
        } else {
            return null;
        }
    }
    public function create(UsuarioDTO $usuario) {
        $sql = "INSERT INTO usuario (nombre, cedula, ciudad, email, contrasena, rol) VALUES (:nombre, :cedula, :ciudad, :email, :contrasena, :rol)";
        $stmt = $this->conn->prepare($sql);
        
        $nombre = $usuario->getNombre();
        $cedula = $usuario->getCedula();
        $ciudad = $usuario->getCiudad();
        $email = $usuario->getEmail();
        $contrasena = $usuario->getContrasena();
        $rol = $usuario->getRol();

        $stmt->bindParam(':nombre', $nombre);
        $stmt->bindParam(':cedula', $cedula);
        $stmt->bindParam(':ciudad', $ciudad);
        $stmt->bindParam(':email', $email);
        $stmt->bindParam(':contrasena', $contrasena);
        $stmt->bindParam(':rol', $rol);

        $stmt->execute();
        
    }

    public function update(UsuarioDTO $usuario) {

        $id = $usuario->getId();
        $nombre = $usuario->getNombre();
        $cedula = $usuario->getCedula();
        $ciudad = $usuario->getCiudad();
        $email = $usuario->getEmail();
        $contrasena = $usuario->getContrasena();
        $rol = $usuario->getRol();
    
        $sql = "UPDATE usuario SET ";
        $params = [];
    
        if ($nombre !== null) {
            $sql .= "nombre = :nombre, ";
            $params[':nombre'] = $nombre;
        }
        if ($cedula !== null) {
            $sql .= "cedula = :cedula, ";
            $params[':cedula'] = $cedula;
        }
        if ($ciudad !== null) {
            $sql .= "ciudad = :ciudad, ";
            $params[':ciudad'] = $ciudad;
        }
        if ($email !== null) {
            $sql .= "email = :email, ";
            $params[':email'] = $email;
        }
        if ($contrasena !== null) {
            $sql .= "contrasena = :contrasena, ";
            $params[':contrasena'] = $contrasena;
        }
        if ($rol !== null) {
            $sql .= "rol = :rol, ";
            $params[':rol'] = $rol;
        }
    
        $sql = rtrim($sql, ", ");
        
        $sql .= " WHERE id = :id";
        $params[':id'] = $id;
    
        $stmt = $this->conn->prepare($sql);
        $stmt->execute($params);
    }
    

    public function delete($id) {
        $sql = "DELETE FROM usuario WHERE id = :id";
        $stmt = $this->conn->prepare($sql);
        $stmt->bindParam(':id', $id);
        $stmt->execute();
    }

    public function show() {
        $sql = "SELECT * FROM usuario";
        $stmt = $this->conn->query($sql);
        $usuario = [];
        while ($row = $stmt->fetch()) {
            $usuario[] = new UsuarioDTO($row['id'], $row['nombre'], $row['cedula'], $row['ciudad'], $row['email'], $row['contrasena'], $row['rol']);
        }
        return $usuario;
    }



}

?>
 