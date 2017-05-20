--Author: Chandan Kumar
--date : 20/05/2017

--Predicting the Growth of a Segment
select * from 
table(dbms_space.OBJECT_GROWTH_TREND 
('CLARITY','SOP_QUEUE','TABLE'));

--The function dbms_space.object_growth_trend() returns record in PIPELINED format, which can be displayed by the TABLE() casting.

   	    TIMEPOINT	        SPACE_USAGE	SPACE_ALLOC	QUALITY

	01-MAY-17 03.20.34.2	2715106441	2989883392	INTERPOLATED
	02-MAY-17 03.20.34.2	2724744564	2989883392	INTERPOLATED
	03-MAY-17 03.20.34.2	2735297863	2989883392	INTERPOLATED
	04-MAY-17 03.20.34.2	2745134973	2989883392	INTERPOLATED
	05-MAY-17 03.20.34.2	2753762575	2989883392	INTERPOLATED
	06-MAY-17 03.20.34.2	2761711912	3056992256	GOOD
	07-MAY-17 03.20.34.2	2765516350	3056992256	GOOD
	08-MAY-17 03.20.34.2	2773447236	3056992256	GOOD
	09-MAY-17 03.20.34.2	2587028386	3056992256	GOOD
	10-MAY-17 03.20.34.2	2594426387	3056992256	GOOD
	11-MAY-17 03.20.34.2	2567522471	3056992256	GOOD
	12-MAY-17 03.20.34.2	2588518153	3056992256	GOOD
	13-MAY-17 03.20.34.2	2599032312	3056992256	GOOD
	14-MAY-17 03.20.34.2	2603957082	3056992256	GOOD
	15-MAY-17 03.20.34.2	2625332066	3056992256	GOOD
	16-MAY-17 03.20.34.2	2650598295	3056992256	GOOD
	17-MAY-17 03.20.34.2	2674229232	3056992256	GOOD
	18-MAY-17 03.20.34.2	2701491895	3056992256	GOOD
	19-MAY-17 03.20.34.2	2727938511	3056992256	GOOD
	20-MAY-17 03.20.34.2	2754763578	3056992256	GOOD
	21-MAY-17 03.20.34.2	2796827476	3188098081	PROJECTED
	22-MAY-17 03.20.34.2	2798625956	3196838469	PROJECTED
	23-MAY-17 03.20.34.2	2800424436	3205578858	PROJECTED
	24-MAY-17 03.20.34.2	2802222916	3214319246	PROJECTED
	25-MAY-17 03.20.34.2	2804021396	3223059634	PROJECTED

/*The output clearly shows the size of the table SOP_QUEUE at various times as shown in the column TIMEPOINT, in the TIMESTAMP datatype. The SPACE_ALLOC column shows the bytes allocated to the table and the SPACE_USAGE column shows how many of those bytes have been used. This information is collected by the Automatic Workload Repository, or AWR (see Week 6 of this series), every day. In the above output, the data was collected well from May 6,2017 to May 20,2017 as indicated by the value of the column QUALITY - "GOOD." The space allocated and usage figures are accurate for that day. However, for all subsequent days, the value of this column is PROJECTED, indicating that the space calculations are projected from the data collected by the AWR facility?not collected directly from the segment.
Note the values in this column prior to May 6,they are all INTERPOLATED. In other words, the value was not really collected or projected, but simply interpolated from the usage pattern for whatever data is available. Most likely the data was not available at that time and hence the values had to be interpolated.*/
