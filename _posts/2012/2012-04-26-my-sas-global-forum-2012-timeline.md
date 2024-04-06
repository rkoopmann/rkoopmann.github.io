---
layout: post
title: My SAS Global Forum 2012 Timeline
category: sas
tags:
- sas
- conference
---

## Monday, April 23 (7 Sessions)

### Technology Connection and Keynote Presentation

> Presenters from SAS R&D offer a look at what's new and techniques to enhance your current use of SAS. In addition to demos, SAS will review the results of this year's SASware Ballot and present the 2012 User Feedback Award, SAS' most prestigious technical award.
>
> Joe Theismann, entrepreneur and former quarterback for the Washington Redskins, will talk about a Game Plan for Success.

<!--more-->

- In database scoring
- Web-based visualization tool like tableau
- Hadoop libname engine
- SAS 12.1 to be out in AUG2012 (Next step from 9.3)
- `PROC FMM` - finite mixture models - experimental in 9.3
- time series data modeling
- Joe Theisman altered pronunciation of last name to rhyme with Heisman Trophy in a failed attempt to win it and he [broke his leg](http://www.youtube.com/watch?v=PHCXNt4P8Xg "ouch")

### [What to Do with a Regular Expression](http://support.sas.com/resources/papers/proceedings12/219-2012.pdf)

> As many know, SAS has provided support for regular expressions for some time now. There are numerous papers that expose the basic concepts as well as some more advanced implementations of regular expressions. The intent of this paper is to narrow the gap between the very beginning and the advanced. In the past you might have solved a programming problem with a combination of SUBSTR/SCAN and other functions. Now a regular expression may be used to greatly reduce the amount of code needed to accomplish the same task. Think of this paper as a recipe or guide book that can be referenced for some real-life examples that will hopefully get you thinking about ways to create your own regular expressions.

- Unexpectedly well-attended (also unexpectedly basic)
- `/i` for case insensitive, but other than that, quite basic


### [Advanced XML Processing with SAS 9.3](http://support.sas.com/resources/papers/proceedings12/220-2012.pdf)


> XML has expanded far beyond the scope originally envisioned by its creators, and this has resulted in the addition of companion standards such as Namespaces in XML and XML Schema. This paper describes how SAS has advanced our XML technology in SAS 9.3 to more fully support these standards. It also examines some of the challenges you might encounter when processing complex XML and describes some best practices to help overcome the challenges.

- nice overview of XML namespaces
- nothing really 'advanced' here


### [Go Beyond the Wizard with Data-Driven Programming](http://support.sas.com/resources/papers/proceedings12/148-2012.pdf)

> Programming techniques that take advantage of Data-Driven Programming will be demonstrated for Novice and Intermediate Users of Base SAS. Most users already take advantage of Data-Driven Programming with wizards. Wizards harvest information through an interface and then write and execute programs based on those parameters. As programmers¶ skills evolve, they may want to edit the product of a wizard in order to confront a variety of problems that a wizard could not anticipate. Going a step further, programmers can author their own wizards that make their own work easier. The workshop will include demonstrations in working with built-in SAS wizards, developing simple Data-Driven Programs, and the use of parameter-gathering techniques using Enhanced Editor, simple macro language, and ODS.

- somewhat basic, but nice workshop for reducing manual steps in a workflows

### 02:45 PM - 02:55 PM [Log Checks Made Easy](http://support.sas.com/resources/papers/proceedings12/042-2012.pdf)

> It is Good Programming Practice (GPP) if a programmer checks SAS log for errors, warnings, and all other objectionable SAS NOTE. In order to successfully create tables, listings, and figures, the programmer must ensure that code is correct, and the accuracy of the code, assuming that the program logic is correct, solely depends on SAS log. Using SAS macro language and Base SAS, this paper will introduce a macro that will enable a programmer or statistician to check all SAS logs in a folder and tabulate the log issues by the name of the SAS log file using PROC REPORT.

- Parse a log file. Possibly useful, but we don't typically save the log files, so…?
- Or maybe it pulls straight for the live log? More interesting now.

### 03:00 PM - 03:10 PM [It's Now Your Project—Clean It Up and Make It Shine](http://support.sas.com/resources/papers/proceedings12/043-2012.pdf)

> Inherited projects may not be well designed. Though a new project owner may not have time to upgrade substandard code immediately, most inherited projects offer plenty of room for improvement. Developing department or company standards and best practices, and then applying these standards and best practices can result in code that is easy to understand, easy to maintain, and easy to transition. The examples in this paper are meant to promote improvements in productivity, consistency, and clarity.

- Guidelines for code. Illustrated via references to poor code and good code examples, but never displayed.
- this would have been the better option, i think

- 03:00 PM - 03:50 PM [Using SAS GTL to Visualize Your Data When There Is Too Much of It to Visualize](http://support.sas.com/resources/papers/proceedings12/262-2012.pdf)

### 04:00 PM - 04:20 PM [A Simple Way to Program Power Calculations](http://support.sas.com/resources/papers/proceedings12/322-2012.pdf)

> We propose a simulation of large sets of statistical power calculations and the selection of those calculations with appropriate power from a long list of study designs. Typical commercial programs complete all but one parameter and solve for the remaining parameter. We avoid solving equations and, thereby, obtain power for atypical designs. For simplicity, we compute the power for the test, comparing two proportions without assuming either an approximate normality or a common variance. We also extend the log-rank test power calculation to account for various patterns of on-study censoring, study duration, and patient recruitment periods. We generate a new approximation for the censoring adjustment. In so doing, we set out an easy way for others to modify our program for other related power calculations

- Suggests generating data set of calculations with permutation of key stats
- Users can then lookup or filter these data sets to ge the answer they want.

### 04:30 PM - 04:50 PM [Quick and Dirty Microsoft Excel Workbooks without Dynamic Data Exchange or the SAS Output Delivery System](http://support.sas.com/resources/papers/proceedings12/264-2012.pdf)

- `Options noxsync;`
- Basic outline of my monthly update process for PROJECT_NAME.
- `=OFFEST()` in Excel.

## Tuesday, April 24 (10 Sessions)

### 08:45 AM - 08:55 AM [Inventory Your Files Using SAS](http://support.sas.com/resources/papers/proceedings12/058-2012.pdf)

> Whether you are attempting to figure out what you have when preparing for a migration or you just want to find out which files or directories are taking up all of your space, SAS is a great tool to inventory and report on the files on your desktop or server. This paper intends to present SAS code to inventory and report on the location you want to inventory.

- search directory for `*.sas` files
- read these files into a SAS data set
- search this data set for keywords
- might be worth the effort

### 09:30 AM - 09:50 AM [Simple Version Control of SAS Programs and SAS Data Sets](http://support.sas.com/resources/papers/proceedings12/365-2012.pdf)

> SAS data sets and programs that reside on a local network are most often stored using a simple file system with no version control, no audit trail of changes, and none of the benefits. In this presentation, we show you how to capitalize on the capabilities of Subversion and other simple, straightforward conventions to provide version control and an audit trail for SAS data sets, standard macro libraries, and programs without changing the SAS environment. Extending the interaction with Subversion using a standard SAS macro is also explored.

- used subversion rather than github.
- would be useful if all analysts used this
- high-ish administrative overhead -- analysts aren't typical Computer Science programmers
- can't be a one-person effort

### 10:00 AM - 10:20 AM [Analyzing Sentiments in Tweets about Wal-Mart's Gender Discrimination Lawsuit Verdict Using SAS Text Miner](http://support.sas.com/resources/papers/proceedings12/306-2012.pdf)

> Social Media has gained considerable attention as a valuable source to monitor customers and public reactions following corporate events. Especially the Tweets posted on Twitter are often used to spot trends, moods, and sentiments of customers and public. Given the huge volume of tweets that gets posted every day, it is extremely difficult for firms to spot current trends related to the public's expressed sentiments about activities of the firm in the tweets. This paper demonstrates the application of a SAS macro (%GetTweet) to collect and summarize tweets and then an application of sentiment analysis on the fetched tweets using SAS Text Miner using directed search and summarization of specific text items.

- despite the name of the session, there was only superficial sentiment analysis done
- sentiment analysis was "planned"
- this would have been the better option, i think

- 10:00 AM - 10:20 AM [Standardized Difference: An Index to Measure the Effect Size between Two Groups](http://support.sas.com/resources/papers/proceedings12/335-2012.pdf)

### 10:30 AM - 10:50 AM [Mix and Match: Diversity in Displaying Data](http://support.sas.com/resources/papers/proceedings12/270-2012.pdf)

> A programmer is often asked to “run some frequencies” or “put together a quick
  report” in order to share results with a group. Just as every scientist has a preferred output style (graph, table, figure, list, etc.) every programmer has a preferred way of getting there. The results of posing this question to five colleagues produced a variety of approaches including the use of PROC MEANS, PROC TABULATE, PROC FREQ, and PROC BOXPLOT as well as visualization techniques in JMP.

- a summary of a survey of how five analysts performed a set of tasks
- only marginally interesting--not really practical

### 11:30 AM - 11:40 AM [Splitting Data Sets on Unique Values: a Macro That Does It All](http://support.sas.com/resources/papers/proceedings12/069-2012.pdf)

> Sometimes it is necessary to split a data set into multiple data sets, depending on the unique values of a variable. After this task was requested several times at the Belastingdienst in the Netherlands, a macro was developed that could split every data set based on a variable. The results are a data set for every unique value of that variable. And, all it took was two DATA steps!

- use distinct value list to generate set of macro variables that are resolved to sub data set names and corresponding select-case output statements
- nice

### 11:45 AM - 11:55 AM [Techniques for Generating Dynamic Code from SAS DICTIONARY Data](http://support.sas.com/resources/papers/proceedings12/070-2012.pdf)

> Integrating the information from SAS DICTIONARY tables into programming helps create dynamic and efficient scripts to manage data sets. The purpose of this paper is to provide such techniques for generating dynamic code from SAS DICTIONARY tables. The author uses three macros to demonstrate how DICTIONARY tables-driven code is dynamically constructed via three approaches: SQL select into macro-variable method, call execute method, and generate-and-include an external file method. These macros manage all data sets at the library level: capitalize all character data, dump all data into an excel file, and query all character data with certain length. Using the basic techniques discussed in the paper, SAS programmers can develop their own dynamic scripts to accomplish other tasks.

- basic

### 01:30 PM - 01:50 PM [Yes! SAS ExcelXP WILL NOT Create a Microsoft Excel Graph, but SAS Users Can Command Microsoft Excel to Automatically Create Graphs from SAS ExcelXP](http://support.sas.com/resources/papers/proceedings12/013-2012.pdf)

> The SAS ODS Tagset ExcelXP creates *.xml output, and *.xml output cannot contain graphs. So how can SAS programmers get graphs into your Excel workbooks? One way is to build them in Excel yourself. This paper shows you how to create data using SAS, and then command Microsoft Excel to read the data, create a graph or fully reformat a worksheet, without putting an Excel macro into the output Excel Workbook. And the program will do it all while you watch, including for multiple sheets in a workbook. The SAS code, and Excel code, shown is a fully integrated system to create and format macro-free Excel workbooks, using SAS 9 (SAS 8 if Internet downloads are available) and Excel 97 and above.

- use VBA macro to update excel workbook
- security warnings/implications
- bad end-user experience

### 02:30 PM - 02:40 PM [A Simple Way of Importing from a REST Web Service into SAS in Three Lines of Code](http://support.sas.com/resources/papers/proceedings12/075-2012.pdf)

> Think old programmers can't learn new tricks? In this paper, I show two neat tricks that combine into something really clever. (1) Our first neat trick is that instead of a path to a file on disk, the filename statement can also accept a URL (via the URL Access Method). (2) Second, the SAS XML Libname Engine (SXLE) can read in a static XML document from a filename statement and turn it into a table. Combining these two, you can have SAS download a dynamically generated XML document, probably produced by a REST web service (which can be built in Java or PHP or .NET; it doesn't matter), and you can do it all in three lines of code.

- such high hopes for this session
- nothing new here, very basic

### 03:30 PM - 04:20 PM [Visualizing Data Techniques, Including Autocharting and Big Data](http://support.sas.com/resources/papers/proceedings12/034-2012.pdf)

> Visualizing data of varying sizes can be challenging. This paper discusses the issues concerning visualizing data and provides suggestions on how to address these issues. The paper assists users who don't know which visualization to use for their data.

- talked about sensible defaults for visualizing different data types
- data viz purity vs. practicality (what <em>should</em> be done vs. what people <em>want to see</em>)

### 04:30 PM - 05:20 PM [Exploratory Factor Analysis with the World Values Survey](http://support.sas.com/resources/papers/proceedings12/331-2012.pdf)

> Exploratory factor analysis (EFA) investigates the possible underlying factor structure (dimensions) of a set of interrelated variables without imposing a preconceived structure on the outcome (Child, 1990). The World Values Survey (WVS) measures changes in what people want out of life and what they believe. WVS helps a worldwide network of social scientists study changing values and their impact on social and political life. This presentation will explore dimensions of selected WVS items using exploratory factor analysis techniques with SAS PROC FACTOR. EFA guidelines and SAS code will be illustrated as well as a discussion of results.

- demonstrated building factors from the data and performing sensible checks
- items should load onto factor at least 0.30
- items should not load onto multiple factors

## Wednesday, April 25 (6 Sessions)

### 08:45 AM - 08:55 AM [Using SAS to Get a Date: Integrating Google Calendar's API with SAS](http://support.sas.com/resources/papers/proceedings12/090-2012.pdf)

> Google offers a powerful API that allows the more analytically and visually powerful SAS to interact with and manipulate calendar data. By combining the ease of Google calendaring with the power of SAS, businesses can operate more efficiently, increase customer satisfaction, and analyze their calendar data in nearly limitless ways. This paper illustrates how SAS can be used to create, modify, and directly interact with Google Calendar data via API calls. Using these calls, it is possible to retrieve available calendars; import all calendar data such as date, time, location, etc.; as well as add, delete, and modify preexisting calendars and their entries. This data can then be analyzed in any number of ways available through the power of SAS.

- cUrl hackery with google calendar

### 09:00 AM - 09:10 AM [Batch Production of Driving Distances and Times Using SAS and Web Map APIs](http://support.sas.com/resources/papers/proceedings12/091-2012.pdf)

> This is a new methodology of using SAS URL access method and Web APIs to run queries on an interactive Web site. This method will capture driving distances and times from a Web map based on points marked by postal codes.

- Pseudo screen scraping.

### 09:15 AM - 09:25 AM [Multidimensional Scaling on ZIP Codes](http://support.sas.com/resources/papers/proceedings12/092-2012.pdf)

> Many marketing or customer relationship management activities require an efficient solution to manage a number of ZIP codes. In SAS, the ZIPCITYDISTANCE function calculates the geographic distances between any ZIP codes. And the MDS procedure translates the distance matrix of the ZIP codes into relational numeric values. This paper describes a simple solution that separates ZIP codes into limited levels based on the multidimensional scaling and clustering methods. With SAS¶s built-in ZIP code and map data sets, two illustrations on Texas and Orlando, FL, are introduced to show how to reduce a number of ZIP codes to manageable regions.

- Interesting--i'll probably try this sometime
- clustering zip codes into managable groups

### 10:00 AM - 10:20 AM [Selecting Unrestricted and Simple Random With Replacement Samples Using Base SAS and PROC SURVEYSELECT](http://support.sas.com/resources/papers/proceedings12/347-2012.pdf)

> This paper reviews techniques for selecting unrestricted and simple random without replacement samples using data step code and procedures such as PROC SORT and RANK. Random sampling basics are given that discusses the UNIFORM random number function and special SAS functions INT, CEIL,and FLOOR. Data step code for selecting Bernoulli samples and two different approaches to selecting a simple random sample without replacement are presented and discussed. Simpler ways to select simple random samples using PROC SORT and PROC RANK are illustrated. An alternative to selecting a random sample in the data step is to use PROC SURVEYSELECT in SAS/STAT. The syntax for the SURVEYSELECT procedure is given and discussed.References to published papers on how to use SAS to select random samples are given.

- `PROC SORT` rather than `PROC SURVEYSELECT`? `PROC RANK`? Nonsense!

### 10:30 AM - 10:50 AM [Simplifying the Analysis of Complex Survey Data Using the SAS Survey Analysis Procedures](http://support.sas.com/resources/papers/proceedings12/348-2012.pdf)

> Large surveys have design features like stratification, clustering, and unequal probability of selection. The calculation of weights involves nonresponse adjustments and raking. The analysis includes descriptive statistics such as frequencies, means, and their standard errors. Standard statistical software modules such as PROC FREQ and PROC MEANS underestimate variance as they assume that the data is from a simple random sample. The survey procedures such as SURVEYMEANS and SURVEYFREQ that have been added to SAS/STAT software can compute variances that accurately reflect complex sample design and estimation procedures. This paper compares the complexity of the variance estimation code used in earlier projects with the simplicity of the code that is possible using the survey analysis procedures.

- Use the `SURVEY PROC`s rather than `FREQ`, `MEANS`, `SUMMARY`, `REG`, etc.
- Compared the old way of doing these survey analysis with the new way using the `SURVEY PROC`s.

### 11:00 AM - 11:50 AM [Using SAS for the Design, Analysis, and Visualization of Complex Surveys](http://support.sas.com/resources/papers/proceedings12/343-2012.pdf)

> Visualizing data, finding estimates for population and model quantities, and checking model validity are challenging in complex surveys because of clustering, unequal weights, and other survey design features. SAS PROC SURVEYMEANS, PROC SURVEYSELECT, and other members of the SURVEY family are powerful tools for designing surveys and analyzing data from complex surveys. Recent developments to these procedures make them more powerful and more flexible than ever before. We present examples from complex surveys to illustrate how the procedures may be used for standard analyses as well as advanced applications such as graphing complex survey data, performing model diagnostics, making inferences employing the bootstrap, and combining data from multiple surveys.

- interesting to see a professional survey statistician (and higher-ed faculty member) go through her workflow
- much reliance on the `SURVEY PROC`s over non-`SURVEY PROC`s
- The `SURVEY PROC`s are syntacticly similar to non-`SURVEY PROC`s.
- Non-`SURVEY PROC`s use BY or subsetted data, `SURVEY PROC`s use DOMAIN statement.
- `SURVEYREG` cannot plot results. Instead, plot the pseudo population with `GCHART`.
