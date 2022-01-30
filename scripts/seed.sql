\copy tasks(id, description, done) 
    FROM '../data.csv' DELIMITER '|' CSV HEADER;
