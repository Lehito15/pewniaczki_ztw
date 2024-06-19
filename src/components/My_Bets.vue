<template>
  <div class="your-bet-container">
    <div class="slider-nav">
      <button @click="selectSection('active')" :class="{ selected: currentSection === 'active' }">
        Aktywne 
        <span class="badge">{{ activeCoupons.length }}</span>
      </button>
      <button @click="selectSection('settled')" :class="{ selected: currentSection === 'settled' }">
        Rozliczone 
        <span class="badge">{{ settledCoupons.length }}</span>
      </button>
    </div>
    <div class="slider-content">
      <div v-show="currentSection === 'active'" class="slider-section">
        <!-- Zawartość dla "Aktywne" -->
        <p>Twoje aktywne kupony:</p>
        <ul class="coupon-list">
          <li v-for="(coupon, index) in activeCoupons" :key="index">
            <p>{{ coupon.bet.betDate }} - Deposit: {{ coupon.bet.deposit }}</p>
            <p v-if="coupon.teamEvent">
              Wydarzenie: {{ coupon.teamEvent.eventDate }} - Liga: {{ coupon.teamEvent.league?.name || 'N/A' }} - Dyscyplina: {{ coupon.teamEvent.discipline?.name || 'N/A' }} - Team: {{ coupon.teamWinner?.name || 'N/A' }}
            </p>
            <p v-else-if="coupon.sportsmanWinner">
              Wydarzenie: {{ coupon.bet.betDate }} - Deposit: {{ coupon.bet.deposit }} - Wydarzenie: {{ coupon.sportsmanWinner?.eventDate || 'N/A' }} - Sportsman: {{ coupon.sportsmanWinner?.lastName || 'N/A' }}
            </p>
            <p v-else>
              Wydarzenie: {{ coupon.bet.betDate }} - Deposit: {{ coupon.bet.deposit }} - Wydarzenie: {{ coupon.teamEvent?.name || 'N/A' }} - Typ: Remis
            </p>
          </li>
        </ul>
      </div>
      <div v-show="currentSection === 'settled'" class="slider-section">
        <!-- Zawartość dla "Rozliczone" -->
        <p>Twoje rozliczone kupony:</p>
        <ul class="coupon-list">
          <li v-for="(coupon, index) in settledCoupons" :key="index">
            <p>{{ coupon.bet.betDate }} - Deposit: {{ coupon.bet.deposit }}</p>
            <p v-if="coupon.teamEvent">
              Wydarzenie: {{ coupon.teamEvent.eventDate }} - Liga: {{ coupon.teamEvent.league?.name || 'N/A' }} - Dyscyplina: {{ coupon.teamEvent.discipline?.name || 'N/A' }} - Team: {{ coupon.teamWinner?.name || 'N/A' }}
            </p>
            <p v-else-if="coupon.sportsmanWinner">
              Wydarzenie: {{ coupon.bet.betDate }} - Deposit: {{ coupon.bet.deposit }} - Wydarzenie: {{ coupon.teamEvent?.name || 'N/A' }} - Team: {{ coupon.teamWinner?.name || 'N/A' }}
            </p>
            <p v-else>
              Wydarzenie: {{ coupon.teamEvent?.eventDate || 'N/A' }} - Deposit: {{ coupon.bet.deposit }} - Wydarzenie: {{ coupon.teamEvent?.name || 'N/A' }} - Typ: Remis
            </p>
          </li>
        </ul>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      currentSection: 'active',
      activeCoupons: [],
      settledCoupons: []
    }
  },
  methods: {
    selectSection(section) {
      this.currentSection = section
    },
    async fetchActive(){
      try {
        const access_token = localStorage.getItem('access_token');
        const response = await fetch('http://localhost:8081/active-bet-events', {
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
        this.activeCoupons = data; // Aktualizacja wartości salda
        console.log('active:', data);
      } catch (error) {
        console.error('There was a problem with the fetch operation:', error);
        // Obsługa błędów
        this.errorMessage = 'Nie udało się pobrać aktywnych kuponów.';
      }
    },
    async fetchInactive(){
      try {
        const access_token = localStorage.getItem('access_token');
        const response = await fetch('http://localhost:8081/inactive-bet-events', {
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
        this.settledCoupons = data; // Aktualizacja wartości salda
        console.log('inactive:', data);
      } catch (error) {
        console.error('There was a problem with the fetch operation:', error);
        // Obsługa błędów
        this.errorMessage = 'Nie udało się pobrać rozliczonych kuponów.';
      }
    }
  },
  mounted(){
    this.fetchActive();
    this.fetchInactive();
  }
}
</script>

<style scoped>
.your-bet-container {
  display: flex;
  flex-direction: column;
  align-items: center;
  width: 100%;
  max-width: 800px;
  margin: 0 auto;
}

.slider-nav {
  display: flex;
  justify-content: space-between; /* Ustawienie przycisków na pełną szerokość */
  width: 100%; /* Pełna szerokość kontenera */
  margin-bottom: 20px;
}

.slider-nav button {
  flex: 1; /* Przyciski rozszerzają się równomiernie */
  padding: 10px 20px;
  cursor: pointer;
  background-color: #f0f0f0;
  border: 1px solid #ccc;
  border-radius: 0; /* Usunięcie zaokrąglonych rogów dla lepszego dopasowania */
  transition: background-color 0.3s, color 0.3s;
  margin: 0; /* Usunięcie marginesów między przyciskami */
}

.slider-nav .badge {
  background-color: #dc3545;
  color: white;
  border-radius: 50%;
  padding: 5px 10px;
  font-size: 12px;
}

.slider-nav button.selected {
  background-color: #007bff;
  color: #fff;
}

.slider-nav button:hover {
  background-color: #007bff;
  color: #fff;
}

.slider-content {
  width: 100%;
}

.slider-section {
  display: none;
}

.slider-section > ul {
  list-style: none;
  padding: 0;
}

.slider-section > ul > li {
  padding: 10px;
  background-color: #eee;
  margin-bottom: 10px;
  border-radius: 5px;
}

.coupon-list {
  max-height: 600px; /* Maksymalna wysokość, po której lista zaczyna się przewijać */
  overflow-y: auto; /* Pozwala na przewijanie w osi Y, gdy zawartość przekracza maksymalną wysokość */
  padding: 0;
  list-style: none;
}

.coupon-list > li {
  padding: 10px;
  background-color: #eee;
  margin-bottom: 10px;
  border-radius: 5px;
}

/* Wyświetl aktywną sekcję */
.slider-content > .slider-section:nth-of-type(1) {
  display: block;
}

.slider-content > .slider-section:nth-of-type(2) {
  display: block;
}
</style>
