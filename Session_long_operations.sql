# Script to check session long operations:

set lines 200
cle bre
col sid form 9999
col start_time head "Start|Time" form a12 trunc
col opname head "Operation" form a12 trunc
col target head "Object" form a30 trunc
col totalwork head "Total|Work" form 9999999999 trunc
col Sofar head "Sofar" form 9999999999 trunc
col elamin head "Elapsed|Time|(Mins)" form 99999999 trunc
col tre head "Time|Remain|(Mins)" form 999999999 trunc
col Module Format a10

--select sid,to_char(start_time,'dd-mon:hh24:mi') start_time,
--       opname,target,totalwork,sofar,(elapsed_Seconds/60) elamin,
--       time_remaining tre
--from v$session_longops
--where totalwork <> SOFAR
--order by start_time


select a.sid,to_char(start_time,'dd-mon:hh24:mi') start_time,opname,substr(b.module,1,10) Module ,target,totalwork,sofar,(elapsed_Seconds/60) elamin,time_remaining/60 tre,b.sql_hash_value
from v$session_longops a, v$session b
where
a.sid = b.sid and
totalwork <> SOFAR
order by start_time
/
