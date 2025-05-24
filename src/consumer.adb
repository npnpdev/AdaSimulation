with Ada.Text_IO; use Ada.Text_IO;
with Global_Types; use Global_Types;
with Ada.Numerics.Discrete_Random;
with Ada.Characters.Latin_1; use Ada.Characters.Latin_1;
with buffer ; use Buffer;
package body Consumer is

    task body Consumer is
      subtype Consumption_Time_Range is Integer range 4 .. 8;
      package Random_Consumption is new Ada.Numerics.Discrete_Random(Consumption_Time_Range);
      package Random_Assembly is new Ada.Numerics.Discrete_Random(Assembly_Type);

      G: Random_Consumption.Generator;
      GA: Random_Assembly.Generator;
      Consumer_Nb: Consumer_Type;
      Assembly_Number: Integer;
      Consumption: Integer;
      Assembly_Type: Integer;
      Time: Integer;
      pobranoAssembly: Boolean;
      Max_Attempts: constant Integer := 3;  -- Limit prób
      Previous_Assembly_Type : Integer;  -- Zmienna do przechowania poprzedniego zestawu
      Waiting_Time : Duration;  -- Zmienna do przechowania czasu oczekiwania
      Short_Wait : constant Duration := 5.0;  -- Czas oczekiwania po nieudanej probie
      Long_Wait : constant Duration := 15.0;   -- Czas oczekiwania po 3 nieudanych probach
   begin
      accept Start(Consumer_Number: in Consumer_Type; Consumption_Time: in Integer) do
         Random_Consumption.Reset(G);
         Random_Assembly.Reset(GA);
         Consumer_Nb := Consumer_Number;
         Consumption := Consumption_Time;
         Time := Random_Consumption.Random(G);
      end Start;

      Put_Line(ESC & "[96m" & "C: Do magazynu przyszedl konsument " & Consumer_Name(Consumer_Nb) & ESC & "[0m");

      loop
         pobranoAssembly := false;
         Previous_Assembly_Type := -1;  -- Zmienna do przechowania poprzedniego zestawu

         -- Proba 1, 2, 3: Konsument losuje zestaw i probuje go pobrac
         for Attempt in 1 .. Max_Attempts loop
            -- Wypisanie numeru proby tylko raz
            Put_Line(ESC & "[91m" & "Konsument " & Consumer_Name(Consumer_Nb) & ": nieudana proba zakupienia zestawu! Proba " & Integer'Image(Attempt) & ESC & "[0m");

            -- Losowanie zestawu
            Assembly_Type := Random_Assembly.Random(GA);

            -- Sprawdzamy, czy nie wylosowano tego samego zestawu co poprzednio
            while Assembly_Type = Previous_Assembly_Type loop
               Assembly_Type := Random_Assembly.Random(GA);  -- Jesli tak, losujemy ponownie
            end loop;

            -- Aktualizujemy poprzednio wylosowany zestaw
            Previous_Assembly_Type := Assembly_Type;

            -- Proba pobrania wylosowanego zestawu
            select
               delay Short_Wait;  -- Krotkie oczekiwanie przed proba
            then abort
               B.Deliver(Assembly_Type, Assembly_Number);  -- Proba pobrania wylosowanego zestawu

               -- Jesli zestaw niedostepny
               if Assembly_Number = -1 then
                  Put_Line(ESC & "[91m" & "Konsument " & Consumer_Name(Consumer_Nb) & ": brak dostepnych zestawow do konsumpcji! Probuje inny zestaw." & ESC & "[0m");

                  -- Losowanie innego zestawu, ale upewniamy sie, ze to nie jest ten sam zestaw
                  Assembly_Type := Random_Assembly.Random(GA);

                  -- Sprawdzamy, czy nie wylosowano tego samego zestawu co poprzednio
                  while Assembly_Type = Previous_Assembly_Type loop
                     Assembly_Type := Random_Assembly.Random(GA);  -- Jesli tak, losujemy ponownie
                  end loop;

                  -- Aktualizujemy poprzedni zestaw
                  Previous_Assembly_Type := Assembly_Type;

                  -- Proba ponownego pobrania
                  B.Deliver(Assembly_Type, Assembly_Number);

                  -- Jesli nadal nie ma dostepnego zestawu, przechodzi do kolejnej proby po odczekaniu
                  if Assembly_Number = -1 then
                     Put_Line(ESC & "[91m" & "Konsument " & Consumer_Name(Consumer_Nb) & ": nadal nie moge pobrac zestawu! Czekam." & ESC & "[0m");
                     Waiting_Time := Short_Wait;  -- Ustawienie krótszego czasu oczekiwania
                     delay Waiting_Time;  -- Oczekiwanie przed kolejna proba
                  else
                     -- Zestaw zostal pobrany, konsument konsumuje
                     Put_Line(ESC & "[96m" & "C: " & Consumer_Name(Consumer_Nb) & " pobiera zestaw " & Assembly_Name(Assembly_Type) & " numer " & Integer'Image(Assembly_Number) & ESC & "[0m");
                     Put_Line("C: Przewidywany czas jedzenia to " & Integer'Image(Time) & " s.");
                     pobranoAssembly := true;
                     exit;  -- Wyjscie z petli prob, jesli sukces
                  end if;
               else
                  -- Zestaw zostal pobrany przy pierwszej probie, konsument konsumuje
                  Put_Line(ESC & "[96m" & "C: " & Consumer_Name(Consumer_Nb) & " pobiera zestaw " & Assembly_Name(Assembly_Type) & " numer " & Integer'Image(Assembly_Number) & ESC & "[0m");
                  Put_Line("C: Przewidywany czas jedzenia to " & Integer'Image(Time) & " s.");
                  pobranoAssembly := true;
                  exit;  -- Wyjscie z petli prob, jesli sukces
               end if;
            end select;
         end loop;

         -- Jesli nie pobrano zestawu po 3 probach, dopiero wtedy konsument czeka dluzej
         if not pobranoAssembly then
            Put_Line("Konsument " & Consumer_Name(Consumer_Nb) & " nie pobral zestawu po 3 probach. Czekam dluzej przed nastepna proba.");
            Waiting_Time := Long_Wait;  -- Ustawienie dluzszego czasu oczekiwania
            delay Waiting_Time;  -- Oczekiwanie przed kolejna seria prob
         else
            -- Jesli zestaw zostal pobrany, konsument rozpoczyna konsumpcje
            Put_Line("Konsument " & Consumer_Name(Consumer_Nb) & " rozpoczyna konsumpcje swoich produktow");
            delay Duration(Random_Consumption.Random(G));  -- Symulacja czasu konsumpcji
         end if;
      end loop;
   end Consumer;
end Consumer;
