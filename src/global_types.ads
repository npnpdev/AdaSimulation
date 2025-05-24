with Ada; use Ada;
with Ada.Strings.Unbounded;
use Ada.Strings.Unbounded;
package Global_Types is
   Number_Of_Producers: constant Integer := 6;
   Number_Of_Assemblies: constant Integer := 3;
   Number_Of_Consumers: constant Integer := 2;
   Number_Of_Additional_Products: constant Integer := 1; -- Przyjmujemy do buffora jeden dodatkowy produkt z kazdej kategorii
   
   Consumer_Name: constant array (1 .. Number_Of_Consumers) of String(1 .. 5) := ("Piotr", "Julka");
   
   subtype Producer_Type is Integer range 1 .. 6;
   subtype Assembly_Type is Integer range 1 .. 3;
   subtype Consumer_Type is Integer range 1 .. 2;
   In_Storage: Integer := 0;

   type Storage_type is array (Producer_Type) of Integer;
   Storage: Storage_type := (0, 0, 0, 0, 0, 0);
   -- Definicja skladnikow zestawow (assemblies)
   Assembly_Content: array(Assembly_Type, Producer_Type) of Integer
     := ((1, 1, 2, 0, 0, 2),  -- Zestaw 1
         (1, 1, 0, 2, 1, 0),  -- Zestaw 2
         (1, 1, 1, 0, 2, 0)); -- Zestaw 3
   
   Storage_Capacity: constant Integer := 30;
   
   Product_Name: constant array (Producer_Type) of Ada.Strings.Unbounded.Unbounded_String
     := (Ada.Strings.Unbounded.To_Unbounded_String("Bulka"),
         Ada.Strings.Unbounded.To_Unbounded_String("Maslo"),
         Ada.Strings.Unbounded.To_Unbounded_String("Jajko"),
         Ada.Strings.Unbounded.To_Unbounded_String("Szynka"),
         Ada.Strings.Unbounded.To_Unbounded_String("Ser"),
         Ada.Strings.Unbounded.To_Unbounded_String("Bekon"));
   
   Assembly_Name: constant array (Assembly_Type) of String(1 .. 17)
     := ("Kanapka Bekonjajo", "Kanapka biurowa  ", "Kanpka jarska    ");
end Global_Types;
