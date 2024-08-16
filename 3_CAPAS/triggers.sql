CREATE TABLE auditoria_usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT,
    nombre VARCHAR(255),
    cedula VARCHAR(20),
    ciudad VARCHAR(255),
    email VARCHAR(255),
    contrasena VARCHAR(255),
    rol VARCHAR(50),
    fecha_modificacion DATE,
    tipo_cambio char(01)
);

DELIMITER $$

CREATE TRIGGER trg_uid_insert_user
AFTER INSERT ON usuario
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_usuarios (usuario_id, accion, nombre, cedula, ciudad, email, contrasena, rol)
    VALUES (NEW.id, NEW.nombre, NEW.cedula, NEW.ciudad, NEW.email, NEW.contrasena, NEW.rol, NOW(), 'I');
END$$

DELIMITER $$

CREATE TRIGGER trg_uid_update_user
AFTER UPDATE ON usuario
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_usuarios (usuario_id,nombre, cedula, ciudad, email, contrasena, rol, fecha_modificacion, tipo_cambio)
    VALUES (NEW.id, NEW.nombre, NEW.cedula, NEW.ciudad, NEW.email, NEW.contrasena, NEW.rol, NOW(),'U');
END$$

DELIMITER $$

CREATE TRIGGER before_delete_user
BEFORE DELETE ON usuario
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_usuarios (usuario_id,nombre, cedula, ciudad, email, contrasena, rol, fecha_modificacion, tipo_cambio)
    VALUES (OLD.id, OLD.nombre, OLD.cedula, OLD.ciudad, OLD.email, OLD.contrasena, OLD.rol, NOW(), 'D');
END$$

