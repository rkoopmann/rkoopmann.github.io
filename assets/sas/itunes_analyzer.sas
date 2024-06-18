x 'cd U:\sas\fun\';
%inc 'itunes.sas';

proc sql;
  create table artist_album as
  select distinct
    artist
  , album
  , count(*) as Tracks
  , sum(total_time) as Total_Length format=time.
  , sum(play_count) as Total_Plays
  , avg(Rating) as Average_Rating format=3.
  , (calculated total_plays / calculated Tracks) as Plays_per_track format=5.2
  from music
  group by artist, album
  having (tracks ge 5 or total_length ge '00:20:00't) and total_plays gt 0
  order by calculated plays_per_track desc
  ;
quit;
