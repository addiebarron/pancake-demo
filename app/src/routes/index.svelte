<script context="module">
</script>

<script>
  //import { PostgrestClient } from "@supabase/postgrest-js";
  //import fs from "fs";
  //import csv from "csv-parser";

  // node-schedule task for downloading new CSV files and re-adding them

  // for CSV file in data folder:
  // https://stackabuse.com/reading-and-writing-csv-files-with-node-js/#readingcsvfilesinnodejs
  // fs.createReadStream("../data/covid_cases_by_zip_2020-06-01.csv")
  //   .pipe(csv())
  //   .on("data", (row) => {
  //     // add row to database table for corresponding zip code
  //   })
  //   .on("end", () => {
  //     console.log("CSV file successfully processed");
  //   });

  // const REST_URL = "http://localhost:5432";
  // const postgrest = new PostgrestClient(REST_URL);

  const zips = [19143, 19144];
</script>

<main>
  <h1>Philadelphia COVID-19 Cases by ZIP code</h1>
  <form action="/viz" method="GET" target="chart-iframe">
    <select name="zip" id="zipselect">
      {#each zips as zip}
        <option value={zip}>{zip}</option>
      {/each}
    </select>
    <input type="submit" />
  </form>
  <iframe name="chart-iframe" title="COVID cases chart" frameborder="0" />
</main>
