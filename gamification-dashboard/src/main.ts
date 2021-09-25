import Vue from "vue";
import App from "./App.vue";
import vuetify from "./plugins/vuetify";
import Chart from "chart.js";
import ChartDataLabels from "chartjs-plugin-datalabels";

Vue.config.productionTip = false;
Chart.plugins.register(ChartDataLabels);

new Vue({
  vuetify,
  render: (h) => h(App),
}).$mount("#app");
