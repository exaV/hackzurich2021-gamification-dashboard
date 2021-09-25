<template>
  <div id="app">
    <link
      href="https://cdn.jsdelivr.net/npm/@mdi/font@5.x/css/materialdesignicons.min.css"
      rel="stylesheet"
    />
    <v-app>
      <transition name="fade" appear>
        <div
          class="modal-overlay"
          v-if="showModal"
          @click="showModal = false"
        ></div>
      </transition>
      <v-main>
        <v-container>
          <v-row>
            <v-col v-for="n in 16" :key="n" cols="4">
              <v-card elevation="2" height="300" width="400">
                <random-chart v-if="n % 2 === 0"></random-chart>
                <team-goal-widget v-if="n % 2 === 1"></team-goal-widget>
              </v-card>
            </v-col>
            <v-col cols="4">
              <v-card elevation="2" height="300" width="400" class="addBoard">
                <div class="addBoardDiv" @click="showModal = true">
                  <v-icon x-large dark class="hugeicon"
                    >mdi-plus-circle-outline
                  </v-icon>
                </div>
              </v-card>
            </v-col>
          </v-row>
        </v-container>

        <transition name="slide" appear>
          <div class="modal" v-if="showModal">
            <h1>Create a Leaderboard</h1>
            <p>
              To compare and compete with others, you can create your own
              leaderboard, just specify a title, what type the competition
              should have, and which interface to use. You can add a
              description, and define whether the leaderboard is private or if
              anyone can compete.
            </p>
            <BoardForm v-on:closeModal="showModal = false"></BoardForm>
          </div>
        </transition>
      </v-main>
    </v-app>
  </div>
</template>

<script lang="ts">
import { Component, Vue } from "vue-property-decorator";
import BarChartWidget from "@/components/BarChartWidget.vue";
import RandomChart from "@/components/RandomChart.vue";
import BoardForm from "@/components/BoardForm.vue";
import TeamGoalWidget from "@/components/TeamGoalWidget.vue";

@Component({
  components: {
    TeamGoalWidget,
    RandomChart,
    BarChartWidget,
    BoardForm,
  },
  data: () => {
    return {
      showModal: false,
    };
  },
})
export default class App extends Vue {}
</script>

<style>
@import "./assets/styles/stylesheet.css";

#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>