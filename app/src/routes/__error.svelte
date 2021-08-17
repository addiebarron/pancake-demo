<script context="module">
  export function load({ status }) {
    return { props: { status } };
  }
</script>

<script>
  export let status;
</script>

<main>
  <h1>{status}</h1>
  <p>
    {#if status == 500}There's probably no data in the database.{/if}
    File an issue
    <a href="https://github.com/addiebarron/covid-viz/issues">here</a>.
  </p>
</main>

<style>
  main {
    width: 100%;
    height: 100%;
    background-color: white;
  }
</style>
