const express = require('express');
const app = express();
const dbPool = require('./db-connector').pool;

const cors = require('cors');
app.use(cors());

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(express.static('public')); // Serve static files from 'public' directory

// Cards CRUD Operations
// Read all cards
app.get('/cards', function (req, res) {
    dbPool.query('SELECT * FROM Cards', function (error, results) {
        if (error) res.status(500).send('Server error');
        else res.json(results);
    });
});

// Add a new card
app.post('/cards', function (req, res) {
    console.log("Received request to add a card:", req.body);
    var { card_name, set_name, pokedex_number, type, image_path, rarity } = req.body;
    var query = 'INSERT INTO Cards (card_name, set_name, pokedex_number, type, image_path, rarity) VALUES (?, ?, ?, ?, ?, ?)';
    dbPool.query(query, [card_name, set_name, pokedex_number, type, image_path, rarity], function (error, results) {
        // ... Inside your POST route ...
        if (error) {
            console.error("Error executing query:", error);
            res.status(500).send('Server error: ' + error.message);
        } else {
            console.log("Card added successfully");
            res.redirect('/success_add.html'); // Redirect to the success page
        }

    });
});

// Update a card
app.put('/cards/:card_id', function (req, res) {
    var { card_name, set_name, pokedex_number, type, image_path, rarity } = req.body;
    var card_id = req.params.card_id;
    var query = 'UPDATE Cards SET card_name = ?, set_name = ?, pokedex_number = ?, type = ?, image_path = ?, rarity = ? WHERE card_id = ?';
    dbPool.query(query, [card_name, set_name, pokedex_number, type, image_path, rarity, card_id], function (error, results) {
        if (error) res.status(500).send('Server error');
        else res.status(200).send('Card updated successfully');
    });
});

// Delete a card
app.delete('/cards/:card_id', function (req, res) {
    var card_id = req.params.card_id;
    var query = 'DELETE FROM Cards WHERE card_id = ?';
    dbPool.query(query, [card_id], function (error, results) {
        if (error) res.status(500).send('Server error');
        else res.status(200).send('Card deleted successfully');
    });
});

// Read all Pokémon
app.get('/pokemon', function (req, res) {
    dbPool.query('SELECT * FROM Pokemon', function (error, results) {
        if (error) res.status(500).send('Server error');
        else res.json(results);
    });
});

// Add a new Pokémon
app.post('/pokemon', function (req, res) {
    var { pokedex_number, pokemon_name, type, evolution_stage, description } = req.body;
    var query = 'INSERT INTO Pokemon (pokedex_number, pokemon_name, type, evolution_stage, description) VALUES (?, ?, ?, ?, ?)';
    dbPool.query(query, [pokedex_number, pokemon_name, type, evolution_stage, description], function (error, results) {
        if (error) {
            console.error("Error executing query:", error);
            res.status(500).send('Server error');
        } else {
            res.redirect('/success_pokemon.html'); // Redirect to the success page
        }
    });
});

// Delete a Pokémon
app.delete('/pokemon/:pokedex_number', function (req, res) {
    var pokedexNumber = req.params.pokedex_number;
    var query = 'DELETE FROM Pokemon WHERE pokedex_number = ?';
    dbPool.query(query, [pokedexNumber], function (error, results) {
        if (error) res.status(500).send('Server error');
        else res.status(200).send('Pokémon deleted successfully');
    });
});


// Read all sets
app.get('/sets', function (req, res) {
    dbPool.query('SELECT * FROM Sets', function (error, results) {
        if (error) res.status(500).send('Server error');
        else res.json(results);
    });
});

// Add a new set
app.post('/sets', function (req, res) {
    var { set_name, number_of_cards, release_date } = req.body;
    var query = 'INSERT INTO Sets (set_name, number_of_cards, release_date) VALUES (?, ?, ?)';
    dbPool.query(query, [set_name, number_of_cards, release_date], function (error, results) {
        if (error) {
            console.error("Error executing query:", error);
            res.status(500).send('Server error');
        } else {
            res.redirect('/success_sets.html'); // Redirect to the success page
        }
    });
});

// Update a set
app.put('/sets/:set_name', function (req, res) {
    var { number_of_cards, release_date } = req.body;
    var set_name = req.params.set_name;
    var query = 'UPDATE Sets SET number_of_cards = ?, release_date = ? WHERE set_name = ?';
    dbPool.query(query, [number_of_cards, release_date, set_name], function (error, results) {
        if (error) res.status(500).send('Server error');
        else res.status(200).send('Set updated successfully');
    });
});

// Delete a set
app.delete('/sets/:set_name', function (req, res) {
    var set_name = req.params.set_name;
    var query = 'DELETE FROM Sets WHERE set_name = ?';
    dbPool.query(query, [set_name], function (error, results) {
        if (error) res.status(500).send('Server error');
        else res.status(200).send('Set deleted successfully');
    });
});

// Read all decks
app.get('/decks', function (req, res) {
    dbPool.query('SELECT * FROM Decks', function (error, results) {
        if (error) res.status(500).send('Server error');
        else res.json(results);
    });
});

// Add a new deck
app.post('/decks', function (req, res) {
    var { deck_name, type_combo, card_count, num_of_pokemon } = req.body;
    var query = 'INSERT INTO Decks (deck_name, type_combo, card_count, num_of_pokemon) VALUES (?, ?, ?, ?)';
    dbPool.query(query, [deck_name, type_combo, card_count, num_of_pokemon], function (error, results) {
        if (error) {
            console.error("Error executing query:", error);
            res.status(500).send('Server error');
        } else {
            res.redirect('/success_deck.html'); // Redirect to the success page
        }
    });
});

// Update a deck
app.put('/decks/:deck_id', function (req, res) {
    var { deck_name, type_combo, card_count, num_of_pokemon } = req.body;
    var deck_id = req.params.deck_id;
    var query = 'UPDATE Decks SET deck_name = ?, type_combo = ?, card_count = ?, num_of_pokemon = ? WHERE deck_id = ?';
    dbPool.query(query, [deck_name, type_combo, card_count, num_of_pokemon, deck_id], function (error, results) {
        if (error) res.status(500).send('Server error');
        else res.status(200).send('Deck updated successfully');
    });
});

// Delete a deck
app.delete('/decks/:deck_id', function (req, res) {
    var deck_id = req.params.deck_id;
    var query = 'DELETE FROM Decks WHERE deck_id = ?';
    dbPool.query(query, [deck_id], function (error, results) {
        if (error) res.status(500).send('Server error');
        else res.status(200).send('Deck deleted successfully');
    });
});

// Start the server
var PORT = 9000; // Replace with your chosen port number
app.listen(PORT, function () {
    console.log('Server running on http://flip1.engr.oregonstate.edu:' + PORT); // Replace 'flipX' with your actual FLIP server
});
