-- ====================================
-- Project Step OSU 340 Introduction to Databases
-- Authors: Liam Armstrong and Tyson Bryant
-- ====================================

-- Disable foreign key checks to allow table drops and creations without restriction
SET FOREIGN_KEY_CHECKS = 0;

-- Disable auto-commit to ensure the entire script runs as a transaction
SET AUTOCOMMIT = 0;

-- Drop the `Cards` table if it exists to allow recreation
DROP TABLE IF EXISTS `Cards`;

-- Create the `Cards` table with details of each card
CREATE TABLE `Cards` (
    `card_id` int(11) NOT NULL,
    `card_name` varchar(50) NOT NULL,
    `set_name` varchar(45) NOT NULL,
    `pokedex_number` varchar(45) DEFAULT NULL,
    `type` varchar(45) NOT NULL,
    `image_path` varchar(45) DEFAULT NULL,
    `rarity` varchar(45) NOT NULL,
    PRIMARY KEY (`card_id`),
    UNIQUE KEY `card_id_UNIQUE` (`card_id`),
    KEY `fk_Cards_Pokemon_idx` (`pokedex_number`),
    KEY `fk_Cards_Sets1` (`set_name`),
    CONSTRAINT `fk_Cards_Pokemon` FOREIGN KEY (`pokedex_number`) REFERENCES `Pokemon` (`pokedex_number`) ON DELETE CASCADE ON UPDATE NO ACTION,
    CONSTRAINT `fk_Cards_Sets1` FOREIGN KEY (`set_name`) REFERENCES `Sets` (`set_name`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb3 COLLATE = utf8mb3_general_ci;

-- Insert sample data into the `Cards` table
INSERT INTO `Cards` (
    `card_id`, `card_name`, `set_name`, `pokedex_number`, `type`, `image_path`, `rarity`
) VALUES
    (1, 'Bulbasaur', 'Base Set', 1, 'Grass', '/images/bulbasaur.jpg', 'Common'),
    (2, 'Charmander', 'Base Set', 2, 'Fire', '/images/charmander.jpg', 'Common'),
    (3, 'Squirtle', 'Base Set', 3, 'Water', '/images/squirtle.jpg', 'Common');

-- Drop the `Decks` table if it exists to allow recreation
DROP TABLE IF EXISTS `Decks`;

-- Create the `Decks` table with details of each deck owned by a player
CREATE TABLE `Decks` (
    `deck_id` int(11) NOT NULL AUTO_INCREMENT,
    `player_id` int(11) NOT NULL,
    `deck_name` varchar(45) NOT NULL,
    `type_combo` varchar(45) NOT NULL,
    `card_count` int(11) NOT NULL,
    `number_of_pokemon` int(11) NOT NULL,
    PRIMARY KEY (`deck_id`),
    UNIQUE KEY `deck_id_UNIQUE` (`deck_id`),
    KEY `fk_Decks_Players1_idx` (`player_id`),
    CONSTRAINT `fk_Decks_Players1` FOREIGN KEY (`player_id`) REFERENCES `Players` (`player_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 7 DEFAULT CHARSET = utf8mb3 COLLATE = utf8mb3_general_ci;

-- Insert sample data into the `Decks` table
INSERT INTO `Decks` (`player_id`, `deck_name`, `type_combo`, `card_count`, `number_of_pokemon`) VALUES
    (1, 'Ashs Deck', 'Grass/Fire/Water', 60, 20),
    (2, 'Mistys Deck', 'Water', 55, 18),
    (3, 'Brocks Deck', 'Fighting', 50, 15);

-- Drop the `Decks_has_Cards` table if it exists to allow recreation
DROP TABLE IF EXISTS `Decks_has_Cards`;

-- Create the `Decks_has_Cards` table which represents the many-to-many relationship between cards and decks
CREATE TABLE `Decks_has_Cards` (
    `id` int(11) NOT NULL,
    `card_id` int(11) NOT NULL,
    `deck_id` int(11) NOT NULL,
    PRIMARY KEY (`id`),
    KEY `fk_Cards_has_Decks_Decks1_idx` (`deck_id`),
    KEY `fk_Cards_has_Decks_Cards1_idx` (`card_id`),
    CONSTRAINT `fk_Cards_has_Decks_Cards1` FOREIGN KEY (`card_id`) REFERENCES `Cards` (`card_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
    CONSTRAINT `fk_Cards_has_Decks_Decks1` FOREIGN KEY (`deck_id`) REFERENCES `Decks` (`deck_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb3 COLLATE = utf8mb3_general_ci;

-- Drop the `Players` table if it exists to allow recreation
DROP TABLE IF EXISTS `Players`;

-- Create the `Players` table with details of each player
CREATE TABLE `Players` (
    `player_id` int(11) NOT NULL AUTO_INCREMENT,
    `name` varchar(45) NOT NULL,
    `country` varchar(45) NOT NULL,
    PRIMARY KEY (`player_id`),
    UNIQUE KEY `player_id_UNIQUE` (`player_id`)
) ENGINE = InnoDB AUTO_INCREMENT = 4 DEFAULT CHARSET = utf8mb3 COLLATE = utf8mb3_general_ci;

-- Insert sample data into the `Players` table
INSERT INTO `Players` (`player_id`, `name`, `country`) VALUES
    (1, 'Ash Ketchum', 'Pallet Town'),
    (2, 'Misty', 'Cerulean City'),
    (3, 'Brock', 'Pewter City');

-- Drop the `Pokemon` table if it exists to allow recreation
DROP TABLE IF EXISTS `Pokemon`;

-- Create the `Pokemon` table with details of each Pokémon
CREATE TABLE `Pokemon` (
    `pokedex_number` varchar(45) NOT NULL,
    `pokemon_name` varchar(50) NOT NULL,
    `type` varchar(45) NOT NULL,
    `evolution_stage` varchar(45) NOT NULL,
    `description` text DEFAULT NULL,
    PRIMARY KEY (`pokedex_number`),
    UNIQUE KEY `pokemon_name_UNIQUE` (`pokemon_name`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb3 COLLATE = utf8mb3_general_ci;

-- Insert sample data into the `Pokemon` table
INSERT INTO `Pokemon` (`pokedex_number`, `pokemon_name`, `type`, `evolution_stage`, `description`) VALUES
    (1, 'Bulbasaur', 'Grass', 'Basic', 'A grass-type Pokémon with a plant bulb on its back.'),
    (2, 'Charmander', 'Fire', 'Basic', 'A fire-type Pokémon with a flame at the tip of its tail.'),
    (3, 'Squirtle', 'Water', 'Basic', 'A water-type Pokémon that can shoot water from its mouth.');

-- Drop the `Sets` table if it exists to allow recreation
DROP TABLE IF EXISTS `Sets`;

-- Create the `Sets` table with details of each card set
CREATE TABLE `Sets` (
    `set_name` varchar(45) NOT NULL,
    `number_of_cards` varchar(45) NOT NULL,
    `release_date` date NOT NULL,
    PRIMARY KEY (`set_name`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb3 COLLATE = utf8mb3_general_ci;

-- Insert sample data into the `Sets` table
INSERT INTO `Sets` (`set_name`, `number_of_cards`, `release_date`) VALUES
    ('Base Set', '102', '1999-01-09'),
    ('Jungle', '64', '1999-06-16'),
    ('Fossil', '62', '1999-10-10');

-- Enable foreign key checks after the operations
SET FOREIGN_KEY_CHECKS = 1;

-- Commit the entire transaction to save all changes
COMMIT;
