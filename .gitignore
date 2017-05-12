#Script to find the size of database, used and free space as well

select
"Reserved_Space(GB)", "Reserved_Space(GB)" - "Free_Space(GB)" "Used_Space(GB)","Free_Space(GB)"
from(
select
(select sum(bytes/(1024*1024*1024)) from dba_data_files) "Reserved_Space(GB)",
(select sum(bytes/(1024*1024*1024)) from dba_free_space) "Free_Space(GB)"
from dual
)
/
