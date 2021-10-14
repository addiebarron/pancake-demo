<!-- Data rendering view -- loads inside `chart-iframe` within index.svelte -->
<script context="module">
  export async function load({ page, fetch }) {
    let zip = page.query.get("zip") ?? 19143;
    let view = page.query.get("view") ?? "roll";

    const res = await fetch(`http://server:3000/tests?zip=eq.${zip}`);
    const json = await res.json();

    let data;

    if (!json.length) {
      data = null;
    } else {
      data = {
        neg: json.map((row) => {
          return {
            x: new Date(row.timestamp),
            y: row.negative,
          };
        }),
        pos: json.map((row) => {
          return {
            x: new Date(row.timestamp),
            y: row.positive,
          };
        }),
      };

      // normalize data to show daily counts, rather
      // than cumulative amounts.
      if (view == "norm" || view == "roll") {
        for (let key in data) {
          let set = data[key];
          let lastVal = 0;
          for (let i = 1; i < set.length; i++) {
            const thisVal = set[i].y;
            set[i].y -= lastVal;
            lastVal = thisVal;
          }
        }
      }
      // rolling average using 30 days as a default. should be
      // performed as a second step to normalization
      if (view == "roll") {
        // size of the rolling average window
        let days = 30;
        for (let key in data) {
          let values = data[key].map((point) => point.y);
          for (let i = 0; i < values.length - days; i++) {
            data[key][i].y =
              values.slice(i, i + days).reduce((a, b) => a + b) / days;
          }
          // flatten the first few values, fixes unexplained spike
          data[key][0].y = data[key][1].y = data[key][2].y;
          // remove the last n values
          data[key] = data[key].slice(0, -days);
        }
      }
    }
    return { props: { data, zip } };
  }
</script>

<script>
  import Chart from "$lib/Chart.svelte";

  export let data, zip;
</script>

{#if data}
  <Chart {data} />
{:else}
  <p>No data for {zip}</p>
{/if}

<style>
  :global(html, body) {
    width: 100%;
    height: 100%;
    padding: 10px;
    background: white;
  }
  :global(body) {
    padding-bottom: 20px;
  }
</style>
