/*********************************************************************************\
PROGRAM INFORMATION
Project : general utilities
Purpose : generate frequency listing of user-selected variables
Inputs  : 
Outputs : 
Notes   : 

PROGRAM HISTORY
2008-09-05 RK Initial program developed.
\*********************************************************************************/;


%macro PickFreq(DATA);
/*********************************************************************************\
standardize data parameter
\*********************************************************************************/;
%if &DATA eq %str( ) %then %let data = &SYSLAST;
%let data = %upcase(&DATA);

%if %index(&DATA,.)
%then %do;
  %let _l_ = %scan(&DATA, 1, '.');
  %let _m_ = %scan(&DATA, 2, '.');
%end;
%else %do;
  %let _l_=WORK;
  %let _m_=&DATA;
%end;


/*********************************************************************************\
fetch variables
\*********************************************************************************/;
proc sql;
  create table _cols_ as
  select *
  from dictionary.columns
  where libname = "&_L_"
    and upcase(memname) = "&_M_";
quit;


/*********************************************************************************\
variable selection
\*********************************************************************************/;
data _null_;
  set _cols_ end=_end_;
  file 'c:\temp\_select_.txt' pad lrecl=200;
  if _n_ = 1 then
  put '%window _select_ columns=100 rows=65'
    / "#2 @1 'Contents of &_L_..&_M_'"
    / '#4 @1 "Sel" @5 "Type" @10 "Length" @17 "Variable"'
    / '#5 "--- ---- ------ --------------------------------"';

  put '/ @1 "[" ' name '1 autoskip=yes "]" @5 "' type '" @10 "' length '" @17 "' name '"';

  if _end_ then
  put '#60 "60";'
    / '%display _select_;';
run;
%inc 'c:\temp\_select_.txt';


/*********************************************************************************\
run frequencies
\*********************************************************************************/;
data _null_;
  set _cols_ end=_end_;
  file 'c:\temp\_freq_.txt';
  if _n_ = 1 then
  put "proc freq data=&_L_..&_M_.;"
    / 'table ';

  if lengthn(symget(name)) then put @2 name;

  if _end_ then
  put '; run;';
run;
%inc 'c:\temp\_freq_.txt';
%mend;
