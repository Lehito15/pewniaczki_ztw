<template>
  <div class="container betting-odds-container">
    <h2 class="text-center">Twoje Zakłady</h2>
    <div class="betting-odds-list">
      <div
        v-for="(bettingOdd, index) in bets"
        :key="index"
        class="betting-odd p-3 bg-light rounded mb-3 d-flex justify-content-between align-items-center"
        @mouseover="hoverEffect(true, index)"
        @mouseleave="hoverEffect(false, index)"
      >
        <p>{{ bettingOdd.team1 }} vs {{ bettingOdd.team2 }}</p>
        <p>
          Twój typ:
          <template v-if="bettingOdd.oddsType === 'odds1'">
            {{ bettingOdd.team1 }}
          </template>
          <template v-else-if="bettingOdd.oddsType === 'oddsX'">
            Remis
          </template>
          <template v-else-if="bettingOdd.oddsType === 'odds2'">
            {{ bettingOdd.team2 }}
          </template>
        </p>
        <button class="btn btn-danger" @click="removeBet(index)">Usuń</button>
      </div>
    </div>

    <!-- Komponent Your_bet umieszczony pod listą zakładów -->
    <Your_bet :bets="bets" @remove-bet="removeBet" />
  </div>
</template>

<script>
import Your_bet from './Send_bet.vue'; // Poprawiona ścieżka do komponentu Your_bet.vue

export default {
  components: {
    Your_bet // Zarejestrowanie komponentu Your_bet
  },
  data() {
    return {
      bets: [] // Inicjalizacja pustej tablicy, w której będą przechowywane zakłady
    };
  },
  methods: {
    // Metoda do parsowania danych z localStorage
    dataToJSON() {
      console.log('dataToJSON method called');
      const selectedBetsList = localStorage.getItem('selectedBetsList');
      if (selectedBetsList) {
        try {
          this.bets = JSON.parse(selectedBetsList);
          console.log('Bets loaded:', this.bets);
        } catch (error) {
          console.error('Error parsing selectedBetsList:', error);
        }
      } else {
        console.warn('selectedBetsList is null or undefined.');
        this.bets = []; // Ustawienie pustej tablicy, jeśli nie ma zapisanych zakładów
      }
    },
    // Metoda do usuwania zakładu
    removeBet(index) {
      this.bets.splice(index, 1);
      localStorage.setItem('selectedBetsList', JSON.stringify(this.bets));
    },
    // Metoda do obsługi efektu najechania myszką
    hoverEffect(activate, index) {
      const element = document.getElementsByClassName('betting-odd')[index];
      if (activate) {
        element.style.backgroundColor = '#d2d8de';
      } else {
        element.style.backgroundColor = '#f8f9fa';
      }
    }
  },
  mounted() {
    console.log('Component mounted');
    // Wywołanie metody do parsowania danych z localStorage po załadowaniu komponentu
    this.dataToJSON();
  }
};
</script>

<style scoped>
.container {
  width: 60%;
  margin: 0 auto; /* Centrowanie na stronie */
}

.betting-odds-list {
  margin-top: 10px;
}

.betting-odd {
  transition: background-color 0.3s;
}

.betting-odd:hover {
  background-color: #d2d8de;
}
</style>
