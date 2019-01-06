-- Requirements:
-- It should be possible to add entries to every table individually
-- and every table should be used in at least one select query.
-- For the select queries, it is fine to just display the content of the tables,
-- but your website needs to also have the ability to search using text
-- or filter using a dynamically populated list of properties to filter on.
-- This search/filter functionality should be present for at least one entity.
-- It is generally not appropriate to have only a single query that joins all tables and displays them.

-- You also need to include one delete and one update function in your website, for any of the entities.
-- In addition, it should be possible to add and remove things from at least one many-to-many relationship
-- and it should be possible to add things to all relationships.

-- In a many-to-one relationship like bsg_people to bsg_planets,
-- it means that you should be able to set the homeworld value to NULL on a person in bsg_people.
-- That removes the relationship.

-- It is a little more interesting in a many-to-many relationship because one would need to delete a row from a table.
-- That would be the case with bsg_people and bsg_certifications.
-- One should be able to add and remove certifications for a person without deleting either bsg_people rows
-- or bsg_certification rows.

-- ----------------------------------------------------------------------------------------------------------
-- Database Manipulation Queries:

/*Add Character*/
INSERT INTO shadowrun_characters (name, leader, race_id, faction_id, weapon_id, magic_id, tech_id)
VALUES ([nameInput], [leaderBool], [race_id_dropdown], [faction_id_dropdown], [weapon_id_dropdown], [magic_id_dropdown], [tech_id_dropdown]);

/*Add Race*/
INSERT INTO shadowrun_race (raceName, special_ability, essence, health)
VALUES ([raceNameInput], [specialAbilityInput], [essenceInput], [healthInput]);

/*Add Faction*/
INSERT INTO shadowrun_factions (factionName, leader_id)
VALUES ([factionNameInput], [character_id_from_dropdown_input]);

/*Add Weapon*/
INSERT INTO shadowrun_weapons (weaponName, damage)
VALUES ([weaponNameInput], [damageInput]);

/*Add Tech*/
INSERT INTO shadowrun_tech (techName, essence_possession)
VALUES ([techNameInput], [essencePossessionInput]);

/*Add Magic*/
INSERT INTO shadowrun_magic (magicName, essence_usage)
VALUES ([magicNameInput], [essenceUsageInput]);



/*Get all character's information*/
SELECT id, name, race_id, faction_id, weapon_id, magic_id, tech_id  FROM shadowrun_characters;

/*Get all character's information with their race name, faction name, weapons, magic and tech*/
SELECT C.id, C.name AS Name, R.raceName AS Race, F.factionName AS Faction, W.weaponName AS Weapon, T.techName AS Tech, M.magicName AS Magic
FROM shadowrun_characters C
INNER JOIN shadowrun_race R ON R.id = C.race_id
INNER JOIN shadowrun_factions F ON F.id=C.faction_id
INNER JOIN shadowrun_weapons W ON W.id=C.weapon_id
INNER JOIN shadowrun_tech T ON T.id=C.tech_id
INNER JOIN shadowrun_magic M ON M.id=C.magic_id
ORDER BY Name;


/*Get single character's data for Update form*/
SELECT id, name, leader, race_id, faction_id, weapon_id, magic_id, tech_id
FROM shadowrun_characters
WHERE id = [character_id_from_browse_page];

/*Get single Race's data for Update form*/
SELECT raceName, special_ability, essence, healthInput
FROM shadowrun_race
WHERE id=[race_id_from_browse_page];

/*Get single Faction's data from Update form*/
SELECT factionName, leader_id
FROM shadowrun_factions
WHERE id=[faction_id_from_browse_page];

/*Get a single Weapon's data from Update form*/
SELECT weaponName, damage
FROM shadowrun_weapons
WHERE id=[weapon_id_from_browse_page]

/*Get a single Tech's data from Update form*/
SELECT techName, essence_possession
FROM shadowrun_tech
WHERE id=[tech_id_from_browse_page]

/*Get a single Magic's data from Update form*/
SELECT magicName, essence_usage
FROM shadowrun_magic
WHERE id=[magic_id_from_browse_page]




/*Update Character*/
UPDATE shadowrun_characters SET name = [nameInput], leader = [leaderInput], race_id = [raceInput] , faction_id = [factionInput], weapon_id = [weaponInput], magic_id = [magicInput], tech_id = [techInput];
WHERE id=[character_id_update_form];

/*Update Race*/
UPDATE shadowrun_race SET raceName = [raceNameInput], special_ability = [specialAbilityInput], essence = [essenceInput], health = [healthInput]
WHERE id = [race_id_update_form];

/*Update Faction*/
UPDATE shadowrun_factions SET factionName=[factionNameInput], leader_id=[character_id_from_browse_page]
WHERE id=[faction_id_from_update_form];

/*Update Weapon*/
UPDATE shadowrun_weapons SET weaponName=[weaponNameInput], damage=[damageInput]
WHERE id=[weapon_id_from_update_form];

/*Update Tech*/
UPDATE shadowrun_tech SET techName=[techNameInput], essence_possession=[essencePossessionInput]
WHERE id=[tech_id_from_update_form];

/*Update Mage*/
UPDATE shadowrun_magic SET magicName=[magicNameInput], essence_usage=[essenceUsageInput]
WHERE id=[magic_id_from_update_form];


/*Delete Character*/
DELETE FROM shadowrun_characters WHERE id=[character_id_from_browse_page];
/*Delete Race*/
DELETE FROM shadowrun_race WHERE id=[race_id_from_browse_page];
/*Delete Faction*/
DELETE FROM shadowrun_factions WHERE id=[faction_id_from_browse_page];
/*Delete Weapon*/
DELETE FROM shadowrun_weapons WHERE id=[weapon_id_from_browse_page];
/*Delete Tech*/
DELETE FROM shadowrun_tech WHERE id=[tech_id_from_browse_page];
/*Delete Magic*/
DELETE FROM shadowrun_magic WHERE id=[magic_id_from_browse_page];
