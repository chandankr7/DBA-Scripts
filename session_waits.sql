#Script to check session wait details:

set echo off
col name form a35
col value form a20
set head off
set feedback off
select '               '||upper(name)name,value
from v$parameter
where name = 'timed_statistics'
/
select 'Current Time -> '||to_char(sysdate,'dd-mon-yy hh24:mi:ss')
from dual
/
set feedback on
set head on
cle bre
col event form a30 trunc head "Event| Waiting For"
col p1 form 9999999999 trunc
col p2 form 9999999999 trunc
col p3 form 999999999 trunc
col sql_hash_value form 99999999999999 trunc
col wait_time form 999 trunc head "Last|Wait|Time"
col command form a7 trunc head "Command"
col state form a10 trunc
col sid form 9999 trunc
select a.sid,
decode(command,0,'None',2,'Insert',3,'Select',
6,'Update',7,'Delete',10,'Drop Index',12,'Drop Table',
45,'Rollback',47,'PL/SQL',b.command) command,
b.event,a.p1raw,a.p2,a.p3,b.sql_hash_value,a.state,a.wait_time
from v$session_wait a,V$session b
where b.sid=a.sid
'SQL*Net more data from client',('SQL*Net message from client',
                                    'SQL*Net message to client','pipe get','rdbms ipc message','queue messages','jobq slave wait')
or (a.sid<=20 and b.event not in ('rdbms ipc message','smon timer',
            'pmon timer','SQL*Net message from client','gcs remote message')))
and b.sql_hash_value!=0
order by decode(b.event,'pipe get','A',b.event),a.p1,a.p2
/
