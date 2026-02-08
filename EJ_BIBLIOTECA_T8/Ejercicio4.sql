CREATE DEFINER=`root`@`localhost` PROCEDURE `Ejercicio_4`(IN p_codlibro INT, OUT v_resultado INT)
BEGIN
	DECLARE v_existe INT;
    DECLARE v_fecha_prestamo DATE;
    DECLARE v_resultado INT;

    -- 1. Verificar si el libro existe
    SELECT COUNT(*) INTO v_existe 
    FROM LIBROS 
    WHERE CODLIBRO = p_codlibro;

    IF v_existe = 0 THEN
        SET v_resultado = -1;
    ELSE
        -- 2. Verificar si está prestado (buscamos la fecha en la tabla PRESTAMOS)
        SELECT FPRESTA INTO v_fecha_prestamo 
        FROM PRESTAMOS 
        WHERE CODLIBRO = p_codlibro 
        LIMIT 1;

        IF v_fecha_prestamo IS NOT NULL THEN
            -- 3. Si está prestado, calculamos los días transcurridos hasta hoy
            SET v_resultado = DATEDIFF(CURDATE(), v_fecha_prestamo);
        ELSE
            -- 4. Si existe pero no está en PRESTAMOS, está en la biblioteca
            SET v_resultado = 0;
        END IF;
    END IF;
END