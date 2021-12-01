const fetch = require('../fetch.js');
const sum = require('./sum.js');

const data = fetch('01/input.csv')
console.log(data);

const process = () => {
    return sum(3)
}
module.exports = process;