
#Script to generate and kill session as per session id

select 'alter system kill session '''||sid||','||serial#||''' immediate;'
from v$session
where sid=&1
/

#Script to generate and kill session as per hash value

select 'alter system kill session '''||sid||','||serial#||''' immediate;'
from v$session
where sql_hash_value= &a;

#Script to generate and kill session as per username

select 'alter system kill session '''||sid||','||serial#||''' immediate;' from v$session where USERNAME in ('&ENTER_USERNAME')
/

#Script to identify database SID as per OS PID

select s.sql_hash_value, s.sql_id,s.program,s.module,s.username,s.osuser  from v$session s , v$process p where p.addr=s.paddr and p.spid=&spid
/
or
select sid from v$session where PADDR=(select addr from v$process where pid=&pid);

# Script to generate and kill sessions with long operations and in Inactive state

 select 'alter system kill session'''||b.sid||','||b.serial#||''' immediate;'
  from v$session_longops a, v$session b
  where
  a.sid = b.sid and
  totalwork <> SOFAR and b.SQL_HASH_VALUE=0 and b.STATUS='INACTIVE'
  order by start_time;
