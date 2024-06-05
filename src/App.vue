<script setup>
import { ref, computed } from 'vue'

import Login from './components/Login-form.vue'
import MianScreen  from './components/Main_screen.vue'
// import Test from './components/Comp_2.vue'
import Bets from './components/Sport_Bets.vue'
import Your_Bet from './components/Your_Bet.vue'
// import All_your_bets from './components/All_your_bets.vue'
import Register_user from './components/Register_user.vue'
import xd from './components/Comp_2.vue'



const routes = {
  '/login': Login,
  '/': MianScreen,
  // '/test': Test,
  '/bets': Bets,
  '/your': Your_Bet,
  // '/end': All_your_bets,
  '/register': Register_user,
  '/com': xd
  

}


const currentPath = ref(window.location.hash)

window.addEventListener('hashchange', () => {
  currentPath.value = window.location.hash
})

const currentView = computed(() => {
  return routes[currentPath.value.slice(1) || '/'] 
})
const navigate = (path) => {
  window.location.hash = path
}
</script>

<template>
  <div class="top-navbar navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="logo navbar-brand"> <!-- Zmiana klasy logo na navbar-brand -->
      <a href="#/" class="company">Pewniaczki.pl</a>
    </div>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav mr-auto">
        <li class="nav-item">
          <a class="nav-link" href="#/">Home</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#" @click="() => navigate('/test')">Zaloguj się</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#/login" @click="() => navigate('/bets')">Bets</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#/com" @click="() => navigate('/your')">Your Bets</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#" @click="() => navigate('/end')">Your Bets</a>
        </li>
      </ul>
      <div class="buttons">
        <button v-if="!loggedIn" class="btn btn-light" @click="() => navigate('/login')">Zaloguj się</button>
        <button v-else class="btn btn-light" @click="deposit">Wpłać</button>
        <button v-if="!loggedIn" class="btn btn-light" @click="() => navigate('/register')">Załóż konto</button>
        <button v-else class="btn btn-light" @click="withdraw">Wypłać</button>
        <button v-if="loggedIn" class="btn btn-light" @click="logout">Wyloguj się</button>
        <div v-if="loggedIn" class="user-options">
          <img src="./assets/user.png" alt="User Icon" width="30" height="30" @mouseover="showOptions = true" @mouseleave="showOptions = false">
          <ul v-if="showOptions" class="user-menu dropdown-menu" aria-labelledby="navbarDropdown">
            <li><a class="dropdown-item" href="#">Profil</a></li>
            <li><a class="dropdown-item" href="#">Ustawienia</a></li>
            <li><a class="dropdown-item" href="#" @click="logout">Wyloguj się</a></li>
          </ul>
        </div>
      </div>
    </div>
  </div>
  <component 
    :is="currentView" 
    @my-login="handleLogin" 
    @my-register="handleLogin" 
    :hidden="currentPath !== '#/login' && currentPath !== '#/register' && currentPath !== '#/'"
  />
</template>

<script>
import LoginForm from './components/Login-form.vue';

export default {
  data(){
    // Sprawdź, czy użytkownik jest zalogowany na podstawie danych w localStorage
    const isLoggedIn = JSON.parse(localStorage.getItem('loggedIn'));

    return {
      loggedIn: isLoggedIn || false, // Ustaw loggedIn na wartość z localStorage lub false, jeśli brak danych
      showLoginForm: false
    };
  },
  components: {
    LoginForm,
    Register_user,
  },
  methods: {
    testEmit(){
      console.log('elo');
    },
    handleLogin() {
      console.log("event");
      localStorage.setItem('loggedIn', true);
      this.loggedIn = true;
      this.showLoginForm = false; // Ukrycie komponentu logowania po zalogowaniu
    },
    check(){
      console.log(this.loggedIn)
    },
    logout(){
      console.log("logout")
      localStorage.setItem('loggedIn', false);
      this.loggedIn = false
    }
  }
}
</script>

<style scoped>
body {
  overflow: hidden; /* Blokowanie przewijania całej strony */
}
.top-navbar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 10px 20px;
  background-color: #072b9a;
}

.logo {
  font-size: 20px;
  font-weight: bold;
}

.buttons {
  display: flex;
}

.buttons button {
  margin-left: 10px;
  padding: 8px 15px;
  background-color: #4CAF50; /* Zielony */
  color: white;
  border: none;
  cursor: pointer;
}
.company{
  color:Black;
  text-decoration: none; 
}


</style>
