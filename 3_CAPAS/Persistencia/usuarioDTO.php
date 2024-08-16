
<?php
 
class usuarioDTO {
    private $id;
    private $nombre;
    private $cedula;
    private $ciudad;
    private $email;
    private $contrasena;
    private $rol;
 
 
    public function __construct($id = null, $nombre = null, $cedula = null,$ciudad = null,$email = null,$contrasena = null, $rol = null) {
        $this->id       = $id;
        $this->nombre  = $nombre;
        $this->cedula   = $cedula;
        $this->ciudad   = $ciudad;
        $this->email    = $email;
        $this->contrasena = $contrasena;
        $this->rol      = $rol;
    }
 
 
    public function getId() {
        return $this->id;}
    public function setId($id) {
        $this->id = $id;
    }
 
 
    public function getNombre() {
        return $this->nombre;
    }
    public function setNombre($nombre) {
        $this->nombre = $nombre;
    }
 
 
    public function getCedula() {
        return $this->cedula;
    }
    public function setCedula($cedula) {
        $this->cedula = $cedula;
    }
 
 
    public function getCiudad() {
        return $this->ciudad;
    }
    public function setCiudad($ciudad) {
        $this->ciudad = $ciudad;
    }
 
 
    public function getEmail() {
        return $this->email;
    }
    public function setEmail($email) {
        $this->email = $email;
    }
 
 
    public function getContrasena() {
        return $this->contrasena;
    }
    public function setContrasena($contrasena) {
        $this->contrasena = $contrasena;
    }
 
 
    public function getRol() {
        return $this->rol;
    }
    public function setRol($rol) {
        $this->rol = $rol;
    }
 
 
}
?>
 
 