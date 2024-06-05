import { createRouter, createWebHistory } from 'vue-router';
import Login from '../components/Login-form.vue'; // Ścieżka do komponentu login.vue
import Register from '../components/Comp_2.vue'; // Ścieżka do komponentu rejestracji (jeśli istnieje)

const routes = [
  {
    path: '/login',
    name: 'Login',
    component: Login
  },
  {
    path: '/register',
    name: 'Register',
    component: Register
  }
];

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes,
});

export default router;
