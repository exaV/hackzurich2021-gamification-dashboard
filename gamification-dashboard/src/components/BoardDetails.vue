<template>
  <v-container style="padding: 0">
    <h1>{{ board.title }}</h1>
    <div>
      {{ board.description }}
    </div>

    <div>End Date: {{ board.end_date }}</div>
    <v-row>
      <v-col cols="12" sm="6" offset-sm="3">
        <v-card style="max-height: 500px; overflow: hidden; margin-bottom: 2em">
          <v-subheader class="rank_title">Ranking</v-subheader>
          <v-list one-line style="max-height: 450px; overflow-y: auto">
            <template v-for="(item, index) in items">
              <v-divider
                v-if="index !== 0"
                :key="index"
                :inset="true"
              ></v-divider>
              <v-list-item :key="item.user.first_name">
                <div class="rank">{{index + 1}}</div>
                <v-list-item-content>
                  <v-list-item-title
                    style="display: inline-flex; max-width: 60%"
                    class="rank_name"
                    v-html="item.user.first_name"
                  ></v-list-item-title>
                  <div class="rank_value" style="display: inline-flex; max-width: 15%">{{item.value}} </div>
                  <div v-if="index === 0" class="rank_icon">👑</div>
                  <div v-if="item.user.first_name === user" class="rank_icon">🙋</div>
                </v-list-item-content>
              </v-list-item>
            </template>
          </v-list>
        </v-card>
      </v-col>
    </v-row>
    <button class="button_form" v-on:click="$emit('closeModal')">Close</button>
  </v-container>
</template>

<script lang="ts">
import Vue from "vue";
import {ChallengeEntry, DataProvider} from "@/components/data-provider";

const provider = new DataProvider();
export default Vue.extend({
  name: "BoardDetails",
  props: ["board"],
  data: () => ({
    title: "Leaderboard name",
    user: "Lukas",
    description:
      " To compare and compete with others, you can create your own leaderboard,\n" +
      "      just specify a title, what type the competition should have, and which\n" +
      "      interface to use. You can add a description, and define whether the\n" +
      "      leaderboard is private or if anyone can compete.",
    items: null as ChallengeEntry[] | null,
  }),
  mounted() {
    this.fetchChallengeDetail(this.board.id);
  },
  methods: {
    fetchChallengeDetail(id: number) {
      provider.getChallengeEntry(id).then((results) => (this.items = results.sort((a, b) => b.value - a.value)));
    },
  },
});
</script>

<style scoped></style>
