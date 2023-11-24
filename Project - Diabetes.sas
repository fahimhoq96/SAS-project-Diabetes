/** SAS Project by Fahim Hoq **/

/** 1 **/
/** Creating Temp Data from permanent data **/

libname in 'C:\DATS7510\SAS';

data diabetes;
set in. diabetes;
run;


PROC SORT DATA = Diabetes;
BY Patient_Number;
RUN; 
DATA TempDiabetes;
SET Diabetes;
BY Patient_Number;
IF FIRST.Patient_Number;
PROC PRINT;
RUN;
proc print data = TempDiabetes (obs =200);
run;

/** 2 **/
/** Creating the Age variable **/

DATA TempDiabetes2;
SET Diabetes;
BY Patient_Number;
IF FIRST.Patient_Number;
Age = (ADMIT_DATE - BIRTH_DATE)/365.25;
run;

proc print data = TempDiabetes2 (obs =200);
var Age BIRTH_DATE ADMIT_DATE;
run;

/** Summarizing the newly created Age variable **/

proc means data = TempDiabetes2;
var Age;
run;


/** 3 **/
/** Using Sub string**/

DATA TempDiabetes3;
SET Diabetes;
BY Patient_Number;
IF FIRST.Patient_Number;
Age = (ADMIT_DATE - BIRTH_DATE)/365.25;

if substr(Diagnosis_1,1,5) in ('250.1') or
	   substr(Diagnosis_2,1,5) in ('250.1') or
	   substr(Diagnosis_3,1,5) in ('250.1') or
	   substr(Diagnosis_4,1,5) in ('250.1') or
	   substr(Diagnosis_5,1,5) in ('250.1') or
	   substr(Diagnosis_6,1,5) in ('250.1') or
	   substr(Diagnosis_7,1,5) in ('250.1') or
	   substr(Diagnosis_8,1,5) in ('250.1') or
	   substr(Diagnosis_9,1,5) in ('250.1') or
	   substr(Diagnosis_10,1,5) in ('250.1') or
	   substr(Diagnosis_11,1,5) in ('250.1') or
	   substr(Diagnosis_12,1,5) in ('250.1') or
	   substr(Diagnosis_13,1,5) in ('250.1') or
	   substr(Diagnosis_14,1,5) in ('250.1') or
	   substr(Diagnosis_15,1,5) in ('250.1')
then ketoacidosis = 1;
	else ketoacidosis = 0;
	Label ketoacidosis = "diabetes with ketoacidosis"

run;

PROC PRINT DATA=TempDiabetes3 Label;
var Patient_Number Age ADMIT_DATE BIRTH_DATE ketoacidosis;
run;

/** Using frequency to count **/

proc freq data = TempDiabetes3;
table ketoacidosis;
title "Patients diagnosed with ketoacidosis";
run;
