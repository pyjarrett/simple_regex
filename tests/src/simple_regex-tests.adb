with Trendy_Test.Assertions;

package body Simple_Regex.Tests is
   subtype Test_Op is Trendy_Test.Operation'Class;
   use Trendy_Test.Assertions;

   procedure Test_Complete_Match (Op : in out Test_Op) is
   begin
      Op.Register;

      Assert (Op, Simple_Regex.Match ("Hello", "Hello"));
      Assert (Op, not Simple_Regex.Match ("Help", "Hemp"));
   end Test_Complete_Match;

   procedure Test_Dot_Match (Op : in out Test_Op) is
   begin
      Op.Register;

      Assert (Op, Simple_Regex.Match ("H.llo", "Hallo"));
      Assert (Op, Simple_Regex.Match ("H.llo", "Hello"));
      
      Assert (Op, Simple_Regex.Match ("tomat.", "automaton"));
      Assert (Op, Simple_Regex.Match ("tomato.", "automaton"));
      Assert (Op, Simple_Regex.Match ("tomato.$", "automaton"));

      Assert (Op, Simple_Regex.Match ("^auto", "automaton"));
      Assert (Op, Simple_Regex.Match ("^.uto", "automaton"));
      Assert (Op, Simple_Regex.Match ("^...o", "automaton"));
   end Test_Dot_Match;

   procedure Test_Star_Match (Op : in out Test_Op) is
   begin
      Op.Register;

      Assert (Op, Simple_Regex.Match ("hel*o", "heo"));
      Assert (Op, Simple_Regex.Match ("hel*o", "helo"));
      Assert (Op, Simple_Regex.Match ("hel*o", "hello"));
      Assert (Op, Simple_Regex.Match ("hel*o", "helllllo"));

      Assert (Op, not Simple_Regex.Match ("hel*o", "hero"));
   end Test_Star_Match;

   procedure Test_Beginning_Match (Op : in out Test_Op) is
   begin
      Op.Register;

      Assert (Op, Simple_Regex.Match ("tomato", "automaton"));
      Assert (Op, not Simple_Regex.Match ("^tomato", "automaton"));

      Assert (Op, Simple_Regex.Match ("auto", "automaton"));
      Assert (Op, Simple_Regex.Match ("^auto", "automaton"));
   end Test_Beginning_Match;

   procedure Test_Ending_Match (Op : in out Test_Op) is
   begin
      Op.Register;

      Assert (Op, Simple_Regex.Match ("on", "automaton"));
      Assert (Op, Simple_Regex.Match ("on$", "automaton"));

      Assert (Op, not Simple_Regex.Match ("tomato$", "automaton"));
   end Test_Ending_Match;


   procedure Test_Dot_Star_Match (Op : in out Test_Op) is
   begin
      Op.Register;

      Assert (Op, Simple_Regex.Match (".*tomato.*", "automaton"));
      Assert (Op, Simple_Regex.Match ("^.*tomato", "automaton"));
      Assert (Op, Simple_Regex.Match ("tomato.*", "automaton"));
   end Test_Dot_Star_Match;

   function All_Tests return Trendy_Test.Test_Group is (
      Test_Complete_Match'Access,
      Test_Dot_Match'Access,
      Test_Star_Match'Access,
      Test_Beginning_Match'Access,
      Test_Ending_Match'Access,
      Test_Dot_Star_Match'Access
   );

end Simple_Regex.Tests;