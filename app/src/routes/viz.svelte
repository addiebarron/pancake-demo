<script>
  import { page } from "$app/stores";

  import Chart from "../components/Chart.svelte";

  let zip;

  if (page.query.has("zip")) {
    zip = page.query.get("zip");
  } else {
    zip = 19143;
  }
</script>

<Chart {zip} />
