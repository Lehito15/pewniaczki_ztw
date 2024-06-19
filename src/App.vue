<script setup>
import { ref, computed } from 'vue'
import Login from './components/Login-form.vue'
import MainScreen from './components/Main_screen.vue'
import Bets from './components/Sport_Bets.vue'
import YourBet from './components/Your_Bet.vue'
// import RegisterUser from './components/Register_user.vue'
// import xd from './components/compon_1.vue'
import icon from './components/icon_action.vue'
import my_bets from './components/My_Bets.vue'
import add_money from './components/Add_money.vue'
import make_bet from'./components/make_bet.vue'

const routes = {
  '/login': Login,
  '/': MainScreen,
  '/bets': Bets,
  '/your': YourBet,
  '/register': make_bet,
  '/com':my_bets,
  '/icon': icon,
  '/my-bets': my_bets,
  '/add-money': add_money,
  '/make-bet': make_bet

}
import { onMounted } from 'vue'

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
const print = () =>{
  const accessToken = localStorage.getItem('access_token');
  const refreshToken = localStorage.getItem('refresh_token');

  // Wyświetl tokeny w konsoli
  console.log('Access Token:', accessToken);
  console.log('Refresh Token:', refreshToken);
   const logoutUri = encodeURIComponent("http://localhost:8080");
  console.log("logoituri")
  console.log(logoutUri);
}
const getBalance = async() =>{
   try {
        const access_token = localStorage.getItem('access_token');
        const response = await fetch('http://localhost:8081/account-balance', {
          method: 'GET',
          headers: {
            'Authorization': `Bearer ${access_token}`,
            'Content-Type': 'application/json'
          }
        });

        if (!response.ok) {
          throw new Error('Network response was not ok ' + response.statusText);
        }

        const data = await response.json();
        amount = data; // Aktualizacja wartości salda
        console.log('Current balance:', data);
      } catch (error) {
        console.error('There was a problem with the fetch operation:', error);
        // Obsługa błędów
        this.errorMessage = 'Nie udało się pobrać salda konta.';
      }

}


const loggedIn = ref(JSON.parse(localStorage.getItem('loggedIn')) || false)
const showOptions = ref(false)
let amount = 0
let refreshTokenInterval = null

const handleLogin = () => {
  localStorage.setItem('loggedIn', true)
  loggedIn.value = true
  console.log('Logged In:', loggedIn.value)
}

const logout = () => {
  // Ustaw stan wylogowania w localStorage
  localStorage.setItem('loggedIn', false);

  // Zaktualizuj stan aplikacji
  loggedIn.value = false;

  // Przekieruj użytkownika na stronę logowania
  navigate('/login');

  console.log('Logged Out:', loggedIn.value);

  // Przygotuj URL do wylogowania z Cognito
  const logoutUri = encodeURIComponent("http://localhost:8080");
  console.log("logoituri")
  console.log(logoutUri);
  const clientId = "4e9n69qdrtscnsd0d3907csknu"

  // Użyj backticków (`) do budowania stringu z wstawieniem zmiennej
  window.location.href = `https://pewniaczki.auth.us-east-1.amazoncognito.com/logout?client_id=${clientId}&logout_uri=${logoutUri}`;
}


const awsLogin = () => {
  window.location.href =  "https://pewniaczki.auth.us-east-1.amazoncognito.com/oauth2/authorize?response_type=code&client_id=4e9n69qdrtscnsd0d3907csknu&redirect_uri=http://localhost:8080"
}
const awsSignUp = () => {
  window.location.href = "https://pewniaczki.auth.us-east-1.amazoncognito.com/signup?response_type=code&client_id=4e9n69qdrtscnsd0d3907csknu&redirect_uri=http://localhost:8080"
}

const handleLoginAWS = async () => {
  const urlParams = new URLSearchParams(window.location.search);
  const code = urlParams.get('code');
  console.log(code);

  if (code) {
    try {
      const response = await fetch(
        `https://pewniaczki.auth.us-east-1.amazoncognito.com/oauth2/token`,
        {
          method: 'POST',
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            "Authorization": "Basic " + btoa("4e9n69qdrtscnsd0d3907csknu:j4kpi85logc1v12po8dmf9klaejhtbsk45eg7bu7jvh13uqeu42")

          },
          body: new URLSearchParams({
            grant_type: 'authorization_code',
            client_id: '4e9n69qdrtscnsd0d3907csknu', // Podmień na swój Client ID
            code: code,
            redirect_uri: 'http://localhost:8080'
          })    
        }
      );

      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }

      const tokenData = await response.json();

      // Przechowaj tokeny w localStorage
      localStorage.setItem('access_token', tokenData.access_token);
      localStorage.setItem('id_token', tokenData.id_token);
      localStorage.setItem('refresh_token', tokenData.refresh_token);
      refreshTokenInterval = setInterval(refreshToken, 60000)
      localStorage.setItem('loggedIn', true)

      // Ustaw stan zalogowania
      loggedIn.value = true;
      
    } catch (error) {
      console.error('Error exchanging code for tokens:', error);
    }
  }
};

const refreshToken = () =>{
    console.log("update")
    const headers = {   
  "Content-Type": "application/x-www-form-urlencoded",
  "Authorization": "Basic " + btoa("4e9n69qdrtscnsd0d3907csknu:j4kpi85logc1v12po8dmf9klaejhtbsk45eg7bu7jvh13uqeu42")
  
}
   
    let refreshToken = localStorage.getItem('refresh_token');

    const urlRefresh = "https://pewniaczki.auth.us-east-1.amazoncognito.com/oauth2/token"
    let data = new URLSearchParams({
        "grant_type": "refresh_token",
        "client_id": "4e9n69qdrtscnsd0d3907csknu",
        "refresh_token": refreshToken
      });

    fetch(urlRefresh, {
        method: "POST",
        headers: headers,
        body: data
      })
      .then(response => response.json())
      .then(data =>{ console.log(data.access_token);
      localStorage.setItem('access_token', data.access_token);
    //   localStorage.setItem('refreshToken', data.refresh_token)
    }
      
    
    )
      .catch(error => console.error("Error:", error));

}



onMounted(() => {
  handleLoginAWS(); // Uruchom logikę logowania, gdy komponent się zamontuje
  getBalance();
  

  if (loggedIn.value) {
    refreshTokenInterval.value = setInterval(refreshToken, 60000); // Odświeżaj token co 60 sekund
  }
});

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
            <a class="nav-link" href="#/" @click="() => print()">Home</a>
          </li>
          <li class="nav-item" v-if="loggedIn">
            <a class="nav-link" href="#/my-bets" @click="() => navigate('/my-bets')">MyBet</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#/icon" @click="() => toggleUserOptions()">Bets</a>
          </li>
          <li class="nav-item" v-if="loggedIn">
            <a class="nav-link" href="#" @click="logout">Wyloguj się</a>
          </li>
        </ul>
        <div class="buttons">
          <button v-if="!loggedIn" class="btn btn-light" @click="() => awsLogin()">Zaloguj się</button>
          <button v-if="!loggedIn" class="btn btn-light" @click="() => awsSignUp()">Załóż konto</button>
          <div v-if="loggedIn" class="saldo-container">
           <p  class="saldo-label">Depozyt</p>
           <p> <span>{{ amount }} zł</span></p>
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
   <!-- <button  class="btn btn-light" @click="() => print()">Zaloguj się</button> -->
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
