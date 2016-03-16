/*
    This is based on javascript.pegjs in the examples for pegjs
    See: https://github.com/dmajda/pegjs/blob/master/examples/json.pegjs
*/

/* ----- 2. JSON Grammar ----- */

JSON_text
  = ws value:value ws { return value; }

begin_array     = ws "[" ws
begin_object    = ws "{" ws
end_array       = ws "]" ws
end_object      = ws "}" ws
name_separator  = ws ":" ws
value_separator = ws "," ws

ws "whitespace" = [ \t\n\r]*

/* ----- 3. Values ----- */

value
  = false
  / null
  / true
  / object
  / array
  / number
  / string

false = "false" { return "no"; }
null  = "null"  { return "empty";  }
true  = "true"  { return "yes";  }

/* ----- 4. Objects ----- */

object
  = begin_object
    members:(
      head:member
      tail:(value_separator m:member { return m; })*
      {
        var result = "such ", i;
        var seps = [',', '.', '!', '?'];
        var sepi = 0;

        result += head.name;
        result += ' is ';
        result += head.value;

        for (i = 0; i < tail.length; i++) {
          result += seps[sepi] + ' ';
          sepi = (sepi + 1) % seps.length;
          result += tail[i].name;
          result += ' is ';
          result += tail[i].value;
        }

        result += " wow"

        return result;
      }
    )?
    end_object
    { return members !== null ? members: "such wow"; }

member
  = name:string name_separator value:value {
      return { name: name, value: value };
    }

/* ----- 5. Arrays ----- */

array
  = begin_array
    values:(
      head:value
      tail:(value_separator v:value { return v; })*
      { 

        var result = "so ", i;
        var seps = ['also', 'and'];
        var sepi = 0;

        result += head;

        for (i = 0; i < tail.length; i++) {
          result += ' ' + seps[sepi] + ' ';
          sepi = (sepi + 1) % seps.length;
          result += tail[i];
        }

        result += " many";

        return result;
      }
    )?
    end_array
    { return values !== null ? values : []; }

/* ----- 6. Numbers ----- */

number "number"
  = minus? int frac? exp?
  { 
    var num = parseFloat(text());
    var str = num.toString(8);
    var exp = 0;


    while (str[str.length-1] == '0') {
      str = str.slice(0, -1);
      exp += 1;
    }

    if (exp > 0)
      str += 'very' + exp;

    return str;
  }

decimal_point = "."
digit1_9      = [1-9]
e             = [eE]
exp           = e (minus / plus)? DIGIT+
frac          = decimal_point DIGIT+
int           = zero / (digit1_9 DIGIT*)
minus         = "-"
plus          = "+"
zero          = "0"

/* ----- 7. Strings ----- */

string "string"
  = quotation_mark chars:char* quotation_mark { return '"' + chars.join("") + '"'; }

char
  = unescaped
  / escape
    sequence:(
        '"'
      / "\\"
      / "/"
      / "b" { return "\b"; }
      / "f" { return "\f"; }
      / "n" { return "\n"; }
      / "r" { return "\r"; }
      / "t" { return "\t"; }
      / "u" digits:$(HEXDIG HEXDIG HEXDIG HEXDIG) {
          return String.fromCharCode(parseInt(digits, 16));
        }
    )
    { return sequence; }

escape         = "\\"
quotation_mark = '"'
unescaped      = [^\0-\x1F\x22\x5C]

/* ----- Core ABNF Rules ----- */

/* See RFC 4234, Appendix B (http://tools.ietf.org/html/rfc4627). */
DIGIT  = [0-9]
HEXDIG = [0-9a-f]i
