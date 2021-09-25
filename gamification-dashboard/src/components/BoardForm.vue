<template id="board-form">
  <v-container style="padding: 0">
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
      <v-select
          v-model="select"
          :items="interfaces"
          :rules="[(v) => !!v || 'Interface is required']"
          label="Interface"
          required
      ></v-select>
      <v-textarea
          v-model="description"
          :counter="250"
          :rules="descriptionRules"
          label="Description"
      ></v-textarea>
      <v-text-field v-model="end" type="date" label="End time" required></v-text-field>
      <v-radio-group v-model="radioGroup">
        <v-radio
            label="Public"
            value=0
        ></v-radio>
        <v-radio
            label="Private"
            value=1
        ></v-radio>
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

export default Vue.extend( {
  template: '#board-form',
  name: "BoardForm",
  methods: {
    storeValuesAndClose: function () {
      //TODO store values with api
      this.$emit('closeModal')
    }
  },
  data: () => ({
    valid: true,
    title: '',
    nameRules: [
      (v: any) => !!v || 'Title is required',
      (v: string | any[]) => (v && v.length <= 15) || 'Title must be less than 15 characters',
    ],
    description: '',
    descriptionRules: [
      (v: string | any[]) => (v && v.length <= 250) || 'Description must be less than 250 characters',
    ],
    select: null,
    items: [
      'Highest Value',
      'Lowest Value',
      'Streak',
      'Global Goal',
    ],
    interfaces: [
      'Fitbit',
      'Github',
      'Logging',
    ],
    radioGroup: 0,
    password: '',
    //Add password validation
    passwordRules: [],
    end: '',
  }),
});
</script>
