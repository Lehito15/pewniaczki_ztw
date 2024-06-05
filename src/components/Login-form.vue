<template>
  <div class="login-form-container">
    <div class="login-form">
      <h2>Zaloguj się</h2>
      <form @submit.prevent="login">
        <div class="form-group">
          <label for="email">Login:</label>
          <input type="login" id="email"   required>
        </div>
        <div class="form-group">
          <label for="password">Hasło:</label>
          <input type="password" id="password" v-model="password" required>
        </div>
        <button type="submit">Zaloguj się</button>
      </form>
    </div>
  </div>
</template>


<script>
export default {
 
  // setup(props, context){
  //   const clickLogin = ()=>{
  //     context.emit('myLogin')
  //   }
  //   return {
  //     clickLogin
  //   }

  // },
  data() {
    return {
      email: '',
      password: ''
    };
  },
  methods: {
    
    login() {
      // Tutaj dodaj logikę logowania, np. wysłanie danych do serwera
      console.log('Logowanie...');
      console.log(this.someProp)
      console.log('E-mail:', this.email);
      console.log('Hasło:', this.password);
      // this.loggedIn = true;
      localStorage.setItem('loggedIn', true);
      // $emit('myLogin');
      this.$emit('my-login');

      window.location.hash = '/'
      
      
      // Czyść pola po zalogowaniu
      this.email = '';
      this.password = '';
    }
  }
};
</script>

<style scoped>
.login-form-container {
  display: flex;
  justify-content: center;
  margin-top: 30px; /* Dodaj odstęp nad formularzem */
}

.login-form {
  width: 400px; /* Ustaw szerokość formularza */
  background-color: #f9f9f9;
  padding: 30px;
  border-radius: 10px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

h2 {
  text-align: center;
  margin-bottom: 20px;
}

.form-group {
  margin-bottom: 20px; /* Zwiększ odstęp między polami formularza */
}

label {
  display: block;
  margin-bottom: 5px;
}

input {
  width: 100%;
  padding: 10px;
  border: 1px solid #ccc;
  border-radius: 5px;
}

button {
  width: 100%;
  padding: 10px 15px;
  background-color: #4CAF50;
  color: white;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  transition: background-color 0.3s;
}

button:hover {
  background-color: #45a049;
}
</style>
