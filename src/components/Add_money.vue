<!-- components/DepositFunds.vue -->
<template>
  <div class="deposit-container">
    <h2>Dodaj środki do konta</h2>
    <div class="current-balance">
      <p>Obecne saldo: <span>{{ balance }} zł</span></p>
    </div>
    <form @submit.prevent="handleDeposit">
      <div class="form-group">
        <label for="amount">Kwota (zł):</label>
        <input
          type="number"
          id="amount"
          v-model="amount"
          min="1"
          step="0.01"
          required
          class="form-control"
        />
      </div>
      <button type="submit" class="btn btn-primary" @click="addMoney">Dodaj środki</button>
      <p v-if="errorMessage" class="error-message">{{ errorMessage }}</p>
    </form>
  </div>
</template>

<script setup>
import { ref } from 'vue'

// Saldo użytkownika - początkowa wartość to 0 zł
const balance = ref(0.0)

// Kwota do dodania - inicjalizowana jako pusty ciąg znaków
const amount = ref('')

// Wiadomość o błędzie walidacji
const errorMessage = ref('')

// Funkcja obsługująca dodanie środków
const handleDeposit = () => {
  const depositAmount = parseFloat(amount.value)
  // Walidacja kwoty
  if (isNaN(depositAmount) || depositAmount <= 0) {
    errorMessage.value = 'Proszę podać poprawną kwotę większą niż 0'
    return
  }
  
  
  // Aktualizacja salda
  balance.value += depositAmount
  // Resetowanie pola kwoty
  amount.value = ''
  // Czyszczenie wiadomości o błędzie
  errorMessage.value = ''
  window.location.href = '/'
}
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
</style>
