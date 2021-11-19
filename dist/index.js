"use strict";

var _server = require("./server");

// startServer();
const fs = require('fs');

const csv = require('@fast-csv/parse');

const lengths = {}; // pass in path to your csv file

let stream = fs.createReadStream('flat_files/reviews.csv');
let csvData = [];
console.log('parsing...');
let csvStream = csv.parse({
  headers: true
}).on('data', row => {
  for (let key in row) {
    lengths[key] = Math.max(lengths[key] || 0, row[key].length);
  }
}).on('error', err => console.log(err)).on('end', () => {
  console.log(lengths);
});
stream.pipe(csvStream); // output:
// {
//   id: 7,
//   name: 26,
//   slogan: 109,
//   description: 462,
//   category: 16,
//   default_price: 7
// }