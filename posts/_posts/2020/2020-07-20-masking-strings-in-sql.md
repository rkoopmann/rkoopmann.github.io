---
layout: post
title: a function to mask strings
tags:
- function
- sql
categories: post
---

here's a handy function to mask strings while retaining _some_ useful metadata. this is helpful in identifying patterns in identifiers.

```sql
CREATE TEMPORARY FUNCTION mask_string(str STRING, n INT64) AS (
  -- keep first n characters of a string, mask remaining characters
  CASE
    WHEN REGEXP_CONTAINS(TRIM(str), r'^[0-9-]{8,}$') -- only digits
    THEN CONCAT(TRIM(SUBSTR(str, 1, n)), REGEXP_REPLACE(TRIM(SUBSTR(str,n+1)),r'[0-9]', '#'))
    WHEN REGEXP_CONTAINS(TRIM(str), r'^[a-zA-Z-]{8,}$') -- only letters
    THEN CONCAT(TRIM(SUBSTR(str, 1, n)),REGEXP_REPLACE(TRIM(SUBSTR(str,n+1)),r'[a-zA-Z]', '@'))
    WHEN REGEXP_CONTAINS(TRIM(str), r'^[a-fA-F0-9-]{8,}$') -- hex-like strings
    THEN CONCAT(TRIM(SUBSTR(str, 1, n)),REGEXP_REPLACE(TRIM(SUBSTR(str,n+1)),r'[a-fA-F0-9]', '⨳'))
    ELSE CONCAT(TRIM(SUBSTR(str, 1, n)),REGEXP_REPLACE(TRIM(SUBSTR(str,n+1)),r'.', '*'))
  END
);
```

We can see this in action by generating some fake identifiers.

```sql
SELECT NUMERIC_ID , mask_string(NUMERIC_ID, 1) AS masked_NUMBERID_ID_1,
  HEX_ID, mask_string(HEX_ID, 0) AS masked_HEX_ID_0, mask_string(HEX_ID, 2) AS masked_HEX_ID_2,
  MESSY_ID , mask_string(MESSY_ID, 1) AS masked_MESSY_ID_1
FROM ( -- fake some data
  SELECT
    SUBSTR(FORMAT("%17.15f", RAND()), 3) AS NUMERIC_ID ,
    SUBSTR(GENERATE_UUID(), 15) AS HEX_ID ,
    TO_BASE64(SUBSTR(SHA256(FORMAT("%17.15f", RAND())), 15)) AS MESSY_ID
  FROM ( -- get 10 records
    SELECT x FROM UNNEST(GENERATE_ARRAY(1,10)) x
  )
)
;
```

And the results. Notice the 5th result for `MESSY_ID` is all-letters, so it unfortunately gets the all-letter treatment.

|   NUMERIC_ID    | masked_NUMBERID_ID_1 |         HEX_ID         |     masked_HEX_ID_0    |     masked_HEX_ID_2    |         MESSY_ID         |     masked_MESSY_ID_1    |
| :-------------: | :------------------: | :--------------------: | :--------------------: | :--------------------: | :----------------------: | :----------------------: |
| 321955549450509 |    3##############   | 429c-970a-066bfdc17fa4 | ⨳⨳⨳⨳-⨳⨳⨳⨳-⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳ | 42⨳⨳-⨳⨳⨳⨳-⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳ | ihF5HMlhwbTR4I1GzBYyXpuZ | i*********************** |
| 092285814003594 |    0##############   | 4364-89ea-148cd4891a9f | ⨳⨳⨳⨳-⨳⨳⨳⨳-⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳ | 43⨳⨳-⨳⨳⨳⨳-⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳ | qqCJAV2tyEx/Rl/gqutED5A8 | q*********************** |
| 721307759069463 |    7##############   | 4780-bca6-ee3999c7a391 | ⨳⨳⨳⨳-⨳⨳⨳⨳-⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳ | 47⨳⨳-⨳⨳⨳⨳-⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳ | 7QEo+6y/wxMxwhtU1NoFcUVL | 7*********************** |
| 195911564152664 |    1##############   | 4d55-b870-3433e43100b8 | ⨳⨳⨳⨳-⨳⨳⨳⨳-⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳ | 4d⨳⨳-⨳⨳⨳⨳-⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳ | EoQTEkXSwD+ElwZ5pq7h+vSo | E*********************** |
| 395125327917730 |    3##############   | 4e11-b5af-7d83b2247273 | ⨳⨳⨳⨳-⨳⨳⨳⨳-⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳ | 4e⨳⨳-⨳⨳⨳⨳-⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳ | ydnPKSZIkFCDeSYGJIabZwRo | y@@@@@@@@@@@@@@@@@@@@@@@ |
| 240142410689042 |    2##############   | 4ea0-9e0b-dc8a2b818605 | ⨳⨳⨳⨳-⨳⨳⨳⨳-⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳ | 4e⨳⨳-⨳⨳⨳⨳-⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳ | 9exU7igSR1MmyRkHHGy1Tkap | 9*********************** |
| 924742093246825 |    9##############   | 4a27-b440-629f23283b94 | ⨳⨳⨳⨳-⨳⨳⨳⨳-⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳ | 4a⨳⨳-⨳⨳⨳⨳-⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳ | WmfYNaFow4xiUmPPqiA/5/mB | W*********************** |
| 208147183726515 |    2##############   | 4cfc-8d05-c43cb9a720fd | ⨳⨳⨳⨳-⨳⨳⨳⨳-⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳ | 4c⨳⨳-⨳⨳⨳⨳-⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳ | KMeTzPpJmR6ZZbqtX1r8s1JK | K*********************** |
| 138648685501020 |    1##############   | 4b45-baf4-2602996a523a | ⨳⨳⨳⨳-⨳⨳⨳⨳-⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳ | 4b⨳⨳-⨳⨳⨳⨳-⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳ | Z8DV26m9QAOY/cWs6L5QDpOu | Z*********************** |
| 618787412556747 |    6##############   | 439c-b218-6ba5d73e7c48 | ⨳⨳⨳⨳-⨳⨳⨳⨳-⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳ | 43⨳⨳-⨳⨳⨳⨳-⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳ | fCiXlZDCzM7suA1xKZS6515x | f*********************** |


Extending this a bit to provide some view of aggregations:

```sql
SELECT mask_string(NUMERIC_ID, 1) AS PATTERN , COUNT(1) AS N
FROM (
  SELECT
    SUBSTR(FORMAT("%17.15f", RAND()), 3) AS NUMERIC_ID ,
    SUBSTR(GENERATE_UUID(), 15) AS HEX_ID ,
    TO_BASE64(SUBSTR(SHA256(FORMAT("%17.15f", RAND())), 15)) AS MESSY_ID
  FROM (
    SELECT x FROM UNNEST(GENERATE_ARRAY(1,100000)) x
  )
)
GROUP BY 1
ORDER BY 1
;
```

|     PATTERN     |     N |
| :-------------: | ----: |
| 0############## |  9949 |
| 1############## | 10005 |
| 2############## |  9999 |
| 3############## | 10020 |
| 4############## | 10087 |
| 5############## | 10003 |
| 6############## |  9996 |
| 7############## | 10053 |
| 8############## | 10050 |
| 9############## |  9838 |

Masking all but the first 2 characters of `MESSY_ID` yields a 4,697-long table:

|         PATTERN          |   N |
| :----------------------: | --: |
| ++********************** |  30 |
| +/********************** |  26 |
| +0********************** |  32 |
| +1********************** |  18 |
| +2********************** |  28 |
|           ...            | ... |

This type of aggregation is useful when comparing overlapping and non-overlapping identifiers across disparate data sources to help narrow down what a "good" identifier looks like vs. the noise. For example:

| ID_LENGTH | ID_PATTERN                                                       | IN_DATA1_CNT |        IN_DATA1_PCT | IN_BOTH_CNT |         IN_DATA2_PCT | IN_DATA2_CNT |
| --------: | :--------------------------------------------------------------- | -----------: | ------------------: | ----------: | -------------------: | -----------: |
|         8 | ########                                                         |       321547 |  0.9814117376308906 |      315570 |   0.8179859975271456 |       385789 |
|         4 | ****                                                             |          202 |  0.6683168316831684 |         135 | 0.051350323316850514 |         2629 |
|         5 | *****                                                            |         1935 |  0.6217054263565891 |        1203 |  0.04688230709275137 |        25660 |
|         6 | ******                                                           |        19923 |   0.635546855393264 |       12662 | 0.048300959763187205 |       262148 |
|         7 | *******                                                          |       158119 |  0.5859574118227411 |       92651 |  0.04273678529667496 |      2167945 |
|         8 | ########                                                         |      4965619 |   0.262163488580175 |     1301804 |  0.09105307969763868 |     14297199 |
|         9 | #########                                                        |        55422 | 0.33896286673162285 |       18786 | 0.048430756856254545 |       387894 |
|        64 | ⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳⨳ |       495494 | 0.25489713296225586 |      126300 |  0.09994579345327356 |      1263685 |
