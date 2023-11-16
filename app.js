const express = require('express');
const app = express();
const dbPool = require('./db-connector');

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(express.static('public')); // Serve static files from 'public' directory

// Cards CRUD Operations
// Read all cards
app.get('/cards', function(req, res) {
    dbPool.query('SELECT * FROM Cards', function(error, results) {
        if (error) res.status(500).send('Server error');
        else res.json(results);
    });
});

// Add a new card
app.post('/cards', function(req, res) {
    var { card_name, set_name, pokedex_number, type, image_path, rarity } = req.body;
    var query = 'INSERT INTO Cards (card_name, set_name, pokedex_number, type, image_path, rarity) VALUES (?, ?, ?, ?, ?, ?)';
    dbPool.query(query, [card_name, set_name, pokedex_number, type, image_path, rarity], function(error, results) {
        if (error) res.status(500).send('Server error');
        else res.status(201).send('Card added successfully');
    });
});

// Update a card
app.put('/cards/:card_id', function(req, res) {
    var { card_name, set_name, pokedex_number, type, image_path, rarity } = req.body;
    var card_id = req.params.card_id;
    var query = 'UPDATE Cards SET card_name = ?, set_name = ?, pokedex_number = ?, type = ?, image_path = ?, rarity = ? WHERE card_id = ?';
    dbPool.query(query, [card_name, set_name, pokedex_number, type, image_path, rarity, card_id], function(error, results) {
        if (error) res.status(500).send('Server error');
        else res.status(200).send('Card updated successfully');
    });
});

// Delete a card
app.delete('/cards/:card_id', function(req, res) {
    var card_id = req.params.card_id;
    var query = 'DELETE FROM Cards WHERE card_id = ?';
    dbPool.query(query, [card_id], function(error, results) {
        if (error) res.status(500).send('Server error');
        else res.status(200).send('Card deleted successfully');
    });
});

// TODO: Repeat similar CRUD operations for Sets, Pokemon, Decks, and Players

// Start the server
var PORT = 9000; // Replace with your chosen port number
app.listen(PORT, function() {
    console.log('Server running on http://flip1.engr.oregonstate.edu:' + PORT); // Replace 'flipX' with your actual FLIP server
});
