<!-- Data rendering view -- loads inside `chart-iframe` within index.svelte -->
<script context="module">
  export async function load({ page, fetch }) {
    let zip = page.query.get("zip");
    const res = await fetch(`/data/${zip}`);
    const json = await res.json();

    let data;

    if (!json.length) {
      data = null;
    }

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

    console.log(data);

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
