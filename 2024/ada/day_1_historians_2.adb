with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with Ada.Containers.Indefinite_Hashed_Maps;
with Ada.Strings.Hash;

procedure Day_1_Historians_2 is
    F : File_Type;
    File_Name : constant String := "day_1_historians_2.inp";
    Number_Of_Lines : Integer := 0;
    package Integer_Hashed_Maps is new
        Ada.COntainers.Indefinite_Hashed_Maps
            (Key_type => String,
             Element_Type => Integer,
             Hash => Ada.Strings.Hash,
             Equivalent_Keys => "=");
    use Integer_Hashed_Maps;

    First_Numbers : Map;
    Line : String (1 .. 13);
    Tab_Idx : Positive;
    First_Number : String (1 .. 5);
    Second_Number : String (1 .. 5);
    Similarity_Score : Integer := 0;
begin
    Open (F, In_File, File_Name);
    while not End_Of_File (F) loop
        Line := Get_Line (F);
        Tab_Idx := Ada.Strings.Fixed.Index ( Source => Line,
                                             Pattern => "   ",
                                             From => 1 );
        First_Numbers.Include (Line (1 .. Tab_Idx - 1), 0);
    end loop;
    Close (F);
    Open (F, In_File, File_Name);
    while not End_Of_File (F) loop
        Line := Get_Line (F);
        Tab_Idx := Ada.Strings.Fixed.Index ( Source => Line,
                                             Pattern => "   ",
                                             From => 1 );
        Second_Number := Line (Tab_Idx + 3 .. Line'Length);
        if First_Numbers.Contains (Second_Number) then
            First_Numbers (Second_Number) := First_Numbers (Second_Number) + 1;
        end if;
    end loop;
    Close (F);
    Open (F, In_File, File_Name);
    while not End_Of_File (F) loop
        Line := Get_Line (F);
        Tab_Idx := Ada.Strings.Fixed.Index ( Source => Line,
                                             Pattern => "   ",
                                             From => 1 );
        First_Number := Line (1 .. Tab_Idx - 1);
        Similarity_Score := Similarity_Score + (Integer'Value (First_Number) * First_Numbers (First_Number));
    end loop;
    Close (F);
    Put_Line (Integer'Image (Similarity_Score));
end Day_1_Historians_2;
