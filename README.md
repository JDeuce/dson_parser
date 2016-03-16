What Is It
==========
Javascript implementation of [DSON](https://github.com/dogescript/DSON) using [PEGjs](http://pegjs.majda.cz/).

Doge Serialized Object Notation (or DSON, previously DogeON) is a data-interchange format that is easy to read and write for Shiba Inu dogs. It strives to replace JSON and XML as the major players in terms of intercommunication between a wide range of services for Shiba Inus and other doge breeds alike.

Show me how it works
====================
Live example at http://dsonlint.github.io/



Integrating Into Another Project
================================
Just include dson.js into your project:

    <script type="text/javascript" src="dson.js"></script>


And then you can simply call DSON.parse:

    var result = DSON.parse("42very3");

    ==> 42e3


Or:

    var result = DSON.parse('such "foo" is "bar" . "doge" is "shibe" wow');

    ==>  {"foo": "bar", "doge": "shibe"}
