data _null_;
  d1='29-31 DEC 2009,04-05 JAN 2010'; *broken across month, year;
  d2='04-05,08-09,11-12 FEB 2010'; *broken within month;
  d3='01-03 MAR 2010'; *contiguous within month;
  d4='31 MAR-01 APR 2010'; *contiguous across month;
  d5='29 DEC 2009-01 JAN 2010'; *contiguous across year;
  d6='01 FEB 2010'; *single day;
  array d(*) d1-d6;

  re_datesx=prxparse('/^\d{2} [A-Z]{3} \d{4}$/');
  re_datesd=prxparse('/(\d\d){1}?(?:.*)(\d\d) ?(?:JAN|FEB|MAR|APR|MAY|JUN|JUL|AUG|SEP|OCT|NOV|DEC) (?:20\d\d)/');
  re_datesm=prxparse('/(JAN|FEB|MAR|APR|MAY|JUN|JUL|AUG|SEP|OCT|NOV|DEC){1}?(?:.*-.* )?(JAN|FEB|MAR|APR|MAY|JUN|JUL|AUG|SEP|OCT|NOV|DEC)? (?:20\d\d)/');
  re_datesy=prxparse('/(20\d\d){1}?(?:.* )?(20\d\d)?/');


  do i = 1 to dim(d);
    if prxmatch(re_datesx, d[i])=0 then do;
      if prxmatch(re_datesd, d[i]) then do;
        sd=prxposn(re_datesd, 1, d[i]);
        ed=prxposn(re_datesd, 2, d[i]);
        end;
      if prxmatch(re_datesm, d[i]) then do;
        sm=prxposn(re_datesm, 1, d[i]);
        em=prxposn(re_datesm, 2, d[i]);
        if em='' then em=sm;
        end;
      if prxmatch(re_datesy, d[i]) then do;
        sy=prxposn(re_datesy, 1, d[i]);
        ey=prxposn(re_datesy, 2, d[i]);
        if ey='' then ey=sy;
        end;
      sdate=input(cats(sd, sm, sy), date9.);
      edate=input(cats(ed, em, ey), date9.);
      end;
    else do;
      sdate=input(compress(d[i], ' '), date9.);
      edate=sdate;
      end;
    put 'Original: >>>' d[i] +(-1) '<<<'
      / (s:)(=)
      / (e:)(=)
      /;
    call missing(of s: e:);
  end;
  format sdate edate date9.;
run;
