with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Strings; use Ada.Strings;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with Ada.Strings.Maps; use Ada.Strings.Maps;

procedure Day_2_Reports is
    F : File_Type;
    File_Name : constant String := "day_2_reports.inp";
    Report_Count : Natural := 0;
begin
    Open (F, In_File, File_Name);
    while not End_Of_File (F) loop
        declare
            Line : String := Get_Line (F);
            I : Natural := 1;
            Correct_Report : Boolean := True;
            F : Positive;
            L : Natural;
            Previous_Increasing : Boolean;
            Previous_Number : Integer;
            Whitespace : constant Character_Set := To_Set (' ');
            Current_Number : Integer;
            Increasing : Boolean;
            Number_Idx : Natural := 1;
        begin
            Put_Line (Line);
            Put_Line ("-------------------------------");
            while I in Line'Range loop
                declare
                begin
                    Find_Token (Source => Line, Set => Whitespace, From => I, Test => Outside, First => F, Last => L);
                    Put_Line ("Index " & Natural'Image (Number_Idx));

                    if Number_Idx > 1 then
                        Previous_Number := Current_Number;
                        Current_Number := Integer'Value (Line (F .. L));
                        if Number_Idx > 2 then
                            Previous_Increasing := Increasing;
                        end if;
                        if Current_Number = Previous_Number then
                            Correct_Report := False;
                            exit;
                        end if;
                        if (Current_Number - Previous_Number < 0) then
                            Increasing := False;
                            Put_Line ("Decreasing");
                        else
                            Put_Line ("Increasing");
                            Increasing := True;
                        end if;
                        if Number_Idx > 2 then
                            if Previous_Increasing /= Increasing then
                                Put_Line ("Report incorrect");
                                Put_Line ("Increasing " & Boolean'Image (Increasing));
                                Put_Line ("Previous Increasing " & Boolean'Image (Previous_Increasing));
                                Put_Line ("Current Number " & Integer'Image (Current_Number));
                                Put_Line ("Previous Number " & Integer'Image (Previous_Number));
                                Correct_Report := False;
                                exit;
                            end if;
                        end if;
                        if abs (Current_Number - Previous_Number) > 3 then
                            Correct_Report := False;
                            Put_Line ("Differs by more then 3");
                            Put_Line ("Current Number " & Integer'Image (Current_Number));
                            Put_Line ("Previous Number " & Integer'Image (Previous_Number));
                            exit;
                        end if;
                        Put_Line ("Current Number " & Integer'Image (Current_Number));
                        Put_Line ("Previous Number " & Integer'Image (Previous_Number));
                    else
                        Current_Number := Integer'Value (Line (F .. L));
                        Put_Line ("First number");
                        Put_Line ("Current Number " & Integer'Image (Current_Number));
                    end if;
                    Number_Idx := Number_Idx + 1;
                end;
                Put_Line ("L is " & Natural'Image (L));
                exit when L = 0;
                I := L + 1;
            end loop;
            if Correct_Report then
                Put_Line ("Report is correct");
                Report_Count := Report_Count + 1;
            end if;
        end;
    end loop;
    Close (F);
    Put_Line (Integer'Image (Report_Count));
end Day_2_Reports;
