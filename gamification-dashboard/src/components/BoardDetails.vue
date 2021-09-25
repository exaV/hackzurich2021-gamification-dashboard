<template>
  <v-container style="padding: 0">
    <h1>{{ board.title }}</h1>
    <p>
      {{ board.description }}
    </p>
    <v-row>
      <v-col cols="12" sm="6" offset-sm="3">
        <v-card style="max-height: 500px; overflow: hidden; margin-bottom: 2em">
          <v-subheader class="rank_title"> Ranking </v-subheader>
          <v-list one-line style="max-height: 450px; overflow-y: auto">
            <template v-for="(item, index) in items">
              <v-divider
                v-if="item.rank !== 1"
                :key="index"
                :inset="true"
              ></v-divider>
              <v-list-item :key="item.name">
                <div class="rank">{{ item.rank }}</div>
                <v-list-item-content>
                  <v-list-item-title
                    style="display: inline-flex; max-width: 80%"
                    class="rank_name"
                    v-html="item.name"
                  ></v-list-item-title>
                  <div v-if="item.rank === 1" class="rank_icon">👑</div>
                  <div v-if="item.name === user" class="rank_icon">🙋</div>
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

<script>
export default {
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
    items: [
      { avatar: "https://picsum.photos/200", name: "Cloe", rank: 1 },
      {
        avatar: "https://picsum.photos/200",
        name: "Patrick",
        rank: 2,
      },
      { avatar: "https://picsum.photos/200", name: "Tobi", rank: 3 },
      { avatar: "https://picsum.photos/200", name: "Lukas", rank: 4 },
      { avatar: "https://picsum.photos/200", name: "Lina", rank: 5 },
      { avatar: "https://picsum.photos/200", name: "Manuel", rank: 6 },
      { avatar: "https://picsum.photos/200", name: "Pascal", rank: 7 },
      { avatar: "https://picsum.photos/200", name: "Andy", rank: 8 },
      { avatar: "https://picsum.photos/200", name: "Sarah", rank: 9 },
      { avatar: "https://picsum.photos/200", name: "Lars", rank: 10 },
      { avatar: "https://picsum.photos/200", name: "Diana", rank: 11 },
    ],
  }),
};
</script>

<style scoped></style>
