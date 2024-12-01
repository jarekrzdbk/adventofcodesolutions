with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with Ada.Containers.Generic_Array_Sort;

procedure Day_1_Historians is
    F : File_Type;
    File_Name : constant String := "day_1_historians.inp";
    Number_Of_Lines : Integer := 0;
    type Integer_Array is
        array  (Natural range <>) of Integer;
    procedure Sort is new Ada.Containers.Generic_Array_Sort
        (Index_Type => Natural,
        Element_Type => Integer,
        Array_Type => Integer_Array);
    Total_Distance : Integer := 0;
begin
    Open (F, In_File, File_Name);
    while not End_Of_File (F) loop
        Skip_Line (F);
        Number_Of_Lines := Number_Of_Lines + 1;
    end loop;
    Close (F);
    declare
        First_Numbers : Integer_Array (1 .. Number_Of_Lines);
        Second_Numbers : Integer_Array (1 .. Number_Of_Lines);
        I : Positive := 1;
        Line : String (1 .. 13);
        Tab_Idx : Positive;
        First_Number : Positive;
        Second_Number : Positive;
        Distance : Integer;
    begin
        Open (F, In_File, File_Name);
        while not End_Of_File (F) loop
            Line := Get_Line (F);
            Tab_Idx := Ada.Strings.Fixed.Index ( Source => Line,
                                                 Pattern => "   ",
                                                 From => 1 );
            First_Number := Integer'Value (Line (1 .. Tab_Idx - 1));
            Second_Number := Integer'Value (Line (Tab_Idx .. Line'Length));
            First_Numbers(I) := First_Number;
            Second_Numbers(I) := Second_Number;
            I := I + 1;
        end loop;
        Close (F);
        Sort (First_Numbers);
        Sort (Second_Numbers);
        for Index in First_Numbers'Range loop
            Distance := abs (First_Numbers (Index) - Second_Numbers (Index));
            Total_Distance := Total_Distance + Distance;
        end loop;
    end;
    Put_Line (Integer'Image (Total_Distance));
end Day_1_Historians;
