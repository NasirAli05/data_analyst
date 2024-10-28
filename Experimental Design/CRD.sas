Title 'CRD';
Options ls = 80 ps = 50 pageno = 1;
*;
Data Insurance;
Infile '\\apporto.com\dfs\STVN\Users\edellas_stvn\Desktop\BIA-654 Project\Project dataset.txt' DLM = '09'X TRUNCOVER;
Input age age_category $ sex $ bmi number_of_children smoking $ region $ Insurance_charges ;
*;
Proc Print Data = Insurance;

*;
Proc GLM Data = Insurance;
Class region;
Model Insurance_charges = region;
Means region;
Means region/regwq bon tukey scheffe hovtest = bartlett hovtest = bf hovtest = levene;
Lsmeans region / pdiff adjust bon;
Lsmeans region / pdiff adjust = tukey;
Lsmeans region / pdiff adjust = scheffe;
*;
Contrast "Compare southwest vs Others" region -3 1 1 1 ;
Contrast "Compare southeast vs Others" region 1 -3 1 1 ;
Contrast "Compare northwest vs Others" region 1 1 -3 1 ;
Contrast "Compare northeast vs Others" region 1 1 1 -3 ;
*;
Contrast "southeast vs northeast" region -1 1 0 0 ;
Contrast "southwest vs northwest" region 0 0 -1 1 ;


Proc GLM Data = Insurance;
Class number_of_children;
Model Insurance_charges = number_of_children;
Means number_of_children;
Means number_of_children/regwq bon tukey scheffe hovtest = bartlett hovtest = bf hovtest = levene;
Lsmeans number_of_children / pdiff adjust bon;
Lsmeans number_of_children / pdiff adjust = tukey;
Lsmeans number_of_children / pdiff adjust = scheffe;
*;
Contrast "Compare 0 vs Others" number_of_children -5 1 1 1 1 1 ;
Contrast "Compare 1 vs Others" number_of_children 1 -5 1 1 1 1 ;
Contrast "Compare 2 vs Others" number_of_children 1 1 -5 1 1 1 ;
Contrast "Compare 3 vs Others" number_of_children 1 1 1 -5 1 1 ;
Contrast "Compare 4 vs Others" number_of_children 1 1 1 1 -5 1 ;
Contrast "Compare 5 vs Others" number_of_children 1 1 1 1 1 -5 ;
*;
Contrast "0 vs 1" number_of_children -1 1 0 0 0 0 ;
Contrast "2 vs 3" number_of_children 0 0 -1 1 0 0 ;
Contrast "4 vs 5" number_of_children 0 0 0 0 -1 1 ;
*;


Run;
Quit;
