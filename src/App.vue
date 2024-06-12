<script setup>
import { ref, computed } from 'vue'
import Login from './components/Login-form.vue'
import MainScreen from './components/Main_screen.vue'
import Bets from './components/Sport_Bets.vue'
import YourBet from './components/Your_Bet.vue'
import RegisterUser from './components/Register_user.vue'
// import xd from './components/compon_1.vue'
import icon from './components/icon_action.vue'
import my_bets from './components/My_Bets.vue'
import add_money from './components/Add_money.vue'

const routes = {
  '/login': Login,
  '/': MainScreen,
  '/bets': Bets,
  '/your': YourBet,
  '/register': RegisterUser,
  '/com':my_bets,
  '/icon': icon,
  '/my-bets': my_bets,
  '/add-money': add_money

}

const currentPath = ref(window.location.hash.slice(1) || '/')

window.addEventListener('hashchange', () => {
  currentPath.value = window.location.hash.slice(1) || '/'
  console.log('Current Path:', currentPath.value)
})

const currentView = computed(() => {
  console.log('Current View:', currentPath.value)
  return routes[currentPath.value] || MainScreen
})

const navigate = (path) => {
  window.location.hash = path
  console.log('Navigating to:', path)
}

const loggedIn = ref(JSON.parse(localStorage.getItem('loggedIn')) || false)
const showOptions = ref(false)

const handleLogin = () => {
  localStorage.setItem('loggedIn', true)
  loggedIn.value = true
  console.log('Logged In:', loggedIn.value)
}

const logout = () => {
  localStorage.setItem('loggedIn', false)
  loggedIn.value = false
  navigate('/login')
  console.log('Logged Out:', loggedIn.value)
}
</script>
<template>
  <div>
    <div class="top-navbar navbar navbar-expand-lg navbar-dark bg-primary">
      <div class="logo navbar-brand">
        <a href="#/" class="company">Pewniaczki.pl</a>
      </div>
      <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
          <li class="nav-item">
            <a class="nav-link" href="#/" @click="() => navigate('/')">Home</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#/icon" @click="() => toggleUserOptions()">Bets</a>
          </li>
          <li class="nav-item">
            <a class="dropdown-item" href="#" @click="logout">Wyloguj się</a>
          </li>
        </ul>
        <div class="buttons">
          <button v-if="!loggedIn" class="btn btn-light" @click="() => navigate('/login')">Zaloguj się</button>
          <button v-if="!loggedIn" class="btn btn-light" @click="() => navigate('/register')">Załóż konto</button>
          <div v-if="loggedIn" class="saldo-container">
           <p  class="saldo-label">Depozyt</p>
           <p class="saldo-amount">20 PLN</p>
          </div>
          <button v-if="loggedIn" class="btn btn-dark" @click="() => navigate('/add-money')">Wpłać</button>
          <div class="user-options-container">
            <div class="user-options" @mouseover="showOptions = true" @mouseleave="showOptions = false">
              <img v-if="loggedIn" src="./assets/user.png" alt="User Icon" width="30" height="30" @click="toggleUserOptions()">
              <div v-show="showOptions" class="user-menu">
                <ul>
                  <li><a class="dropdown-item" href="#/my-bets">Moje Bety</a></li>
                  <li><a class="dropdown-item" href="#">Mój Profil</a></li>
                  <li><a class="dropdown-item" href="#" @click="logout">Wyloguj się</a></li>
                </ul>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!-- <div v-show="showIcon" class="icon-overlay" @click="toggleUserOptions()">
      <icon />
    </div> -->
    <component :is="currentView" @my-login="handleLogin" />
  </div>
</template>
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
  position: relative;
}

.logo {
  font-size: 20px;
  font-weight: bold;
}

.company {
  color: black;
  text-decoration: none;
}

.buttons {
  display: flex;
  align-items: center;
}

.buttons button {
  margin-left: 10px;
  padding: 8px 15px;
  background-color: #4CAF50; /* Zielony */
  color: white;
  border: none;
  cursor: pointer;
}
.btn.btn-dark {
  background-color: orange;
  color: black;
}

.user-options {
  position: absolute;
  margin-right: 200px;
}
.user-options-container {
  height: 30px; /* Stała wysokość kontenera dla ikony użytkownika */
  margin-right: 20px; 
}

.user-options img {
  cursor: pointer;
}

.user-menu {
  position: relative;
  top: 100%;

  right: 80%;
  width: 100%; 
  background-color: white;
  border: 1px solid #ab1616;
  border-radius: 4px;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
  padding: 10px;
  z-index: 10;
}

.user-menu ul {
  margin: 0;
  padding: 0;
  list-style: none;
}

.user-menu .dropdown-item {
  padding: 10px 20px;
  cursor: pointer;
  color: #333;
  text-decoration: none;
}

.user-menu .dropdown-item:hover {
  background-color: #f1f1f1;
}
.icon-overlay {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.5); /* Przezroczyste tło */
  z-index: 999; /* Wyższy index, aby ikona była na wierzchu */
  display: flex;
  justify-content: center;
  align-items: center;
}


.saldo-label {
  font-weight: bold; /* Pogrubienie etykiety */
  margin-bottom: 5px; /* Odstęp między etykietą a saldem */
}

.saldo-amount {
  font-size: 18px; /* Rozmiar tekstu salda */
  margin: 0; /* Usunięcie marginesu na górze i na dole */
}

</style>
