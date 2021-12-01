const process = require('./main.js');

test('returns 3', () => {
  expect(process()).toBe(6);
});