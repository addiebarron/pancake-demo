<script context="module">
  export async function load({ page, fetch }) {
    let zip = page.query.get("zip");
    const res = await fetch(`/data/${zip}`);
    const json = await res.json();

    if (!json.length) {
      let data = null;
    }

    let data = {
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

    return { props: { data, zip } };
  }
</script>

<script>
  import Chart from "../components/Chart.svelte";

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
</style>
