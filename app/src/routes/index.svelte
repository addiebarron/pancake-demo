<script>
  import { onMount } from "svelte";

  const zips = [
    19100, 19101, 19102, 19103, 19104, 19105, 19106, 19107, 19108, 19109, 19110,
    19111, 19113, 19114, 19115, 19116, 19118, 19119, 19120, 19121, 19122, 19123,
    19124, 19125, 19126, 19127, 19128, 19129, 19130, 19131, 19132, 19133, 19134,
    19135, 19136, 19137, 19138, 19139, 19140, 19141, 19142, 19143, 19144, 19145,
    19146, 19147, 19148, 19149, 19150, 19151, 19152, 19153, 19154, 19155, 19156,
    19157, 19158, 19160, 19161, 19162, 19170, 19171, 19172, 19174, 19176, 19178,
    19179, 19181, 19182, 19183, 19184, 19188, 19190, 19191, 19192, 19193, 19194,
    19195, 19196, 19197,
  ];

  let form;

  const submitForm = (e) => form.submit();
</script>

<main>
  <h1>Philadelphia COVID-19 Cases by ZIP</h1>
  <form
    id="form"
    action="/viz"
    method="GET"
    target="chart-iframe"
    bind:this={form}
  >
    My zip code is <select
      name="zip"
      id="zipselect"
      on:change|preventDefault={submitForm}
    >
      {#each zips as zip}
        <option value={zip}>{zip}</option>
      {/each}
    </select>
    <noscript>
      <input type="submit" />
    </noscript>
  </form>
  <div id="iframe-container">
    <iframe
      src="/viz?zip=19100"
      name="chart-iframe"
      title="COVID cases chart"
      frameborder="0"
      scrolling="no"
    />
  </div>
  <aside>
    <p>
      <big>
        This site was created using <a
          href="https://kit.svelte.dev"
          target="_blank">SvelteKit</a
        >
        and
        <a href="https://pancake-charts.surge.sh" target="_blank">Pancake</a>.
        It is designed to be fully functional and responsive with zero
        Javascript. Try disabling JS and reloading the page!
      </big>
    </p>
    <p>
      <i
        >Created by <a href="https://addieis.online" target="_blank">Addie B</a
        ></i
      >
    </p>
  </aside>
</main>

<style>
  :global(html, body) {
    width: 100%;
    height: 100%;
    margin: 0;
    padding: 0;
    background: rgb(207, 255, 207);
  }
  main {
    width: 100%;
    height: 100%;
    max-width: 800px;
    padding: 20px;
    margin: auto;
    display: flex;
    flex-direction: column;
  }
  main > * {
    margin: 10px auto;
    text-align: center;
  }
  main form select,
  main form input {
    width: auto;
    height: auto;
    font-size: 1.5em;
    font-family: inherit;
  }
  main form select option {
    font-size: 15px !important;
  }

  main #iframe-container {
    width: 100%;
    height: 100%;
    flex: 1;
    overflow: hidden;
    border: solid 1px gray;
    box-shadow: 10px 10px black;
  }
  main #iframe-container iframe {
    width: 100%;
    height: 100%;
  }

  aside {
    margin: auto;
    width: 100%;
    max-width: 600px;
    color: rgba(0, 0, 0, 0.6);
  }
  aside big {
    font-size: 16px;
  }

  a {
    text-decoration: none;
    color: rgb(255, 65, 65);
  }
  a:hover {
    text-decoration: underline;
  }
</style>
