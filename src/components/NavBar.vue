<template>
  <div class="top-navbar">
    <div class="logo">
      <router-link to="/">Pewniaczki.pl</router-link>
    </div>
    <div class="buttons">
      <button @click="login">Zaloguj się</button>
      <button @click="register">Załóż konto</button>
    </div>
  </div>
</template>

<script>
export default {
  methods: {
    login() {
      this.$router.push('/login'); // Używanie routera dostępnego przez this.$router
      console.log('Zaloguj się');
    },
    register() {
      this.$router.push('/register'); // Używanie routera dostępnego przez this.$router
      console.log('Załóż konto');
    }
  }
}
</script>

<style scoped>
.top-navbar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 10px 20px;
  background-color: #f0f0f0;
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

.buttons button:hover {
  background-color: #45a049; /* Zielony ciemniejszy */
}
</style>
