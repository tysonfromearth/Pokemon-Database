//Citation for the following file:
//Date: 2023-11-30
//Copied as a template then based on
//Source URL: https://github.com/osu-cs340-ecampus/nodejs-starter-app/

// ./database/db-connector.js

// Get an instance of mysql we can use in the app
var mysql = require('mysql')

// Create a 'connection pool' using the provided credentials
var pool = mysql.createPool({
    connectionLimit : 10,
    host            : 'classmysql.engr.oregonstate.edu',
    user            : 'cs340_bryantty',
    password        : '1989',
    database        : 'cs340_bryantty'
})

// Export it for use in our applicaiton
module.exports.pool = pool;