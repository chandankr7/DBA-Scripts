
--Author: Chandan Kumar
--date : 20/05/2017
rem Estimating Index Size

rem This process applies only to tablespaces with SEGMENT SPACE MANAGEMENT AUTO turned on. Second, the package calculates the estimated size of the index
rem from the statistics on the table. Hence it is very important to have relatively fresh statistics on the tables. But beware: the absence of statistics on
rem the table will not result in an error in the use of the package, but will yield a wrong result.

	
declare
   l_used_bytes number;
   l_alloc_bytes number;
begin
   dbms_space.create_index_cost (
      ddl => 'create index SOPQ_SOPC_COMMAND_IDX on SOP_QUEUE '||
        '(SOPQ_SOPC_COMMAND) tablespace CLARITY_GROWTH_TS_3',
      used_bytes => l_used_bytes,
      alloc_bytes => l_alloc_bytes
   );
   dbms_output.put_line ('Used Bytes      = '||l_used_bytes);
   dbms_output.put_line ('Allocated Bytes = '||l_alloc_bytes);
end;

rem Output is:
rem Used Bytes      = 74568496
rem Allocated Bytes = 142606336

--Estimating index size with initrans parameter		
declare
   l_used_bytes number;
   l_alloc_bytes number;
begin
   dbms_space.create_index_cost (
      ddl => 'create index SOPQ_SOPC_COMMAND_IDX on SOP_QUEUE '||
        '(SOPQ_SOPC_COMMAND) tablespace CLARITY_GROWTH_TS_3 initrans 10',
      used_bytes => l_used_bytes,
      alloc_bytes => l_alloc_bytes
   );
   dbms_output.put_line ('Used Bytes      = '||l_used_bytes);
   dbms_output.put_line ('Allocated Bytes = '||l_alloc_bytes);
end;
  
rem Output is:
rem Used Bytes      = 74568496
rem Allocated Bytes = 150994944
