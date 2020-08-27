<template>
    <v-app class="login ma-auto mt-6">
        <v-card raised>
            <v-card-text>
                <v-form ref="form" v-model="valid">
                    <v-text-field v-model="dataLogin.email" :rules="emailRules" label="e-mail" prepend-icon="mdi-at" color="black" required autofocus></v-text-field>
                    <v-text-field v-model="dataLogin.password" :rules="passRules" type="password" label="Mot de passe" prepend-icon="mdi-lock-outline" color="black" required></v-text-field>
                </v-form>
            </v-card-text>
            
            <v-btn :disabled="!valid" class="success mb-3" @click="sendLogin()">Valider</v-btn>
            <p v-if="msg">{{ message }}</p>
            
        </v-card>
    </v-app>
</template>
<script>

import axios from "axios"

export default {
    name : "Login",
    data(){
        return{
            valid: true,
            emailRules: [
                v => !!v || 'Renseignez votre e-mail',
                v => /.+@.+\..+/.test(v) || "Votre e-mail n'est pas valide",
            ],
            passRules: [
                v => !!v || 'Renseignez votre mot de passe'
            ],
            dataLogin: {
                email: "",
                password: "",
            },
            dataLoginS: "",
            msg: false,
            message: ""
        }
    },
    methods: {
        sendLogin(){
            this.dataLoginS = JSON.stringify(this.dataLogin);
            axios.post('http://localhost:3000/api/auth/login', this.dataLoginS, {headers: {'Content-Type': 'application/json'}})
                .then(response => {
                    let log = JSON.parse(response.data);
                    localStorage.userId = log.userId;
                    localStorage.token = log.token;
                    localStorage.moderation = log.moderation;
                    this.$router.push('/Accueil');  
                })
                .catch(error => {
                    console.log(error);
                    this.message = error;
                    this.msg = true 
                }); 
        }
    }
}
</script>
<style lang="scss">
    .login{
        position: flex;
        flex-direction: row;
        top: 5%;
        width: 350px;
        height: 200px;
        text-align: center;
    }
</style>