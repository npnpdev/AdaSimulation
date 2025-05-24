with Global_Types;
with Ada.Numerics.Discrete_Random;
with buffer; use Buffer;
package Consumer is
   B: buffer.Buffer;
   task type Consumer is
      entry Start(Consumer_Number: in Global_Types.Consumer_Type;
                  Consumption_Time: in Integer);
   end Consumer;
   K: array ( 1 .. Global_Types.Number_Of_Consumers ) of Consumer;
end Consumer;
