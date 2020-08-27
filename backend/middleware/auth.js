
const jwt = require('jsonwebtoken');
const connectdb = require('../connectdb.js');
const mysql = require('mysql');

module.exports = (req, res, next) => {
    try {
        const token = req.headers.authorization.split(' ')[1];
        const decodedToken = jwt.verify(token, 'RANDOM_TOKEN_SECRET');
        const userId = decodedToken.userId;
        let sqlInserts = [userId];
        let sql = 'SELECT COUNT(id) FROM users WHERE id=?';
        sql = mysql.format(sql, sqlInserts); 
        connectdb.query(sql, function(err, result){
            if (err) reject({error : 'Erreur dans l\'inscription'});
            if (result[0]['COUNT(id)'] !== 1) {
                throw 'Token invalide';
            } else {
                next();
            }
        })
    } catch (error) {
        res.status(401).json({error: error | 'Requête non authentifiée!'})
    }
}; 