<template>
  <div class="container betting-odds-container">
    <div class="betting-odds">
      <h2 class="text-center">Zakłady Bukmacherskie</h2>
      <div class="betting-odds-list">
        <div
          v-for="(bettingOdd, index) in bettingOdds"
          :key="index"
          class="betting-odd p-3 bg-light rounded mb-3"
          @mouseover="hoverEffect(true, index)"
          @mouseleave="hoverEffect(false, index)"
        >
          <div class="d-flex justify-content-between">
            <p>{{ bettingOdd.team1 }} vs {{ bettingOdd.team2 }}</p>
            <div class="d-flex align-items-center">
              <button
                class="btn custom-button"
                :class="['btn', 'me-2', isSelected(index, 'odds1') ? 'btn-warning' : 'btn-primary']"
                @click="selectBet(index, 'odds1', bettingOdd.odds1, bettingOdd.team1, bettingOdd.team2)"
              >{{ bettingOdd.odds1 }}</button>
              <button
                class="btn custom-button"
                :class="['btn', 'me-2', isSelected(index, 'oddsX') ? 'btn-warning' : 'btn-primary']"
                @click="selectBet(index, 'oddsX', bettingOdd.oddsX, bettingOdd.team1, bettingOdd.team2)"
              >X {{ bettingOdd.oddsX }}</button>
              <button
                class="btn custom-button"
                :class="['btn', isSelected(index, 'odds2') ? 'btn-warning' : 'btn-primary']"
                @click="selectBet(index, 'odds2', bettingOdd.odds2, bettingOdd.team1, bettingOdd.team2)"
              >{{ bettingOdd.odds2 }}</button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <button  @click="printBets" >Print</button>
</template>

<script>
export default {
  data() {
    return {
      bettingOdds: [
        { team1: 'FC Barcelona', team2: 'Real Madrid', odds1: 1.5, oddsX: 3.0, odds2: 2.5 },
        { team1: 'Manchester United', team2: 'Liverpool', odds1: 2.0, oddsX: 2.5, odds2: 3.0 },
        // Add more betting odds as needed
      ],
      selectedBetsList: [],
      bets: []
    };
  },
  methods: {
    async fetchBets(){
      try{
     const response = await fetch('http://localhost:8081/events')
     const  data = await response.json()
     this.bets = data
     console.log('fwefw')
    

      }
      catch(error){
        console.log(error)
        console.log("error kurde");
      }
    },
    printBets(){
         const logoutUri = encodeURIComponent("http://localhost:8080");
  console.log("logoituri")
  console.log(logoutUri);

    },
    selectBet(index, oddsType, oddsValue, team1, team2) {
      const existingBetIndex = this.selectedBetsList.findIndex(item => item.index === index);

      if (existingBetIndex !== -1) {
        this.selectedBetsList.splice(existingBetIndex, 1);
      } else {
        this.selectedBetsList = this.selectedBetsList.filter(item => item.index !== index);

        this.selectedBetsList.push({
          index,
          oddsType,
          oddsValue,
          team1,
          team2
        });
      }

      localStorage.setItem('selectedBetsList', JSON.stringify(this.selectedBetsList));
      this.$emit('bet-selected');
    },
    isSelected(index, oddsType) {
      return this.selectedBetsList.some(item => item.index === index && item.oddsType === oddsType);
    },
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
 this.fetchBets()
 }, 
};
</script>

<style scoped>
html, body {
  height: 100%;
  margin: 0;
}


.betting-odds-container {
  display: flex;
  justify-content: center;
  height: 75vh;
  overflow-y: auto;
  background-color: #2e3948;
  border-radius: 40px;
}

.betting-odds {
  width: 80%;
  max-width: 600px;
  
}

.betting-odd {
  width: 100%; /* Każdy element meczu zajmuje całą szerokość kontenera */
  background-color: #f8f9fa; /* Domyślne tło */
  transition: background-color 0.3s; /* Płynne przejście */
}

.betting-odd:hover {
  background-color: #d2d8de; /* Rozjaśnienie po najechaniu myszką */
}

.odds-buttons button {
  padding: 10px 20px;
}

.odds-buttons button.selected {
  background-color: yellow;
  color: black;
}
.custom-button {
  width: 80px; /* Stała szerokość przycisków */
  margin-right: 10px; /* Odstęp między przyciskami */
}
</style>
