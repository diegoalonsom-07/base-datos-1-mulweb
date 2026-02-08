CREATE PROCEDURE `CONSULTA_LIBRO`(p_codlibro INT)
BEGIN
    DECLARE v_titulo VARCHAR(30);
    DECLARE v_nomlector VARCHAR(45);

    -- 1. Intentamos obtener el título del libro
    SELECT TITULO INTO v_titulo
    FROM LIBROS
    WHERE CODLIBRO = p_codlibro;

    -- 2. Comprobamos si se encontró el libro (si no, v_titulo será NULL)
    IF v_titulo IS NULL THEN
        SELECT 'El libro no existe' AS MENSAJE;
    ELSE
        -- 3. Buscamos si hay un lector que lo tenga actualmente.
        -- Usamos SET para evitar errores si la consulta devuelve vacío (libro disponible)
        SET v_nomlector = (
            SELECT L.NOMLECTOR
            FROM PRESTAMOS P
            JOIN LECTORES L ON P.NUMLECTOR = L.NUMLECTOR
            WHERE P.CODLIBRO = p_codlibro
              -- Condición: Que ese préstamo NO esté en la tabla de devoluciones
              AND (P.CODLIBRO, P.NUMLECTOR, P.FPRESTA) NOT IN (
                  SELECT CODLIBRO, NUMLECTOR, FPRESTA FROM DEVOLUCIONES
              )
            LIMIT 1
        );

        -- 4. Mostramos el mensaje según el resultado
        IF v_nomlector IS NOT NULL THEN
            SELECT CONCAT('Libro: ', v_titulo, ' | Prestado a: ', v_nomlector) AS ESTADO;
        ELSE
            SELECT CONCAT('Libro: ', v_titulo, ' | Disponible en biblioteca') AS ESTADO;
        END IF;
    END IF;
END //
