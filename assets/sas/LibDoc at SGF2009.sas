%macro LibDoc(
  libname
, path=C:\temp
, file=&LIBNAME.
, chm=NO
, html=&CHM
, pdf=NO
, style=minimal
);

%let libname = %upcase(&LIBNAME);

%if &LIBNAME eq HELP or &LIBNAME eq %str( ) %then %do;
%put ***********************************************************************************;
%put * LIBDOC documents a SAS library to an Excel workbook.                            *;
%put ***********************************************************************************;
%put * Positional Parameters (in this order):                                          *;
%put *  LIBRARY   The LIBRARY to docunent.                                             *;
%put *                                                                                 *;
%put * Optional Keyword Parameters (in any order):                                     *;
%put *  PATH      Path to save the Excel workbook. Defaults to H drive of user.        *;
%put *            This MUST be a fully qualified network directory--no local drives.   *;
%put *  FILE      File to save the Excel workbook. Defaults to H drive of user.        *;
%put *            This MUST be a fully qualified network directory--no local drives.   *;
%put *  CHM       Optionally compile CHM file from HTML files. Defaults to NO.         *;
%put *  HTML      Optionally create set of HTML files. Defaults to &CHM.               *;
%put *  PDF       Optionally a PDF file. Defaults to NO.                               *;
%put *  STYLE     Specify a style for optional output destinations. Defaults to minimal*;
%put ***********************************************************************************;
%put * Example macro call                                                              *;
%put *  LibDoc( WORK, path=C:\temp, file=myWork)                                       *;
%put ***********************************************************************************;
%goto ByeBye;
%end;

%else %if &LIBNAME eq EDIT %then %do; /* location of LibDoc macro source file */
dm wedit 'whostedit "\\mspfile02\MPLSData\sas\macros\LibDoc.sas"';
%goto ByeBye;
%end;

x "if exist ""&PATH.\&FILE..xls"" del ""&PATH.\&FILE..xls""";
libname ld excel "&PATH.\&FILE..xls";


/*********************************************************************************\
fetch library metadata.
\*********************************************************************************/;
proc sql;
  create table ld.libnames(drop=libname)  as select *
  from dictionary.libnames  where libname="&LIBNAME";
  create table ld.tables(drop=libname)    as select *
  from dictionary.tables    where libname="&LIBNAME";
  create table ld.views(drop=libname)     as select *
  from dictionary.views     where libname="&LIBNAME";
  create table ld.indexes(drop=libname)   as select *
  from dictionary.indexes   where libname="&LIBNAME";
  create table ld.columns(drop=libname)   as select *
  from dictionary.columns   where libname="&LIBNAME";
  create table ld.catalogs(drop=libname)  as select *
  from dictionary.catalogs  where libname="&LIBNAME";
  create table ld.members(drop=libname)   as select *
  from dictionary.members   where libname="&LIBNAME";
  create table ld.formats(drop=libname)   as select *
  from dictionary.formats   where libname="&LIBNAME";
quit;
proc format cntlout=fmtdefs library=&LIBNAME; run;
/*the excel engine doesn't appreciate numeric variables with length < 8*/
proc sql;
  create table ld.format_definitions as
  select FMTNAME, START, END, LABEL, 
  MIN length=8
, MAX length=8
, DEFAULT length=8
, LENGTH length=8
, FUZZ, PREFIX, MULT, FILL
, NOEDIT length=8
, TYPE, SEXCL, EEXCL, HLO, DECSEP, DIG3SEP, DATATYPE, LANGUAGE
  from fmtdefs;
quit;


%if "&HTML" ne "NO" OR "&PDF" ne "NO" %then %do;
/*********************************************************************************\
if a table has 0 obervations, insert 1; otherwise, 1:1 copy.
\*********************************************************************************/;
data ld_libnames; if _obs_=0 then output; set ld.libnames  nobs=_obs_; output; run;
data ld_tables;   if _obs_=0 then output; set ld.tables    nobs=_obs_; output; run;
data ld_views;    if _obs_=0 then output; set ld.views     nobs=_obs_; output; run;
data ld_indexes;  if _obs_=0 then output; set ld.indexes   nobs=_obs_; output; run;
data ld_columns;  if _obs_=0 then output; set ld.columns   nobs=_obs_; output; run;
data ld_catalogs; if _obs_=0 then output; set ld.catalogs  nobs=_obs_; output; run;
data ld_members;  if _obs_=0 then output; set ld.members   nobs=_obs_; output; run;
data ld_formats;  if _obs_=0 then output; set ld.formats   nobs=_obs_; output; run;
data ld_format_definitions; 
                  if _obs_=0 then output; set ld.format_definitions
                                                           nobs=_obs_; output; run;


/*********************************************************************************\
generate the desired output.
variables listed on the ID statement help uniquely identify rows.
\*********************************************************************************/;
ods listing close;
ods noproctitle;
option orientation=landscape;
%if "&PDF" ne "NO" %then ods pdf file="&PATH.\&FILE..pdf" style=&style uniform fontscale=80;;

ods html file="&PATH.\&FILE.libnames.html" (title="libnames") style=&style;
ods proclabel 'Libnames';
proc print data=ld_libnames contents=""; id path level; run;
ods html close;

ods proclabel 'Members';
ods html file="&PATH.\&FILE.members.html" (title="members") style=&style;
proc print data=ld_members contents=""; id memname memtype; run;
ods html close;

ods proclabel 'Tables';
ods html file="&PATH.\&FILE.tables.html" (title="tables") style=&style;
proc print data=ld_tables contents=""; id memname memtype; run;
ods html close;

ods proclabel 'Columns';
ods html file="&PATH.\&FILE.columns.html" (title="columns") style=&style;
proc print data=ld_columns contents=""; id memname memtype name; run;
ods html close;

ods proclabel 'Indexes';
ods html file="&PATH.\&FILE.indexes.html" (title="indexes") style=&style;
proc print data=ld_indexes contents=""; id memname name indxname; run;
ods html close;

ods proclabel 'Views';
ods html file="&PATH.\&FILE.views.html" (title="views") style=&style;
proc print data=ld_views contents=""; id memname; run;
ods html close;

ods proclabel 'Catalogs';
ods html file="&PATH.\&FILE.catalogs.html" (title="catalogs") style=&style;
proc print data=ld_catalogs contents=""; id memname objname objtype; run;
ods html close;

ods proclabel 'Formats';
ods html file="&PATH.\&FILE.formats.html" (title="formats") style=&style;
proc print data=ld_formats contents=""; id memname path objname fmtname fmttype; run;
ods html close;

ods proclabel 'Format Definitions';
ods html file="&PATH.\&FILE.format_definitions.html" (title="format definitions") style=&style;
proc print data=ld_format_definitions contents=""; id fmtname; run;
ods html close;


%if "&PDF" ne "NO" %then ods pdf close;;
option orientation=portrait;
ods proctitle;
ods listing;
%end;

libname ld excel clear;

%if "&CHM" ne "NO" %then %do;
data _null_;
file "&PATH.\&FILE..hhp";
put '[OPTIONS]';
put 'Compatibility=1.1 or later';
put "Compiled file=&FILE..chm";
put "Contents file=&FILE..hhc";
put "Default topic=&FILE.libnames.HTML";
put 'Display compile progress=No';
put 'Language=0x409 English (United States)';
put "Title=&LIBNAME as of &SYSDATE9 - LibDoc";
put ;
put '[FILES]';
put "&FILE.catalogs.HTML";
put "&FILE.columns.HTML";
put "&FILE.formats.HTML";
put "&FILE.format_definitions.HTML";
put "&FILE.indexes.HTML";
put "&FILE.libnames.HTML";
put "&FILE.members.HTML";
put "&FILE.tables.HTML";
put "&FILE.views.HTML";
put ;
put '[INFOTYPES]';
put ;
run;

data _null_;
file "&PATH.\&FILE..hhc";
put "<!DOCTYPE HTML PUBLIC ""-//IETF//DTD HTML//EN"">";
put "<HTML><HEAD>";
put "<!-- Sitemap 1.0 -->";
put "</HEAD><BODY>";
put "<OBJECT type=""text/site properties"">";
put "<param name=""ImageType"" value=""Folder"">";
put "</OBJECT>";
put "<UL>";
put "<LI><OBJECT type=""text/sitemap""><param name=""Name"" value=""Library"">";
put     "<param name=""Local"" value=""&FILE.libnames.HTML""></OBJECT>";
put "<LI><OBJECT type=""text/sitemap""><param name=""Name"" value=""Members"">";
put     "<param name=""Local"" value=""&FILE.members.HTML""></OBJECT>";
put "<LI><OBJECT type=""text/sitemap""><param name=""Name"" value=""Tables"">";
put     "<param name=""Local"" value=""&FILE.tables.HTML""></OBJECT>";
put "<UL>";
put "<LI><OBJECT type=""text/sitemap""><param name=""Name"" value=""Columns"">";
put     "<param name=""Local"" value=""&FILE.columns.HTML""></OBJECT>";
put "<LI><OBJECT type=""text/sitemap""><param name=""Name"" value=""Indexes"">";
put     "<param name=""Local"" value=""&FILE.indexes.HTML""></OBJECT>";
put "</UL>";
put "<LI><OBJECT type=""text/sitemap""><param name=""Name"" value=""Views"">";
put     "<param name=""Local"" value=""&FILE.views.HTML""></OBJECT>";
put "<LI><OBJECT type=""text/sitemap""><param name=""Name"" value=""Catalogs"">";
put     "<param name=""Local"" value=""&FILE.catalogs.HTML""></OBJECT>";
put "<LI><OBJECT type=""text/sitemap""><param name=""Name"" value=""Formats"">";
put     "<param name=""Local"" value=""&FILE.formats.HTML""></OBJECT>";
put "<UL>";
put "<LI><OBJECT type=""text/sitemap""><param name=""Name"" value=""Definitions"">";
put     "<param name=""Local"" value=""&FILE.format_definitions.HTML""></OBJECT>";
put "</UL>";
put "</UL>";
put "</BODY></HTML>";
run;

x """C:\Program Files\HTML Help Workshop\hhc"" ""&PATH.\&FILE..hhp""";
%end;

proc datasets library=work nodetails nolist; delete ld_:; run; quit;

%ByeBye:
%mend;
