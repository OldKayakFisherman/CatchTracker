
-- Create the schema 
DROP SCHEMA IF EXISTS catchtracker;
CREATE SCHEMA catchtracker AUTHORIZATION catchuser;

-- Safeguard, should never have to do this since we drop the schema
DROP TABLE IF EXISTS catchtracker.species;
DROP TABLE IF EXISTS catchtracker.fisheries;
DROP TABLE IF EXISTS catchtracker.users;
DROP TABLE IF EXISTS catchtracker.login_locations;
DROP TABLE IF EXISTS catchtracker.catches;



CREATE TABLE catchtracker.species
(
    id SERIAL PRIMARY KEY NOT NULL,
    species TEXT NOT NULL
);

CREATE TABLE catchtracker.fisheries
(
    id SERIAL PRIMARY KEY NOT NULL,
    location POINT NOT NULL,
    name text not null
);

CREATE TABLE catchtracker.users
(
    id SERIAL PRIMARY KEY NOT NULL,
    email TEXT NOT NULL,
    password TEXT NOT NULL,
    last_password_change TIMESTAMP,
    password_expiration TIMESTAMP NOT NULL,
    account_created TIMESTAMP not null default now(),
    account_confirmed TIMESTAMP,
    account_muted_till TIMESTAMP,
    account_disable_till TIMESTAMP
);

CREATE TABLE catchtracker.login_locations
(
    id SERIAL PRIMARY KEY NOT NULL,
    user_id INTEGER NOT NULL REFERENCES catchtracker.users(id),
    location POINT NOT NULL,
    location_timestamp TIMESTAMP NOT NULL default now()
);

CREATE TABLE catchtracker.catches
(
    id SERIAL PRIMARY KEY NOT NULL,
    user_id INTEGER REFERENCES catchtracker.users(id) NOT NULL,
    species_id INTEGER REFERENCES catchtracker.species(id) NOT NULL,
    fishery_id INTEGER REFERENCES catchtracker.fisheries(id) NOT NULL,
    location POINT NOT NULL,
    catch_date date NOT NULL,
    bait text not null,
    bait_color text,
    water_temperature decimal,
    sky_conditions text
);


ALTER TABLE catchtracker.species OWNER TO catchuser;
ALTER TABLE catchtracker.fisheries OWNER TO catchuser;
ALTER TABLE catchtracker.users OWNER TO catchuser;
ALTER TABLE catchtracker.login_locations OWNER TO catchuser;
ALTER TABLE catchtracker.catches OWNER TO catchuser;


-- Insert our data
INSERT INTO catchtracker.fisheries (location, name) values (POINT(38.759398, -77.297435), 'Burke');
INSERT INTO catchtracker.fisheries (location, name) values (POINT(38.741981, -77.387838), 'Bull Run');
INSERT INTO catchtracker.fisheries (location, name) values (POINT(38.720545, -77.334994), 'Occoquan');

INSERT INTO catchtracker.species (species) values ('Bass');
INSERT INTO catchtracker.species (species) values ('Crappie');
INSERT INTO catchtracker.species (species) values ('Catfish');
INSERT INTO catchtracker.species (species) values ('Perch');
