<template>
  <v-container>
    <v-col>
      <bar-chart :chart-data="datacollection" class="chart"></bar-chart>
      <button @click="fillData">Randomize</button>
    </v-col>
  </v-container>
</template>

<script lang="ts">
import Vue from "vue";
import { DataCollection, DataProvider } from "@/components/data-provider";
import BarChart from "@/components/BarChart.vue";

const provider = new DataProvider();
export default Vue.extend({
  components: {
    BarChart,
  },
  data() {
    return {
      datacollection: null as DataCollection | null,
      chartOptions: {
        responsive: true,
        maintainAspectRatio: false,
      },
      chartStyles: {
        position: "relative",
      },
    };
  },
  mounted() {
    this.fillData();
  },
  methods: {
    fillData() {
      this.datacollection = provider.randomCollection(5);
    },
  },
});
</script>

<style></style>