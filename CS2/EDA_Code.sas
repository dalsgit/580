data baking;                                                                                                                           
input Taste Day Sugar $ Batch;
datalines; 
7	1	double	1
8	1	double	1
6	1	double	1
6	1	double	1
7	1	double	1
5	2	double	1
8	2	double	1
5	2	double	1
7	2	double	1
6	2	double	1
2	3	double	1
9	3	double	1
2	3	double	1
7	3	double	1
9	3	double	1
4	1	half	2
4	1	half	2
7	1	half	2
5	1	half	2
6	1	half	2
3	2	half	2
2	2	half	2
5	2	half	2
7	2	half	2
5	2	half	2
8	3	half	2
4	3	half	2
7	3	half	2
4	3	half	2
2	3	half	2
5	1	regular	3
6	1	regular	3
4	1	regular	3
6	1	regular	3
10	1	regular	3
7	2	regular	3
8	2	regular	3
6	2	regular	3
7	2	regular	3
6	2	regular	3
6	3	regular	3
6	3	regular	3
7	3	regular	3
5	3	regular	3
7	3	regular	3
8	1	double	4
8	1	double	4
7	1	double	4
6	1	double	4
8	1	double	4
7	2	double	4
6	2	double	4
9	2	double	4
5	2	double	4
5	2	double	4
6	3	double	4
5	3	double	4
2	3	double	4
4	3	double	4
3	3	double	4
6	1	half	5
10	1	half	5
4	1	half	5
9	1	half	5
6	1	half	5
9	2	half	5
5	2	half	5
8	2	half	5
6	2	half	5
7	2	half	5
5	3	half	5
6	3	half	5
6	3	half	5
4	3	half	5
2	3	half	5
7	1	regular	6
8	1	regular	6
4	1	regular	6
4	1	regular	6
9	1	regular	6
9	2	regular	6
8	2	regular	6
5	2	regular	6
10	2	regular	6
7	2	regular	6
4	3	regular	6
7	3	regular	6
7	3	regular	6
4	3	regular	6
7	3	regular	6
6	1	double	7
8	1	double	7
5	1	double	7
6	1	double	7
7	1	double	7
6	2	double	7
7	2	double	7
5	2	double	7
7	2	double	7
6	2	double	7
3	3	double	7
7	3	double	7
6	3	double	7
5	3	double	7
3	3	double	7
5	1	half	8
6	1	half	8
7	1	half	8
8	1	half	8
5	1	half	8
5	2	half	8
6	2	half	8
6	2	half	8
9	2	half	8
8	2	half	8
4	3	half	8
5	3	half	8
4	3	half	8
7	3	half	8
8	3	half	8
7	1	regular	9
6	1	regular	9
7	1	regular	9
5	1	regular	9
8	1	regular	9
6	2	regular	9
7	2	regular	9
6	2	regular	9
6	2	regular	9
5	2	regular	9
6	3	regular	9
7	3	regular	9
6	3	regular	9
7	3	regular	9
3	3	regular	9
;

PROC BOXPLOT data=baking;
	plot Taste*Sugar;
RUN;

proc summary data=baking;
	class Sugar Day;
	var Taste;
	output out=output1 mean=mean stderr=se;
	run;
	proc print data=output1;
	title 'Summary Output for Lesson 1';
run;

title; run;