<?php
require_once '../Persistencia/usuarioDAO.php';  
require_once '../Persistencia/usuarioDTO.php'; 

class UsuarioLogica {
    private $usuarioDAO;

    public function __construct() {
        $this->usuarioDAO = new usuarioDAO();
    }

    private function validarContrasena($contrasena) {
        if (strlen($contrasena) < 8) {
            return false;
        }
        if (!preg_match('/\d/', $contrasena)) {
            return false;
        }
        if (!preg_match('/[\W_]/', $contrasena)) {
            return false;
        }
        return true;
    }
    
    private function validarEmail($email) {
        return filter_var($email, FILTER_VALIDATE_EMAIL) !== false;
    }

    private function validarCedula($cedula) {
        return preg_match('/^\d{10,}$/', $cedula);
    }

    

    public function crearUsuario($nombre, $cedula, $ciudad, $email, $contrasena, $rol) {

        if (!$this->validarContrasena($contrasena)) {
            throw new Exception('La contraseña debe tener al menos 8 caracteres, un número y un carácter especial');
        }
        if (!$this->validarEmail($email)) {
            throw new Exception('El email no es válido');
        }
        if (!$this->validarCedula($cedula)) {
            throw new Exception('La cédula debe tener al menos 10 dígitos');
        }
        if ($this->usuarioDAO->existeCedula($cedula)) {
            throw new Exception('La cédula ya está registrada.');
        }
        if ($this->usuarioDAO->existeEmail($email)) {
            throw new Exception('El email ya está registrado.');
        }

        $usuario = new usuarioDTO(null, $nombre, $cedula, $ciudad, $email, $contrasena, $rol);
        $this->usuarioDAO->create($usuario);
        return 'Usuario creado!!';
    }



    public function actualizarUsuario($id, $nombre, $cedula, $ciudad, $email, $contrasena, $rol) {
        if (!empty($email) && !$this->validarEmail($email)) {
            throw new Exception('El email no es válido');
        }
        
        if (!empty($cedula) && !$this->validarCedula($cedula)) {
            throw new Exception('La cédula debe tener al menos 10 dígitos');
        }
    
        if (!empty($contrasena) && !$this->validarContrasena($contrasena)) {
            throw new Exception('La contraseña debe tener al menos 8 caracteres, un número y un carácter especial');
        }
    
        $usuarioExistente = $this->usuarioDAO->getId($id);
    
        if (!$usuarioExistente) {
            throw new Exception('Usuario no encontrado');
        }
    
        $nombre = !empty($nombre) ? $nombre : $usuarioExistente->getNombre();
        $cedula = !empty($cedula) ? $cedula : $usuarioExistente->getCedula();
        $ciudad = !empty($ciudad) ? $ciudad : $usuarioExistente->getCiudad();
        $email = !empty($email) ? $email : $usuarioExistente->getEmail();
        $contrasena = !empty($contrasena) ? $contrasena : $usuarioExistente->getContrasena();
        $rol = !empty($rol) ? $rol : $usuarioExistente->getRol();
    
        $usuario = new UsuarioDTO($id, $nombre, $cedula, $ciudad, $email, $contrasena, $rol);
        $this->usuarioDAO->update($usuario);
    
        return 'Usuario actualizado con éxito!';
    }
    
    
    public function eliminarUsuario($id) {
        $this->usuarioDAO->delete($id);
    }

    public function mostrarUsuarios() {
        return $this->usuarioDAO->show();
    }
}
?>
