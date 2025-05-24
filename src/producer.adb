with Ada.Text_IO; use Ada.Text_IO;
with Global_Types; use Global_Types;
with Buffer; use Buffer;
with Ada.Numerics.Discrete_Random;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Characters.Latin_1; use Ada.Characters.Latin_1;
with Consumer; use Consumer;

package body Producer is
   task body Producer is
      subtype Production_Time_Range is Integer range 2 .. 8;
      package Random_Production is new Ada.Numerics.Discrete_Random(Production_Time_Range);
      G: Random_Production.Generator;
      Producer_Type_Number: Integer;
      Product_Number: Integer;
      Production: Integer;
      Random_Time: Integer;
      Accepted: Boolean;
      Current_Level: Integer;
   begin
      -- Punkt startowy produkcji
      accept Start(Product: in Producer_Type; Production_Time: in Integer) do
         Random_Production.Reset(G);
         Product_Number := 1;
         Producer_Type_Number := Product;
         Production := Production_Time;
         Random_Time := Random_Production.Random(G);
      end Start;

      -- Information about starting production
      Put_Line(ESC & "[93m" & "P: Rozpoczyna produkcje: " & To_String(Product_Name(Producer_Type_Number)) & ESC & "[0m");

      -- Main production loop
      loop
         -- Get the buffer's current level
         Buffer.B.Get_Storage_Level(Current_Level);

         -- Sprawdz jaki produkt jest najbardziej potrzebny
         declare
            Most_Needed_Product: Producer_Type;
            Current_Storage_Level: Integer;
         begin
            Buffer.B.Get_Most_Needed_Product(Most_Needed_Product);

            --Put_Line(ESC & "[95m" & "P: Najbardziej potrzebny produkt: " & To_String(Product_Name(Most_Needed_Product)) & ESC & "[0m");
            --Put_Line(ESC & "[95m" & "P: Aktualnie produkowany produkt: " & To_String(Product_Name(Producer_Type_Number)) & ESC & "[0m");

            Buffer.B.Get_Storage_Level(Current_Storage_Level);  -- Pobieramy aktualny poziom magazynu dla produktu

            -- Sprawdzamy, czy producent produkuje najbardziej potrzebny produkt
            if Current_Storage_Level > 0 then
               if Producer_Type_Number /= Most_Needed_Product then
                  --Put_Line(ESC & "[91m" & "P: Produkt " & To_String(Product_Name(Producer_Type_Number)) & " nie jest aktualnie najbardziej potrzebny. Oczekiwanie..." & ESC & "[0m");
                  delay 5.0;  -- Odczekanie przed kolejnym sprawdzeniem
               end if;
            end if;
         end;

         -- Sprawdzamy, czy bufor jest pelny
         if Current_Level >= Storage_Capacity then
            Put_Line("P: Magazyn jest pelen! Zatrzymujemy produkcje...");

            -- Czekamy dopoki magazyn nie oprozni sie do 50%.
            loop
               delay 5.0;
               Buffer.B.Get_Storage_Level(Current_Level);
               exit when Current_Level <= Storage_Capacity / 2;
            end loop;

            Put_Line("P: Magazyn jest w 50% pusty. Wznawiamy produkcje!");
         end if;

         -- Simulate production time
         Put_Line("P: Szacowany czas produkcji to " & Integer'Image(Random_Time) & " sekund");
         delay Duration(Random_Time);

         Put_Line(ESC & "[93m" & "P: Wytworzono produkt " & To_String(Product_Name(Producer_Type_Number))
                  & " numer " & Integer'Image(Product_Number) & ESC & "[0m");

         -- Try adding product to buffer
         for Attempt in 1 .. 3 loop
            Buffer.B.Take(Producer_Type_Number, Product_Number, Accepted);

            if Accepted then
               Product_Number := Product_Number + 1;
               exit;
            else
               Put_Line(ESC & "[91m" & "P: Magazyn jest pelen! Proba " & Integer'Image(Attempt) & " nieudana." & ESC & "[0m");
               delay 3.0;
            end if;
         end loop;

         -- If product was not accepted after 3 attempts, wait longer
         if not Accepted then
            Put_Line(ESC & "[91m" & "P: Produkt nadal nie potrzebny! Przygotowywanie do zmiany produktu..." & ESC & "[0m");
            delay 10.0;
            Product_Number := (Product_Number + 1) mod 6;
         end if;
      end loop;
   end Producer;
end Producer;
