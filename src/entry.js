/* jshint esversion: 6 */

import dson_json from 'grammars/dson_json';
import json_dson from 'grammars/json_dson';

var DSON = {
  parse: dson_json.parse,
  stringify: function(json) {
    if (typeof json !== 'string')
      json = JSON.stringify(json);
    return json_dson.parse(json);
  }
};

export default DSON;

// Export to browser global namespace
if (typeof window !== 'undefined')
  window.DSON = DSON;
