<template>
  <div class="main-container">
    <div class="top-navbar">
      <!-- Your navbar content -->
    </div>
    <div class="content-wrapper">
      <div class="component-small">
        <Categories />
      </div>
      <div class="component-large">
        <Betss @bet-selected="handleBetSelected"/>
        <Your_Bet />
      </div>
      <div class="component-small">
        <Categories />
      </div>
    </div>
  </div>
</template>

<script>
import Betss from '../components/Sport_Bets.vue'
import Categories from '../components/Sport_Categories.vue'
import Your_Bet from './Your_Bet.vue';
import eventHub from '../eventHub.js';

export default {
  components: {
    Betss,
    Your_Bet,
    Categories
  },
  methods: {
    handleBetSelected() {
      console.log('main');
      eventHub.emit('bet-calc');
    }
  }
}
</script>

<style scoped>
.main-container {
  display: grid;
  grid-template-rows: auto 1fr; /* Pierwszy rząd dostosowuje się do zawartości, drugi rząd zajmuje dostępną przestrzeń */
  min-height: 100vh; /* Minimalna wysokość, aby kontener zajmował całą wysokość ekranu */
}

.content-wrapper {
  display: grid;
  grid-template-columns: 10% 70% 15%; /* Komponenty są rozmieszczone w proporcjach 20%, 60%, 20% */
  gap: 10px; /* Odstęp między komponentami */
}

.component-small,
.component-large {
  /* Styl komponentów */
}

.component-small {
  /* Styl dla mniejszych komponentów */
}

.component-large {
  /* Styl dla większego komponentu */
}
</style>
