<template id="board-form">
  <v-container style="padding: 0">
    <h1>Create a Leaderboard</h1>
    <p>
      To compare and compete with others, you can create your own
      leaderboard, just specify a title, what type the competition
      should have, and which interface to use. You can add a
      description, and define whether the leaderboard is private or if
      anyone can compete.
    </p>
    <v-form ref="form" v-model="valid" lazy-validation>
      <v-text-field
        v-model="title"
        :counter="15"
        :rules="nameRules"
        label="Title"
        required
      ></v-text-field>
      <v-select
        v-model="select"
        :items="items"
        :rules="[(v) => !!v || 'Board type is required']"
        label="Type"
        required
      ></v-select>
      <v-text-field
        v-model="goal"
        label="Goal"
        type="number"
        v-if="select == items[3]"
      >
      </v-text-field>
      <v-select
        v-model="datasource"
        :items="interfaces"
        :rules="[(v) => !!v || 'Datasource is required']"
        label="Datasource"
        required
      ></v-select>
      <v-textarea
        v-model="description"
        :counter="250"
        :rules="descriptionRules"
        label="Description"
      ></v-textarea>
      <v-text-field
        v-model="end"
        type="date"
        label="End time"
        required
      ></v-text-field>
      <v-radio-group v-model="radioGroup">
        <v-radio label="Public" value="0"></v-radio>
        <v-radio label="Private" value="1"></v-radio>
      </v-radio-group>
      <v-text-field
        v-model="password"
        :counter="15"
        label="Password"
        v-if="radioGroup == 1"
      ></v-text-field>
    </v-form>
    <button class="button_form" v-on:click="storeValuesAndClose()">
      Create
    </button>
  </v-container>
</template>

<script lang="ts">
import Vue from "vue";

export default Vue.extend({
  template: "#board-form",
  name: "BoardForm",
  methods: {
    storeValuesAndClose: function () {

      const requestOptions = {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ title: this.$data.title, description: this.$data.description, end_date:this.$data.end, private: this.$data.radioGroup === 1, password: this.$data.password, owner: 1 })
      };
      console.log(requestOptions)
      fetch("http://cfbf-178-239-165-202.ngrok.io/api/v1/challenge/", requestOptions)
          .then(response => response.json())
          .then(response => console.log(response));
      //TODO store values with api
      this.$emit("closeModal");
    },
  },
  data: () => ({
    valid: true,
    title: "",
    nameRules: [
      (v: any) => !!v || "Title is required",
      (v: string | any[]) =>
        (v && v.length <= 15) || "Title must be less than 15 characters",
    ],
    description: "",
    descriptionRules: [
      (v: string | any[]) =>
        (v && v.length <= 250) ||
        "Description must be less than 250 characters",
    ],
    select: null,
    items: ["Highest Value", "Lowest Value", "Streak", "Global Goal"],
    datasource: null,
    interfaces: ["Fitbit", "Github", "Logging"],
    goal: 0,
    radioGroup: 0,
    password: null,
    //Add password validation
    passwordRules: [],
    end: "",
  }),
});
</script>
