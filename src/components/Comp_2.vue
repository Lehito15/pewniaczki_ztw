<template>
  <button @click="emitTest">Emit Test</button>
</template>

<script>
export default {
  methods: {
    emitTest() {
      this.$emit('test-emit');
    }
  }
}
</script>