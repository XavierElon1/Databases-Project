use cs340_hwangk;
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS characters;
CREATE TABLE characters(
ID int(11) NOT NULL AUTO_INCREMENT,
name varchar(50) NOT NULL,
arc_id int(11) NOT NULL,
bounty bigint(20),
PRIMARY KEY (ID),
FOREIGN KEY (arc_id) REFERENCES arc(ID) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE = InnoDB;

DROP TABLE IF EXISTS devil_fruit;
CREATE TABLE devil_fruit(
ID int(11) NOT NULL AUTO_INCREMENT,
arc_id int(11) NOT NULL,
category varchar(50) NOT NULL,
ability varchar(50) NOT NULL,
PRIMARY KEY (ID),
FOREIGN KEY (arc_id) REFERENCES arc(ID) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE = InnoDB;

DROP TABLE IF EXISTS crew;
CREATE TABLE crew(
ID int(11) NOT NULL AUTO_INCREMENT,
name varchar(50) NOT NULL,
leader_id int(11) NOT NULL,
population int NOT NULL,
alignment varchar(50) NOT NULL,
ship varchar(50),
arc_id int(11) NOT NULL,
PRIMARY KEY (ID),
FOREIGN KEY (leader_id) REFERENCES characters(ID) ON DELETE NO ACTION ON UPDATE CASCADE,
FOREIGN KEY (arc_id) REFERENCES arc(ID) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE = InnoDB;

DROP TABLE IF EXISTS arc;
CREATE TABLE arc(
ID int(11) NOT NULL AUTO_INCREMENT,
name varchar(50) NOT NULL,
enemy_id int(11),
PRIMARY KEY (ID),
FOREIGN KEY (enemy_id) REFERENCES characters(ID) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE = InnoDB;

DROP TABLE IF EXISTS characters_devil_fruit;
CREATE TABLE characters_devil_fruit(
character_id int(11) NOT NULL,
devil_fruit_id int(11) NOT NULL,
PRIMARY KEY (character_id, devil_fruit_id),
FOREIGN KEY (character_id) REFERENCES characters(ID) ON DELETE NO ACTION ON UPDATE CASCADE,
FOREIGN KEY (devil_fruit_id) REFERENCES devil_fruit(ID) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE = InnoDB;

DROP TABLE IF EXISTS crew_characters;
CREATE TABLE crew_characters(
crew_id int(11) NOT NULL,
character_id int(11) NOT NULL,
PRIMARY KEY (crew_id, character_id),
FOREIGN KEY (crew_id) REFERENCES crew(ID) ON DELETE NO ACTION ON UPDATE CASCADE,
FOREIGN KEY (character_id) REFERENCES characters(ID) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE = InnoDB;

DROP TABLE IF EXISTS crew_devil_fruit;
CREATE TABLE crew_devil_fruit(
crew_id int(11) NOT NULL,
devil_fruit_id int(11) NOT NULL,
PRIMARY KEY (crew_id, devil_fruit_id),
FOREIGN KEY (crew_id) REFERENCES crew(ID) ON DELETE NO ACTION ON UPDATE CASCADE,
FOREIGN KEY (devil_fruit_id) REFERENCES devil_fruit(ID) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE = InnoDB;

SET FOREIGN_KEY_CHECKS = 1;

INSERT INTO arc(name) values('East Blue');
INSERT INTO characters(name, arc_id, bounty) values('Monkey D. Luffy', (select ID from arc where name = 'East Blue'), 1500000000);
INSERT INTO devil_fruit(arc_id, category, ability) values((select ID from arc where name = 'East Blue'),'Paramecia', 'Rubber');
INSERT INTO crew(name, leader_id, population, alignment, ship, arc_id) values('Straw Hat Pirates', 
(select ID from characters where name = 'Monkey D. Luffy'), 10, 'good', 'Thousand Sunny', (select ID from arc where name = 'East Blue'));
INSERT INTO characters_devil_fruit(character_id, devil_fruit_id) values((select ID from characters where name = 'Monkey D. Luffy'), (select ID from devil_fruit where ability = 'Rubber'));
INSERT INTO crew_characters(crew_id, character_id) values((select ID from crew where name = 'Straw Hat Pirates'), (select ID from characters where name = 'Monkey D. Luffy'));
INSERT INTO crew_devil_fruit(crew_id, devil_fruit_id) values((select ID from crew where name = 'Straw Hat Pirates'), (select ID from devil_fruit where ability = 'Rubber'));