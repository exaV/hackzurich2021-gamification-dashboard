<template>
  <v-card elevation="2" class="preview-card" height="300" width="400">
    <v-container style="padding: 2em">
      <v-row style="height: 100%">
        <v-col>
          <v-row class="title">
            {{ challenge.title }}
          </v-row>
          <v-row class="subtitle">
            {{ challenge.description }}
          </v-row>
          <v-row style="height: 100%">
            <random-chart></random-chart>
          </v-row>
        </v-col>
      </v-row>
    </v-container>
  </v-card>
</template>
<script lang="ts">
import RandomChart from "@/components/RandomChart.vue";

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
  // eslint-disable-next-line
  data(): any {
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

.title {
  align-items: center;
  justify-content: center;
  display: flex;
  flex-wrap: wrap;
  font-size: 1.25rem;
  font-weight: 500;
  letter-spacing: 0.0125em;
  line-height: 2rem;
  word-break: break-all;
}

.subtitle {
  font-size: 0.875rem;
  font-weight: 400;
  line-height: 1.375rem;
  letter-spacing: 0.0071428571em;
}
</style>
