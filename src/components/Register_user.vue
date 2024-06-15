<template>
  <div class="register-form-container">
    <div class="register-form">
      <h2>Rejestracja</h2>
   
      <form @submit.prevent="register">
        <div class="form-group">
          <label for="firstName">Imię:</label>
          <input type="text" id="firstName" v-model="firstName" required>
        </div>
        <div class="form-group">
          <label for="lastName">Nazwisko:</label>
          <input type="text" id="lastName" v-model="lastName" required>
        </div>
        <div class="form-group">
          <label for="pesel">PESEL:</label>
          <input type="text" id="pesel" v-model="pesel" required>
        </div>
        <div class="form-group">
          <label for="email">Email:</label>
          <input type="email" id="email" v-model="email" required>
        </div>
        <div class="form-group">
          <label>Płeć:</label>
          <input type="radio" id="male" value="male" v-model="gender"> <label for="M">Mężczyzna</label>
          <input type="radio" id="female" value="female" v-model="gender"> <label for="K">Kobieta</label>
        </div>
        <div class="form-group">
          <label for="dob">Data urodzenia:</label>
          <input type="date" id="dob" v-model="dob" required>
          <p v-if="!isAdult" class="error-message">Musisz mieć co najmniej 18 lat, aby się zarejestrować.</p>
        </div>
        <div class="form-group">
          <label for="password">Hasło:</label>
          <input type="password" id="password" v-model="password" required>
        </div>  
        <div class="password-requirements" v-if="password.length > 0">
          <p v-if="!isPasswordValid" class="error_pass">Hasło musi zawierać co najmniej 8 znaków, 1 wielką literę i 1 znak specjalny.</p>
          <p v-else class="pass_ok">Hasło spełnia wymagania.</p>
        </div>
        <button type="submit">Załóż konto</button>
       
      </form>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      firstName: '',
      lastName: '',
      pesel: '',
      email: '',
      gender: '', // 'male' or 'female'
      dob: '',
      password: ''
    };
  },
  computed: {
    isAdult() {
  // Obliczanie wieku na podstawie daty urodzenia
  const today = new Date();
  const birthDate = new Date(this.dob);
  const age = today.getFullYear() - birthDate.getFullYear();
  const monthDiff = today.getMonth() - birthDate.getMonth();
  if (monthDiff < 0 || (monthDiff === 0 && today.getDate() < birthDate.getDate())) {
    return age - 1 >= 18; // Sprawdź, czy użytkownik ma co najmniej 18 lat
  }
  return age >= 18;
},

    isPasswordValid() {
      const passwordRegex = /^(?=.*[A-Z])(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,}$/;
      console.log(passwordRegex.test(this.password));
      return passwordRegex.test(this.password);
    },
    isPeselValid() {
  // Sprawdzanie czy numer PESEL ma dokładnie 11 cyfr
  const peselRegex = /^\d{11}$/;
  if (!peselRegex.test(this.pesel)) {
    return false;
  }

  // Sprawdzanie czy rok urodzenia odpowiada dwóm pierwszym cyfrom numeru PESEL
  const birthYear = parseInt(this.pesel.substr(0, 2), 10);
  const date = new Date(this.dob);
  const year = date.getFullYear() % 100; // Pobranie dwóch ostatnich cyfr roku
  if (birthYear !== year) {
    return false;
  }

  return true;
}

  },
  methods: {
    async register() {
    // Sprawdź, czy użytkownik jest pełnoletni, hasło spełnia wymagania i numer PESEL jest poprawny
    if (this.isAdult && this.isPasswordValid && this.isPeselValid) {
      // Przygotuj dane do wysłania na serwer
      const userData = {
        firstName: this.firstName,
        lastName: this.lastName,
        // pesel: this.pesel,
        // gender: this.gender,
        email: this.email,
        // dob: this.dob,
        password: this.firstName // Tutaj możesz zahaszować hasło przed wysłaniem na serwer
      };

      try {
        // Wysyłanie żądania POST na serwer
        const response = await fetch('http://localhost:8081/register', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json'
          },
          body: JSON.stringify(userData)
        });

        // Sprawdź status odpowiedzi
        if (response.ok) {
          // Przekieruj użytkownika na stronę główną w przypadku sukcesu
          window.location.href = '/';
        } else {
          // Wyświetl alert w przypadku niepowodzenia
          alert('Rejestracja nie powiodła się. Spróbuj ponownie.');
        }
      } catch (error) {
        console.error('Błąd podczas wysyłania żądania:', error);
        // Wyświetl alert w przypadku błędu
        alert('Wystąpił błąd. Spróbuj ponownie później.');
      }
    } else if (!this.isPasswordValid) {
        // Wyświetl komunikat, jeśli hasło nie spełnia wymagań
        alert('złe hasło');
        console.log('Hasło musi zawierać co najmniej 8 znaków, 1 wielką literę i 1 znak specjalny.');
      } else  if(!this.isAdult) {
        // Wyświetl komunikat, jeśli użytkownik nie jest pełnoletni
        alert("Musisz mieć co najmniej 18 lat, aby się zarejestrować.")
        console.log('Musisz mieć co najmniej 18 lat, aby się zarejestrować.');
      }
      else{
        alert("Zły pesel");
      }
  },
    // register() {
    //   // Sprawdź, czy użytkownik jest pełnoletni i hasło spełnia wymagania
    //   if (this.isAdult == true && this.isPasswordValid && this.isPeselValid) {
    //     console.log('Rejestracja:', this.firstName, this.lastName, this.pesel, this.gender, this.dob, this.password);
    //     this.$emit('my-register');
    //     window.location.hash = '/';
    //   } else if (!this.isPasswordValid) {
    //     // Wyświetl komunikat, jeśli hasło nie spełnia wymagań
    //     alert('złe hasło');
    //     console.log('Hasło musi zawierać co najmniej 8 znaków, 1 wielką literę i 1 znak specjalny.');
    //   } else  if(!this.isAdult) {
    //     // Wyświetl komunikat, jeśli użytkownik nie jest pełnoletni
    //     alert("Musisz mieć co najmniej 18 lat, aby się zarejestrować.")
    //     console.log('Musisz mieć co najmniej 18 lat, aby się zarejestrować.');
    //   }
    //   else{
    //     alert("Zły pesel");
    //   }
    // }
  }
};
</script>

<style scoped>
.register-form-container {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100vh;
}

.register-form {
  width: 300px;
  padding: 20px;
  background-color: #ffffff;
  border-radius: 5px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.register-form h2 {
  margin-bottom: 20px;
}

.form-group {
  margin-bottom: 15px;
}

label {
  display: block;
  margin-bottom: 5px;
}

input[type="text"],
input[type="date"],
input[type="password"] {
  width: 100%;
  padding: 8px;
  border: 1px solid #ccc;
  border-radius: 3px;
}

input[type="radio"] {
  margin-right: 5px;
}

button {
  display: block;
  width: 100%;
  padding: 10px;
  background-color: #2e3948;
  color: #ffffff;
  border: none;
  border-radius: 3px;
  cursor: pointer;
}

button:hover {
  background-color: #1c2633;
}

.error-message {
  color: red;
  font-size: 14px;
  margin-top: 10px;
}
.error_pass{
  color: red;
}
.pass_ok{
  color: green;
}

.password-requirements p {
  margin: 5px 0;
}
</style>
