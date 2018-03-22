data memory;                                                                                                                          
 input  Major $	Student	Test	Wordlist $	Distracter $  TreatmentCode $ Score;
 datalines;
Math	1	1	abstract	poetry	TR1	6
Math	1	2	abstract	math	TR2	8
Math	1	3	concrete	poetry	TR3	8
Math	1	4	concrete	math	TR4	11
Math	2	5	abstract	poetry	TR1	5
Math	2	6	abstract	math	TR2	8
Math	2	7	concrete	poetry	TR3	8
Math	2	8	concrete	math	TR4	10
Math	3	9	abstract	poetry	TR1	7
Math	3	10	abstract	math	TR2	10
Math	3	11	concrete	poetry	TR3	9
Math	3	12	concrete	math	TR4	10
CS	4	13	abstract	poetry	TR1	9
CS	4	14	abstract	math	TR2	12
CS	4	15	concrete	poetry	TR3	10
CS	4	16	concrete	math	TR4	13
CS	5	17	abstract	poetry	TR1	4
CS	5	18	abstract	math	TR2	8
CS	5	19	concrete	poetry	TR3	8
CS	5	20	concrete	math	TR4	9
CS	6	21	abstract	poetry	TR1	7
CS	6	22	abstract	math	TR2	8
CS	6	23	concrete	poetry	TR3	5
CS	6	24	concrete	math	TR4	8
Hist	7	25	abstract	poetry	TR1	8
Hist	7	26	abstract	math	TR2	7
Hist	7	27	concrete	poetry	TR3	9
Hist	7	28	concrete	math	TR4	10
Hist	8	29	abstract	poetry	TR1	7
Hist	8	30	abstract	math	TR2	6
Hist	8	31	concrete	poetry	TR3	10
Hist	8	32	concrete	math	TR4	8
Hist	9	33	abstract	poetry	TR1	5
Hist	9	34	abstract	math	TR2	4
Hist	9	35	concrete	poetry	TR3	7
Hist	9	36	concrete	math	TR4	7
Eng	10	37	abstract	poetry	TR1	10
Eng	10	38	abstract	math	TR2	9
Eng	10	39	concrete	poetry	TR3	10
Eng	10	40	concrete	math	TR4	8
Eng	11	41	abstract	poetry	TR1	9
Eng	11	42	abstract	math	TR2	4
Eng	11	43	concrete	poetry	TR3	9
Eng	11	44	concrete	math	TR4	8
Eng	12	45	abstract	poetry	TR1	10
Eng	12	46	abstract	math	TR2	7
Eng	12	47	concrete	poetry	TR3	8
Eng	12	48	concrete	math	TR4	8 ;                                                                                                                                                                

/* Split-Plot Approach */
title 'Split-Plot approach';
proc mixed data=memory method=ml covtest;
	class Student Wordlist Distracter Major;
	/*model Score = Wordlist|Distracter|Major / DDFM=KR residual;*/
	model Score = Wordlist Distracter Wordlist*Distracter Major Wordlist*Major Distracter*Major Wordlist*Distracter*Major / ddfm=kr;
	random Student(Major);
run;
			 
/* Repeated Measures Approach */
/* Fitting covariance structures: */
/* Note:  the code beginning with "ods output...." for each
	run of the Mixed procedure generates an output that
	is tablulated at the end to enable comparison of 
	the candidate covariance structures 
*/
title 'Repeated measures approach';
proc mixed data=memory method=ml covtest;
	class Student Wordlist Distracter Major;
	model Score = Wordlist Distracter Wordlist*Distracter Major Wordlist*Major Distracter*Major Wordlist*Distracter*Major / ddfm=kr;
	repeated / subject=Student(Major) type=CS rcorr;
run;  
ods output FitStatistics=FitCS (rename=(value=CS))
FitStatistics=FitCSp;
title 'Compound Symmetry'; run;

proc mixed data=memory method=ml covtest;
	class Student Wordlist Distracter Major;
	model Score = Wordlist Distracter Wordlist*Distracter Major Wordlist*Major Distracter*Major Wordlist*Distracter*Major / ddfm=kr;
	repeated / subject=Student(Major);
run; 
ods output FitStatistics=FitVC (rename=(value=VC))
FitStatistics=FitVCp;
title 'Variance Components'; run;

proc mixed data=memory method=ml covtest;
	class Student Wordlist Distracter Major;
	model Score = Wordlist Distracter Wordlist*Distracter Major Wordlist*Major Distracter*Major Wordlist*Distracter*Major / ddfm=kr;
	repeated / subject=Student(Major) type=un rcorr;
run; 
ods output FitStatistics=FitUN (rename=(value=UN))
FitStatistics=FitUNp;
title 'Unstructured'; run;

title 'Covariance Summary'; run;
data fits;
merge FitCS FitVC FitUN;
by descr;
run;
ods listing; proc print data=fits; run;



