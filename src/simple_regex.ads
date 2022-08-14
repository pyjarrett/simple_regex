package Simple_Regex
    with SPARK_Mode => On,
      Abstract_State => null,
      Pure
is

-- Strings must be slightly smaller than the maximum positive indexing value
-- to prevent index overflow during one of the checks.
Max_String_Length : constant := Positive'Last - 2;

-- Match a simple regular expression in an block of text.
--
-- A port of the algorithm of Rob Pike's simple regular expression matcher in
-- "The Practice of Programming".
function Match (Regexp : String; Text : String)
   return Boolean
with
   Pre => Regexp'Last < Max_String_Length and then Text'Last < Max_String_Length,
   Global => null,
   Depends => (Match'Result => (Regexp, Text));

end Simple_Regex;
