// Get an instance of mysql we can use in the app
let mysql = require('mysql')

// Create a 'connection pool' using the provided credentials
let pool = mysql.createPool({
    connectionLimit : 10,
    host            : 'classmysql.engr.oregonstate.edu',
    user            : 'cs340_armstlia',
    password        : '5213',
    database        : 'cs340_armstlia'
})

// Export it for use in our application
module.exports.pool = pool;
