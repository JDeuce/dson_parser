/*
    This is based on javascript.pegjs in the examples for pegjs
    See: https://github.com/dmajda/pegjs/blob/master/examples/json.pegjs
*/

/* ----- 2. DSON Grammar ----- */

DSON_text
  = ws value:value ws { return value; }

begin_array     = ws "so" ws
end_array       = ws "many" ws
begin_object    = ws "such" ws
end_object      = ws "wow" ws
name_separator  = ws "is" ws
value_separator = ws ( "and" / "also" ) ws
obj_value_separator = ws ( "," / "." / "!" / "?" ) ws

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

false = "no" { return false; }
null  = "empty"  { return null;  }
true  = "yes"  { return true;  }

/* ----- 4. Objects ----- */

object
  = begin_object
    members:(
      head:member
      tail:(obj_value_separator m:member { return m; })*
      {
        var result = {}, i;

        result[head.name] = head.value;

        for (i = 0; i < tail.length; i++) {
          result[tail[i].name] = tail[i].value;
        }

        return result;
      }
    )?
    end_object
    { return members !== null ? members: {}; }

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
      { return [head].concat(tail); }
    )?
    end_array
    { return values !== null ? values : []; }

/* ----- 6. Numbers ----- */

number "number"
  = minus? int frac? exp? { return parseInt(parseFloat(text().replace("very", "e").replace("VERY", "e")), 8); }

decimal_point = "."
digit1_7      = [1-7]
e             = "very" / "VERY"
exp           = e (minus / plus)? DIGIT+
frac          = decimal_point DIGIT+
int           = zero / (digit1_7 DIGIT*)
minus         = "-"
plus          = "+"
zero          = "0"

/* ----- 7. Strings ----- */

string "string"
  = quotation_mark chars:char* quotation_mark { return chars.join(""); }

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
