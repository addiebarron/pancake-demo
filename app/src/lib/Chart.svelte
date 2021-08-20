<!-- Chart generated from two sets of x-y points (positive and negative tests) -->
<script>
  import * as Pancake from "@sveltejs/pancake";

  export let data;

  // set bounds to encapsulate all data
  let x1 = +Infinity;
  let x2 = -Infinity;
  let y1 = +Infinity;
  let y2 = -Infinity;

  for (let type in data) {
    data[type].forEach((d) => {
      let x = d.x; //.getTime();

      if (x < x1) x1 = x;
      if (x > x2) x2 = x;

      if (d.y < y1) y1 = d.y;
      if (d.y > y2) y2 = d.y;
    });
  }
</script>

<div class="legend">
  <p><span class="box blue" />Negative tests</p>
  <p><span class="box red" />Postive tests</p>
</div>
<div class="chart">
  <Pancake.Chart {x1} {x2} {y1} {y2}>
    <Pancake.Grid horizontal count={5} let:value>
      <div class="grid-line horizontal"><span>{value}</span></div>
    </Pancake.Grid>

    <Pancake.Grid vertical count={2} let:value>
      <span class="grid-line vertical x-label">{value}</span>
    </Pancake.Grid>

    <Pancake.Svg>
      <Pancake.SvgLine data={data.neg} let:d>
        <path class="data neg" {d} />
      </Pancake.SvgLine>

      <Pancake.SvgLine data={data.pos} let:d>
        <path class="data pos" {d} />
      </Pancake.SvgLine>
    </Pancake.Svg>
  </Pancake.Chart>
</div>

<style>
  :root {
    --legend-red: rgb(255, 65, 65);
    --legend-blue: rgb(0, 140, 255);
  }
  .chart {
    height: calc(100% - 3.5em);
    padding: 1em 1em 1em 2em;
    margin: 0 0 36px 0;
  }

  .grid-line {
    position: relative;
    display: block;
  }
  .grid-line.horizontal {
    width: calc(100% + 2em);
    left: -2em;
    border-bottom: 1px dashed #ccc;
  }
  .grid-line span {
    position: absolute;
    left: 0;
    bottom: 0.5vw;
    font-family: sans-serif;
    font-size: 0.8em;
    color: #999;
  }
  .x-label {
    position: absolute;
    width: 4em;
    left: -2em;
    bottom: -22px;
    font-family: sans-serif;
    font-size: 14px;
    color: #999;
    text-align: center;
  }

  path.data {
    stroke-linejoin: round;
    stroke-linecap: round;
    stroke-width: 1px;
    fill: none;
  }
  path.data.pos {
    stroke: var(--legend-red);
  }
  path.data.neg {
    stroke: var(--legend-blue);
  }

  .legend p {
    margin: 5px 0;
  }
  .legend .box {
    display: inline-block;
    width: 0.8em;
    height: 0.8em;
    margin-right: 5px;
  }
  .legend .box.red {
    background-color: var(--legend-red);
  }
  .legend .box.blue {
    background-color: var(--legend-blue);
  }
</style>
