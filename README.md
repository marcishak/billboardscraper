# Bootleg Billboard Scraper

Scrapes Billboard -> can export to csv or Json :)

Originally written in Perl as an application of what was learnt after comp2041 

* now used as toy data source for R stuff
* won't really be updated, plan to rewrite into R to develop into package
* needs wget (already installed on linux, install from homebrew on mac)
* The error messages really suck. Sorry about that.
* Also the relationship structure between programs also sucks. It's way too varied with some needing pipes and others calling the other program directly...
* The variable names also super suck. This really isn't ~~great good~~ passable code...

## Usage

## scrapeBillboard.pl
* This gets the chart for the date provided 
* Dates must be in YYYY-MM-DD format
* By default it just outputs json to stdout but with a -c or -j flag (after the date) it can output into csv or json respectively.
* Bug: occasionally will fail to scrape the website correctly. Re-running the script fixes the problem (most of the time) ¯\\\_(ツ)_/¯ 

## scrapeYear.pl
* This scrapes an entire given year of the billboard chart and out puts it to data/ 
* A -c or -j flag is required as well as scrapeBillboard.pl
* Note that for billboard a year is not defined as a calendar year, it runs from the first week of december from the previous year up until the last week of november
  * This is the "year" that this program scrapes. For a full calender year you can just copy and paste the previous years december into your desired year.
* Bug: as this relies on scrapeBillboard.pl it falls under the same bug. Except that this will fail to scrape every site after the first failure. Re-running the script solves the problem. ¯\\\_(ツ)_/¯ 

## slimData.pl
* This produces a summary for the entire year of charts. All the files for that year need to be downloaded in advance in csv format.
* There are two summary options (in flags after the year) available: 
  * -w: gets the cumulative number of weeks for a particular song
  * -p: produces the points based on an inverse point system. (ie: 1->100, 2->99, ..., 99 -> 2, 100 -> 1). 
    * This is the way the year end billboard chart used to do it before getting the data from Nielsen.
    * This won't produce an accurate year end chart because of this. The new method allows for variable point totals between chat positions while this assumes that the distance is constant between them.
    * [Wikipedia](https://en.wikipedia.org/wiki/Billboard_Year-End) has some good info on this

## songCount.pl 
* This gets the year end artist totals from slimData.pl
  * It needs to be piped in (smh) from slimData.pl 
    * ie: slimData.pl 2019 -p | songCount.pl 
    * Hence it also relies on the flag you gave slimData.pl
* This also can't split up artist collaborations ie:  There will be separate entries for Ariana Grande & Social House and Ariana Grande




