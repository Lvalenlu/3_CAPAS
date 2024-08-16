<?php
require_once '../Logica/logica.php';

$logica = new UsuarioLogica();

try {
    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        if (isset($_POST['create'])) {
            $logica->crearUsuario($_POST['nombre'], $_POST['cedula'], $_POST['ciudad'], $_POST['email'], $_POST['contrasena'], $_POST['rol']);
        } elseif (isset($_POST['update'])) {
            $logica->actualizarUsuario($_POST['id'], $_POST['nombre'], $_POST['cedula'], $_POST['ciudad'], $_POST['email'], $_POST['contrasena'], $_POST['rol']);
        } elseif (isset($_POST['delete'])) {
            $logica->eliminarUsuario($_POST['id']);
        }
    }
} catch (Exception $e) {
    echo '<p>Error: ' . htmlspecialchars($e->getMessage()) . '</p>';
}

$usuarios = $logica->mostrarUsuarios();
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="style.css">
    <title>Gestión de Clientes</title>
</head>
<body>
    <div class="forms">
        <form method="POST">
            <h1>Crear Cliente</h1>
            <input type="text" name="nombre" placeholder="Nombres y apellidos" required>
            <input type="number" name="cedula" placeholder="Cédula" required>
            <input type="text" name="ciudad" placeholder="Ciudad" required>
            <input type="email" name="email" placeholder="Email" required>
            <input type="password" name="contrasena" placeholder="Contraseña" required>
            <div class="selectForm">
            <label for="rol" class="form-label">Rol</label>
                <select class="form-select" id="rol" name="rol" style="width: 100%; padding: 10px; font-size: 14px; border: 1px solid #ccc; border-radius: 5px; background-color: #fff; margin-top:10px">
                    <option value="" disabled selected>Selecciona un rol</option>
                    <option value="1">Usuario Estandar</option>
                    <option value="2">Administrador</option>
                </select>
            </div>
            
            <button type="submit" name="create">Crear Cliente</button>
        </form>

        <form method="POST">
            <h1>Modificar Cliente</h1>
            <input type="number" name="id" placeholder="ID del usuario que desea modificar" required>
            <input type="text" name="nombre" placeholder="Nombres y apellidos" >
            <input type="number" name="cedula" placeholder="Cédula" >
            <input type="text" name="ciudad" placeholder="Ciudad" >
            <input type="email" name="email" placeholder="Email" >
            <input type="password" name="contrasena" placeholder="Contraseña" >
            <div class="selectForm">
            <label for="rol" class="form-label">Rol</label>
                <select class="form-select" id="rol" name="rol" style="width: 100%; padding: 10px; font-size: 14px; border: 1px solid #ccc; border-radius: 5px; background-color: #fff; margin-top:10px">
                    <option value="">Selecciona un rol</option>
                    <option value="1">Usuario Estandar</option>
                    <option value="2">Administrador</option>
                </select>
            </div>
            <button type="submit" name="update">Modificar Cliente</button>
        </form>

        <form method="POST">
            <h1>Eliminar Cliente</h1>
            <input type="number" name="id" placeholder="ID del usuario que desea eliminar" required>
            <button type="submit" name="delete">Eliminar Cliente</button>
        </form>
    </div>
    
    <h1>Lista de Clientes</h1>

    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Nombre</th>
                <th>Cédula</th>
                <th>Ciudad</th>
                <th>Email</th>
                <th>Rol</th>
            </tr>
        </thead>
        <tbody>
            <?php foreach ($usuarios as $usuario): ?>
                <tr>
                    <td><?php echo htmlspecialchars($usuario->getId()); ?></td>
                    <td><?php echo htmlspecialchars($usuario->getNombre()); ?></td>
                    <td><?php echo htmlspecialchars($usuario->getCedula()); ?></td>
                    <td><?php echo htmlspecialchars($usuario->getCiudad()); ?></td>
                    <td><?php echo htmlspecialchars($usuario->getEmail()); ?></td>
                    <td><?php echo htmlspecialchars($usuario->getRol()); ?></td>
                </tr>
            <?php endforeach; ?>
        </tbody>
    </table>
</body>
</html>
