pragma Warnings (Off);
pragma Ada_95;
pragma Source_File_Name (ada_main, Spec_File_Name => "b__main.ads");
pragma Source_File_Name (ada_main, Body_File_Name => "b__main.adb");
pragma Suppress (Overflow_Check);

with System.Restrictions;
with Ada.Exceptions;

package body ada_main is

   E065 : Short_Integer; pragma Import (Ada, E065, "system__os_lib_E");
   E016 : Short_Integer; pragma Import (Ada, E016, "ada__exceptions_E");
   E012 : Short_Integer; pragma Import (Ada, E012, "system__soft_links_E");
   E010 : Short_Integer; pragma Import (Ada, E010, "system__exception_table_E");
   E033 : Short_Integer; pragma Import (Ada, E033, "ada__containers_E");
   E061 : Short_Integer; pragma Import (Ada, E061, "ada__io_exceptions_E");
   E007 : Short_Integer; pragma Import (Ada, E007, "ada__strings_E");
   E048 : Short_Integer; pragma Import (Ada, E048, "ada__strings__maps_E");
   E052 : Short_Integer; pragma Import (Ada, E052, "ada__strings__maps__constants_E");
   E071 : Short_Integer; pragma Import (Ada, E071, "interfaces__c_E");
   E019 : Short_Integer; pragma Import (Ada, E019, "system__exceptions_E");
   E073 : Short_Integer; pragma Import (Ada, E073, "system__object_reader_E");
   E042 : Short_Integer; pragma Import (Ada, E042, "system__dwarf_lines_E");
   E090 : Short_Integer; pragma Import (Ada, E090, "system__soft_links__initialize_E");
   E032 : Short_Integer; pragma Import (Ada, E032, "system__traceback__symbolic_E");
   E134 : Short_Integer; pragma Import (Ada, E134, "ada__numerics_E");
   E094 : Short_Integer; pragma Import (Ada, E094, "ada__strings__utf_encoding_E");
   E100 : Short_Integer; pragma Import (Ada, E100, "ada__tags_E");
   E006 : Short_Integer; pragma Import (Ada, E006, "ada__strings__text_buffers_E");
   E174 : Short_Integer; pragma Import (Ada, E174, "interfaces__c__strings_E");
   E108 : Short_Integer; pragma Import (Ada, E108, "ada__streams_E");
   E120 : Short_Integer; pragma Import (Ada, E120, "system__file_control_block_E");
   E119 : Short_Integer; pragma Import (Ada, E119, "system__finalization_root_E");
   E117 : Short_Integer; pragma Import (Ada, E117, "ada__finalization_E");
   E116 : Short_Integer; pragma Import (Ada, E116, "system__file_io_E");
   E158 : Short_Integer; pragma Import (Ada, E158, "system__storage_pools_E");
   E156 : Short_Integer; pragma Import (Ada, E156, "system__finalization_masters_E");
   E138 : Short_Integer; pragma Import (Ada, E138, "ada__strings__unbounded_E");
   E184 : Short_Integer; pragma Import (Ada, E184, "system__task_info_E");
   E126 : Short_Integer; pragma Import (Ada, E126, "ada__calendar_E");
   E124 : Short_Integer; pragma Import (Ada, E124, "ada__calendar__delays_E");
   E216 : Short_Integer; pragma Import (Ada, E216, "ada__real_time_E");
   E106 : Short_Integer; pragma Import (Ada, E106, "ada__text_io_E");
   E224 : Short_Integer; pragma Import (Ada, E224, "system__random_seed_E");
   E196 : Short_Integer; pragma Import (Ada, E196, "system__tasking__initialization_E");
   E204 : Short_Integer; pragma Import (Ada, E204, "system__tasking__protected_objects_E");
   E206 : Short_Integer; pragma Import (Ada, E206, "system__tasking__protected_objects__entries_E");
   E210 : Short_Integer; pragma Import (Ada, E210, "system__tasking__queuing_E");
   E214 : Short_Integer; pragma Import (Ada, E214, "system__tasking__stages_E");
   E227 : Short_Integer; pragma Import (Ada, E227, "system__tasking__async_delays_E");
   E154 : Short_Integer; pragma Import (Ada, E154, "global_types_E");
   E136 : Short_Integer; pragma Import (Ada, E136, "buffer_E");
   E122 : Short_Integer; pragma Import (Ada, E122, "consumer_E");
   E233 : Short_Integer; pragma Import (Ada, E233, "producer_E");

   Sec_Default_Sized_Stacks : array (1 .. 1) of aliased System.Secondary_Stack.SS_Stack (System.Parameters.Runtime_Default_Sec_Stack_Size);

   Local_Priority_Specific_Dispatching : constant String := "";
   Local_Interrupt_States : constant String := "";

   Is_Elaborated : Boolean := False;

   procedure finalize_library is
   begin
      E206 := E206 - 1;
      declare
         procedure F1;
         pragma Import (Ada, F1, "system__tasking__protected_objects__entries__finalize_spec");
      begin
         F1;
      end;
      E106 := E106 - 1;
      declare
         procedure F2;
         pragma Import (Ada, F2, "ada__text_io__finalize_spec");
      begin
         F2;
      end;
      E138 := E138 - 1;
      declare
         procedure F3;
         pragma Import (Ada, F3, "ada__strings__unbounded__finalize_spec");
      begin
         F3;
      end;
      E156 := E156 - 1;
      declare
         procedure F4;
         pragma Import (Ada, F4, "system__finalization_masters__finalize_spec");
      begin
         F4;
      end;
      declare
         procedure F5;
         pragma Import (Ada, F5, "system__file_io__finalize_body");
      begin
         E116 := E116 - 1;
         F5;
      end;
      declare
         procedure Reraise_Library_Exception_If_Any;
            pragma Import (Ada, Reraise_Library_Exception_If_Any, "__gnat_reraise_library_exception_if_any");
      begin
         Reraise_Library_Exception_If_Any;
      end;
   end finalize_library;

   procedure adafinal is
      procedure s_stalib_adafinal;
      pragma Import (Ada, s_stalib_adafinal, "system__standard_library__adafinal");

      procedure Runtime_Finalize;
      pragma Import (C, Runtime_Finalize, "__gnat_runtime_finalize");

   begin
      if not Is_Elaborated then
         return;
      end if;
      Is_Elaborated := False;
      Runtime_Finalize;
      s_stalib_adafinal;
   end adafinal;

   type No_Param_Proc is access procedure;
   pragma Favor_Top_Level (No_Param_Proc);

   procedure adainit is
      Main_Priority : Integer;
      pragma Import (C, Main_Priority, "__gl_main_priority");
      Time_Slice_Value : Integer;
      pragma Import (C, Time_Slice_Value, "__gl_time_slice_val");
      WC_Encoding : Character;
      pragma Import (C, WC_Encoding, "__gl_wc_encoding");
      Locking_Policy : Character;
      pragma Import (C, Locking_Policy, "__gl_locking_policy");
      Queuing_Policy : Character;
      pragma Import (C, Queuing_Policy, "__gl_queuing_policy");
      Task_Dispatching_Policy : Character;
      pragma Import (C, Task_Dispatching_Policy, "__gl_task_dispatching_policy");
      Priority_Specific_Dispatching : System.Address;
      pragma Import (C, Priority_Specific_Dispatching, "__gl_priority_specific_dispatching");
      Num_Specific_Dispatching : Integer;
      pragma Import (C, Num_Specific_Dispatching, "__gl_num_specific_dispatching");
      Main_CPU : Integer;
      pragma Import (C, Main_CPU, "__gl_main_cpu");
      Interrupt_States : System.Address;
      pragma Import (C, Interrupt_States, "__gl_interrupt_states");
      Num_Interrupt_States : Integer;
      pragma Import (C, Num_Interrupt_States, "__gl_num_interrupt_states");
      Unreserve_All_Interrupts : Integer;
      pragma Import (C, Unreserve_All_Interrupts, "__gl_unreserve_all_interrupts");
      Detect_Blocking : Integer;
      pragma Import (C, Detect_Blocking, "__gl_detect_blocking");
      Default_Stack_Size : Integer;
      pragma Import (C, Default_Stack_Size, "__gl_default_stack_size");
      Default_Secondary_Stack_Size : System.Parameters.Size_Type;
      pragma Import (C, Default_Secondary_Stack_Size, "__gnat_default_ss_size");
      Bind_Env_Addr : System.Address;
      pragma Import (C, Bind_Env_Addr, "__gl_bind_env_addr");

      procedure Runtime_Initialize (Install_Handler : Integer);
      pragma Import (C, Runtime_Initialize, "__gnat_runtime_initialize");

      Finalize_Library_Objects : No_Param_Proc;
      pragma Import (C, Finalize_Library_Objects, "__gnat_finalize_library_objects");
      Binder_Sec_Stacks_Count : Natural;
      pragma Import (Ada, Binder_Sec_Stacks_Count, "__gnat_binder_ss_count");
      Default_Sized_SS_Pool : System.Address;
      pragma Import (Ada, Default_Sized_SS_Pool, "__gnat_default_ss_pool");

   begin
      if Is_Elaborated then
         return;
      end if;
      Is_Elaborated := True;
      Main_Priority := -1;
      Time_Slice_Value := -1;
      WC_Encoding := 'b';
      Locking_Policy := ' ';
      Queuing_Policy := ' ';
      Task_Dispatching_Policy := ' ';
      System.Restrictions.Run_Time_Restrictions :=
        (Set =>
          (False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           True, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False),
         Value => (0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
         Violated =>
          (False, False, False, False, True, True, False, False, 
           True, False, False, True, True, True, True, False, 
           False, False, False, True, True, False, True, True, 
           False, True, True, False, True, True, True, True, 
           False, False, False, False, False, True, False, False, 
           True, False, True, False, False, True, False, True, 
           False, True, True, False, False, True, False, False, 
           False, False, True, False, False, False, True, False, 
           True, True, True, False, False, True, False, True, 
           True, True, False, True, True, False, True, True, 
           True, True, False, False, False, False, False, False, 
           False, False, False, True, True, True, True, False, 
           False),
         Count => (0, 0, 0, 0, 4, 4, 11, 1, 0, 0),
         Unknown => (False, False, False, False, False, False, False, True, False, False));
      Priority_Specific_Dispatching :=
        Local_Priority_Specific_Dispatching'Address;
      Num_Specific_Dispatching := 0;
      Main_CPU := -1;
      Interrupt_States := Local_Interrupt_States'Address;
      Num_Interrupt_States := 0;
      Unreserve_All_Interrupts := 0;
      Detect_Blocking := 0;
      Default_Stack_Size := -1;

      ada_main'Elab_Body;
      Default_Secondary_Stack_Size := System.Parameters.Runtime_Default_Sec_Stack_Size;
      Binder_Sec_Stacks_Count := 1;
      Default_Sized_SS_Pool := Sec_Default_Sized_Stacks'Address;

      Runtime_Initialize (1);

      Finalize_Library_Objects := finalize_library'access;

      Ada.Exceptions'Elab_Spec;
      System.Soft_Links'Elab_Spec;
      System.Exception_Table'Elab_Body;
      E010 := E010 + 1;
      Ada.Containers'Elab_Spec;
      E033 := E033 + 1;
      Ada.Io_Exceptions'Elab_Spec;
      E061 := E061 + 1;
      Ada.Strings'Elab_Spec;
      E007 := E007 + 1;
      Ada.Strings.Maps'Elab_Spec;
      E048 := E048 + 1;
      Ada.Strings.Maps.Constants'Elab_Spec;
      E052 := E052 + 1;
      Interfaces.C'Elab_Spec;
      E071 := E071 + 1;
      System.Exceptions'Elab_Spec;
      E019 := E019 + 1;
      System.Object_Reader'Elab_Spec;
      E073 := E073 + 1;
      System.Dwarf_Lines'Elab_Spec;
      E042 := E042 + 1;
      System.Os_Lib'Elab_Body;
      E065 := E065 + 1;
      System.Soft_Links.Initialize'Elab_Body;
      E090 := E090 + 1;
      E012 := E012 + 1;
      System.Traceback.Symbolic'Elab_Body;
      E032 := E032 + 1;
      E016 := E016 + 1;
      Ada.Numerics'Elab_Spec;
      E134 := E134 + 1;
      Ada.Strings.Utf_Encoding'Elab_Spec;
      E094 := E094 + 1;
      Ada.Tags'Elab_Spec;
      Ada.Tags'Elab_Body;
      E100 := E100 + 1;
      Ada.Strings.Text_Buffers'Elab_Spec;
      Ada.Strings.Text_Buffers'Elab_Body;
      E006 := E006 + 1;
      Interfaces.C.Strings'Elab_Spec;
      E174 := E174 + 1;
      Ada.Streams'Elab_Spec;
      E108 := E108 + 1;
      System.File_Control_Block'Elab_Spec;
      E120 := E120 + 1;
      System.Finalization_Root'Elab_Spec;
      System.Finalization_Root'Elab_Body;
      E119 := E119 + 1;
      Ada.Finalization'Elab_Spec;
      E117 := E117 + 1;
      System.File_Io'Elab_Body;
      E116 := E116 + 1;
      System.Storage_Pools'Elab_Spec;
      E158 := E158 + 1;
      System.Finalization_Masters'Elab_Spec;
      System.Finalization_Masters'Elab_Body;
      E156 := E156 + 1;
      Ada.Strings.Unbounded'Elab_Spec;
      Ada.Strings.Unbounded'Elab_Body;
      E138 := E138 + 1;
      System.Task_Info'Elab_Spec;
      E184 := E184 + 1;
      Ada.Calendar'Elab_Spec;
      Ada.Calendar'Elab_Body;
      E126 := E126 + 1;
      Ada.Calendar.Delays'Elab_Body;
      E124 := E124 + 1;
      Ada.Real_Time'Elab_Spec;
      Ada.Real_Time'Elab_Body;
      E216 := E216 + 1;
      Ada.Text_Io'Elab_Spec;
      Ada.Text_Io'Elab_Body;
      E106 := E106 + 1;
      System.Random_Seed'Elab_Body;
      E224 := E224 + 1;
      System.Tasking.Initialization'Elab_Body;
      E196 := E196 + 1;
      System.Tasking.Protected_Objects'Elab_Body;
      E204 := E204 + 1;
      System.Tasking.Protected_Objects.Entries'Elab_Spec;
      E206 := E206 + 1;
      System.Tasking.Queuing'Elab_Body;
      E210 := E210 + 1;
      System.Tasking.Stages'Elab_Body;
      E214 := E214 + 1;
      System.Tasking.Async_Delays'Elab_Body;
      E227 := E227 + 1;
      Global_Types'Elab_Spec;
      E154 := E154 + 1;
      Buffer'Elab_Spec;
      Buffer'Elab_Body;
      E136 := E136 + 1;
      Consumer'Elab_Spec;
      Consumer'Elab_Body;
      E122 := E122 + 1;
      Producer'Elab_Spec;
      Producer'Elab_Body;
      E233 := E233 + 1;
   end adainit;

   procedure Ada_Main_Program;
   pragma Import (Ada, Ada_Main_Program, "_ada_main");

   function main
     (argc : Integer;
      argv : System.Address;
      envp : System.Address)
      return Integer
   is
      procedure Initialize (Addr : System.Address);
      pragma Import (C, Initialize, "__gnat_initialize");

      procedure Finalize;
      pragma Import (C, Finalize, "__gnat_finalize");
      SEH : aliased array (1 .. 2) of Integer;

      Ensure_Reference : aliased System.Address := Ada_Main_Program_Name'Address;
      pragma Volatile (Ensure_Reference);

   begin
      if gnat_argc = 0 then
         gnat_argc := argc;
         gnat_argv := argv;
      end if;
      gnat_envp := envp;

      Initialize (SEH'Address);
      adainit;
      Ada_Main_Program;
      adafinal;
      Finalize;
      return (gnat_exit_status);
   end;

--  BEGIN Object file/option list
   --   C:\Users\PC\Desktop\adaPROJEKT2\ADA_Project\obj\global_types.o
   --   C:\Users\PC\Desktop\adaPROJEKT2\ADA_Project\obj\buffer.o
   --   C:\Users\PC\Desktop\adaPROJEKT2\ADA_Project\obj\consumer.o
   --   C:\Users\PC\Desktop\adaPROJEKT2\ADA_Project\obj\producer.o
   --   C:\Users\PC\Desktop\adaPROJEKT2\ADA_Project\obj\main.o
   --   -LC:\Users\PC\Desktop\adaPROJEKT2\ADA_Project\obj\
   --   -LC:\Users\PC\Desktop\adaPROJEKT2\ADA_Project\obj\
   --   -LC:/gnat/2021/lib/gcc/x86_64-w64-mingw32/10.3.1/adalib/
   --   -static
   --   -lgnarl
   --   -lgnat
   --   -Xlinker
   --   --stack=0x200000,0x1000
   --   -mthreads
   --   -Wl,--stack=0x2000000
--  END Object file/option list   

end ada_main;
