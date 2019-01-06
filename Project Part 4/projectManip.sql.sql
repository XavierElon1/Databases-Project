-- SELECT queries for each entity and relationship.
SELECT * FROM `characters`;
SELECT * FROM `devil_fruit`;
SELECT * FROM `crew`;
SELECT * FROM `arc`;
SELECT * FROM `characters_devil_fruit`;
SELECT * FROM `crew_characters`;
SELECT * FROM `crew_devil_fruit`;

-- Search queries that will take a user inputed name and return the corresponding character's data.
SELECT `ID`, `name` FROM `characters` WHERE `name` LIKE [character name];


-- Insert queries for each entity as well as each many-to-many relationship table.
INSERT INTO `characters`(name, arc_id, bounty) values([name], [arc name], [bounty]);
INSERT INTO `devil_fruit`(arc_id, category, ability) values((SELECT arc_id FROM arc WHERE name = [arc name]),[category], [ability]);
INSERT INTO `crew`(name, leader_id, population, alignment, ship, arc_id) values([crew name], 
(SELECT leader_id FROM characters WHERE name = [leader name]), [population number], [alignment], [ship name], (SELECT arc_id FROM arc WHERE name = [arc name]));
INSERT INTO `arc`(name, enemy_id) values([arc name], (SELECT enemy_id FROM characters WHERE name = [character name]));
INSERT INTO `characters_devil_fruit`(character_id, devil_fruit_id) values((SELECT character_id FROM characters WHERE name = [user name]), (SELECT devil_fruit_id FROM devil_fruit WHERE ability = [ability]));
INSERT INTO `crew_characters`(crew_id, character_id) values((SELECT crew_id FROM crew WHERE name = [crew name]), (SELECT character_id FROM characters WHERE name = [character name]));
INSERT INTO `crew_devil_fruit`(crew_id, devil_fruit_id) values((SELECT crew_id FROM crew WHERE name = [crew name]), (SELECT devil_fruit_id FROM devil_fruit WHERE ability = [ability]));

-- Delete queries for each table.
DELETE FROM `characters` WHERE `name` = [character name];
DELETE FROM `devil_fruit` WHERE `ability` = [devil fruit ability];
DELETE FROM `crew` WHERE `name` = [crew name];
DELETE FROM `arc` WHERE `name` = [arc name];
DELETE FROM `crew_characters` WHERE character_id = [character id];
DELETE FROM `characters_devil_fruit` WHERE character_id = [character id];
DELETE FROM `crew_devil_fruit` WHERE devil_fruit_id = [devil fruit id];

-- Update queries for each entity and relationship.
UPDATE crew SET `name` = [crew name] WHERE `name` = [crew name];
UPDATE crew SET `leader_id` = [id of leader] WHERE `name` = [crew name];
UPDATE crew SET `population` = [population] WHERE `name` = [crew name];
UPDATE crew SET `alignment` = [alignment] WHERE `name` = [crew name];
UPDATE crew SET `ship` = [ship name] WHERE `name` = [crew name];
UPDATE crew SET `arc_id` = [arc id] WHERE `name` = [crew name];
UPDATE crew SET name = [crew name] WHERE `name` = [crew name];

UPDATE `characters` SET `name` = [character name] WHERE `name` = [character name];

UPDATE `devil_fruit` SET `ability` = [devil fruit ability] WHERE `ability` = [devil fruit ability];
UPDATE `devil_fruit` SET `category` = [devil fruit category] WHERE `ability` = [devil fruit ability];
UPDATE `devil_fruit` SET `arc_id` = [arc id] WHERE `ability` = [devil fruit ability];

UPDATE `arc` SET `name` = [arc name] WHERE `name` = [arc name];
UPDATE `arc` SET `enemy_id` = [id of enemy] WHERE `name` = [arc name];

UPDATE `characters_devil_fruit` SET `character_id` = [id of new user] WHERE `devil_fruit_id` = [id of devil fruit];
UPDATE `characters_devil_fruit` SET `devil_fruit_id` = [id of devil fruit] WHERE `character_id` = [id of new user];

UPDATE `crew_characters` SET `character_id` = [id of member] WHERE `crew_id` = [id of crew];
UPDATE `crew_characters` SET `crew_id` = [id of crew] WHERE `character_id` = [id of member];

UPDATE `crew_devil_fruit` SET `devil_fruit_id` = [id of devil fruit] WHERE `crew_id` = [id of crew];
UPDATE `crew_devil_fruit` SET `crew_id` = [id of crew] WHERE `devil_fruit_id` = [id of devil fruit];