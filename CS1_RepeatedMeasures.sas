data memory;                                                                                                                          
 input  Major $	Student	Test	Wordlist $	Distracter $	Score;
 datalines;  
Math	1	1	abstract	poetry	6
Math	1	2	abstract	math	8
Math	1	3	concrete	poetry	8
Math	1	4	concrete	math	11
Math	2	5	abstract	poetry	5
Math	2	6	abstract	math	8
Math	2	7	concrete	poetry	8
Math	2	8	concrete	math	10
Math	3	9	abstract	poetry	7
Math	3	10	abstract	math	10
Math	3	11	concrete	poetry	9
Math	3	12	concrete	math	10
CS	4	13	abstract	poetry	9
CS	4	14	abstract	math	12
CS	4	15	concrete	poetry	10
CS	4	16	concrete	math	13
CS	5	17	abstract	poetry	4
CS	5	18	abstract	math	8
CS	5	19	concrete	poetry	8
CS	5	20	concrete	math	9
CS	6	21	abstract	poetry	7
CS	6	22	abstract	math	8
CS	6	23	concrete	poetry	5
CS	6	24	concrete	math	8
Hist	7	25	abstract	poetry	8
Hist	7	26	abstract	math	7
Hist	7	27	concrete	poetry	9
Hist	7	28	concrete	math	10
Hist	8	29	abstract	poetry	7
Hist	8	30	abstract	math	6
Hist	8	31	concrete	poetry	10
Hist	8	32	concrete	math	8
Hist	9	33	abstract	poetry	5
Hist	9	34	abstract	math	4
Hist	9	35	concrete	poetry	7
Hist	9	36	concrete	math	7
Eng	10	37	abstract	poetry	10
Eng	10	38	abstract	math	9
Eng	10	39	concrete	poetry	10
Eng	10	40	concrete	math	8
Eng	11	41	abstract	poetry	9
Eng	11	42	abstract	math	4
Eng	11	43	concrete	poetry	9
Eng	11	44	concrete	math	8
Eng	12	45	abstract	poetry	10
Eng	12	46	abstract	math	7
Eng	12	47	concrete	poetry	8
Eng	12	48	concrete	math	8 ;                                                                                                                                                                                                                                                             
/* Repeated Measures Approach */
/* Fitting covariance structures: */
/* Note:  the code beginning with "ods output...." for each
	run of the Mixed procedure generates an output that
	is tablulated at the end to enable comparison of 
	the candidate covariance structures 
input  Major $	Student	Test	Wordlist $	Distracter $	Score;
*/
title ;
proc mixed data=memory method=ml covtest;
class Student Wordlist Distracter Major;
model Score = Wordlist Distracter Wordlist*Distracter Major Major*Distracter Major*Wordlist / ddfm=kr;
repeated / type=CS subject=Student type=cs rcorr;
store outcs;
run; 
 
ods output FitStatistics=FitCS (rename=(value=CS))
FitStatistics=FitCSp;
title 'Compound Symmetry'; run;


