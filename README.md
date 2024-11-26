# Yeeeeeeet

TRIGGERS


CREATE TRIGGER evitar_precio_negativo
BEFORE INSERT ON producto
FOR EACH ROW
BEGIN
    IF NEW.precio < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El precio no puede ser negativo';
    END IF;
END $$


CREATE TRIGGER evitar_existencia_negativo
BEFORE INSERT ON producto
FOR EACH ROW
BEGIN
    IF NEW.existencia < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La existencia no puede ser negativo';
    END IF;
END $$


DELIMITER //

CREATE TRIGGER validar_existencia_venta
BEFORE INSERT ON detalle_f_venta
FOR EACH ROW
BEGIN
    DECLARE existencia_actual INT;
    
    -- Obtener la existencia actual del producto
    SELECT existencia INTO existencia_actual
    FROM producto
    WHERE id_p = NEW.FK_Producto;
    
    -- Validar que haya suficiente existencia
    IF existencia_actual < NEW.Cantidad THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No hay suficiente inventario para realizar la venta.';
    END IF;
END;
//

DELIMITER ;


DELIMITER //

CREATE TRIGGER actualizar_existencia_compra
AFTER INSERT ON detalle_f_compra
FOR EACH ROW
BEGIN
    UPDATE producto
    SET existencia = existencia + NEW.Cantidad
    WHERE id_p = NEW.FK_Producto;
END;
//

DELIMITER ;


DELIMITER //

CREATE TRIGGER actualizar_existencia_venta
AFTER INSERT ON detalle_f_venta
FOR EACH ROW
BEGIN
    UPDATE producto
    SET existencia = existencia - NEW.Cantidad
    WHERE id_p = NEW.FK_Producto;
END;
//

DELIMITER ;