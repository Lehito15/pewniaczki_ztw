<template>
  <div class="sport-list">
    <h2 class="text-center">Kategorie</h2>
    
    <ul class="list-group">
      <li 
        v-for="(sport, index) in sports" 
        :key="index" 
        class="list-group-item d-flex justify-content-between align-items-center"
      >
        <span>{{ sport }}</span>
        <span 
          @click="toggleFavorite(sport)" 
          :class="{ 'favorite': favorites.includes(sport) }"
          class="badge bg-warning"
        >★</span>
      </li>
    </ul>
  </div>
</template>

<script>
export default {
  data() {
    return {
      sports: ['Piłka nożna', 'Koszykówka', 'Siatkówka', 'Tenis', 'Bieganie', 'Pływanie'],
      favorites: []
    };
  },
  methods: {
    toggleFavorite(sport) {
      if (this.favorites.includes(sport)) {
        this.favorites = this.favorites.filter(item => item !== sport);
      } else {
        this.favorites.push(sport);
      }
    }
  }
};
</script>

<style scoped>

</style>
