<template>
  <div class="deposit-container">
    <h2>Dodaj środki do konta</h2>
    <div class="current-balance">
      <p>Obecne saldo: <span>{{ deposit }} zł</span></p>
    </div>
    <form @submit.prevent="updateBalance">
      <div class="quick-amounts">
        <button type="button" @click="setAmount(5)" class="btn btn-secondary">5 zł</button>
        <button type="button" @click="setAmount(10)" class="btn btn-secondary">10 zł</button>
        <button type="button" @click="setAmount(50)" class="btn btn-secondary">50 zł</button>
      </div>
      <div class="form-group">
        <label for="amount">Kwota (zł):</label>
        <input
          type="number"
          id="amount"
          v-model="amount"
          min="1"
          step="1"
          required
          class="form-control"
        />
      </div>
      <button type="submit" class="btn btn-primary">Dodaj środki</button>
      <p v-if="errorMessage" class="error-message">{{ errorMessage }}</p>
    </form>
  </div>
</template>

<script>
export default {
  data() {
    return {
      deposit: 0,
      amount: 0,
      errorMessage: ''
    };
  },
  methods: {
    async getBalance() {
      try {
        console.log('ekokok')
        const access_token = localStorage.getItem('access_token');
        const response = await fetch('http://localhost:8081/account-balance', {
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
        this.deposit = data; // Aktualizacja wartości salda
        console.log('Current balance:', data);
      } catch (error) {
        console.error('There was a problem with the fetch operation:', error);
        // Obsługa błędów
        this.errorMessage = 'Nie udało się pobrać salda konta.';
      }
    },
     async updateBalance() {
      console.log('Amount to deposit:', this.amount);
      try {
        const access_token = localStorage.getItem('access_token');
        const response = await fetch('http://localhost:8081/update-balance', {
          method: 'POST',
          headers: {
            'Authorization': `Bearer ${access_token}`,
            'Content-Type': 'application/json'
          },
         body: JSON.stringify(this.amount)
        });

        if (!response.ok) {
          throw new Error('Network response was not ok ' + response.statusText);
        }

        const data = await response.json();
        console.log('Balance updated successfully:', data);
        this.getBalance(); 
        alert('Środki zostały dodane pomyślnie!');
        this.amount = 0; 
        
        window.location.href = '#/';
      } catch (error) {
        console.error('There was a problem with the fetch operation:', error);
        // Obsługa błędów
        alert('Nie udało się dodać środków.');
      }
    },
    setAmount(value) {
      this.amount = value;
    }
  },
  mounted() {
    this.getBalance(); // Wywołanie getBalance() przy montowaniu komponentu
  }
};
</script>

<style scoped>
.deposit-container {
  max-width: 400px;
  margin: 0 auto;
  padding: 20px;
  border: 1px solid #ccc;
  border-radius: 8px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.current-balance {
  text-align: center;
  margin-bottom: 20px;
}

.current-balance span {
  font-weight: bold;
  color: #007bff;
}

.form-group {
  margin-bottom: 15px;
}

.form-group label {
  display: block;
  margin-bottom: 5px;
}

.form-group input {
  width: 100%;
  padding: 10px;
  border: 1px solid #ccc;
  border-radius: 4px;
}

.btn {
  display: block;
  width: 100%;
  padding: 10px;
  background-color: #007bff;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  text-align: center;
}

.btn:hover {
  background-color: #0056b3;
}

.error-message {
  color: red;
  margin-top: 10px;
  text-align: center;
}

.quick-amounts {
  display: flex; /* Ustawia przyciski w jednym rzędzie */
  gap: 10px; /* Odstępy między przyciskami */
  margin-bottom: 15px; /* Odstęp od następnego elementu formularza */
}

.quick-amounts .btn {
  flex: 1; /* Umożliwia przyciskom zajęcie równomiernie dostępnej przestrzeni */
}
</style>
