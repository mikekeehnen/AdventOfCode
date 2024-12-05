const fs = require("fs");

const input = fs.readFileSync("./input.txt", "utf-8").split("\n");

const rules = input
  .filter((line) => line.includes("|"))
  .map((rule) => rule.split("|"));
const pages = input
  .filter((line) => line.includes(","))
  .map((page) => page.split(","));

let correctPagesCount = 0;

pages.forEach((page) => {
  const applicableRules = rules.filter(
    (rule) => page.includes(rule[0]) && page.includes(rule[1])
  );
  if (
    applicableRules.every(
      (rule) => page.indexOf(rule[0]) < page.indexOf(rule[1])
    )
  ) {
    const middleNumberIndex = Math.floor(page.length / 2);
    correctPagesCount += Number(page[middleNumberIndex]);
  }
});

const graph = {};
rules.forEach((line) => {
  const [left, right] = line.map((num) => parseInt(num));
  if (graph[right] === undefined) graph[right] = [];
  if (graph[left] === undefined) graph[left] = [];
  graph[right].push(left);
});

const correctedPagesCount = pages.reduce((sum, line) => {
  const numbers = line.map((num) => parseInt(num));

  let correct = true;
  for (let i = 1; i < numbers.length; i++) {
    for (let j = i - 1; j >= 0; j--) {
      if (!graph[numbers[i]].includes(numbers[j])) correct = false;
    }
  }

  // if not correct, sort by page rule counts (only count page rules that affect current list)
  if (!correct) {
    numbers.sort(
      (a, b) =>
        graph[a].filter((num) => numbers.includes(num)).length -
        graph[b].filter((num) => numbers.includes(num)).length
    );
    sum += numbers[Math.floor(numbers.length / 2)];
  }

  return sum;
}, 0);

console.log("Part 1: ", correctPagesCount);
console.log("Part 2: ", correctedPagesCount);
