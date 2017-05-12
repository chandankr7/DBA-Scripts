# Script to get the size of tablespaces in a oracle database and finding space utilization more than 90%

select  tbs.tablespace_name,
        tot.bytes/1024/1024/1024 total,
        tot.bytes/1024/1024/1024-sum(nvl(fre.bytes,0))/1024/1024/1024 used,
        sum(nvl(fre.bytes,0))/1024/1024/1024 free,
        (1-sum(nvl(fre.bytes,0))/tot.bytes)*100 pct,
        decode(
            greatest((1-sum(nvl(fre.bytes,0))/tot.bytes)*100, 90),
            90, '', '*'
        ) pct_warn
from    dba_free_space fre,
        (select tablespace_name, sum(bytes) bytes
        from    dba_data_files
        group by tablespace_name) tot,
        dba_tablespaces tbs
where   tot.tablespace_name    = tbs.tablespace_name
and     fre.tablespace_name(+) = tbs.tablespace_name
--and fre.tablespace_name='SYSTEM'
group by tbs.tablespace_name, tot.bytes/1024/1024/1024, tot.bytes
order by 5, 1 ASC
/
