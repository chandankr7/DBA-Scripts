# Script to fetch session details

set echo off
set linesize 130
set head on
set feedback on
col sid head "Sid" form 9999 trunc
col serial# form 99999 trunc head "Ser#"
col username form a11 trunc
col osuser form a7 trunc
col machine form a20 trunc head "Client|Machine"
col program form a15 trunc head "Client|Program"
col login form a11
col "last call"  form 9999999 trunc head "Last Call|In Secs"
col status form a6 trunc
select sid,serial#,substr(username,1,10) username,substr(osuser,1,10) osuser,
         substr(program||module,1,15) program,substr(machine,1,22) machine,
         to_char(logon_time,'ddMon hh24:mi') login,sql_hash_value, last_call_et "last call",status
from v$session
where sid=&1
order by 1
/
