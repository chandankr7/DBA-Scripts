##Script to find out how much memory each session is using

COLUMN sid                     FORMAT 999            HEADING 'SID'
COLUMN oracle_username         FORMAT a12            HEADING 'Oracle User'     JUSTIFY right
COLUMN os_username             FORMAT a9             HEADING 'O/S User'        JUSTIFY right
COLUMN session_program         FORMAT a18            HEADING 'Session Program' TRUNC
COLUMN session_module         FORMAT a18            HEADING 'Session module' TRUNC
COLUMN session_action         FORMAT a18            HEADING 'Session action' TRUNC
COLUMN session_machine         FORMAT a8             HEADING 'Machine'   JUSTIFY right TRUNC
COLUMN session_pga_memory      FORMAT 9,999,999,999  HEADING 'PGA Memory'
COLUMN session_pga_memory_max  FORMAT 9,999,999,999  HEADING 'PGA Memory Max'
COLUMN session_uga_memory      FORMAT 9,999,999,999  HEADING 'UGA Memory'
COLUMN session_uga_memory_max  FORMAT 9,999,999,999  HEADING 'UGA Memory MAX'
COLUMN session_total_memory  FORMAT 9,999,999,999  HEADING 'Total Memory'

select sid,oracle_username,os_username,session_program,session_module,session_action, 
session_pga_memory,session_pga_memory_max,session_uga_memory,session_uga_memory_max,session_pga_memory+session_uga_memory session_total_memory from (
SELECT
    s.sid                sid
  , lpad(s.username,12)  oracle_username
  , lpad(s.osuser,9)     os_username
  , s.program            session_program
  , s.module            session_module
  , s.action            session_action
  , lpad(s.machine,8)    session_machine
  , (select ss.value from v$sesstat ss, v$statname sn
     where ss.sid = s.sid and 
           sn.statistic# = ss.statistic# and
           sn.name = 'session pga memory')        session_pga_memory
  , (select ss.value from v$sesstat ss, v$statname sn
     where ss.sid = s.sid and 
           sn.statistic# = ss.statistic# and
           sn.name = 'session pga memory max')    session_pga_memory_max
  , (select ss.value  from v$sesstat ss, v$statname sn
     where ss.sid = s.sid and 
           sn.statistic# = ss.statistic# and
           sn.name = 'session uga memory')        session_uga_memory
  , (select ss.value from v$sesstat ss, v$statname sn
     where ss.sid = s.sid and 
           sn.statistic# = ss.statistic# and
           sn.name = 'session uga memory max')   as session_uga_memory_max
FROM 
    v$session  s )
ORDER BY session_total_memory DESC;
