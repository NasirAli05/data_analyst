Title 'RBD';
Options ls = 80 ps = 50 pageno = 1;
*;
Data Insurance;
Infile '\\apporto.com\dfs\STVN\Users\edellas_stvn\Desktop\BIA-654 Project\Project dataset.txt' DLM = '09'X TRUNCOVER;
Input age age_category $ sex $ bmi number_of_children smoking $ region $ Insurance_charges ;
*;
*Proc Print Data = Insurance;


*;
Proc GLM Data = Insurance;
Plots = (Diagnostics Residuals)
Plots(Unpack) = Residuals;
Class region age_category ;
Model Insurance_charges = region age_category ;
Means region/regwq ;

Contrast "southeast vs northeast" region -1 1 0 0 ;
Contrast "southwest vs northwest" region 0 0 -1 1 ;



*;
Proc GLM Order = Data ;
Class region age_category ;
Model Insurance_charges = region age_category ;
Output Out = New Predicted = Yhat;
*;
Proc GLM Order = Data;
Class region age_category ;
Model Insurance_charges = region age_category Yhat*Yhat/ss1;

Means region age_category /regwq bon tukey scheffe hovtest = bartlett hovtest = bf hovtest = levene;
Lsmeans region age_category / pdiff adjust = bon;
Lsmeans region age_category / pdiff adjust = tukey;
Lsmeans region age_category / pdiff adjust = scheffe;



*;
Proc GLM Data = Insurance;
Plots = (Diagnostics Residuals)
Plots(Unpack) = Residuals;
Class number_of_children age_category ;
Model Insurance_charges = number_of_children age_category ;
Means number_of_children/regwq ;

Contrast "0 vs 1" number_of_children -1 1 0 0 0 0 ;
Contrast "2 vs 3" number_of_children 0 0 -1 1 0 0 ;
Contrast "4 vs 5" number_of_children 0 0 0 0 -1 1 ;

*;
Proc GLM Order = Data ;
Class number_of_children age_category ;
Model Insurance_charges = number_of_children age_category ;
Output Out = New Predicted = Yhat;
*;
Proc GLM Order = Data;
Class number_of_children age_category ;
Model Insurance_charges = number_of_children age_category Yhat*Yhat/ss1;
*;
Means number_of_children age_category /regwq bon tukey scheffe hovtest = bartlett hovtest = bf hovtest = levene;
Lsmeans number_of_children age_category / pdiff adjust = bon;
Lsmeans number_of_children age_category / pdiff adjust = tukey;
Lsmeans number_of_children age_category / pdiff adjust = scheffe;



Run;

Quit;
