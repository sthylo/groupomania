const connectdb = require('../connectdb.js');
const mysql = require('mysql');
const jwt = require('jsonwebtoken');
const ModModels = require ('../Models/ModModels.js');

let modModels = new ModModels();

exports.getAllPosts = (req, res, next) => {
    const token = req.headers.authorization.split(' ')[1];
    const decodedToken = jwt.verify(token, 'RANDOM_TOKEN_SECRET');
    const mod = decodedToken.moderation;
    if(mod == 1){
        modModels.getAllPosts()
            .then((response) => {
                res.status(200).json(JSON.stringify(response));
            })
    }else{
        res.status(400).json({error: 'Requête non authorisée'})
    }
}
exports.deletePost = (req, res, next) => {
    const token = req.headers.authorization.split(' ')[1];
    const decodedToken = jwt.verify(token, 'RANDOM_TOKEN_SECRET');
    const mod = decodedToken.moderation;
    console.log(mod);
    if(mod == 1){
        let postId = req.params.id;
        let sqlInserts = [postId];
        modModels.deletePost(sqlInserts)
            .then((response) => {
                res.status(200).json(JSON.stringify(response));
            })
    }else{
        res.status(400).json({error: 'Requête non authorisée'})
    }
}
exports.getAllComments = (req, res, next) => {
    const token = req.headers.authorization.split(' ')[1];
    const decodedToken = jwt.verify(token, 'RANDOM_TOKEN_SECRET');
    const mod = decodedToken.moderation;
    if(mod == 1){
        modModels.getAllComments()
            .then((response) =>{
                res.status(200).json(JSON.stringify(response));
            })
    }else{
        res.status(400).json({error: 'Requête non authorisée'})
    }
}
exports.deleteComment = (req, res, next) => {
    const token = req.headers.authorization.split(' ')[1];
    const decodedToken = jwt.verify(token, 'RANDOM_TOKEN_SECRET');
    const mod = decodedToken.moderation;
    if(mod == 1){
        let commentId = req.params.id;
        let sqlInserts = [commentId];
        modModels.deleteComment(sqlInserts)
            .then((response) =>{
                res.status(200).json(JSON.stringify(response));
            })
    }else{
        res.status(400).json({error: 'Requête non authorisée'})
    }
}
