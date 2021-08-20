# A noJS data visualization project using [Pancake](https://pancake-charts.surge.sh)

The goal of this demo is to provide a robust, interactive, and responsive experience of viewing a simple dataset _without requiring any client-side Javascript_. The page mimics SPA functionality by using an iframe to render the chart. The zip-code select form has its submit event pointed to the iframe by using the HTMLFormElement `target` attribute, so only the iframe is reloaded with new data when the form is submitted.

The chart is rendered using the new Pancake library from Rich Harris, which uses some lesser-known properties of SVG to render responsive charts with no Javascript required.

A simple bash scraper (`data/process-data.sh`) runs via a cron job (`cron.sh`) to update a Postgres database every day with new data.
