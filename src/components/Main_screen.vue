<template>
  <div class="main-container">
    <div class="top-navbar">
      <!-- Your navbar content -->
    </div>
    <div class="content-wrapper">
      <div class="component-small">
        <Categories />
      </div>
      <div class="component-small-right">
        <Categories />
      </div>
      <div class="component-large">
        <Betss @bet-selected="handleBetSelected"/>
        <Your_Bet />
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
  grid-template-rows: auto 1fr, 1fr; /* Pierwszy rząd dostosowuje się do zawartości, drugi rząd zajmuje dostępną przestrzeń, trzeci rząd dostosowuje się do zawartości */
  min-height: 90vh; /* Minimalna wysokość, aby kontener zajmował całą wysokość ekranu */
}

.content-wrapper {
  display: grid;
  grid-template-columns: 15% 70% 15%; /* Komponenty są rozmieszczone w proporcjach 15%, 70%, 15% */
  gap: 1px; /* Odstęp między komponentami */
}

.component-small,
.component-large,
.component-small-right {
  /* Styl komponentów */
}

.component-small {
  /* Styl dla mniejszych komponentów */
}

.component-large {
  /* Styl dla większego komponentu */
}

.component-small-right {
  /* Styl dla komponentu small-right */
  grid-column: 3; /* Komponent small-right zajmuje pierwszą kolumnę */
  grid-row: 3 / 1; /* Komponent small-right zajmuje drugi rząd i zaczyna się od połowy drugiego rzędu */
}
</style>
