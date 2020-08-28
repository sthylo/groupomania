<template>
    <v-app class="signup ma-auto mt-6" v-if="form">
        <v-card class="signup__card" raised>
            <v-card-text>
                <v-form ref="form" v-model="valid">
                    <v-text-field  v-model="dataSignup.firstName" :rules="firstNameRules" label="Prénom" prepend-icon="mdi-account-outline" color="black" autofocus required></v-text-field>
                    <v-text-field  v-model="dataSignup.lastName" :rules="lastNameRules" label="Nom" prepend-icon="mdi-account-outline" color="black" required></v-text-field>
                    <v-text-field  v-model="dataSignup.email" :rules="emailRules" label="e-mail" prepend-icon="mdi-at" color="black" required></v-text-field>
                    <v-text-field  v-model="dataSignup.password" :rules="passRules" error-count="4" type="password" label="Mot de passe" prepend-icon="mdi-lock-outline" color="black" required></v-text-field>
                </v-form>
                <template>
                  <div class="text-center">
                    <v-dialog v-model="dialog" persistent width="500">
                      <template v-slot:activator="{ on, attrs }">
                        <v-btn :disabled="!valid" class="success" v-bind="attrs" v-on="on">Confirmer</v-btn>
                      </template>
                      <v-card>
                        <v-card-title class="text-center">
                          Votre compte a été créé ! <br/>
                          Veuillez vous connecter pour accéder à l'intranet.
                        </v-card-title>
                        <v-divider></v-divider>
                        <v-card-actions>
                          <v-spacer></v-spacer>
                          <v-btn @click="sendSignup()" class="success">Se connecter</v-btn>
                        </v-card-actions>
                      </v-card>
                    </v-dialog>
                  </div>
                </template>
                <p v-if="msg">{{ message }}</p>
            </v-card-text>
        </v-card>
    </v-app>
</template>
<script>
import axios from "axios"

export default {
    name : "Signup",
    data(){
        return{
            valid: true,
            firstNameRules: [
                v => !!v || 'Renseignez votre prénom',
                v => /^[A-Za-z]+$/.test(v) || "Votre prénom n'est pas valide",
            ],
            lastNameRules: [
                v => !!v || 'Renseignez votre nom',
                v => /^[A-Za-z]+$/.test(v) || "Votre nom n'est pas valide",
            ],
            emailRules: [
                v => !!v || 'Renseignez votre e-mail',
                v => /.+@.+\..+/.test(v) || "Votre e-mail n'est pas valide",
            ],
            passRules: [
                v => !!v || 'Renseignez votre mot de passe',
                v => (v && v.length >= 5) || '5 caractères minimun',
                v => /(?=.*[A-Z])/.test(v) || 'Au moins une majuscule', 
                v => /(?=.*\d)/.test(v) || 'Au moins un chiffre',
            ],
            dataSignup:{
                firstName: "",
                lastName: "",
                email: "",
                password: "",
            },
            dataSignupS: "", 
            form: true,
            msg: false,
            message: ""
        }
    },
    methods: {
        sendSignup(){
            this.dataSignupS = JSON.stringify(this.dataSignup)
            axios.post('http://localhost:3000/api/auth/signup', this.dataSignupS, {headers: {'Content-Type': 'application/json'}})
            .then(response => {
                let sign = JSON.parse(response.data);
                this.message = sign.message;
                this.form = false;
                this.msg = true;
            })
            .catch(error => {
                console.log(error);
                this.message = error;
                this.msg = true; 
                });
        }
    }
}
</script>
<style lang="scss">
    .signup{
        position: flex;
        flex-direction: row;
        top: 5%;
        width: 350px;
        height: 200px;
        text-align: center;
    }
</style>
