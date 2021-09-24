<template>
  <div class="small">
    <bar-chart :chart-data="datacollection"></bar-chart>
    <button @click="fillData">Randomize</button>
  </div>
</template>

<script lang="ts">
import BarChart from "./BarChart.vue";
import Vue from "vue";

export default Vue.extend({
  components: {
    BarChart,
  },
  data() {
    return {
      datacollection: null,
    };
  },
  mounted() {
    this.fillData();
  },
  methods: {
    fillData() {
      this.datacollection = {
        labels: [this.getRandomInt(), this.getRandomInt()],
        datasets: [
          {
            label: "Data One",
            backgroundColor: "#f87979",
            data: [this.getRandomInt(), this.getRandomInt()],
          },
          {
            label: "Data One",
            backgroundColor: "#f87979",
            data: [this.getRandomInt(), this.getRandomInt()],
          },
        ],
      };
    },
    getRandomInt(): number {
      return Math.floor(Math.random() * (50 - 5 + 1)) + 5;
    },
  },
});
</script>

<style>
.small {
  max-width: 600px;
  margin: 150px auto;
}
</style>