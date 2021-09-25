<script lang="ts">
import { Bar, mixins } from "vue-chartjs";
import Vue from "vue";

const { reactiveProp } = mixins;

export default Vue.extend({
  extends: Bar,
  props: ["chartdata", "options"],
  mixins: [reactiveProp],
  mounted() {
    // eslint-disable-next-line
    this.renderChart(this.chartdata, this.options);
  },
});
</script>

<style></style>
