<template>
    <v-app id="forum" class="forum">

        <top-header/>
        <div class="ml-12">
            <h1 class="ma-4">Forum</h1>
            

            <router-view></router-view>
            <v-container >
                <v-btn class="ma-3" color="black white--text" @click="afficheForm">Créer un post</v-btn>
                
                <v-card class="forum__post ma-3 mt-6" v-for="(post, index) in allPosts" v-bind:key="index">
                    <div class="d-flex justify-space-between">
                        <v-card-title>
                            <h2 class="forum__post__title ml-0">{{ post.title }}</h2>
                        </v-card-title>
                        <v-card-actions class=" forum__post__manage" v-if="post.userId == userId">
                            <v-btn class="forum__post__manage--btn" color="black" title="modifier le post" @click.stop="goDialogUpPost(post.title, post.content, post.id)" icon>
                                <v-icon>mdi-pencil</v-icon>
                            </v-btn>
                            <v-btn class="forum__post__manage--btn" color="black" title="supprimer le post" @click="deletePost(post.id)" icon>
                                <v-icon>mdi-delete</v-icon>
                            </v-btn> 
                        </v-card-actions>

                    </div>

                    <v-card-subtitle class="forum__post__name">
                        Par {{ post.firstName }} {{ post.lastName }}, le {{ post.date }} à {{ post.time }}
                    </v-card-subtitle>

                    <v-card-text class="v-card-text black--text forum__post__content" >
                        {{ post.content }}
                    </v-card-text>


                    <v-card-text class="py-0">
                        <v-btn icon fab title="J'aime" class="ma-3" color="green"  @click="likePost(post.id, post.likes)">
                                <v-icon>mdi-thumb-up</v-icon>
                                {{ post.likes }}
                        </v-btn> 
                            
                        <v-btn text @click="afficheCom(post.id)" title="Voir les commentaires">
                            <v-icon>mdi-comment-eye</v-icon>
                            Voir les commentaires 
                        </v-btn>
                    </v-card-text>

            
                    <v-dialog v-model="dialogUpPost" max-width="500px">
                        <v-card>
                            <v-card-title>Modifier mon post</v-card-title>
                            <v-card-text>
                                <v-form ref="form" v-model="valid">
                                    <v-text-field v-model="dataPost.title" color="black" :rules="titleRules" :counter="50" label="Titre"></v-text-field>
                                    <v-textarea v-model="dataPost.content" color="black" :rules="contentRules" label="Commentaire"></v-textarea>
                                </v-form>
                            </v-card-text>
                            <v-card-actions>
                                <v-btn text @click="dialogUpPost=false">Annuler</v-btn>
                                <v-btn text :disabled="!valid" @click="updatePost()">Valider</v-btn>
                            </v-card-actions>
                        </v-card>
                    </v-dialog>

                
                    <div class="forum__comments" v-if="postId === post.id">
                        <v-card class="forum__comments--ind my-1 mx-2 pa-3 " color="#ECECEC" v-for="(comment, index) in allComments" v-bind:key="index" outlined>
                            <v-card-subtitle class="pa-0 forum__comments__name">
                                Le {{ comment.date }}, {{ comment.firstName }} {{ comment.lastName }} commente :
                            </v-card-subtitle>

                            <v-card-text class="pa-0 text--primary forum__comments__content ">
                                {{ comment.comContent }}
                            </v-card-text>

                            
                            <v-dialog v-model="dialogUpCom" max-width="500px">
                                <v-card>
                                    <v-card-title>Modifier mon commentaire</v-card-title>
                                    <v-card-text>
                                        <v-form ref="form" v-model="valid">
                                            <v-textarea v-model="dataCom.content" color="black" :rules="comContentRules" :counter="255" label="Commentaire"></v-textarea>
                                        </v-form>
                                    </v-card-text>
                                    <v-card-actions>
                                        <v-btn text @click="dialogUpCom=false">Annuler</v-btn>
                                        <v-btn text :disabled="!valid" @click="updateCom()">Valider</v-btn>
                                    </v-card-actions>
                                </v-card>
                            </v-dialog>
                        </v-card>

                        <v-btn v-if="!afficheFrmCm" color="black white--text" title="commenter le post" class="ma-2" @click="afficheFormCom()">Commenter</v-btn>
                        
                        
                        <v-card v-if="afficheFrmCm">
                            <v-form  ref="form" class="ma-3" v-model="valid" v-if="form">
                                <v-textarea background-color="#ECECEC" color="black" v-model="dataCom.content" :rules="comContentRules" :counter="255" label="Commentaire" autofocus required></v-textarea>
                            </v-form>
                            <v-btn :disabled="!valid" class="success ma-2" @click="sendCom(post.id)">Poster</v-btn>
                            
                        </v-card>
                    </div>
                </v-card>
            </v-container>
        </div>
    </v-app>
</template>

<script>
import TopHeader from "./TopHeader"

import axios from "axios"

export default {
    name: "forum",
    data(){
        return{
            userId: "",
            admin: "",
            afficheFrmCm: false,
            allPosts: [],
            allLikes: [],
            allComments: [],
            postId: "",
            dialogUpCom: false,
            dialogUpPost: false,

            valid: true,
            titleRules: [
                v => !!v || 'Titre de la publication',
                v => (v && v.length <= 50) || 'Le titre doit faire moins de 50 caractères',
            ],
            contentRules: [
                v => !!v || 'Ecrivez votre message',
            ],
            comContentRules: [
                v => !!v || 'Ecrivez votre commentaire',
                v => (v && v.length <= 255) || 'Le commentaire doit faire moins de 255 caractères',
            ],
            dataPost: {
                id: "",
                title:"",
                content:"",
                userId:"",
            },
            dataPostS: "",
            dataCom:{
                id: "",
                content:"",
                userId: ""
            },
            dataComS: "",
            dataLike:{
                userId: "",
                nbLikes: "",
                postId: "",
                liked: false,
            },
            dataLikeS: "",
            form: true
            
            
        }
    },
    methods: {
        afficheCom(pId){
            this.postId = pId;
            this.afficheFrmCm = false;
            axios.get("http://localhost:3000/api/posts/" + pId + "/comments", {headers: {Authorization: 'Bearer ' + localStorage.token}})
                .then(response => {
                    let com = JSON.parse(response.data);
                    this.allComments = com;
                })
                .catch(error => {
                console.log(error);
                });
        },
        sendCom(pId){
            this.dataCom.userId = this.userId;
            this.dataComS = JSON.stringify(this.dataCom);
            axios.post("http://localhost:3000/api/posts/" + pId + "/comments", this.dataComS, {headers: {'Content-Type': 'application/json', Authorization: 'Bearer ' + localStorage.token}})
                .then(response => {
                    let rep = JSON.parse(response.data);
                    console.log(rep.message);
                    this.dataCom.content="";
                    this.dataCom.userId="";
                    this.afficheFrmCm=false;
                })
                .catch(error => {
                    console.log(error); 
                    this.message=error;
                    this.msg=true
                });
        },
        deletePost(pId){
            axios.delete("http://localhost:3000/api/posts/" + pId, {headers: {Authorization: 'Bearer ' + localStorage.token}})
                .then(response => {
                    let rep = JSON.parse(response.data);
                    console.log(rep.message);
                    window.location.assign('http://localhost:8080/Accueil/forum');
                })
                .catch(error => {
                    console.log(error);    
                })
        },
        deleteCom(cId){
            axios.delete("http://localhost:3000/api/posts/comments/" + cId, {headers: {Authorization: 'Bearer ' + localStorage.token}})
                .then(response => {
                    let rep = JSON.parse(response.data);
                    console.log(rep.message);
                    window.location.assign('http://localhost:8080/Accueil/forum');
                })
                .catch(error => {
                    console.log(error);
                })
        },
        goDialogUpPost(postTitle, postContent, postId){
            this.dataPost.title = postTitle;
            this.dataPost.content = postContent;
            this.dataPost.id = postId;
            this.dialogUpPost = true;
        },
        updatePost(){
            this.dataPost.userId = localStorage.userId;
            this.dataPostS = JSON.stringify(this.dataPost);
            axios.put("http://localhost:3000/api/posts/" + this.dataPost.id, this.dataPostS, {headers: {'Content-Type': 'application/json', Authorization: 'Bearer ' + localStorage.token}})
                .then(response => {
                    let rep = JSON.parse(response.data);
                    console.log(rep.message);
                    this.dataPost.title = "";
                    this.dataPost.content = "";
                    this.dataPost.userId = "";
                    this.dataPost.id = "";
                    this.dialogUpPost = false;
                    window.location.assign('http://localhost:8080/Accueil/forum');
                })
                .catch(error => {
                    console.log(error);
                })
        },
        goDialogUpCom(comContent, comId){
            this.dataCom.id = comId;
            this.dataCom.content = comContent;
            this.dialogUpCom = true; 
        },
        updateCom(){
            this.dataCom.userId = localStorage.userId;
            this.dataComS = JSON.stringify(this.dataComS);
            axios.put("http://localhost:3000/api/posts/comments/" + this.dataCom.id, this.dataComS, {headers: {'Content-Type': 'application/json', Authorization: 'Bearer ' + localStorage.token}})
                .then(response => {
                    let rep = JSON.parse(response.data);
                    console.log(rep.message);
                    this.dataCom.content = "";
                    this.dataCom.userId = "";
                    this.afficheFrmCm = false;
                    this.dialogUpCom = false;
                    window.location.assign('http://localhost:8080/Accueil/forum');
                })
                .catch(error => {
                    console.log(error);
                    
                })
        },
        afficheForm(){
            this.$router.push('/Accueil/forum/Post')
        },
        afficheFormCom(){
            this.afficheFrmCm = true
        },

        likePost(postId, nbLikes){
            this.allLikes.forEach(element => {
                if(element.postId == postId && element.userId == localStorage.userId){
                    this.dataLike.nbLikes = nbLikes+-1;
                    this.dataLike.liked = true;
                }
            });
            if(this.dataLike.liked == false){
                this.dataLike.nbLikes = nbLikes+1;
            }
            this.dataLike.userId = localStorage.userId;
            this.dataLike.postId = postId;
            this.dataLikeS = JSON.stringify(this.dataLike);
            axios.post("http://localhost:3000/api/posts/" + postId + "/like", this.dataLikeS, {headers: {'Content-Type': 'application/json', Authorization: 'Bearer ' + localStorage.token}})
                .then(response => {
                    let rep = JSON.parse(response.data);
                    console.log(rep.message);
                    this.dataLike.liked = false;
                    window.location.assign('http://localhost:8080/Accueil/forum');
                })
                .catch(error => {
                    console.log(error);
                    this.dataLike.liked = false;
                })
        },
    },
    components: {
        "top-header": TopHeader, 
    },
    mounted(){
        this.userId = localStorage.userId;
        axios.get("http://localhost:3000/api/posts", {headers: {Authorization: 'Bearer ' + localStorage.token}})
            .then(response => {
                let posts = JSON.parse(response.data);
                this.allPosts = posts;
            })
            .catch(error => {
            console.log(error); 
            });
        axios.get("http://localhost:3000/api/posts/likes", {headers: {Authorization: 'Bearer ' + localStorage.token}})
            .then(response =>{
                let likes = JSON.parse(response.data);
                this.allLikes = likes;
            })
            .catch(error => {
                console.log(error)
            }); 
    },
}
</script>
<style lang="scss">
    h1{
        text-align: center;
    }
    .forum{
        &__comments{
            &--ind{
                position: relative;
            }
        }
   }
</style>