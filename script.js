// script.js

// Function to fetch and display data (READ operation)
function fetchAndDisplayCards() {
    fetch('/cards')
        .then(response => response.json())
        .then(cards => {
            // TODO: Update your HTML with the fetched cards data
        })
        .catch(error => console.error('Error:', error));
}

// Function to handle form submission (CREATE or UPDATE operation)
function submitCardForm(formData) {
    // Determine whether it's a create or update operation based on formData
    const url = formData.get('card_id') ? '/cards/' + formData.get('card_id') : '/cards';
    const method = formData.get('card_id') ? 'PUT' : 'POST';

    fetch(url, {
        method: method,
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(Object.fromEntries(formData))
    })
    .then(response => {
        if (response.ok) {
            // TODO: Handle successful operation
            fetchAndDisplayCards(); // Fetch and display updated data
        } else {
            // TODO: Handle error
        }
    })
    .catch(error => console.error('Error:', error));
}

// Function to handle card deletion (DELETE operation)
function deleteCard(cardId) {
    fetch('/cards/' + cardId, { method: 'DELETE' })
        .then(response => {
            if (response.ok) {
                // TODO: Handle successful deletion
                fetchAndDisplayCards(); // Fetch and display updated data
            } else {
                // TODO: Handle error
            }
        })
        .catch(error => console.error('Error:', error));
}

// Call fetchAndDisplayCards on page load to display existing data
document.addEventListener('DOMContentLoaded', fetchAndDisplayCards);
