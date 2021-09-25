<template>
  <div id="app" class="overflow-hidden">
    <link
      href="https://cdn.jsdelivr.net/npm/@mdi/font@5.x/css/materialdesignicons.min.css"
      rel="stylesheet"
    />
    <v-app>
      <transition name="fade" appear>
        <div
          class="modal-overlay"
          v-if="showModal || showDetail"
          @click="
            showModal = false;
            showDetail = false;
          "
        ></div>
      </transition>
      <v-app-bar
        app
        shrink-on-scroll
        color="#CC2E50"
        dark
        prominent
        src="https://picsum.photos/id/547/1920/1080"
        fade-img-on-scroll
      >
        <template v-slot:img="{ props }">
          <v-img
            v-bind="props"
            gradient="to top, rgba(204,	46,	80, 0.7), rgba(255,	88,	89, 0.7)"
          ></v-img>
        </template>
        <!--
        <v-app-bar-nav-icon></v-app-bar-nav-icon>
-->
        <v-toolbar-title class="bartitle">Leaderboard</v-toolbar-title>

        <v-spacer></v-spacer>
        <div class="achievements">
          <v-btn icon class="iconFont"> 🔥</v-btn>
          <div class="achievementNumber">
            {{ streakNumber }}
          </div>
        </div>
        <div class="achievements">
          <v-btn icon class="iconFont"> 👑</v-btn>
          <div class="achievementNumber">
            {{ winNumber }}
          </div>
        </div>
        <v-btn icon class="iconFont"> 🙋</v-btn>
      </v-app-bar>

      <v-main
        id="scrolling-techniques-3"
        class="overflow-y-auto"
        max-height="600px"
      >
        <v-container>
          <v-row>
            <v-col v-for="n in 16" :key="n" cols="4">
              <preview-card
                @click="showDetail = true"
                height="300"
                width="400"
                v-if="n % 2 === 0"
              ></preview-card>
              <v-card
                v-if="n % 2 === 1"
                elevation="2"
                height="300"
                width="400"
                @click="showDetail = true"
              >
                <team-goal-widget @click="showDetail = true"></team-goal-widget>
              </v-card>
            </v-col>
            <v-col cols="4">
              <v-card elevation="2" height="300" width="400" class="addBoard">
                <div class="addBoardDiv" @click="showModal = true">
                  <v-icon x-large dark class="hugeIcon"
                    >mdi-plus-circle-outline
                  </v-icon>
                </div>
              </v-card>
            </v-col>
          </v-row>
        </v-container>

        <transition name="slide" appear>
          <div class="modal" v-if="showModal">
            <BoardForm v-on:closeModal="showModal = false"></BoardForm>
          </div>
          <div class="modal" v-if="showDetail">
            <BoardDetails
              v-on:closeModal="showDetail = false"
              v-bind:is="currentBoardComponent"
            ></BoardDetails>
          </div>
        </transition>
      </v-main>
    </v-app>
  </div>
</template>

<script lang="ts">
import { Vue } from "vue-property-decorator";
import BarChartWidget from "@/components/BarChartWidget.vue";
import RandomChart from "@/components/RandomChart.vue";
import BoardForm from "@/components/BoardForm.vue";

import TeamGoalWidget from "@/components/TeamGoalWidget.vue";
import BoardDetails from "@/components/BoardDetails.vue";
import PreviewCard from "@/components/PreviewCard.vue";
import {
  DataProvider,
  LeaderBoardCollection,
} from "@/components/data-provider";

const provider = new DataProvider();
export default Vue.extend({
  name: "App",
  components: {
    PreviewCard,
    BoardDetails,
    TeamGoalWidget,
    RandomChart,
    BarChartWidget,
    BoardForm,
  },
  data: () => {
    return {
      showModal: false,
      showDetail: false,
      challenges: null as LeaderBoardCollection | null,

      winNumber: 2,
      streakNumber: 32,
    };
  },
  mounted() {
    this.fetchChallenges(1);
  },
  methods: {
    fetchChallenges(id: number) {
      provider.getChallenges(id).then(results => this.challenges = results).then(()=>console.log(this.challenges));
    },
  },
});
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
