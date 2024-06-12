<template>
  <div class="betting-summary">
    <div class="summary-left">
      <h2>Twój kupon</h2>
    </div>
    <div class="summary-right">
      <div class="summary-item">
        <label for="stake">Stawka:</label>
        <input type="number" id="stake" v-model.number="stake" min="0" step="any">
        <span>PLN</span>
      </div>
      <div class="summary-item">
        <label>Kurs:</label>
        <span>{{ odds }}</span>
      </div>
      <div class="summary-item">
        <label>Wygrana:</label>
        <span>{{ calculateWinnings }} PLN</span>
      </div>
      <button @click="confirmBet">Podsumowanie</button>
    </div>
  </div>
</template>

<script>
import eventHub from '../eventHub.js';
export default {
    data() {
        return {
            stake: 10, // Początkowa wartość stawki
            odds: 0 // Przykładowy kurs
        };
    },
    computed: {
        calculateWinnings() {
            // Logika obliczania wygranej na podstawie stawki i kursu
            return (this.stake * this.odds).toFixed(2);
        }
    },
    methods: {
        confirmBet() {
          const logged = localStorage.getItem('loggedIn') ;
          console.log(logged);
          if(logged === 'true'){
            console.log('Bet confirmed!');
          }
          else{
            alert('Musisz być zalogowanym');
          }

            
            // Tutaj możesz umieścić logikę potwierdzenia zakładu
        },
        calculete() {
      const storedBets = localStorage.getItem('selectedBetsList');
      const bets = storedBets ? JSON.parse(storedBets) : [];
      console.log("calculate", bets);

      // Calculate the odds based on the selected bets
      if (bets.length > 0) {
        this.odds = bets.reduce((totalOdds, bet) => totalOdds * bet.oddsValue, 1).toFixed(2);
        console.log(this.odds);
      } else {
        this.odds = 0;
      }
    }
    },
    mounted() {
        // Nasłuchuj na zdarzenie bet-selected emitowane przez pierwszy komponent
        eventHub.on('bet-calc', this.calculete);

    },
    // beforeUnmount() {
    //     // Usuń nasłuchiwanie zdarzenia, aby uniknąć wycieków pamięci
    //     eventHub.off('bet-calc', this.calculete);
    // }
};
</script>

<style scoped>
.betting-summary {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 20px;
  background-color: #2e3948;
  color: white;
  border: 1px solid #ccc;
  border-radius: 40px;
}

.summary-left {
  flex: 1;
}

.summary-right {
  display: flex;
  flex: 2;
  justify-content: space-between;
  align-items: center;
}

.summary-item {
  margin-right: 20px;
}

button {
  padding: 10px 20px;
  background-color: #578db3;
  color: yellow;
  border: none;
  cursor: pointer;
}

button:hover {
  background-color: #446a92;
}
</style>
