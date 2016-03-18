# What Is It
Javascript implementation of [DSON](https://github.com/dogescript/DSON) using [PEGjs](http://pegjs.majda.cz/).

Doge Serialized Object Notation (or DSON, previously DogeON) is a data-interchange format that is easy to read and write for Shiba Inu dogs. It strives to replace JSON and XML as the major players in terms of intercommunication between a wide range of services for Shiba Inus and other doge breeds alike.

# Show me how it works
Live example at http://dsonlint.github.io/



# Integrating Into Another Project
Just include dson.min.js into your project:

    <script type="text/javascript" src="dson.min.js"></script>


And then you can simply call DSON.parse:

    var result = DSON.parse("42very3");

    ==> 17408


Or:

    var result = DSON.parse('such "foo" is "bar" . "doge" is "shibe" wow');

    ==>  {"foo": "bar", "doge": "shibe"}


Or backwards:

    var result = DSON.stringify({ "foo": "bar", "doge": "shibe" })
    ==> 'such "foo" is "bar", "doge" is "shibe" wow'


    var result = DSON.stringify(17408)
    ==> '42very3';

# Building


## Installing the deps

    npm install


## Making the dist files

    $ make
    webpack src/entry.js dist/dson.js
    Hash: d1e572f8a950cc6d23b6
    Version: webpack 1.12.14
    Time: 1818ms
      Asset     Size  Chunks             Chunk Names
    dson.js  85.8 kB       0  [emitted]  main
        + 3 hidden modules
    uglifyjs dist/dson.js > dist/dson.min.js


## Running the tests

    $ make test
    webpack --target node test/tests.js dist/test.js
    Hash: 25d099fd564253a6cdef
    Version: webpack 1.12.14
    Time: 2013ms
      Asset     Size  Chunks             Chunk Names
    test.js  87.7 kB       0  [emitted]  main
        + 5 hidden modules
    mocha dist/test.js


      DSON
        parse
          ✓ should pass sample case #0
          ✓ should pass sample case #1
          ✓ should pass sample case #2
          ✓ should pass sample case #3
        stringify
          ✓ should pass sample case #0
          ✓ should pass sample case #1
          ✓ should pass sample case #2
          ✓ should pass sample case #3
          ✓ should handle objects
          ✓ should handle strings


      10 passing (49ms)


