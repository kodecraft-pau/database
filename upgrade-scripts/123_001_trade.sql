-- Start a transaction explicitly
BEGIN;

-- SQL statements to be executed within the transaction
CREATE TABLE test_table (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50)
);

INSERT INTO public.upgrade_script (name, description) values('123_001_test_table.sql', 'Created test_table');

-- If everything is as expected, commit the transaction
COMMIT;