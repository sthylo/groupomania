import Vue from 'vue'
import VueRouter from 'vue-router'
import Auth from '../components/Auth.vue'
import Accueil from '../components/Accueil.vue'
import Profil from '../components/Accueil/Profil.vue'
import Forum from '../components/Accueil/Forum.vue'
import Post from '../components/Accueil/FormPost.vue'
import Moderation from '../components/Accueil/Moderation.vue'


Vue.use(VueRouter)

  const routes = [
  {
    path: '/',
    name: 'Auth',
    component: Auth
  },
  {
    path: '/Accueil',
    name: 'Accueil',
    component: Accueil
  },
  {
    path: '/Accueil/Profil',
    name: 'Profil',
    component: Profil
  },
  {
    path: '/Accueil/Forum',
    name: 'Forum',
    component: Forum
  },
  {
    path: '/Accueil/Forum/Post',
    name: 'Post',
    component: Post
  },
  {
    path: '/Accueil/Moderation',
    name: 'Moderation',
    component: Moderation
  },
]

const router = new VueRouter({
  routes,
  mode: 'history'
})

export default router
