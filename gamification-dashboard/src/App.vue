<template>
  <div id="app">
    <v-app>
      <v-main>
        <v-container>
          <v-row>
            <v-col v-for="n in 16" :key="n" cols="4">
              <v-card elevation="2" height="300" width="400">
                <random-chart></random-chart>
              </v-card>
            </v-col>
          </v-row>
        </v-container>
      </v-main>
    </v-app>
  </div>
</template>

<script lang="ts">
import { Component, Vue } from "vue-property-decorator";
import BarChartWidget from "@/components/BarChartWidget.vue";
import RandomChart from "@/components/RandomChart.vue";

@Component({
  components: {
    RandomChart,
    BarChartWidget,
  },
})
export default class App extends Vue {}
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
