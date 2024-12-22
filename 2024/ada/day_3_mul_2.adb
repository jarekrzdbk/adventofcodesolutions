with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Strings; use Ada.Strings;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

procedure Day_3_Mul_2 is
    F : File_Type;
    File_Name : constant String := "day_3_mul.inp";
    P : constant String := "mul(";
    Do_Pattern : constant String := "do()";
    Dont_Pattern : constant String := "don't()";
    TotalCount : Long_Integer := 0;
    Count : Integer := 0;
    DoMul : Boolean := True;
begin
    Open (F, In_File, File_Name);
    while not End_Of_File (F) loop
        declare
            Line : String := Get_Line (F);
            I : Natural := 1;
            DI : Natural := 1;
            DnI : Natural := 1;
        begin
            Put_Line (Line);
            Put_Line ("-------------------------------");
            while I in Line'Range loop
                Put_Line ("Index " & Integer'Image (I));
                if I = Line'Last then
                    exit;
                end if;
                I := Index (Source => Line, Pattern => P, From => I);
                if DI /= 0 then
                    DI := Index (Source => Line, Pattern => Do_Pattern, From => DI);
                end if;
                if DnI /= 0 then
                    DnI := Index (Source => Line, Pattern => Dont_Pattern, From => DnI);
                end if;

                if I = 0 then
                    exit;
                end if;
                Put_Line ("I" & Integer'Image (I));
                Put_Line ("DI index " & Natural'Image (DI));
                Put_Line ("DnI index " & Natural'Image (DnI));
                if DnI /= 0 and DnI < I then
                    if (DI > I or DI = 0) then
                        DoMul := False;
                        DnI := I;
                        Put_Line ("Disabling instruction");
                    end if;
                end if;
                if DI /= 0 and DI < I then
                    if (DnI > I or DnI = 0) then
                        DoMul := True;
                        DI := I;
                        Put_Line ("Enabling instruction");
                    end if;
                end if;
                Put_Line ("Index is " & Natural'Image (I));
                declare
                    CurrentIdx : Natural := I + P'Length;
                    FirstNumberString : Unbounded_String := To_Unbounded_String ("");
                    SecondNumberString : Unbounded_String := To_Unbounded_String ("");
                    FirstNumber : Long_Integer;
                    SecondNumber : Long_Integer;
                begin
                    while CurrentIdx <= Line'Last and then Line (CurrentIdx) in '0' .. '9' loop
                        FirstNumberString := FirstNumberString & To_Unbounded_String (Line (CurrentIdx .. CurrentIdx));
                        CurrentIdx := CurrentIdx + 1;
                    end loop;

                    Put_Line ("First number " & To_String (FirstNumberString));
                    Put_Line ("Current character " & Line (CurrentIdx));
                    if To_String (FirstNumberString) /= "" and then Line (CurrentIdx) = ',' then
                        FirstNumber := Long_Integer'Value (To_String (FirstNumberString));
                        Put_Line ("Current index character " & Line (CurrentIdx));
                        CurrentIdx := CurrentIdx + 1;

                        while CurrentIdx <= Line'Last and then Line (CurrentIdx) in '0' .. '9' loop
                            SecondNumberString := SecondNumberString & To_Unbounded_String (Line (CurrentIdx .. CurrentIdx));
                            CurrentIdx := CurrentIdx + 1;
                        end loop;

                        Put_Line ("Current second character index" & Line (CurrentIdx));

                        if To_String (SecondNumberString) /= "" and then Line (CurrentIdx) = ')' then
                            SecondNumber := Long_Integer'Value (To_String (SecondNumberString));
                            if DoMul then
                                Put_Line ("-------------------------------------");
                                Put_Line ("(" & Trim (FirstNumber'Image, Both) & "," & Trim (SecondNumber'Image, Both) & ")");
                                TotalCount := TotalCount + (FirstNumber * SecondNumber);
                                Put_Line ("Total count " & TotalCount'Image);
                                Put_Line ("------------------------------------");
                            end if;
                            Count := Count + 1;
                            I := CurrentIdx;
                        else
                            I := CurrentIdx;
                            Put_Line ("Increasing I 1 " & Integer'Image(I));
                        end if;
                        CurrentIdx := CurrentIdx + 1;
                        I := CurrentIdx;
                        Put_Line ("Increasing I -----" & Integer'Image(I));
                    else
                        I := CurrentIdx;
                        Put_Line ("Increasing I " & Integer'Image(I));
                    end if;
                end;
            end loop;
        end;
    end loop;
    Close (F);
    Put_Line (Long_Integer'Image (TotalCount));
    Put_Line ("Multiplied " & Integer'Image (Count));
end Day_3_Mul_2;
