<template>
  <div class="sport-list">
    <h2 class="text-center">Kategorie</h2>
    
    <ul class="list-group">
      <!-- Pierwsza pozycja to "Start" -->
      <li class="list-group-item sport-item d-flex justify-content-between align-items-center">
        <span>Start</span>
        <i 
          @click="toggleFavorite('Start')" 
          :class="['favorite-icon', favorites.includes('Start') ? 'fas fa-star' : 'far fa-star']"
        ></i>
      </li>

      <!-- Reszta pozycji -->
      <li 
        v-for="(sport, index) in sports" 
        :key="index" 
        class="list-group-item sport-item d-flex justify-content-between align-items-center"
      >
        <span>{{ sport }}</span>
        <i 
          @click="toggleFavorite(sport)" 
          :class="['favorite-icon', favorites.includes(sport) ? 'fas fa-star' : 'far fa-star']"
        ></i>
      </li>
    </ul>
  </div>
</template>

<script>
export default {
  data() {
    return {
      sports: ['Piłka nożna', 'Koszykówka', 'Siatkówka', 'Tenis', 'Bieganie', 'Pływanie'],
      favorites: [],
      categories: []
    };
  },
  methods: {
    toggleFavorite(sport) {
      if (this.favorites.includes(sport)) {
        this.favorites = this.favorites.filter(item => item !== sport);
      } else {
        this.favorites.push(sport);
      }
    },
    async fetchCategories(){
      try { 
        const response = await fetch('http://localhost:8081/events');
        const data = await response.json();
        this.categories = data;
        console.log(data);
      } catch (error) {
        console.error('Błąd podczas pobierania kategorii', error);
      }
    }
  }
};
</script>

<style scoped>
/* Style listy sportów */
.sport-list {
  max-width: 600px;
  margin: 0 auto;
  padding: 20px;
}

/* Stylowanie pozycji listy */
.sport-item {
  margin-bottom: 10px; /* Odstęp między elementami */
  border-radius: 8px; /* Zaokrąglone rogi */
  padding: 10px; /* Wyściełanie */
  transition: background-color 0.3s ease, color 0.3s ease; /* Płynna zmiana koloru */
  background-color: #f8f9fa; /* Domyślny kolor tła */
  cursor: pointer; /* Kursor wskaźnika */
}

/* Efekt rozjaśnienia przy najechaniu */
.sport-item:hover {
  background-color: #e9ecef; /* Kolor tła przy najechaniu */
}

/* Stylowanie ikony ulubionych */
.favorite-icon {
  color: #ffc107; /* Domyślny kolor złoty dla aktywnej gwiazdki */
  font-size: 1.5em; /* Większy rozmiar ikony */
  cursor: pointer; /* Kursor wskaźnika */
  transition: color 0.3s ease; /* Płynna zmiana koloru */
}

/* Stylowanie gwiazdki nieaktywnej (kontur) */
.favorite-icon.far {
  color: #c1c1c1; /* Kolor konturu dla nieaktywnej gwiazdki */
}

.list-group-item {
  border: none; /* Usunięcie obramowania */
  display: flex;
  justify-content: space-between;
  align-items: center;
}
</style>
