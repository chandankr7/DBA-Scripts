#Script to check only active sessions in oracle database

select sid,serial#,substr(username,1,10) username,substr(osuser,1,10) osuser,
         substr(program||module,1,15) program,substr(machine,1,22) machine,
         to_char(logon_time,'ddMon hh24:mi') login,
         last_call_et "last call",status,sql_hash_value
 and username is not nullus='ACTIVE'
order by 7
/

# Script to check ACTIVE and INACTIVE sessions together

set echo off
set linesize 150
set head on
set feedback on
col sid head "Sid" form 9999 trunc
col serial# form 99999 trunc head "Ser#"
col username form a8 trunc
col osuser form a7 trunc
col machine form a20 trunc head "Client|Machine"
col program form a25 trunc head "Client|Program"
col login form a11
col "last call"  form 9999999 trunc head "Last Call|In Secs"
col status form a6 trunc
select sid,serial#,substr(username,1,10) username,substr(osuser,1,10) osuser,
         substr(program||module,1,25) program,substr(machine,1,22) machine,
         to_char(logon_time,'ddMon hh24:mi') login,
         last_call_et "last call",status,sql_hash_value
from v$session
order by 1
/
