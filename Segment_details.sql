# Script to find segment details

col owner head "Owner" form a10
col segment_name head "Segment Name" form a30
col segment_type head "Segment|Type" form a10
col tablespace_name head "Tablespace" form a15
col extents head "Extents" form 99999
col blocks head "Blocks" form 999999999
select owner,segment_name,segment_type,tablespace_name,extents,blocks,bytes/1024/1024/1024
from dba_segments
where segment_name like upper('%&1%')
order by 1,2
/
