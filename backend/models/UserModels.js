const connectdb = require('../connectdb.js');
const mysql = require('mysql');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');

class UserModels {
    constructor() {
    }
    signup(sqlInserts){
        let sql = 'INSERT INTO users VALUES(NULL, ?, ?, ?, ?, NULL)';
        sql = mysql.format(sql, sqlInserts);
        return new Promise((resolve, reject) =>{
            connectdb.query(sql, function(err, result){
                if (err) reject({error : 'Erreur dans l\'inscription'});
                resolve({message : 'Nouvel utilisateur !'})
            })
        })
    }
    login(sqlInserts, password){
        let sql = 'SELECT * FROM users WHERE email = ?';
        sql = mysql.format(sql, sqlInserts);
        
        return new Promise((resolve, reject) =>{
            connectdb.query(sql, function(err, result){
                if (err) reject({ err });
                if (!result[0]){
                    reject ({ error : 'Utilisateur introuvable !'});
                } else {
                    bcrypt.compare(password, result[0].password) 
                        .then(valid => { 
                            if (!valid) return reject({ error: 'Mot de passe incorrect !' });
                            resolve({
                                userId: result[0].id,
                                token: jwt.sign(
                                    { userId: result[0].id,
                                    moderation: result[0].moderation },
                                    'RANDOM_TOKEN_SECRET',
                                    { expiresIn: '24h' } 
                                ),
                                moderation: result[0].moderation
                            });
                        })
                        .catch(error => reject({ error }));
                }
            })
        
        })
    }
    seeMyProfile(sqlInserts){
        let sql = 'SELECT firstName, lastName, email FROM users WHERE id = ?';
        sql = mysql.format(sql,sqlInserts);
        return new Promise((resolve, reject) =>{
            connectdb.query(sql, function(err, result){
                if (err) return reject({error : 'page indisponible'});
                resolve(result);
            }) 

        })
    
    }
    updateUser(sqlInserts){
        let sql = 'UPDATE users SET firstName = ?, lastName = ?, email = ? WHERE id = ?';
        sql = mysql.format(sql,sqlInserts);
        return new Promise((resolve, reject) =>{
            connectdb.query(sql, function(err, result){
                if (err) return reject({error : 'fonction indisponible'});
                resolve({message : 'Informations mises à jour !'});
            }) 

        })
    }
    deleteUser(sqlInserts){
        let sql = 'DELETE FROM users WHERE id = ?'; 
        sql = mysql.format(sql,sqlInserts);
        return new Promise((resolve, reject) =>{
            connectdb.query(sql, function(err, result){
                if (err) return reject({error : 'fonction indisponible'});
                resolve({message : 'Utilisateur supprimé'});
            }) 

        })
    
    }
}

module.exports = UserModels;
