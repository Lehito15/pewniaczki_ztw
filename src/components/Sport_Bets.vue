<template>
  <div class="container betting-odds-container">
    <div class="betting-odds">
      <h2 class="text-center">Zakłady Bukmacherskie</h2>
      <div class="betting-odds-list">
        <div
          v-for="(bettingOdd, index) in combinedBets"
          :key="index"
          class="betting-odd p-3 bg-light rounded mb-3"
          @mouseover="hoverEffect(true, index)"
          @mouseleave="hoverEffect(false, index)"
        >
          <div class="d-flex justify-content-between align-items-center">
            <div>
              <p class="mb-0">{{ bettingOdd.team1 }} vs {{ bettingOdd.team2 }}</p>
              <div class="small text-muted">
                <span>{{ bettingOdd.date }}</span>
                <span class="mx-1">•</span>
                <span>{{ bettingOdd.leagueName }}</span>
               
              </div>
            </div>
            <div class="d-flex align-items-center">
              <button
                class="btn custom-button"
                :class="['btn', 'me-2', isSelected(index, 'odds1') ? 'btn-warning' : 'btn-primary']"
                @click="selectBet(index, 'odds1', bettingOdd.odds1, bettingOdd.team1, bettingOdd.team2, bettingOdd.odds1, bettingOdd.odds2, bettingOdd.oddsX, bettingOdd.isSingleCompetition, bettingOdd.id, bettingOdd.id1, bettingOdd.id2)"
              >{{ bettingOdd.odds1 }}</button>
              <button
                class="btn custom-button"
                :class="['btn', 'me-2', isSelected(index, 'oddsX') ? 'btn-warning' : 'btn-primary']"
                @click="selectBet(index, 'oddsX',  bettingOdd.oddsX, bettingOdd.team1, bettingOdd.team2, bettingOdd.odds1, bettingOdd.odds2, bettingOdd.oddsX, bettingOdd.isSingleCompetition, bettingOdd.id, bettingOdd.id1, bettingOdd.id2)"
              >X {{ bettingOdd.oddsX }}</button>
              <button
                class="btn custom-button"
                :class="['btn', isSelected(index, 'odds2') ? 'btn-warning' : 'btn-primary']"
                @click="selectBet(index, 'odds2', bettingOdd.odds2, bettingOdd.team1, bettingOdd.team2, bettingOdd.odds1, bettingOdd.odds2, bettingOdd.oddsX, bettingOdd.isSingleCompetition, bettingOdd.id, bettingOdd.id1, bettingOdd.id2 )"
              >{{ bettingOdd.odds2 }}</button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <!-- <button @click="printBets">Print</button> -->
</template>

<script>
import eventHub from '../eventHub.js';
export default {
  data() {
    return {
      bettingOdds: [
        { team1: 'FC Barcelona', team2: 'Real Madrid', odds1: 1.5, oddsX: 3.0, odds2: 2.5 },
        { team1: 'Manchester United', team2: 'Liverpool', odds1: 2.0, oddsX: 2.5, odds2: 3.0 },
        // Add more betting odds as needed
      ],
      selectedBetsList: [],
      bets: [],
      detailedBets: [],
      combinedBets: []

    };
  },
  methods: {
    async fetchBets(){
      try{
     const response = await fetch('http://localhost:8081/active-events')
     const  data = await response.json()
     this.bets = data
     console.log(this.bets)
      await this.fetchDetailedBets();
    

      }
      catch(error){
        console.log(error)
        console.log("error kurde");
      }
    },
  async fetchDetailedBets() {
  this.detailedBets = [];
  this.errorMessage = ''; // Resetowanie komunikatu o błędzie

  for (const bet of this.bets) {
    try {
      let response;
      if (bet.isSingleCompetition) {
        response = await fetch(`http://localhost:8081/events/${bet.id}/sportsman`);
      } else {
        response = await fetch(`http://localhost:8081/events/${bet.id}/team`);
      }

      if (!response.ok) {
        throw new Error(`Failed to fetch details for event ID ${bet.id}`);
      }

      const data = await response.json();

      // Sprawdzenie czy data zawiera sportsman z polami firstName i lastName
   if (Array.isArray(data) && data.length > 0 && Object.prototype.hasOwnProperty.call(data[0], 'competitor') && Object.prototype.hasOwnProperty.call(data[0].competitor, 'firstName')) {
  const combinedData = data.map(item => ({
    ...item,
    competitor: {
      ...item.competitor,
      name: `${item.competitor.firstName} ${item.competitor.lastName}`
    }
  }));
        this.detailedBets.push(combinedData);
      } else {
        this.detailedBets.push(data);
      }

    } catch (error) {
      console.log(`Error fetching details for event ID ${bet.id}:`, error);
      this.errorMessage = `Error fetching details for some events`;
    }
  }
  console.log("detailed");

  console.log(this.detailedBets);
  this.combineBets();
},

    combineBets() {
  // Assuming bets and detailedBets are arrays of equal length
  if (this.bets.length !== this.detailedBets.length) {
    console.error('Lists bets and detailedBets must have the same length');
    return;
  }

  this.combinedBets = [];

  for (let i = 0; i < this.bets.length; i++) {
    const bet = this.bets[i];
    const detailedBet = this.detailedBets[i];

    // Ensure there are detailed bet details available
    // const team1 = detailedBet && detailedBet.details && detailedBet.details.length > 0 ? detailedBet.details[0].name : 'Unknown';
    // const team2 = detailedBet && detailedBet.details && detailedBet.details.length > 1 ? detailedBet.details[1].name : 'Unknown';

    this.combinedBets.push({
      id: bet.id,
      name: bet.name,
      leagueName: bet.league.name,
      discipline: bet.discipline,
      date: bet.eventDate,
      
      winner: bet.winner,
      isSingleCompetition: bet.isSingleCompetition,
      eventDate: bet.eventDate,
      drawRate: bet.drawRate,
      team1: detailedBet[0].competitor.name,
      team2: detailedBet[1].competitor.name,
      odds1: detailedBet[0].rate, // Replace with real odds if available
      oddsX: bet.drawRate, // Assuming draw rate is available in basic bet
      odds2: detailedBet[1].rate, // Replace with real odds if available
      id1: detailedBet[0].id,
      id2: detailedBet[1].id

    });
  }

  console.log(this.combinedBets);
},

    printBets(){
         const logoutUri = encodeURIComponent("http://localhost:8080");
  console.log("logoituri")
  console.log(logoutUri);

    },
    selectBet(index, oddsType, oddsValue, team1, team2, odds1, odds2, oddsX, isSingleCompetition,
          id, id1, id2) {
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
          team2,
          odds1,
          odds2,
          oddsX,
          isSingleCompetition,
          id,
          id1,
          id2,
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
    },
   async handleCategoryChange() {
      console.log("my bet emit");
      const sport = localStorage.getItem('sport');
      console.log(sport)
      try{
         const response = await fetch(`http://localhost:8081/events/${sport}`)
          const data = await response.json()
          this.bets = [];
          this.combinedBets = [];
          this.detailedBets = [];
     this.bets = data
     console.log(this.bets)
      await this.fetchDetailedBets();
         

      }
      catch(error){
        console.log(error)
        console.log("error kurde");
      }
      
      // console.log(sport);
    }
  },
  mounted() {
  eventHub.on('category-clicked', this.handleCategoryChange);
  eventHub.on('category-clicked-start', this.fetchBets)
 this.fetchBets();

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
