with Global_Types;
with Ada.Numerics.Discrete_Random;

package Producer is
   task type Producer is
      entry Start(Product: in Global_Types.Producer_Type; Production_Time: in Integer);
   end Producer;
   P: array ( 1 .. Global_Types.Number_Of_Producers ) of Producer;
end Producer;
