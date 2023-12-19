-- Crear la base de datos principal
CREATE DATABASE IF NOT EXISTS main_database;

USE main_database;

CREATE TABLE IF NOT EXISTS example_table (
    id INT AUTO_INCREMENT PRIMARY KEY,
    data VARCHAR(255) NOT NULL
);

-- Cambiar el delimitador para el procedimiento almacenado
DELIMITER $$

CREATE PROCEDURE CreateUserDatabaseAndPermissions(IN user_prefix VARCHAR(255))
BEGIN
    DECLARE i INT DEFAULT 1;

    WHILE i <= 20 DO
        SET @db_name = CONCAT(user_prefix, '_', i);
        SET @username = CONCAT(user_prefix, '_', i);

        -- Crear base de datos para el usuario
        SET @query = CONCAT('CREATE DATABASE IF NOT EXISTS ', @db_name);
        PREPARE stmt FROM @query;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;

        -- Crear usuario
        SET @query = CONCAT('CREATE USER IF NOT EXISTS ''', @username, '''@''%'' IDENTIFIED BY ''password''');
        PREPARE stmt FROM @query;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;

        -- Dar permisos sobre la base de datos al usuario
        SET @query = CONCAT('GRANT ALL PRIVILEGES ON ', @db_name, '.* TO ''', @username, '''@''%''');
        PREPARE stmt FROM @query;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;

        SET i = i + 1;
    END WHILE;
END $$

-- Restaurar el delimitador predeterminado
DELIMITER ;

CALL CreateUserDatabaseAndPermissions('user');
