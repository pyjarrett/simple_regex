with Simple_Regex.Tests;
with Trendy_Test.Reports;

procedure Simple_Regex_Tests is
begin
   Trendy_Test.Register (Simple_Regex.Tests.All_Tests);
   Trendy_Test.Reports.Print_Basic_Report (Trendy_Test.Run);
end Simple_Regex_Tests;
