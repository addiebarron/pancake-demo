<script context="module">
  export function load({ status, error }) {
    return { props: { status, error } };
  }
</script>

<script>
  export let status, error;
  export let dev = import.meta.env.DEV;
</script>

<main>
  <h1>{status}</h1>
  {#if dev}
    <p>{error.message}</p>
  {:else}
    <p>
      {#if status == 500}There's probably no data in the database.{/if}
      File an issue
      <a href="https://github.com/addiebarron/covid-viz/issues">here</a>.
    </p>
  {/if}
</main>

<style>
  main {
    width: 100%;
    height: 100%;
    background-color: white;
  }
</style>
