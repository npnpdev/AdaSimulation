with Ada.Text_IO;
with producer;
with consumer;
with global_Types;

procedure Main is
begin
   for I in 1 .. Global_Types.Number_Of_Producers loop
      producer.P(I).Start(I, 10);
   end loop;
   for J in 1 .. Global_Types.Number_Of_Consumers loop
      consumer.K(J).Start(J, 12);
   end loop;
end Main;
