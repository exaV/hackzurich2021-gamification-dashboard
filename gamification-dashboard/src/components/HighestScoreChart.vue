<template>
  <v-col style="height: 100%">
    <bar-chart
      v-bind:chartdata="datacollection"
      :options="chartOptions"
      :styles="chartStyles"
      class="chart"
    ></bar-chart>
  </v-col>
</template>

<script lang="ts">
import Vue from "vue";
import {
  ChallengeEntry,
  DataCollection,
  DataProvider,
} from "@/components/data-provider";
import BarChart from "@/components/BarChart.vue";

const provider = new DataProvider();
export default Vue.extend({
  components: {
    BarChart,
  },
  props: {
    challengeEntries: ChallengeEntry,
  },
  data() {
    return {
      datacollection: this.convert(this.challengeEntries),
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
  methods: {
    convert(entries: ChallengeEntry[]): DataCollection {
      console.log(`converting ${entries.length} challenge entries`);
      const result = {
        datasets: entries.map((entry) => {
          return {
            backgroundColor: "#f87979",
            data: [entry.value],
            label: entry.user.username,
          };
        }),
        labels: ["blubbb"],
      };
      console.log(`result=${JSON.stringify(result)}`);
      return result;
    },
  },
});
</script>

<style></style>