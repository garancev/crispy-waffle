const fs = require('fs');

const fetch = url => {
  return fs.readFileSync(url)
    .toString()
    .split('\n')
    .map(e => e.trim())
    .map(e => e.split(',').map(e => e.trim()));
}

module.exports = fetch;