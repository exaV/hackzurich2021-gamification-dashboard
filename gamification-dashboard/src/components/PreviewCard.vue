<template>
  <v-container style="padding: 2em">
    <v-row style="height: 100%">
      <v-col>
        <v-row class="title">
          {{ challenge.title }}
        </v-row>
        <v-row class="subtitle">
          {{ challenge.description }}
        </v-row>
        <v-row v-if="challengeDetails" style="height: 100%; max-height: 70%">
          <!-- TODO show appropriate content here base on-->
          <highest-score-chart
            v-if="challenge.type === 'max'"
            v-bind:challenge-entries="challengeDetails"
          ></highest-score-chart>
          <TeamGoalWidget v-if="challenge.type === 'sum-up'" v-bind:challenge-entries="challengeDetails" ></TeamGoalWidget>
        </v-row>
        <v-row v-else>
          <v-progress-circular indeterminate></v-progress-circular>
        </v-row>
      </v-col>
    </v-row>
  </v-container>
</template>
<script lang="ts">
import {
  Challenge,
  ChallengeEntry,
  DataProvider,
} from "@/components/data-provider";
import HighestScoreChart from "@/components/HighestScoreChart.vue";
import TeamGoalWidget from "@/components/TeamGoalWidget.vue";

const provider = new DataProvider();

export default {
  components: { TeamGoalWidget, HighestScoreChart },
  props: {
    // eslint-disable-next-line
    challenge: Challenge,
  },
  mounted() {
    console.log(`challenge with type ${this.challenge.type}`);
    provider.getChallengeEntry(this.challenge?.id).then((entries) => {
      this.challengeDetails = entries;
      console.log("entries", entries);
    });
  },
  // eslint-disable-next-line
  data(): any {
    return {
      challengeDetails: null as ChallengeEntry[] | null,
    };
  },
};
</script>

<style>
.preview-card {
  display: inline-flex;
}

.title {
  align-items: center;
  justify-content: center;
  display: flex;
  flex-wrap: wrap;
  font-size: 1.25rem;
  font-weight: 500;
  letter-spacing: 0.0125em;
  line-height: 2rem;
  word-break: break-all;
}

.subtitle {
  font-size: 0.875rem;
  font-weight: 400;
  line-height: 1.375rem;
  letter-spacing: 0.0071428571em;
}
</style>