DROP TABLE IF EXISTS `shadowrun_race`;
DROP TABLE IF EXISTS `shadowrun_factions`;
DROP TABLE IF EXISTS `shadowrun_weapons`;
DROP TABLE IF EXISTS `shadowrun_tech`;
DROP TABLE IF EXISTS `shadowrun_magic`;
DROP TABLE IF EXISTS `shadowrun_characters`;







CREATE TABLE `shadowrun_race` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `raceName` varchar(255) NOT NULL,
  `special_ability` varchar(255) NOT NULL,
  `essence` int(11) NOT NULL,
  `health` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;


LOCK TABLES `shadowrun_race` WRITE;
INSERT INTO `shadowrun_race` VALUES
(1, 'Human', 'No Essence Usage with Technology', 10, 175),
(2, 'Elf', 'Regenerative Health', 12, 125),
(3, 'Dwarf', 'Sucks Enemy Essence when Nearby', 8, 190),
(4, 'Troll', 'Reduced Damage While Taking Damage', 7, 250);
UNLOCK TABLES;




CREATE TABLE `shadowrun_factions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `factionName` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;


LOCK TABLES `shadowrun_factions` WRITE;
INSERT INTO `shadowrun_factions` VALUES
(1, 'Lineage'),
(2, 'RNA Global'),
(3, 'The ORK'),
(4, 'The Ziggurat');
UNLOCK TABLES;



CREATE TABLE `shadowrun_weapons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `weaponName` varchar(255) NOT NULL,
  `damage` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;


LOCK TABLES `shadowrun_weapons` WRITE;
INSERT INTO `shadowrun_weapons` VALUES
(1, 'Pistol', 10),
(2, 'Sword', 25),
(3, 'SMG', 3),
(4, 'Shotgun', 50),
(5, 'Rifle', 15),
(6, 'SniperRifle', 33);
UNLOCK TABLES;



CREATE TABLE `shadowrun_tech` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `techName` varchar(255) NOT NULL,
  `essence_possession` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;


LOCK TABLES `shadowrun_tech` WRITE;
INSERT INTO `shadowrun_tech` VALUES
(1, 'Teleport', 3),
(2, 'Smart Lock', 3),
(3, 'Glider', 3),
(4, 'Enhanced Vision', 4);
UNLOCK TABLES;



CREATE TABLE `shadowrun_magic` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `magicName` varchar(255) NOT NULL,
  `essence_usage` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;


LOCK TABLES `shadowrun_magic` WRITE;
INSERT INTO `shadowrun_magic` VALUES
(1, 'Strangle', 2),
(2, 'Resurrect', 5),
(3, 'Minion', 6),
(4, 'Tree of Life', 4);
UNLOCK TABLES;


CREATE TABLE `shadowrun_characters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `leader` boolean,
  `race_id` int(11),
  `faction_id` int(11),
  `weapon_id` int(11),
  `magic_id` int(11),
  `tech_id` int(11),
  PRIMARY KEY (`id`),
  FOREIGN KEY (`race_id`) REFERENCES `shadowrun_race` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  FOREIGN KEY (`faction_id`) REFERENCES `shadowrun_factions` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  FOREIGN KEY (`weapon_id`) REFERENCES `shadowrun_weapons` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  FOREIGN KEY (`magic_id`) REFERENCES `shadowrun_magic` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  FOREIGN KEY (`tech_id`) REFERENCES `shadowrun_tech` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB;


LOCK TABLES `shadowrun_characters` WRITE;
INSERT INTO `shadowrun_characters` VALUES
(1, 'Luscus', 0, 1, 1, 1, 1, 2),
(2, 'Leonidas', 1, 2, 2, 5, 2, 1),
(3, 'Xander', 0, 3, 3, 4, 3, 4),
(4, 'Xerxes', 1, 4, 4, 3, 4, 3),
(5, 'Capricus', 0, 2, 2, 3, 2, 1),
(6, 'Trinity', 1, 1, 1, 2, 1, 2),
(7, 'Libra', 0, 4, 4, 5, 4, 3),
(8, 'Theocles', 1, 3, 3, 6, 3, 4);
UNLOCK TABLES;
