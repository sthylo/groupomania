const connectdb = require('../connectdb.js');
const mysql = require('mysql');

class PostsModels {
    constructor() {
    }
    

    getAllPosts(){
        let sql = "SELECT posts.id, posts.userId, posts.title, posts.content, DATE_FORMAT(DATE(posts.date), '%d/%m/%Y') AS date, TIME(posts.date) AS time, posts.likes, users.lastName, users.firstName FROM posts JOIN users ON posts.userId = users.id ORDER BY posts.date DESC";
        return new Promise((resolve) =>{
            connectdb.query(sql, function (err, result, fields) {
                if (err) throw err;
                resolve(result)
            });
        })
    }
    createPost(sqlInserts){
        let sql = 'INSERT INTO posts VALUES(NULL, ?, ?, ?, NOW(), 0)';
        sql = mysql.format(sql, sqlInserts);
        return new Promise((resolve) =>{
            connectdb.query(sql, function (err, result, fields) {
                if (err) throw err;
                resolve({message : 'Nouveau post !'});
            })       
        })
    }
    updatePost(sqlInserts1, sqlInserts2){
        let sql1 = 'SELECT * FROM posts where id = ?';
        sql1 = mysql.format(sql1, sqlInserts1);
        return new Promise((resolve) =>{
            connectdb.query(sql1, function (err, result, fields){
                if (err) throw err;
                if(sqlInserts2[3] == result[0].userId){
                    let sql2 = 'UPDATE posts SET title = ?, content = ? WHERE id = ? AND userId = ?';
                    sql2 = mysql.format(sql2, sqlInserts2);
                    connectdb.query(sql2, function (err, result, fields){
                        if (err) throw err;
                        resolve({message : 'Post modifié !'});
                    })
                }else{
                    reject({error: 'fonction indisponible'});
                }
            })
        });
    }
    deletePost(sqlInserts1, sqlInserts2){
        let sql1 = 'SELECT * FROM posts where id = ?';
        sql1 = mysql.format(sql1, sqlInserts1);
        return new Promise((resolve, reject) =>{
            connectdb.query(sql1, function (err, result, fields){
                if (err) throw err;
                if(sqlInserts2[1] == result[0].userId){
                    let sql2 = 'DELETE FROM posts WHERE id = ? AND userId = ?';
                    sql2 = mysql.format(sql2, sqlInserts2);
                    connectdb.query(sql2, function (err, result, fields){
                        if (err) throw err;
                        resolve({message : 'Post supprimé !'});
                    })
                }else{
                    reject({error: 'fonction indisponible'});
                }
            
            });
        })
    }


    getComments(sqlInserts){
        let sql = "SELECT comments.comContent, DATE_FORMAT(comments.date, '%d/%m/%Y à %H:%i:%s') AS date, comments.id, comments.userId, users.firstName, users.lastName FROM comments JOIN users on comments.userId = users.id WHERE postId = ? ORDER BY date";
        sql = mysql.format(sql, sqlInserts);
        return new Promise((resolve) =>{
            connectdb.query(sql, function (err, result, fields){
                if (err) throw err;
                resolve(result);
            })
        
        })
    }
    createComment(sqlInserts){
        let sql = 'INSERT INTO comments VALUES(NULL, ?, ?, NOW(), ?)';
        sql = mysql.format(sql, sqlInserts);
        return new Promise((resolve) =>{
            connectdb.query(sql, function (err, result, fields){
                if (err) throw err;
                resolve({message : 'Nouveau commentaire !'})
            })
        })
    }
    updateComment(sqlInserts1, sqlInserts2){
        let sql1 = 'SELECT * FROM comments where id = ?';
        sql1 = mysql.format(sql1, sqlInserts1);
        return new Promise((resolve) =>{
            connectdb.query(sql1, function (err, result, fields){
                if (err) throw err;
                if(sqlInserts2[2] == result[0].userId){
                    let sql2 = 'UPDATE comments SET comContent = ? WHERE id = ? AND userId = ?';
                    sql2 = mysql.format(sql2, sqlInserts2);
                    connectdb.query(sql2, function (err, result, fields){
                        if (err) throw err;
                        resolve({message : 'Commentaire modifié !'});
                    })
                }else{
                    reject({error: 'fonction indisponible'});
                }
            })
        });
    }
    deleteComment(sqlInserts1, sqlInserts2){
        let sql1 = 'SELECT * FROM comments where id = ?';
        sql1 = mysql.format(sql1, sqlInserts1);
        return new Promise((resolve, reject) =>{
            connectdb.query(sql1, function (err, result, fields){
                if (err) throw err;
                if(sqlInserts2[1] == result[0].userId){
                    let sql2 = 'DELETE FROM comments WHERE id = ? AND userId = ?';
                    sql2 = mysql.format(sql2, sqlInserts2);
                    connectdb.query(sql2, function (err, result, fields){
                        if (err) throw err;
                        resolve({message : 'Commentaire supprimé !'});
                    })
                }else{
                    reject({error: 'fonction indisponible'});
                }
            
            });
        })
    }

    
    getAllLikes(){
        let sql = 'SELECT * FROM likes';
        return new Promise((resolve) =>{
            connectdb.query(sql, function (err, result, fields) {
                if (err) throw err;
                resolve(result)
            });
        })
    }
    postLike(sqlInserts1, sqlInserts2, liked){
        let sql1 = 'INSERT INTO likes VALUES (NULL, ?, ?)'; 
        sql1 = mysql.format(sql1, sqlInserts1);
        let sql2 = 'UPDATE posts SET likes = ? WHERE id = ?';
        sql2 = mysql.format(sql2, sqlInserts2);
        let sql3 = 'DELETE FROM likes WHERE postId = ? AND userId = ?';
        sql3 = mysql.format(sql3, sqlInserts1);
        return new Promise((resolve) =>{
            connectdb.query(sql2, function (err, result, fields){
                if (err) throw err;
                
            });
            if(liked === false){
                connectdb.query(sql1, function (err, result, fields){
                    if (err) throw err;
                    resolve({ message: 'Like !'})
                })
            }
            if(liked === true){
                connectdb.query(sql3, function(err, result, fields){
                    if(err) throw err;
                    resolve({ message : 'Like annulé!' })
                })
            }
        })

    }
};

module.exports = PostsModels;