// Get an instance of mysql we can use in the app
let mysql = require('mysql')

// Create a 'connection pool' using the provided credentials. NOTE: Access to this db ended with class completion. Seeking new hosting method.
/*let pool = mysql.createPool({
    connectionLimit : 10,
    host            : 'classmysql.engr.oregonstate.edu',
    user            : '',
    password        : '',
    database        : ''
})*/

// Export it for use in our application
module.exports.pool = pool;
