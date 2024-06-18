/*********************************************************************************\
PROGRAM INFORMATION
Project : Autocall utilities
Purpose : Returns DATE in the specified format.
Inputs  : 
Outputs : 
Notes   : 

PROGRAM HISTORY
2008-04-14 RK Initial program developed.
\*********************************************************************************/;


%macro d(
  format
, d=&SYSDATE9
, interval=day
, increment=0
, alignment=b
);

%if &FORMAT eq %str( ) %then %let format = date9;

%else %if %upcase(&FORMAT) eq HELP %then %do;
  %put ***********************************************************************************;
  %put * D Returns a date value in the specified format.                                 *;
  %put ***********************************************************************************;
  %put * Positional Parameters (in this order):                                          *;
  %put *  FORMAT    The format to return DATE in. Defaults to date9.                     *;
  %put *                                                                                 *;
  %put * Optional Keyword Parameters (in any order):                                     *;
  %put *  D         Date value to use entered in date9 format. Defaults to SYSDATE9.     *;
  %put *  INTERVAL  Interval to shift the DATE parameter by. Defaults to day.            *;
  %put *  INCREMENT Amount to shift the DATE parameter by. Defaults to 0.                *;
  %put *  ALIGNMENT Sets the position of the result. Defaults to b(eginning).            *;
  %put ***********************************************************************************;
  %put * Example macro call                                                              *;
  %put *  d(worddate, d=07DEC1942, interval=month, increment=5, alignment=s)             *;
  %put ***********************************************************************************;
  dm log 'show';
  %goto ByeBye;
%end;

%else %if %upcase(&FORMAT) eq EDIT %then %do;
  dm wedit 'whostedit "\\mspfile02\MPLSData\sas\macros\d.sas"';
  %goto ByeBye;
%end;

%sysfunc(intnx(&INTERVAL, "&D"d, &INCREMENT, &ALIGNMENT), &FORMAT..)

%ByeBye:
%mend  d;
