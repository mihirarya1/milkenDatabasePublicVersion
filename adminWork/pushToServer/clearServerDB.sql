-- Script to compelteley wipe all tables from the remote UCLA server database 'music'
SET FOREIGN_KEY_CHECKS = 0; -- Fine to temporarily turn these off so we don't run into issues when wiping db
SET @tables = NULL;
SELECT GROUP_CONCAT('`', table_schema, '`.`', table_name, '`') INTO @tables
  FROM information_schema.tables 
  WHERE table_schema = 'music'; -- specify DB name here. -- Read into tables variable all the table names in db 'music'

SET @tables = CONCAT('DROP TABLE ', @tables); -- Create prepared statements to delete each of the tables in 'music'
PREPARE stmt FROM @tables;
EXECUTE stmt; -- Execute prepared statement to drop table at hand
DEALLOCATE PREPARE stmt;
SET FOREIGN_KEY_CHECKS = 1; -- Turn on foreign key checking again
