<template>
  <v-container style="display: inline-flex; max-height: 100%">
    <v-row style="max-height: inherit; max-width: 100%">
      <bar-chart2 :chart-data="sum"></bar-chart2>
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

<script lang="ts">
import Vue from "vue";
import { DataProvider } from "@/components/data-provider";
import BarChart2 from "@/components/BarChart2";

const provider = new DataProvider();
const data = provider.randomCollection(5);

export default Vue.extend({
  components: { BarChart2 },
  data() {
    return {
      contributors: data,
      sum: provider.randomCollection(2),
    };
  },
  methods: {},
});
</script>

<style></style>