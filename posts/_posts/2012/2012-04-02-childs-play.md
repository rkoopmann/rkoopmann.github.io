---
layout: post
title: simulating child's play
category: sas
tags:
- array
- do loop
- sas
- simulation
---

as of late, the kids are enjoying simple, pre-risk board games. of these, i prefer chutes and ladders. for the most part, there's no skill involved: you spin, you count, and maybe slide but hopefully climb. there's no strategy involved. you just take what you get and hope to avoid the chutes. but i've been hesitant to start a game too close to bedtime (since it is essentially a game of luck, you could theoretically get stuck in a chute-ladder loop making no progress to the goal).

that got me wondering about the length of a 'regular' game.

<!--more-->

since the game is essentially a game of chance (the haven't mastered the art of 'light' spins), it's pretty easy to simulate in SAS.

the first step was to create a 100-element array for the lookups (that's one element for each position on the board). for this array, the index serves as the 'landing' position, and the value is the 'destination' position. if the index matches the value, there is no chute or ladder to worry about. if the index is greater than the position, you've landed at the base of a ladder; if the index is less than the position, you've landed at the start of a chute.

next, i simulate 1,000,000 games with up to 250 turns. all games start at index 0 (that is, the first spin will get them on the board) and are trying to end up on index 100 (without overshooting). the math is pretty easy: take your starting position and add the spin value to determine the landing value. then, check against the `cl` array for any climbing or sliding needed before ending at the destination.

here's my code:

    data ChutesAndLadders;

        format Game Turn Start Spin Land End 4.;

        *** set up the wormhole array ***;
        *** if cl[i] ne i, then a wormhole ***;
        array cl(100) _temporary_ (
            38,  2,  3, 14,  5,  6,  7,  8, 31, 10,
            11, 12, 13, 14, 15,  6, 17, 18, 19, 20,
            42, 22, 23, 24, 25, 26, 27, 84, 29, 30,
            31, 32, 33, 34, 35, 44, 37, 38, 39, 40,
            41, 42, 43, 44, 45, 46, 47, 26, 11, 50,
            67, 52, 53, 54, 55, 53, 57, 58, 59, 60,
            61, 19, 63, 60, 65, 66, 67, 68, 69, 70,
            91, 72, 73, 74, 75, 76, 77, 78, 79,100,
            81, 82, 83, 84, 85, 86, 24, 88, 89, 90,
            91, 92, 73, 94, 75, 96, 97, 78, 99,100);

        do game = 1 to 1000000;
            GameOver=0;
            do turn = 1 to 250 until (GameOver=1);
                *** all games start at 0 ***;
                if turn = 1 then do;
                    Start = 0;
                    Spin = 0;
                    Land = 0;
                    End = 0;
                end;

                *** starts where ended last turn ***;
                Start = End;

                *** spin the thing ***;
                Spin = ceil(ranuni(8675309)*6);

                *** last spin must be EXACTLY 100 ***;
                if Start + Spin &gt; 100 then Spin = 0;

                *** landing spot (pre-wormhole)***;
                Land = Start + Spin;

                *** destination (post-wormhole) ***;
                End = cl[Land];

                *** game over? ***;
                if End = 100 then GameOver=1;
                output;
            end;
        end;
        drop GameOver;
    run;

a quick `proc univariate` shows the following:

    Variable:  Turn

                                Moments

    N                      999896    Sum Weights             999896
    Mean                39.576811    Sum Observations      39572695
    Std Deviation      25.5080205    Variance            650.659108
    Skewness           1.78522598    Kurtosis             4.7663735
    Uncorrected SS     2216751859    Corrected SS         650590789
    Coeff Variation    64.4519349    Std Error Mean      0.02550935


                  Basic Statistical Measures

        Location                    Variability

    Mean     39.57681     Std Deviation           25.50802
    Median   33.00000     Variance               650.65911
    Mode     22.00000     Range                  243.00000
                          Interquartile Range     28.00000


one thing to note is that rarely (104 times out of 1000000 games) it takes a single player more than 250 spins to end on 100. that's a long game. if all 4 players we simultaneously unlucky, that'd be a painfully long game.

**UPDATES**:

- I've spawned off a [GitHub repo](https://github.com/rkoopmann/SASBoredGames). This code can be found in the `\ChutesAndLadders` subdirectory.
- A brief search online yielded [this page](http://www.r-bloggers.com/basics-on-markov-chain-for-parents/) which uses R for simulation and analysis.
