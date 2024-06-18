---
layout: post
title: Scraping the SAS Training Pages
category: sas
tags:
- regex
- web scraping
---

i thought it might be fun to see if i couldn’t pull the sas training catalog and corresponding schedules into a sas data set. easy enough, right?

<!--more-->

**Hello [SAS Tech Report](http://www.sas.com/news/newsletter/tech/2009_4.html) readers!** *be sure to check out the rest of [this blog](/) <s>and accompanying project</s>. you can [follow this blog via your rss reader](/feed.json) and <s>follow me on twitter</s>. now back to the post…*

**UPDATE:** *it turns out that SAS has changed some things on their training site that affects the parsing of individual course schedules. they’ve apparently eliminated the directory for the print versions of the schedules. i’ll look into modifying the code when i find some free time. now back to the post…*

sas puts this information online in two places: the [course listing](http://support.sas.com/training/us/crs/) and individual course outline pages (for example, [SAS Report Writing 1: Using Procedures and ODS](http://support.sas.com/training/us/crs/pr/rpt1.html)).

first step: get the catalog.

    filename Courses url "http://support.sas.com/training/us/crs/" lrecl=1000;

    data SAS_Catalog(drop=re_: course_flags i);
        infile Courses scanover;
        format Course_Code $10. Course_Desc $200. Schedule New SAS8 SAS9 LW BKS SGF 4.;
        retain re_course re_bks re_new re_s9 re_s8 re_lw re_sgf re_schedule Schedule--sgf;
        if _n_=1 then do;
            re_course=prxparse('/<td class="newstext"><a href="\/training\/us\/crs\/(.*).html">(.*)<\/a>(.*)<\/td>/');
            re_new = prxparse('/<img src="\/training\/images\/new2.gif" width=44 height=14 alt="New" border=0>/');
            re_s8  = prxparse('/<span class="colorit">V8<\/span>/');
            re_s9  = prxparse('/<img src="\/training\/images\/sas9sm.gif" width=26 height=14 alt="SAS 9" border=0>/');
            re_lw  = prxparse('/<span class="lw"><nobr>Live Web<\/nobr><\/span>/');
            re_bks = prxparse('/<span class="bks">BKS<\/span>/');
            re_sgf = prxparse('/<img src="\/training\/images\/sgf_icon.gif" width=100 height=14 border=0 alt="SAS Global Forum">/');

            re_schedule=prxparse('/<td class="newstext"><a href="http.*\?course_code=(.*)&ctry=us">schedule<\/a>.*<\/td>/');
        end;
        input;
        if prxmatch(re_course, _infile_) then do;
            course_code = prxposn(re_course, 1, _infile_);
            course_desc = prxposn(re_course, 2, _infile_);
            course_flags= prxposn(re_course, 3, _infile_);
            if course_flags ne ' ' then do;
                New = (prxmatch(re_new, course_flags) ne 0);
                SAS8= (prxmatch(re_s8 , course_flags) ne 0);
                SAS9= (prxmatch(re_s9 , course_flags) ne 0);
                LW  = (prxmatch(re_lw , course_flags) ne 0);
                BKS = (prxmatch(re_bks, course_flags) ne 0);
                SGF = (prxmatch(re_sgf, course_flags) ne 0);
                if sum(of new--sgf) le 0 then put course_code;
            end;
        end;
        else if prxmatch(re_schedule, _infile_) then do;
            course_code = prxposn(re_schedule, 1, _infile_);
            Schedule = 1;
            return;
        end;
        else do;
            array t(*) Schedule New SAS8 SAS9 LW BKS SGF;
            do i = 1 to dim(t);
                t[i] = 0;
            end;
            delete;
        end;
        output;
    run;

    filename Courses clear;

    proc sort data=SAS_Catalog; by course_code; run;

step two: set up a macro for processing individual course outline pages.

    %macro getSchedule(COURSE_CODE);
    filename schedule url "http://support.sas.com/training/us/crs/pr/&COURSE_CODE..html" lrecl=1500;
    data _schedule_ (drop=re_: offer1-offer3 duration_course duration_liveweb);
      format Course_Code $10. Location $200. Start date9. Duration CEU 4.1 offer1-offer3 $1000.;
      infile schedule scanover;
      retain Course_Code re_offering re_duration re_br location start duration_course duration_liveweb ceu;
      if _n_ = 1 then do;
          course_code = "&COURSE_CODE";
          re_duration=prxparse('/<p class="newstext">((Classroom )?[Dd]uration: (\d\.\d|\d) day(s)? )?( )*((Live Web d|D)uration: (\d\.\d|\d) half-day session(s)? )?( )*CEU: (\d\.\d|\d) <\/p>/');
          re_offering=prxparse('/<tr valign="top"><td class="newstext">(.*)<\/td><td class="newstext">(.*)<\/td><td class="newstext">(.*)<\/td><\/tr>/');
          re_br      =prxparse('/(\d\d\w\w\w\d\d\d\d)\s+([A-Za-z,\.\s]*)<br>(.*)/');
          end;
      input;
      if prxmatch(re_duration, _infile_) then do;
          duration_course   = input(prxposn(re_duration, 3, _infile_), 4.);
          duration_liveweb  = input(prxposn(re_duration, 8, _infile_), 4.);
          ceu               = input(prxposn(re_duration, 11, _infile_), 4.);
          return;
          end;
      if prxmatch(re_offering, _infile_) then do;
          offer1 = prxposn(re_offering, 1, _infile_);
          do while (prxmatch(re_br, offer1));
              Start   =input(prxposn(re_br, 1, offer1), date9.);
              Location=prxposn(re_br, 2, offer1);
              if location eq 'Live Web,' then duration = duration_liveweb;
                                         else duration = duration_course;
              offer1  =prxposn(re_br, 3, offer1);
              output;
              end;
          offer2 = prxposn(re_offering, 2, _infile_);
          do while (prxmatch(re_br, offer2));
              Start   =input(prxposn(re_br, 1, offer2), date9.);
              Location=prxposn(re_br, 2, offer2);
              if location eq 'Live Web,' then duration = duration_liveweb;
                                         else duration = duration_course;
              offer2  =prxposn(re_br, 3, offer2);
              output;
              end;
          offer3 = prxposn(re_offering, 3, _infile_);
          do while (prxmatch(re_br, offer3));
              Start   =input(prxposn(re_br, 1, offer3), date9.);
              Location=prxposn(re_br, 2, offer3);
              if location eq 'Live Web,' then duration = duration_liveweb;
                                         else duration = duration_course;
              offer3  =prxposn(re_br, 3, offer3);
              output;
              end;
          end;
      else delete;
    run;
    filename schedule clear;
    proc append base=SAS_Schedule data=_schedule_ force; run;
    proc datasets library=work nodetails nolist; delete _schedule_; run; quit;
    %mend;

finally, cycle through each course that has a schedule available.

    proc datasets library=work nodetails nolist;
      delete sas_schedule;
      run;
    quit;
    data _null_;
      set SAS_Catalog;
      where schedule;
      calltext = cats('%getSchedule(', course_code, ');');
      call execute(calltext);
    run;

    proc sql;
      create table SAS_Training as
      select distinct c.*, s.*
      from sas_catalog as c
      left join sas_schedule as s
        on c.course_code=s.course_code
      order by course_desc, location, start
      ;
    quit;

see? it was easy. oh, the file can be downloaded [here](/assets/sas/sas-training.sas).
