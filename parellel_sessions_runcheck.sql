# Script to check paralle sessions running in database

col sid head "Sid" form 9999 trunc
col qcsid head "Query|Coordinator|Sid" form 9999999999999 trunc
col server_group head "Server|Group #" form 9999
col server_set head "Server|Set|Within|Server|Group" form 9999
col degree head "Degree|Of|Parallelism|Being|Used" form 9999
col req_degree head "Requested|Degree|Of|Parallelism" form 9999

select sid,qcsid,server_group,server_set,degree,req_degree
from v$px_session
/
