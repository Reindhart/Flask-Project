# Yeeeeeeet
Yeeeeeeet




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
