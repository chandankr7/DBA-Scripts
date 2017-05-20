
--Author: Chandan Kumar
--date : 20/05/2017

-- Estimating Table Size
/* Suppose there is a table named SOP_QUEUE, which has the average row lengthof 463 and total number of rows as 46,60,531 rows and the PCTFREE parameter of 10. What if you wanted to increase the parameter PCT_FREE to 30,by what amount will the table increase in size? Because 30 is a 20% increase over 10, will the size go up by 20%? Instead of asking your psychic, ask the procedure CREATE_TABLE_COST inside the package DBMS_SPACE. Here is how you can estimate the size:*/

declare
   l_used_bytes number;
   l_alloc_bytes number;
begin
   dbms_space.create_table_cost (
       tablespace_name => 'CLARITY_GROWTH_TS_3',
       avg_row_size => 463,
       row_count => 4660531,
       pct_free => 10,
       used_bytes => l_used_bytes,
       alloc_bytes => l_alloc_bytes
   );
   dbms_output.put_line('Used: '||l_used_bytes);
   dbms_output.put_line('Allocated: '||l_alloc_bytes);
end;
/
--The output is:(for 10%)

--Used: 2545278976
--Allocated: 2550136832

--Changing the table's PCT_FREE parameter to 30 from 10, by specifying

--pct_free => 30
--The output is:(for 30%)

--Used: 3181592576
--Allocated: 3221225472
--Note how the used space has increased from 2545278976 to 3181592576 because the PCT_FREE parameter conserves less room in the data block for user data. The --increase is about 25%, not 20%, as expected. Using this package you can easily calculate the impact of parameters such as PCT_FREE on the size of the --table, or of moving the table to a different tablespace.

--Note: This process applies only to tablespaces with SEGMENT SPACE MANAGEMENT AUTO turned on. Second, the package calculates the estimated size of the index --from the statistics on the table. Hence it's very important to have relatively fresh statistics on the tables. But beware: the absence of statistics on the --table will not result in an error in the use of the package, but will yield a wrong result.
