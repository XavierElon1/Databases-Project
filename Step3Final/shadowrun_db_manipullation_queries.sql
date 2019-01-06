/* Name: Xavier Hollingsworth
** Date: 7/16/18
** File name: shadowrun_db_manipulation_queries.sql
** Source(s): sample_database_manipulation_queries.sql and insert statments from the sql function in phpmyadmin
** Comments: Still have a lot of work to do on this to get it to work properly. Currently a work in progress.
*/

--Get all IDs, colors, names, goals and leader_ids to populate the Faction dropdown
SELECT id, color, name, goal, leader_id FROM shadowrun_factions

--Get all characters and their homeworld name for the List People page
SELECT shadowrun_character.character_id, name, race, special_ability, essence, leader, faction_id, shadowrun_factions.name AS faction, name FROM shadowrun_characters INNER JOIN shadowrun_factions ON faction = shadowrun_factions.faction_id

--Get a single character's data for the Update People form
SELECT id, name, race, special_ability, essence, leader, faction_id FROM shadowrun_characters WHERE id = [character_ID_selected_from_browse_character_page]

--Get all character's data to populate a dropdown for associating with a faction
SELECT id AS faction_id, name FROM shadowrun_characters
--Get all factions to populate a dropdown for associating with weapons
SELECT id AS weapon_id, name FROM shadowrun_weapons

--Get all peoople with their current associated faction to list
SELECT id, CONCAT(name,' ',faction) AS name,  weapon_id AS certificate
FROM shadowrun_characters
INNER JOIN shadowrun_cert_characters ON shadowrun_characters.character_id = shadowrun_characters.fid
INNER JOIN shadowrun_cert on shadowrun_cert.certification_id = shadowrun_cert_characters.cid
ORDER BY name, certificate

--Add a new character
INSERT INTO shadowrun_characters (name, race, special_ability, essence, leader, faction_id) VALUES ([nameInput], [raceInput], [special_abilityInput], [essenceInput], [leaderInput], [faction_id_from_dropdown_Input])

--Associate a character with a certificate (M-to-M relationship addition)
INSERT INTO shadowrun_cert_characters (pid, cid) VALUES ([character_id_from_dropdown_Input], [certification_id_from_dropdown_Input])

--Update a character's data based on submission of the Update Character form
UPDATE shadowrun_characters SET name=[nameInput], race=[raceInput], special_ability=[special_abilityInput], essence=[essenceInput], leaderInput=[leaderInput], faction_id=[homeworld_id_from_dropdown_Input], WHERE character_id=[character_ID_from_the_update_form]

--Delete a character
DELETE FROM shadowrun_characters WHERE id = [character_ID_selected_from_browse_character_page]

--Dis-associate a certificate from a character (M-to-M relationship deletion)
DELETE FROM shadowrun_cert_characters WHERE pid = [character_ID_selected_from_certificate_and_character_list] AND cid = [certification_ID_selected_from-certificate_and_character_list]
