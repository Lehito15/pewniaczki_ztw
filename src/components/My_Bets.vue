<!-- components/Your_Bet.vue -->
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
          <li v-for="(coupon, index) in activeCoupons" :key="index">{{ coupon }}</li>
        </ul>
      </div>
      <div v-show="currentSection === 'settled'" class="slider-section">
        <!-- Zawartość dla "Rozliczone" -->
        <p>Twoje rozliczone kupony:</p>
        <ul class="coupon-list">
          <li v-for="(coupon, index) in settledCoupons" :key="index">{{ coupon }}</li>
        </ul>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'

const currentSection = ref('active')

// Przykładowe dane kuponów - zamień je na dane pobrane z backendu
const activeCoupons = ref(['Kupon 1', 'Kupon 2', 'Kupon 3'])
const settledCoupons = ref(['Kupon A', 'Kupon B', 'Kupon C','Kupon A', 'Kupon B', 'Kupon C','Kupon A', 'Kupon B', 'Kupon C','Kupon A', 'Kupon B', 'Kupon C','Kupon A', 'Kupon B', 'Kupon C'])

const selectSection = (section) => {
  currentSection.value = section
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
  /* position: absolute; */
  top: 5px;
  right: 10px;
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
