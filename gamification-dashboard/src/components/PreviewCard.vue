<template>
  <v-card elevation="2" class="preview-card" height="300" width="400">
    <v-col>
      <v-card-title>{{ challenge.title }}</v-card-title>
      <v-card-subtitle>{{ challenge.description }}</v-card-subtitle>
      <random-chart></random-chart>
    </v-col>
  </v-card>
</template>
<script lang="ts">
import RandomChart from "./RandomChart";

interface Challenge {
  title: string;
  description: string;
}

export default {
  components: { RandomChart },
  methods: {
    makeChallenge(): Challenge {
      return {
        title: "1000 km",
        description: "Run a thousand km with your team",
      };
    },
  },
  data() {
    return {
      challenge: this.makeChallenge(),
    };
  },
};
</script>

<style>
.preview-card {
  display: inline-flex;
}
</style>