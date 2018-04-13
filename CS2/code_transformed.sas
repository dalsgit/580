data baking;                                                                                                                           
input AvgTaste Day Sugar $ Batch;
crock	soaktime $ recipe rating;
datalines;                        
6.8	1	double	1
6.2	2	double	1
5.8	3	double	1
5.2	1	half	2
4.4	2	half	2
5	3	half	2
6.2	1	regular	3
6.8	2	regular	3
6.2	3	regular	3
7.4	1	double	4
6.4	2	double	4
4	3	double	4
7	1	half	5
7	2	half	5
4.6	3	half	5
6.4	1	regular	6
7.8	2	regular	6
5.8	3	regular	6
6.4	1	double	7
6.2	2	double	7
4.8	3	double	7
6.2	1	half	8
6.8	2	half	8
5.6	3	half	8
6.6	1	regular	9
6	2	regular	9
5.8	3	regular	9
;

proc mixed data=baking method=type3 plots=all; 
class AvgTaste Day Sugar $ Batch;
model AvgTaste=Sugar Day Sugar*Day;
random Batch(Sugar);
store abc123; /*Stores results for the next procedure (abc123 is name I give)*/
title 'ANOVA of baking Data';
run;

ods html style=statistical sge=on;
proc plm restore=abc123; 
lsmeans Sugar / adjust=tukey plot=meanplot cl lines;  
lsmeans Day / adjust=tukey plot=meanplot cl lines;  
lsmeans Sugar*Day / adjust=tukey plot=meanplot cl lines;  
/* The lsmeans statement here prints out the model fit means, performs the Tukey
      mean comparisons, and plots the data. */
ods exclude diffplot; 
run; title; run;

