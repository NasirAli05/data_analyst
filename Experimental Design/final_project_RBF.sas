;
* ODS LISTING;
*;
ODS Graphics On;
*;
Title 'SAS Program for RBF Design';
Options Linesize = 80;
*;
PROC IMPORT DATAFILE="C:\Users\vedan\Downloads\Project dataset (3).xlsx"
            OUT=project_dataset
            DBMS=XLSX
            REPLACE;
RUN;

PROC PRINT DATA=project_dataset;
RUN;
*;

Proc GLM Data = project_dataset;
Class  region children age_category;
Model Insurance_charges =  region children region*children age_category;
Means region children region*children;
Means region children/regwq;
Means region children/bon;

*;
Lsmeans region children region*children;
*;
Lsmeans region / pdiff adjust = bon;
Lsmeans region / pdiff adjust = tukey;
Lsmeans region / pdiff adjust = scheffe;
*;
Lsmeans children / pdiff adjust = bon;
Lsmeans children / pdiff adjust = tukey;
Lsmeans children / pdiff adjust = scheffe;
*;
Lsmeans region*children / pdiff adjust = bon;
Lsmeans region*children / pdiff adjust = tukey;
Lsmeans region*children / pdiff adjust = scheffe;
*;
Run;
*;
ODS Graphics Off;
*;
Quit;
