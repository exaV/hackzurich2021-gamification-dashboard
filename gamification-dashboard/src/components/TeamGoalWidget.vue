<template>
  <v-container style="display: inline-flex; max-height: 100%">
    <v-row style="max-height: inherit; max-width: 100%">
      <BarChart
        :chartdata="sum"
        :options="chartOptions"
        :styles="chartStyles"
        style="max-width: 30%; max-height: 100%"
      ></BarChart>
      <v-spacer style="width: 1em"></v-spacer>
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
import { DataProvider } from "@/components/data-provider";

const provider = new DataProvider();

export default Vue.extend({
  components: { BarChart },
  data() {
    return {
      contributors: provider.randomCollection(5),
      sum: provider.randomCollection(1),
      chartOptions: {
        responsive: true,
        maintainAspectRatio: false,
      },
      chartStyles: {
        // position: "relative",
      },
    };
  },
  methods: {},
});
</script>

<style></style>