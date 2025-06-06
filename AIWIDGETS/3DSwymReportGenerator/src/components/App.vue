<template>
  <div class="container">
    <h1>?? 3DSwym Report Generator</h1>

    <!-- File Picker -->
    <label>
      ?? Select SWYM feed list (.txt or .json):
      <input type="file" accept=".txt,.json" @change="handleFileUpload" />
    </label>

    <!-- Timeframe Selector -->
    <div class="timeframe">
      <label><input type="radio" value="24h" v-model="timeframe" /> Last 24h</label>
      <label><input type="radio" value="7d" v-model="timeframe" /> Last 7 days</label>
      <label><input type="radio" value="30d" v-model="timeframe" /> Last 30 days</label>
      <label><input type="radio" value="all" v-model="timeframe" /> All time</label>
    </div>

    <!-- Generate Button -->
    <button @click="generateReport" :disabled="!feeds.length || loading">
      ?? Generate Report
    </button>

    <!-- Report Display -->
    <div v-if="loading">? Generating summary...</div>
    <div v-if="report.length" class="report">
      <div v-for="(entry, idx) in report" :key="idx" class="entry">
        <h3>{{ entry.title }}</h3>
        <p><strong>URL:</strong> {{ entry.url }}</p>
        <ul>
          <li v-for="(line, i) in entry.summary" :key="i">{{ line }}</li>
        </ul>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      feeds: [],
      timeframe: "7d",
      loading: false,
      report: []
    };
  },
  methods: {
    async handleFileUpload(event) {
      const file = event.target.files[0];
      if (!file) return;

      const text = await file.text();
      const lines = text.split("\n").filter(line => line.trim() && !line.startsWith("#"));
      this.feeds = lines.map(line => {
        const [type, url] = line.trim().split("|");
        return { type, url };
      });
    },

    async generateReport() {
      this.loading = true;
      this.report = [];

      // ?? Placeholder summary logic (LLM to be plugged here)
      for (const feed of this.feeds) {
        this.report.push({
          title: `?? ${feed.type.toUpperCase()} Feed`,
          url: feed.url,
          summary: [
            " Placeholder summary line 1",
            " Placeholder summary line 2",
            " ?? Urgent message detected! Please read full post."
          ]
        });
      }

      this.loading = false;
    }
  }
};
</script>

<style scoped>
.container {
  max-width: 700px;
  margin: 0 auto;
  padding: 1.5rem;
  font-family: Arial, sans-serif;
}
.timeframe {
  margin: 1rem 0;
}
.report {
  margin-top: 2rem;
  border-top: 1px solid #ccc;
  padding-top: 1rem;
}
.entry {
  margin-bottom: 1.5rem;
  border-left: 4px solid #ddd;
  padding-left: 1rem;
}
</style>