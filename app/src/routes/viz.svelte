<script context="module">
  export async function load({ page }) {
    let zip = 19143;
    if (page.query.has("zip")) {
      zip = page.query.get("zip");
    }
    return { props: { zip } };
  }
</script>

<script>
  import Chart from "../components/Chart.svelte";

  export let zip;
</script>

<h1>Chart</h1>
<Chart {zip} />
