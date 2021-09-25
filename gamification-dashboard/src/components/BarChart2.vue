<template>
  <v-sparkline
    :gradient="['#f72047', '#ffd200', '#1feaea']"
    :line-width="15"
    :type="type"
    :value="chartData.datasets.map((d) => d.data[0])"
    auto-draw
    stroke-linecap="round"
  ></v-sparkline>
</template>

<script lang="ts">
import Vue from "vue";
import { DataCollection } from "@/components/data-provider";

export default Vue.extend({
  components: {},
  data() {
    return {
      type: "bar",
    };
  },
  props: {
    // eslint-disable-next-line
    chartData: DataCollection,
  },
});
</script>
