# 3DSwym Report Generator Widget

A lightweight Vue-based custom widget for 3DEXPERIENCE dashboards.  
It allows users to summarize recent 3DSwym **conversations** and **community posts** using an LLM via Hugging Face API.

## 🔍 Key Features

- Upload a text config file containing SWYM conversation and community URLs.
- Choose between:
  - Last 24 hours
  - Weekly
  - Monthly
  - Full report
- Summarizes key **takeaways** from each feed using Hugging Face Zephyr.
- Highlights **urgent** or **important** discussions.
- Suggests which posts should be read in full.

## 📁 Usage

1. Drag and drop your configuration `.txt` file into the widget.
2. Select your preferred time filter.
3. Click **Generate Report**.
4. Wait for LLM summaries and key insights to appear.

The configuration file must contain lines formatted as:

conversation|https://swym-url/path-to-conversation
community|https://swym-url/path-to-community