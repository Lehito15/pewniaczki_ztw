<template>
  <div class="user-menu">
    <ul>
      <li><button class="dropdown-button" @click="logout">Moje Bety</button></li>
      <li><button class="dropdown-button" @click="logout">Mój Profil</button></li>
      <li><button class="dropdown-button" @click="logout">Wyloguj się</button></li>
    </ul>
  </div>
</template>

<script setup>
const logout = () => {
  // Tutaj możesz dodać logikę wylogowania
  console.log('Wylogowanie użytkownika...')
}
</script>

<style scoped>
.user-menu {
  border-radius: 10px;
  background-color: #ffffff;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
  padding: 10px;
}

.user-menu ul {
  margin: 0;
  padding: 0;
  list-style: none;
}

.user-menu .dropdown-button {
  display: block;
  width: 100%;
  padding: 10px 0;
  border: none;
  background-color: transparent;
  cursor: pointer;
  text-align: left;
}

.user-menu .dropdown-button:hover {
  background-color: #f1f1f1;
}
</style>
