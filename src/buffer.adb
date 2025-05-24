with Ada.Text_IO; use Ada.Text_IO;
with Global_Types; use Global_Types;
with Ada.Numerics.Discrete_Random;
with Ada.Characters.Latin_1; use Ada.Characters.Latin_1;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
package body Buffer is

   task body Buffer is
      Max_Assembly_Content: array(Producer_Type) of Integer;
      Assembly_Number: array(Assembly_Type) of Integer := (1, 1, 1);

      -- Ustawiamy maksymalna liczbe produktow dla kazdego producenta
      procedure Setup_Variables is
      begin
         for W in Producer_Type loop
            Max_Assembly_Content(W) := 0;
            for Z in Assembly_Type loop
               if Assembly_Content(Z, W) > Max_Assembly_Content(W) then
                  Max_Assembly_Content(W) := Assembly_Content(Z, W);
               end if;
            end loop;
         end loop;
      end Setup_Variables;

      function Get_Most_Needed_Product return Producer_Type is
         Most_Needed_Product: Producer_Type := 1;
         Max_Needed: Integer := 0;
         Needed: Integer;
      begin
         for Product in Producer_Type loop
            Needed := 0;
            for Assembly in Assembly_Type loop
               Needed := Needed + Assembly_Content(Assembly, Product) - Storage(Product);
            end loop;

            Needed := Needed + Number_Of_Additional_Products; -- dodajemy zapas produktow

            if Needed > Max_Needed then
               Max_Needed := Needed;
               Most_Needed_Product := Product;
            end if;
         end loop;

         -- Put_Line("Most needed product: " & To_String(Product_Name(Most_Needed_Product)) & " with " & Integer'Image(Max_Needed));
         return Most_Needed_Product;
      end Get_Most_Needed_Product;

      function Is_Every_Assembly_Possible(Product: Producer_Type) return Boolean is
      begin
         for A in Assembly_Type loop
            for B in Producer_Type loop
               if Storage(B) < Assembly_Content(A, B) and In_Storage < Integer(0.95 * Float(Storage_Capacity)) then
                  return False;
               end if;
            end loop;
         end loop;
         return True;
      end Is_Every_Assembly_Possible;

      -- Funkcja sprawdzajaca, czy produkt jest potrzebny do skompletowania ktoregokolwiek zestawu
      function Is_Product_Needed(Product: Producer_Type) return Boolean is
      begin
         -- Przegladamy kazdy zestaw (Assembly_Type) i sprawdzamy, czy brakuje danego produktu
         for A in Assembly_Type loop
            -- Jesli liczba produktow w buforze jest mniejsza niz wymagana dla tego zestawu
            if Storage(Product) < Assembly_Content(A, Product) then
               return True;  -- Produkt jest potrzebny do ukonczenia zestawu
            end if;
         end loop;

         -- Jesli zaden zestaw nie wymaga tego produktu, zwroc False
         return Is_Every_Assembly_Possible(Product);
      end Is_Product_Needed;

      function Can_Accept(Product: Producer_Type) return Boolean is
      begin
         -- Sprawdzamy, czy bufor ma miejsce
         if In_Storage >= Storage_Capacity then
            Put_Line(ESC & "[91m" & "B: Bufor pelny, wstrzymanie produkcji." & ESC & "[0m");
            return False;

            -- Sprawdzamy, czy produkt jest faktycznie potrzebny
         elsif not Is_Product_Needed(Product) then
            Put_Line(ESC & "[91m" & "B: Produkt " & To_String(Product_Name(Product)) & " nie jest potrzebny." & ESC & "[0m");
            return False;

         else
            -- Produkt moze byc zaakceptowany, jesli jest miejsce i jest potrzebny
            return True;
         end if;
      end Can_Accept;

      -- Sprawdzamy, czy mozna dostarczyc zestaw (czy sa odpowiednie produkty)
      function Can_Deliver(Assembly: Assembly_Type) return Boolean is
      begin
         for W in Producer_Type loop
            if Storage(W) < Assembly_Content(Assembly, W) then
               return False;  -- Brak wystarczajacej liczby produktow
            end if;
         end loop;
         return True;
      end Can_Deliver;

      -- Wyswietlamy zawartosc bufora (dla debugowania)
      procedure Storage_Contents is
      begin
         for W in Producer_Type loop
            Put_Line("|   Magazyn zawiera: " & Integer'Image(Storage(W)) & " " &
                       To_String(Product_Name(W)));
         end loop;
         Put_Line("|   Ilosc produktow w magazynie: " & Integer'Image(In_Storage));
      end Storage_Contents;

   begin
      Put_Line(ESC & "[91m" & "B: Magazyn rozpoczyna prace..." & ESC & "[0m");

      loop
         -- Obslugujemy przyjmowanie produktu od producenta
         select
            accept Take(Product: in Producer_Type; Number: in Integer; Accepted: out Boolean) do
               if Can_Accept(Product) then
                  Put_Line(ESC & "[91m" & "B: Zaakceptowano produkt " & To_String(Product_Name(Product)) & " numer " &
                             Integer'Image(Number)& ESC & "[0m");
                  Storage(Product) := Storage(Product) + 1;
                  In_Storage := In_Storage + 1;
                  Accepted := True;
               else
                  Accepted := False;
                  Put_Line(ESC & "[91m" & "B: Odrzucono produkt " & To_String(Product_Name(Product)) & " numer " &
                             Integer'Image(Number)& ESC & "[0m");
               end if;
            end Take;
            Storage_Contents;

            -- Obslugujemy dostarczanie zestawu do konsumenta
         or
            accept Deliver(Assembly: in Assembly_Type; Number: out Integer) do
               if Can_Deliver(Assembly) then
                  -- Tworzymy zestaw, zmniejszamy liczby produktow w buforze
                  Put_Line(ESC & "[91m" & "B: Magazyn dostarczyl produkty potrzebne do skompletowania zestawu " & Assembly_Name(Assembly) & " numer " &
                             Integer'Image(Assembly_Number(Assembly))& ESC & "[0m");
                  for W in Producer_Type loop
                     Storage(W) := Storage(W) - Assembly_Content(Assembly, W);
                     In_Storage := In_Storage - Assembly_Content(Assembly, W);
                  end loop;
                  Number := Assembly_Number(Assembly);
                  Assembly_Number(Assembly) := Assembly_Number(Assembly) + 1;
               else
                  Put_Line(ESC & "[91m" & "B: Brakuje produktow do zestawu " & Assembly_Name(Assembly)& ESC & "[0m");
                  Number := -1;  -- Zwracamy -1, jesli nie mozna stworzyc zestawu - zestaw zer
               end if;
            end Deliver;
         or
            accept Get_Storage_Level(Level: out Integer) do
               Level := In_Storage;  -- Przekazujemy aktualny poziom
            end Get_Storage_Level;
         or
              -- Entry dla zwracania najbardziej potrzebnego produktu
            accept Get_Most_Needed_Product(Product: out Producer_Type) do
               Product := Get_Most_Needed_Product;
            end Get_Most_Needed_Product;
            Storage_Contents;
         end select;
      end loop;
   end Buffer;

end Buffer;
