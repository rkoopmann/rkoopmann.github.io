---
date: 2021-12-16
---

1. Browse to website and copy/paste csv into an editor. Append additional months as season progresses.
2. In shell, prepare data. This really means replicate each dataline and swap the home team & points scored with the away team & points scored. In the end, each game should have two records.

```bash
awk -F, '{OFS=",";print $1,$2,$3,$4,$5,$6,$7,$8,$9,$10"
"$1,$2,$5,$6,$3,$4,$7,$8,$9,$10}' nba.csv | grep -v 'PTS,Visitor' > nba2.csv
```
3. Load data into DataGraph.
4. Get creative & have fun.

https://www.basketball-reference.com/leagues/NBA_2022_games-december.html

