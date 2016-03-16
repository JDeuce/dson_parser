/* jshint esversion: 6 */

import DSON from '../src/entry.js';
import assert from 'assert';

let cases = [
  [
    'such "foo" is "bar", "doge" is "shibe" wow',
    '{"foo":"bar","doge":"shibe"}'
  ],
  [
    'such "foo" is such "shiba" is "inu", "doge" is yes wow wow',
    '{"foo":{"shiba":"inu","doge":true}}'
  ],
  [
    'such "foo" is so "bar" also "baz" and "fizzbuzz" many wow',
    '{"foo":["bar","baz","fizzbuzz"]}'
  ],
  [
    'such "foo" is 42, "bar" is 42very3 wow',
    '{"foo":34,"bar":17408}'
  ]
];

function test_parse(i) {
  let c = cases[i];
  let r = JSON.stringify(DSON.parse(c[0]));
  assert.equal(r, c[1]);
}

function test_stringify(i) {
  let c = cases[i];
  let r = DSON.stringify(JSON.parse(c[1]));
  assert.equal(r, c[0]);
}

describe('DSON', function() {
  let test_case;
  describe('parse', function () {
    for (test_case=0; test_case<cases.length; test_case++)
      it('should pass sample case #' + test_case, test_parse.bind(test_parse, test_case));
  });
  describe('stringify', function () {
    for (test_case=0; test_case<cases.length; test_case++)
      it('should pass sample case #' + test_case, test_stringify.bind(test_stringify, test_case));

    it('should handle objects', function() {
      let r = DSON.stringify({});
      assert.equal(r, "such wow");
    });

    it('should handle strings', function() {
      let r = DSON.stringify("{}");
      assert.equal(r, "such wow");
    });
  });
});
