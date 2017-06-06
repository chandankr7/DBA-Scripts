## Login prompt for SQL*PLUS connection

column global_name new_value gname
set termout off
select lower(user) || '@' ||
decode(global_name, 'ORACLE8.WORLD', '8.0', 'ORA8I.WORLD',
'8i', 'ORA8IDEV.WORLD', 'dev8i', global_name ) global_name from
global_name;
set termout on
set pages 120
set lines 120
set sqlprompt '&gname> '
