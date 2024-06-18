data _null_;
  input x ? $50.;
  dt=dhms(input(scan(x, 1, ' '), mmddyy10.)
        , 0
        , 0
        , input(catx(' ', scan(x, 2, ' '), scan(x, 3, ' ')), time.)
        );
  put dt datetime19.;
datalines;
5/5/2009 2:22:17 AM
04/08/2015 04:23:42 PM 
run;
