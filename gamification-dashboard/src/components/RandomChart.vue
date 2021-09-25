<template>
  <v-col style="height: 100%">
    <bar-chart
      :chart-data="datacollection"
      :options="chartOptions"
      :styles="chartStyles"
      class="chart"
    ></bar-chart>

  </v-col>
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
        legend: {
          display: false,
        },
        scales: {
          xAxes: [
            {
              display: false,
              gridLines: {
                display: false,
              },
            },
          ],
          yAxes: [
            {
              display: false,
              gridLines: {
                display: false,
              },
            },
          ],
        },
        plugins: {
          datalabels: {
            align: "end",
            anchor: "end",
            labels: {
              title: {
                font: {
                  weight: "bold",
                },
              },
              value: null,
            },
            formatter: function (
              value: any,
              context: {
                chart: { data: { datasets: { [x: string]: { label: any } } } };
                datasetIndex: string | number;
              }
            ) {
              console.log(value, context);
              return context.chart.data.datasets[context.datasetIndex].label;
            },
          },
        },
      },
      chartStyles: {
        position: "relative",
        height: "100%",
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
