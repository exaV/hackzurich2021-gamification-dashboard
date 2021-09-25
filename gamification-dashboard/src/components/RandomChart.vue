<template>
  <div class="small">
    <bar-chart :chart-data="datacollection" class="chart"></bar-chart>
    <button @click="fillData">Randomize</button>
  </div>
</template>

<script lang="ts">
import BarChart from "./BarChart.vue";
import Vue from "vue";
import { DataCollection, DataProvider } from "@/components/data-provider";

const provider = new DataProvider();
export default Vue.extend({
  components: {
    BarChart,
  },
  data() {
    return {
      datacollection: null as DataCollection | null,
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