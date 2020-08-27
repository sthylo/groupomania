const mysql = require('mysql');
console.log('Connexion à la base de données...');
let connectdb = mysql.createConnection({ 
    host: 'localhost', 
    user: 'root', 
    password: 'Jtesuce11!', 
    database: 'groupomania_database', 
});
connectdb.connect(function(err) { 
    if (err) throw err;
    console.log('Connecté!')
});

module.exports = connectdb;