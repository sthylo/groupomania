<template>
    <v-app id="accueil">
        <top-header/>
        <router-view></router-view>

        <v-carousel
            id="carousel"
            cycle
            height="auto"
            hide-delimiters
            :show-arrows="false"
            >
            <v-carousel-item
              v-for="(item,i) in items"
              :key="i"
              :src="item.src"
            ></v-carousel-item>
        </v-carousel>      

    </v-app>
</template>
<script>
import TopHeader from "./Accueil/TopHeader"

export default {
    name: "Accueil",
    data(){
        return{
            items: [
            {
                src: require("../assets/images/immeuble.jpg"),
            },
            {
                src: require("../assets/images/openspace.jpg"),
            },
            {
                src: require("../assets/images/chocolat.jpg"),
            },
            ]
            
        }
    },
    components: {
        "top-header": TopHeader,
    },
}
</script>
<style lang="scss">
    #accueil{
        background: no-repeat center top/70% url("../assets/icon-left-font-monochrome-black.png") ;
        display: flex;
        flex-direction: row;
    }
    #carousel{
        width: 60%;
        margin-top: 17%;
        margin-left: 20%;
    }
    .header{
        background-color: rgb(253,45,1);
        color: white;
    }
    @media screen and (min-width: 200px) and (max-width: 640px) {
    #carousel {
    padding-right: 15%;
    width: 80%;
    } 
    #accueil{
    background: no-repeat center top/70% url("../assets/icon-left-font-monochrome-black.png") ;
  }
}
        
    
</style>