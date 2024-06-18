filename itunes 'iTunes Music Library.xml' encoding='utf-8';

data _null_;
  infile itunes;
  input;
  if index(_infile_, '<key>Tracks</key>') then call symput('start', _n_);
  if index(_infile_, '<key>Playlists</key>') then call symput('stop', _n_);
run;

data music( drop=_: kind play_date persistent_id--Composer sort_: );
  format
    Track_ID 8.
    Name $50.
    Artist $30.
    Album $50.
    Genre $15.
    Kind $25.
    Size 8.
    Start_Time
    Stop_Time
    Total_Time time.
    Disc_Number
    Disc_Count
    Track_Number
    Track_Count
    Artwork_Count
    Rating
    BPM
    Year 8.
    Date_Modified
    Date_Added datetime19.
    Bit_Rate
    Sample_Rate
    Play_Count 8.
    Play_Date 16.
    Play_Date_UTC datetime19.
    Persistent_ID $20.
    Track_Type $8.
    Location $250.
    File_Folder_Count
    Library_Folder_Count 8.
    Sort_Artist
    Sort_Album
    Sort_Name
    Sort_Composer
    Sort_Album_Artist
    Grouping
    Album_Artist
    Composer
    Comments $50.
    Release_Date datetime19.
    Volume_Adjustment 8.
    ;
  retain Track_ID--sort_name;

  if _n_ = 1 then do;
    __re = prxparse("/.*\<(.+)\>(.*)\<\/.*\>\<.+\>(.*)\<\/.*\>/");
    retain __re;
  end;

  infile itunes firstobs=&start obs=&stop; input;

  if prxmatch("/.*\<dict\>/", _infile_) then do;
    call missing(Track_ID);
    call missing(Name);
    call missing(Artist);
    call missing(Album);
    call missing(Genre);
    call missing(Kind);
    call missing(Size);
    call missing(Start_Time);
    call missing(Stop_Time);
    call missing(Total_Time);
    call missing(Disc_Number);
    call missing(Disc_Count);
    call missing(Track_Number);
    call missing(Track_Count);
    call missing(Artwork_Count);
    call missing(Rating);
    call missing(BPM);
    call missing(Year);
    call missing(Date_Modified);
    call missing(Date_Added);
    call missing(Bit_Rate);
    call missing(Sample_Rate);
    call missing(Play_Count);
    call missing(Play_Date);
    call missing(Play_Date_UTC);
    call missing(Persistent_ID);
    call missing(Track_Type);
    call missing(Location);
    call missing(File_Folder_Count);
    call missing(Library_Folder_Count);
    call missing(Sort_Artist);
    call missing(Sort_Album);
    call missing(Sort_Name);
    call missing(Sort_Composer);
    call missing(Sort_Album_Artist);
    call missing(Grouping);
    call missing(Album_Artist);
    call missing(Composer);
    call missing(Comments);
    call missing(Release_Date);
    call missing(Volume_Adjustment);
    call missing(_lost);
    delete;
  end;

  if prxmatch(__re, _infile_) then do;
    select (prxposn(__re, 2, _infile_));
      when ('Track ID')             Track_ID            = input(prxposn(__re, 3, _infile_),8.);
      when ('Name')                 Name                =       prxposn(__re, 3, _infile_);
      when ('Artist')               Artist              =       prxposn(__re, 3, _infile_);
      when ('Album')                Album               =       prxposn(__re, 3, _infile_);
      when ('Genre')                Genre               =       prxposn(__re, 3, _infile_);
      when ('Kind')                 Kind                =       prxposn(__re, 3, _infile_);
      when ('Size')                 Size                = input(prxposn(__re, 3, _infile_),8.);
      when ('Start Time')           Start_Time          = input(prxposn(__re, 3, _infile_),8.)/1000;
      when ('Stop Time')            Stop_Time           = input(prxposn(__re, 3, _infile_),8.)/1000;
      when ('Total Time')           Total_Time          = input(prxposn(__re, 3, _infile_),8.)/1000;
      when ('Disc Number')          Disc_Number         = input(prxposn(__re, 3, _infile_),8.);
      when ('Disc Count')           Disc_Count          = input(prxposn(__re, 3, _infile_),8.);
      when ('Track Number')         Track_Number        = input(prxposn(__re, 3, _infile_),8.);
      when ('Track Count')          Track_Count         = input(prxposn(__re, 3, _infile_),8.);
      when ('Artwork Count')        Artwork_Count       = input(prxposn(__re, 3, _infile_),8.);
      when ('Rating')               Rating              = input(prxposn(__re, 3, _infile_),8.);
      when ('BPM')                  BPM                 = input(prxposn(__re, 3, _infile_),8.);
      when ('Year')                 Year                = input(prxposn(__re, 3, _infile_),8.);
      when ('Date Modified')        Date_Modified       = input(prxposn(__re, 3, _infile_),anydtdtm.);
      when ('Date Added')           Date_Added          = input(prxposn(__re, 3, _infile_),anydtdtm.);
      when ('Bit Rate')             Bit_Rate            = input(prxposn(__re, 3, _infile_),8.);
      when ('Sample Rate')          Sample_Rate         = input(prxposn(__re, 3, _infile_),8.);
      when ('Play Count')           Play_Count          = input(prxposn(__re, 3, _infile_),8.);
      when ('Play Date')            Play_Date           = input(prxposn(__re, 3, _infile_),8.);
      when ('Play Date UTC')        Play_Date_UTC       = input(prxposn(__re, 3, _infile_),anydtdtm.);
      when ('Persistent ID')        Persistent_ID       =       prxposn(__re, 3, _infile_);
      when ('Track Type')           Track_Type          =       prxposn(__re, 3, _infile_);
      when ('Location')             Location            =       prxposn(__re, 3, _infile_);
      when ('File Folder Count')    File_Folder_Count   = input(prxposn(__re, 3, _infile_),8.);
      when ('Library Folder Count') Library_Folder_Count= input(prxposn(__re, 3, _infile_),8.);
      when ('Sort Artist')          Sort_Artist         =       prxposn(__re, 3, _infile_);
      when ('Sort Album')           Sort_Album          =       prxposn(__re, 3, _infile_);
      when ('Sort Name')            Sort_Name           =       prxposn(__re, 3, _infile_);
      when ('Sort Composer')        Sort_Composer       =       prxposn(__re, 3, _infile_);
      when ('Sort Album Artist')    Sort_Album_Artist   =       prxposn(__re, 3, _infile_);
      when ('Grouping')             Grouping            =       prxposn(__re, 3, _infile_);
      when ('Album Artist')         Album_Artist        =       prxposn(__re, 3, _infile_);
      when ('Composer')             Composer            =       prxposn(__re, 3, _infile_);
      when ('Comments')             Comments            =       prxposn(__re, 3, _infile_);
      when ('Release Date')         Release_Date        = input(prxposn(__re, 3, _infile_),anydtdtm.);
      when ('Volume Adjustment')    Volume_Adjustment   = input(prxposn(__re, 3, _infile_),8.);
      otherwise put _infile_;
      end;
    end;

  if prxmatch("/.*\<\/dict\>/", _infile_) then do;
    output;
    delete;
  end;
run;
proc sort data=music;
  by artist album disc_number track_number;
run;
