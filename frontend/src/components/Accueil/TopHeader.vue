<template>
    <div class="head">
        <v-navigation-drawer
            v-model="drawer"
            color="black"
            expand-on-hover
            mini-variant
            mini-variant-width=45
            bottom
            permanent
            absolute
            dark
        >
            <v-list dense nav>
                <v-list-item two-line class="px-0 ">
                    <v-list-item-avatar>
                        <v-img src="../../assets/logo-blanc.png" contain></v-img>
                    </v-list-item-avatar>
                        
                    <v-list-item-content>
                        <v-list-item-title>
                            Intranet Groupomania
                        </v-list-item-title>
                    </v-list-item-content>
                </v-list-item>

                <v-divider></v-divider>

                <v-list-item v-for="item in items" :key="item.title">
                    <v-list-item-icon>
                        <v-icon>{{ item.icon }}</v-icon>
                    </v-list-item-icon>

                    <v-list-item-content>
                        <router-link :to=item.link>
                            <v-list-item-title>{{ item.title }}</v-list-item-title>
                        </router-link>
                    </v-list-item-content>
                </v-list-item>

                <v-list-item v-if="this.modo==1">
                    <v-list-item-icon>
                        <v-icon>mdi-security</v-icon>
                    </v-list-item-icon>
                    <v-list-item-content @click="moderation" class="lien">
                        <v-list-item-title>Modération</v-list-item-title>
                    </v-list-item-content>
                </v-list-item>

                <v-list-item>
                    <v-list-item-icon>
                        <v-icon>mdi-logout-variant</v-icon>
                    </v-list-item-icon>
                    <v-list-item-content @click="logout" class="lien">
                        <v-list-item-title>Se déconnecter</v-list-item-title>
                    </v-list-item-content>
                </v-list-item>
            </v-list>
        </v-navigation-drawer>
    </div>
</template>

<script>
export default {
    name : 'TopHeader',
    data(){
        return {
            modo: "",
            drawer: true,
            items: [
                { title: 'Accueil', icon: 'mdi-home', link: '/Accueil'  },
                { title: 'Profil', icon: 'mdi-account', link: '/Accueil/Profil'},
                { title: 'Forum', icon: 'mdi-forum', link: '/Accueil/Forum' },
            ],
        }
    },
    methods: {
        logout(){
            localStorage.userId = "";
            localStorage.token = "";
            localStorage.moderation = "";
             this.$router.push('/');
        },
        moderation(){
            this.$router.push('/Accueil/Moderation')
        }
    },
    mounted(){
        this.modo = localStorage.moderation;
    },
}
</script>

<style lang="scss">
    a {
        text-decoration: none;
        color: white!important;
        
    }
    a:hover {
        color: #F13E18!important;
        text-decoration: underline;     
    }
    .lien {
        cursor: pointer;
    }
    .lien:hover {
        color: #F13E18!important;
        text-decoration: underline;
    }
</style>