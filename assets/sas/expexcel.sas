%macro expExcel(
  data
, path=c:\temp\
, file=%scan(&DATA,1,'.')
, sheet=%scan(&DATA,2,'.')
);

proc export
      data=&DATA.
      outfile="&PATH.\&FILE..xls"
      dbms=excel
      replace;
  sheet=&SHEET;
run;

%mend;
