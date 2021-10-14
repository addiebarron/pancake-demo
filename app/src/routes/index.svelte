<!-- Homepage -->
<script>
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
      on:change|preventDefault={() => form.submit()}
    >
      {#each zips as zip}
        <option selected={zip == 19143} value={zip}>{zip}</option>
      {/each}
    </select>. View as
    <select
      name="view"
      id="viewselect"
      on:change|preventDefault={() => form.submit()}
    >
      <option value="roll">Rolling average</option>
      <option value="norm">Daily counts</option>
      <option value="raw">Total count</option>
    </select>.
    <noscript>
      <input type="submit" value="Show me" />
    </noscript>
  </form>
  <div id="iframe-container">
    <iframe
      src="/viz"
      name="chart-iframe"
      title="COVID cases chart"
      frameborder="0"
      scrolling="no"
    />
  </div>
  <aside>
    <p>
      This site was created using <a
        href="https://kit.svelte.dev"
        target="_blank">SvelteKit</a
      >
      and
      <a href="https://pancake-charts.surge.sh" target="_blank">Pancake</a>. It
      is designed to be fully functional and responsive with no JavaScript. Try
      disabling JS!
    </p>
    <p>
      The data is scraped daily from the
      <a
        target="_blank"
        href="https://github.com/ambientpointcorp/covid19-philadelphia/tree/master/cases_by_date"
        >city's official testing datasets</a
      >. This is a demonstration of a web tool, and is not intended to inform
      COVID-related decisions or analysis~
    </p>
    <p>
      <i
        >Created by <a href="https://addieis.online" target="_blank">Addie B</a
        >. Source code and more info on
        <a target="_blank" href="https://github.com/addiebarron/pancake-demo"
          >GitHub</a
        >.</i
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
    font-size: 18px;
  }
  main {
    width: 100%;
    height: 100%;
    max-width: 50vw;
    min-width: 600px;
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
    font-size: 1.1em;
    font-family: inherit;
    border: solid 1px #8f8f9d;
    border-radius: 3px;
    background-color: #eee;
    margin: 5px 0;
  }
  main form input[type="submit"] {
    background-color: rgb(255, 229, 143);
  }

  main #iframe-container {
    width: 100%;
    height: 100%;
    min-height: 400px;
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
    color: rgba(0, 0, 0, 0.7);
  }

  a {
    text-decoration: none;
    color: rgb(255, 65, 65);
  }
  a:hover {
    text-decoration: underline;
  }

  @media screen and (max-width: 650px) {
    main {
      min-width: unset;
      max-width: unset;
    }
  }
</style>
