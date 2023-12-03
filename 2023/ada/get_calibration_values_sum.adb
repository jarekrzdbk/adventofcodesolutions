with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Characters.Handling; use Ada.Characters.Handling;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

procedure Get_Calibration_Values_Sum is
   File : File_Type;
   Line : Unbounded_String;
   Total_Sum : Integer := 0;
   First_Digit, Last_Digit : Character;
   Num : Integer;

   function Concatenate_Digits(Str : Unbounded_String) return Integer is
      Num : Integer;
   begin
      for I in 1 .. Length(Str) loop
         if Is_Digit(Element(Str, I)) then
            First_Digit := Element(Str, I);
            exit; 
         end if;
      end loop;

      for I in reverse 1 .. Length(Str) loop
         if Is_Digit(Element(Str, I)) then
            Last_Digit := Element(Str, I);
            exit; 
         end if;
      end loop;

         Num := Integer'Value(First_Digit & Last_Digit);

      return Num;
   end Concatenate_Digits;

begin
   Open (File, Mode => In_File, Name => "2023_1_input.txt");

   while not End_Of_File(File) loop
      Line := To_Unbounded_String(Get_Line(File));
      Put("Line "); Put(To_String(Line));
      New_Line;
      Num := Concatenate_Digits(Line);
      Put("Number "); Put(Num);
      Total_Sum := Total_Sum + Num;
   end loop;

   Put("Total Sum: "); Put(Total_Sum);
   New_Line;

   Close (File);
end Get_Calibration_Values_Sum;

