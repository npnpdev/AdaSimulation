with Global_Types; use Global_Types;
with Ada.Numerics.Discrete_Random;
package Buffer is

   -- Deklaracja dla tasku Buffer
   task type Buffer is
      -- Akceptowanie produktów od producentów
      entry Take(Product: in Producer_Type; Number: in Integer; Accepted: out Boolean);
      -- Dostarczanie zestawów do konsumentów
      entry Deliver(Assembly: in Assembly_Type; Number: out Integer);
      -- Zwracanie informacji o ilosci w buforze
      entry Get_Storage_Level(Level: out Integer);
      -- Zwracanie najbardziej potrzebnego produktu
      entry Get_Most_Needed_Product(Product: out Producer_Type);
   end Buffer;

   B: Buffer;
end Buffer;
