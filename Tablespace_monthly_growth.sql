# Script to monitor database tabelspace growth in a month

SELECT INSTANCE_NAME,REPORT_DATE,TS_NAME,(sum(ALLOCATED_MB)/1024) ALLOCATED_GB,(sum(USED_MB)/1024) USED_GB,
(sum(FREE_MB)/1024) FREE_GB FROM DBGRTH.TABLESPACES_GROWTH_INFO
WHERE to_char(REPORT_DATE,'MON-YYYY')=to_char(last_day(add_months(trunc(sysdate),-1)),'MON-YYYY')
AND trim(to_char(REPORT_DATE,'DAY'))='MONDAY' and ts_name not in('TEMP','TEMP_TBS')
group by rollup(INSTANCE_NAME,REPORT_DATE,TS_NAME);
