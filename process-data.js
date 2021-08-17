const GHC = require("github-content");

const ghc = new GHC({
  owner: "ambientpointcorp",
  repo: "covid19-philadelphia",
  branch: "master", // defaults to master
});

const postgresPassword = process.env.POSTGRES_PASSWORD;
const databaseURI = `postgres://covidviz:${postgresPassword}@db:5432/database`;

const today = new Date();
const todayString = `${today.getFullYear()}-${
  today.getMonth() < 10 ? "0" + today.getMonth() : today.getMonth()
}-${today.getDate()}`;
const arr = getDaysArray("2020-06-01", todayString);

var getDaysArray = function (start, end) {
  for (
    var arr = [], dt = new Date(start);
    dt <= end;
    dt.setDate(dt.getDate() + 1)
  ) {
    arr.push(new Date(dt));
  }
  return arr;
};
