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
      <button @click="confirmBet">Wyślij</button>
    </div>
  </div>
</template>

<script>
import eventHub from '../eventHub.js';
export default {
    data() {
        return {
            stake: localStorage.getItem('deposit'), // Początkowa wartość stawki
            odds: localStorage.getItem("odd") // Przykładowy kurs
        };
    },
    computed: {
        calculateWinnings() {
            // Logika obliczania wygranej na podstawie stawki i kursu
            return (this.stake * this.odds).toFixed(2);
        }
    },
    methods: {
    async    confirmBet() {
        try{

        
  
  const bets = JSON.parse(localStorage.getItem('selectedBetsList'));
  console.log("moje bety");

  console.log(bets);
  
    if (bets.length === 0) {
            alert('Nie wybrano żadnych zakładów!');
            return;
        }
  let newList = [];
 bets.forEach(item => {
    // Sprawdzenie, czy isSingleCompetition jest prawdziwe
    
      // Dodanie nowego elementu do listy z wymaganymi danymi
      newList.push({
        eventID: item.id,
        winnerID: item.id1,
        isSingleCompetition: item.isSingleCompetition
      });
    
  });

  const body = {
    eventsWinners: newList,
    deposit: this.stake
  }


  const access_token = localStorage.getItem('access_token');
        const response = await fetch('http://localhost:8081/make-bet', {
          method: 'POST',
          headers: {
            'Authorization': `Bearer ${access_token}`,
            'Content-Type': 'application/json'
          },
         body: JSON.stringify(body)
        });
        console.log(response);
        alert('Kupon postawiony');
        window.location.href = '#/';
        }
        catch(error){
            console.error('There was a problem with the fetch operation:', error);
        // Obsługa błędów
        alert('Nie udało się dodać środków.');
        }
  
  
  
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
