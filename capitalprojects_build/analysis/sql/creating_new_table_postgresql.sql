--Creating a new table in postgresql and populating it with data
DROP TABLE IF EXISTS example_table;
CREATE TABLE example_table 
(example_field text, example_field text
);
COPY example_table FROM '/Users/path/to/example_table.csv' DELIMITER ',' CSV;