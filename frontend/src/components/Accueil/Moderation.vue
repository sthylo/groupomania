<template>
    <v-app id="moderation" class="moderation">
        <top-header/>
        <div class="ml-12">
            <h1 class="ma-4">Modération</h1>
            <v-container>
                <v-btn class="ma-3" color="black white--text" @click="clickPosts">Voir les posts</v-btn>
                <v-btn class="ma-3" color="black white--text" @click="clickComments">Voir les commentaires</v-btn>
                <div v-if="showPosts">
                    <v-card class="forum__post ma-3 mt-6" v-for="(post, index) in allPosts" v-bind:key="index">
                        <v-card-title>
                            <h2 class="forum__post__title">{{ post.title }}</h2>
                        </v-card-title>

                        <v-card-subtitle class=" forum__post__name">
                            Par {{ post.firstName }} {{ post.lastName }}, le {{ post.date }}
                        </v-card-subtitle>

                        <v-card-text class="v-card-text black--text forum__post__content" >
                            {{ post.content }}
                        </v-card-text>

                        <v-card-actions class="forum__post__manage">
                            <v-btn class="forum__post__manage--btn" title="supprimer le post" @click="deletePost(post.id)" icon>
                                <v-icon>mdi-delete</v-icon>
                            </v-btn> 
                        </v-card-actions>
                    </v-card>
                </div>
                <div v-if="showComments">
                    <v-card class="forum__comments--ind my-1 mx-2 pa-0" color="#ECECEC" v-for="(comment, index) in allComments" v-bind:key="index" outlined>
                        <v-card-subtitle class=" pb-0 forum__comments__name">
                            Le {{ comment.date }}, {{ comment.firstName }} {{ comment.lastName }} commente :
                        </v-card-subtitle>

                        <v-card-text class="text--primary forum__comments__content ">
                            {{ comment.comContent }}
                        </v-card-text>

                        <v-card-actions class="forum__comments__manage">
                            <v-btn title="supprimer le commentaire" class="forum__comments__manage--btn" @click="deleteComment(comment.id)" icon>
                                <v-icon >mdi-delete</v-icon>
                            </v-btn>
                        </v-card-actions>
                    </v-card>
                </div>
            </v-container>
        </div>
    </v-app>
</template>


<script>

import TopHeader from "./TopHeader"
import axios from "axios"

export default {
    name: "Moderation",
    data(){
        return{
            allPosts: [],
            allComments: [],
            showPosts: true,
            showComments: false
        }
    },
    components: {
        "top-header": TopHeader,
    },
    methods: {
        clickPosts(){
            this.showPosts = true,
            this.showComments = false
        },
        clickComments(){
            this.showPosts = false,
            this.showComments = true
        },
        deletePost(pId){
            axios.delete("http://localhost:3000/api/moderation/post/" + pId, {headers: {Authorization: 'Bearer ' + localStorage.token}})
                .then(response => {
                    let rep = JSON.parse(response.data);
                    console.log(rep.message);
                    window.location.assign('http://localhost:8080/Accueil/Moderation');

                })
                .catch(error => {
                    console.log(error);    
                })
        },
        deleteComment(cId){
            axios.delete("http://localhost:3000/api/moderation/comment/" + cId, {headers: {Authorization: 'Bearer ' + localStorage.token}})
                .then(response => {
                    let rep = JSON.parse(response.data);
                    console.log(rep.message);
                    window.location.assign('http://localhost:8080/Accueil/Moderation');
                })
                .catch(error => {
                    console.log(error);
                })
        }
    },
    mounted(){
        axios.get("http://localhost:3000/api/moderation/posts", {headers: {Authorization: 'Bearer ' + localStorage.token}})
            .then(response => {
                let posts = JSON.parse(response.data);
                this.allPosts = posts;
            })
            .catch(error => {
            console.log(error); 
            });
        axios.get("http://localhost:3000/api/moderation/comments", {headers: {Authorization: 'Bearer ' + localStorage.token}})
                .then(response => {
                    let com = JSON.parse(response.data);
                    this.allComments = com;
                })
                .catch(error => {
                console.log(error);
                });
    }
}
</script>

<style lang="scss">

</style>