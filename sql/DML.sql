-- ====================================
-- Project Step OSU 340 Introduction to Databases
-- Authors: Liam Armstrong and Tyson Bryant
-- ====================================

-- Cards
------------------------------------------------------
-- get all information for view_cards.html browse page
SELECT card_name, set_name, pokedex_number, type, image_path, rarity
    FROM Cards;

-- 'set' drowpdown for add_card.html new page
SELECT set_name FROM Sets;

-- 'type' dropdown and rarity drowpdown? might hardcode into html

-- add a new card on add_card.html
INSERT INTO Cards (card_name, set_name, pokedex_number, type, image_path, rarity)
    VALUES (
        :name_input, :set_from_dropwdown_input, :pokedex_number_input, :type_from_drowpdown_input, 
        :image_path_input, :rarity_from_dropdown_input
        );

-- delete a card
DELETE FROM Cards WHERE card_id = :card_id_selected_from_view_cards_page;

-- update an existing card on update_card.html
UPDATE Cards
    SET card_name = :name_input, set_name = :set_from_dropwdown_input,
        rarity = :rarity_from_dropdown_input, type = :type_from_drowpdown_input,
        pokedex_number = pokedex_number_input_from_update_form, image_path = image_path_input
    WHERE card_id = :card_id_from_update_form;


--  Sets
-----------------------------------------------------
-- get all information for view_sets.html browse page
SELECT set_name, number_of_cards, release_date
    FROM Sets;

-- add a new set on the add_sets.html page
INSERT INTO Sets (set_name, number_of_cards, release_date)
    VALUES (:set_name_input, :number_of_cards_input, :release_date_input);

-- delete a set on the view_sets.html page
DELETE FROM Sets WHERE set_name = :set_name_from_dropdown;

-- update a set on the update_set.html page
UPDATE Sets
    SET set_name = :set_name_input, number_of_cards = :number_of_cards_input,
        release_date = :release_date_input
    WHERE set_name = :set_name_input_from_update_form;

-- Pokemon
--------------------------------------------------------
-- get all information for view_pokemon.html browse page
SELECT pokedex_number, pokemon_name, type, evolution_stage, description
    FROM Pokemon;

-- add a new pokemon on add_pokemon.html page
INSERT INTO Pokemon (pokedex_number, pokemon_name, type, evolution_stage, description)
    VALUES (
        :pokedex_number_input, :pokemon_name_input, 
        :type_input_from_dropdown, :evolution_stage_input_from_drowpdown,
        :description_input
        );

-- delete a pokemon on view_pokemon.html page
DELETE FROM Pokemon WHERE pokedex_number = :pokedex_number_selected_from_view_pokemon_page;

-- update a pokemon on update_pokemon.html page
UPDATE Pokemon
    SET pokemon_name = :pokemon_name_input, type = :type_input_from_dropdown, 
        evolution_stage = :evolution_stage_input_from_drowpdown, description = :description_input
    WHERE pokedex_number = pokedex_number_input_from_update_form


-- Decks
------------------------------------------------------
-- get all information for view_decks.html browse page
SELECT deck_id, Players.name AS 'Player Name', deck_name, type_combo, card_count, number_of_pokemon
    FROM Decks
        JOIN Players
        ON Decks.player_id = Players.player_id;

-- add a new deck on add_deck.html page
INSERT INTO Decks (player_id, deck_name, type_combo, card_count, number_of_pokemon)
    VALUES (:player_id_input, :deck_name_input, :type_combo_input, :card_count_input, :number_of_pokemon_input);

-- delete a deck on view_decks.html page
DELETE FROM Decks WHERE deck_id = :deck_id_selected_from_view_decks_page;

-- update a deck on update_deck.html page
UPDATE Decks
    SET player_id = :player_id_input, deck_name = :deck_name_input, type_combo = :type_combo_input
    WHERE deck_id = deck_id_input_from_update_form;

-- Players
---------------------------------------------------------
-- get all information for view_players.html browse page
SELECT player_id, name, country 
FROM Players;

-- add a new player on add_player.html page
INSERT INTO Players (name, country)
VALUES (:name_input, :country_input);

-- delete a player on view_players.html page
DELETE FROM Players WHERE player_id = :player_id_selected_from_view_players_page;

-- update an existing player on update_player.html page
UPDATE Players
SET name = :name_input, country = :country_input
WHERE player_id = :player_id_from_update_form;