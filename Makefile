#######
# Environment config
#######
# Add node binaries to path
export PATH := ./node_modules/.bin:$(PATH)

#######
# Variables
#######
GRAMMARS := $(wildcard src/grammars/*.pegjs)
SCRIPTS := $(wildcard src/*.js)
# List of files the dist and tests depend on
SOURCES := $(GRAMMARS) $(SCRIPTS)
# Entry point for dson.js
DISTENTRY := src/entry.js
# Entry point for tests
TESTENTRY := test/tests.js

#######
# Callable rules
#######
# Mark them phony since they don't build files
.PHONY: dist test clean
# build dson.js and the minified version
dist: dist/dson.js dist/dson.min.js
# build and run the tests
test: dist/test.js
	mocha $<
# clean the output artifacts
clean:
	rm -f dist/*.js

#######
# Build rules
#######
# Core distribution
dist/dson.js: $(DISTENTRY) $(SOURCES)
	webpack $< $@
# Minified version of core
dist/dson.min.js: dist/dson.js
	uglifyjs $< > $@
# Test script
dist/test.js: $(TESTENTRY) $(SOURCES)
	webpack --target node $< $@

