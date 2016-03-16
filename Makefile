WEBPACK_BIN = ./node_modules/.bin/webpack
UGLIFYJS_BIN = ./node_modules/.bin/uglifyjs
MOCHA_BIN = ./node_modules/.bin/mocha

DSON_DEPS = src/entry.js src/grammars/dson_json.pegjs src/grammars/json_dson.pegjs

.PHONY: clean all test

all: dist/dson.js dist/dson.min.js

dist/dson.js: $(DSON_DEPS)
	$(WEBPACK_BIN) $< $@

dist/dson.min.js: dist/dson.js
	$(UGLIFYJS_BIN) $< > $@

dist/test.js: test/tests.js $(DSON_DEPS)
	$(WEBPACK_BIN) --target node $< $@

test: dist/test.js
	$(MOCHA_BIN) dist/test.js


clean:
	rm dist/*.js
