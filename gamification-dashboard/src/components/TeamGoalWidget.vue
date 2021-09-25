<template>
  <v-container style="display: inline-flex; max-height: 100%">
    <v-row style="max-height: inherit; max-width: 100%">
      <BarChart
        :chartdata="sum"
        :options="chartOptions"
        :styles="chartStyles"
        style="max-width: 30%; max-height: 200px; padding-bottom: 12px"
      ></BarChart>
      <v-simple-table>
        <template v-slot:default>
          <thead>
            <tr>
              <th class="text-left">Participant</th>
              <th class="text-left">Score</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="item in contributors.datasets" :key="item.label">
              <td>{{ item.label }}</td>
              <td>{{ item.data[0] }}</td>
            </tr>
          </tbody>
        </template>
      </v-simple-table>
    </v-row>
  </v-container>
</template>
<script>
import BarChart from "@/components/BarChart";
import Vue from "vue";
import { ChallengeEntry, DataProvider } from "@/components/data-provider";

const provider = new DataProvider();

export default Vue.extend({
  components: { BarChart },
  props: {
    challengeEntries: ChallengeEntry,
  },
  data() {
    return {
      contributors: DataProvider.convert(this.challengeEntries),
      sum: provider.randomCollection(1),
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
          },
        },
      },
      chartStyles: {
        position: "relative",
      },
    };
  },
  methods: {},
});
</script>

<style></style>