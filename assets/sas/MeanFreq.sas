/*********************************************************************************\
PROGRAM INFORMATION
Project : autocall utilities
Purpose : Generate interval and nominal analysis of variable.
Inputs  : specified data set
Outputs : output data set and log printout
to-do   : add checks for too many discrete values.
          add ability to processes multiple variables in one call.
          add ability to have multiple by-variables in one call.

PROGRAM HISTORY
2008-06-19 RK Initial program developed.
\*********************************************************************************/;


%macro MeanFreq(
  data=
, var=%str( )
, by=%str( )
, out=Data&Sysdate9.
, debug=NO
);

%if %index(' ', &var) or (&by ne %str( ) and %index(' ', &by)) %then %let data=HELP;

%if %upcase(&data) eq HELP %then %do;
  %put ***********************************************************************************;
  %put * MeanFreq Extracts a list of learners enrolled in a program, including           *;
  %put *             CERTificates. The grain is at the learner-program level.            *;
  %put ***********************************************************************************;
  %put * Positional Parameters (in this order):                                          *;
  %put *                                                                                 *;
  %put * Optional Keyword Parameters (in any order):                                     *;
  %put *  DATA      Input data set name.                                                 *;
  %put *  VAR       Variable to analyze. One variable...no more.                         *;
  %put *  BY        Optional by-variable. One variable...no more.                        *;
  %put *  OUT       Name of output data set. Defaults to DATA&SYSDATE9.                  *;
  %put *  DEBUG     Preserves intermittent data sets for debugging. Defaults to NO.      *;
  %put ***********************************************************************************;
  %put * Example macro call (remove space after %)                                       *;
  %put * % MeanFreq(data=psol.data, by=UMS_Degree, var=sum2)                             *;
  %put ***********************************************************************************;
  %goto ByeBye;
%end;

ods listing close;
/*********************************************************************************\
mean
\*********************************************************************************/;
proc summary data=&data;
  %if &by ne %then class &by;;
  var &var;
  output out=&out._summary(drop=_type_ rename=(_Freq_=N_Valid))
         nmiss=N_Missing mean=Mean stddev=StdDev;
run;


/*********************************************************************************\
freq
\*********************************************************************************/;
proc tabulate data=&data out=&out._freq order=formatted;
  class %if &by ne %then &by; &var;
  table %if &by ne %then (&by all)*;&var;
run;

proc sql;
  select distinct catt('f_',&var), catt('p_',&var)
  into :f separated by ' ', :p separated by ' ' 
  from &out._freq
  ;
quit;

%if &by ne %then %do;
proc sort data=&out._freq; by &by; run;
%end;

proc transpose data=&out._freq out=&out._freq(drop=_name_) prefix=f_;
  %if &by ne %then by &by;;
  id &var;
  var n;
run;


/*********************************************************************************\
mean + freq
\*********************************************************************************/;
data &out(drop=i);
  merge &out._summary &out._freq;
  %if &by ne %then by &by;;
  N_Valid = sum(of f_:);
  array f_{*} &f;
  array p_{*} &p;
  do i = 1 to dim(f_);
    if f_[i] = . then f_[i] = 0;
    p_[i] = f_[i] / N_Valid;
  end;
  format N_Valid N_Missing f_: comma8. Mean StdDev 8.4 p_: percent8.2;
run;

ods listing;

proc print data=&out;
  %if &by ne %then id &by;;
run;

%if &debug eq NO %then %do;
  proc datasets library=work nodetails nolist;
    delete &out._freq &out._summary;
    run;
  quit;
%end;

%ByeBye:;

%mend  MeanFreq;
