What Is It
==========
Javascript implementation of DOGEON/DSON
parsing following the document at http://dogeon.org/
and using PEGjs (http://pegjs.majda.cz/)


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
