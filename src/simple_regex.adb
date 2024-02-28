-- Strings are defined like:
--     type String is array(Positive range <>) of Character;
--
-- Since <> is "box", meaning any value in the indexing range, strings might
-- have an indexing range somewhere in 1 .. Positive'Last.  So, for a given
-- string S, S'First might not be 1, such as when working with a slice.
--
-- Writing the algorithm with S'First and S'Last instead of indexing directly
-- with 1 and S'Length allows the prover to show a lack of indexing overflows.
package body Simple_Regex
   with Spark_Mode => On
is

-- Declarations of the helper functions here, so Match can appear first in the file.
function Match_Here (Regexp : String; Text : String) return Boolean
   with Pre => Regexp'Last < Max_String_Length and then Text'Last < Max_String_Length,
   Global => null,
   Depends => (Match_Here'Result => (Regexp, Text));

function Match_Star (C : Character; Regexp : String; Text : String) return Boolean
   with Pre => Regexp'Last < Max_String_Length and then Text'Last < Max_String_Length,
   Global => null,
   Depends => (Match_Star'Result => (C, Regexp, Text));

-- Search for regex anywhere in the text.
function Match (Regexp : String; Text : String) return Boolean is
begin
   -- This check is missing from the sample code.
   if Regexp'Length = 0 then
      return True;
   end if;

   if Regexp (Regexp'First) = '^' then
      return Match_Here (Regexp (Regexp'First + 1 .. Regexp'Last), Text);
   end if;

   for Index in Text'First .. Text'Length loop
      if Match_Here (Regexp, Text (Index .. Text'Last)) then
         return True;
      end if;
   end loop;

   return False;
end Match;

-- Search for regexp at the beginning of the text.
function Match_Here (Regexp : String; Text : String) return Boolean is
begin
   if Regexp'Length = 0 then
      return True;
   end if;

   if Regexp'Length > 1 and then Regexp (Regexp'First + 1) = '*' then
      return Match_Star (Regexp (Regexp'First), Regexp (Regexp'First + 2 .. Regexp'Last), Text);
   end if;

   if Regexp (Regexp'First) = '$' and then Regexp'Length = 1 then
      return Text'Length = 0;
   end if;

   if Text'Length > 0 and then
      (Regexp (Regexp'First) = '.' or else Regexp (Regexp'First) = Text (Text'First))
   then
      return Match_Here (Regexp (Regexp'First + 1 .. Regexp'Last), Text (Text'First + 1 .. Text'Last));
   end if;

   return False;
end Match_Here;

-- Search for c*regexp at the beginning of Text.
function Match_Star (C : Character; Regexp : String; Text : String) return Boolean is
begin
   for Index in Text'First .. Text'Last loop
      if Match_Here (Regexp, Text (Index .. Text'Last)) then
         return True;
      end if;

      exit when not (Text (Index) = C or else C = '.');
   end loop;

   return False;
end Match_Star;

end Simple_Regex;
