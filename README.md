# Scrivener Document Stats Generator

## Reason

I'm not a Scrivener user nor an author. This is written for an author colleague to give them a better overview of the "shape" of a manuscript in terms of relative sizes of chapters and scenes. Maybe this kind of report is possible in Scrivener somewhere but I was unable to find that functionality. Hence this script.

## Assumptions
* The scrivener Binder folder holding the manuscript content is titled "Manuscript"
* The manuscript chapters are prefixed with "Chapter" (e.g. Chapter 1, Chapter 2, ...)

## Prerequisites

* Written against Ruby 2.5.x
* gems required:
    * nokogiri
    * rtf
## Chapter & Scene "Heat Map"

``` Chapter & Scene Heat Map
[Chapter 1 ] ▆▆▆▆▁
[Chapter 2 ] ▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▁▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▁▆▆▆▁▆▆▆▆▆▆▁▆▁▆▆▆▆▆▆▆▆▆
[Chapter 3 ] ▆▆▆▆▆▆▆
[Chapter 4 ] ▆▆▆▆▆▆▆▆▆▁▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▁▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▁▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▁▆▆▆▆▆▆▆▆ 
[Chapter 5 ] ▆▆▆▆▆▆▆▆▆▆▆▆▆▆
[Chapter 6 ] ▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▁▆▆▆▆▆▆▆▆▆▁▆▆▆▆▆▆▆▆▆▁▆▆▆▆▆▆▆▆▁▆▆▆▆▆▆▆▆▆▆▆▁▆▆▆▆▁▆▆▆▆▆▆▆▆▆▆▆▆▆▆
[Chapter 7 ] ▆▆▆▆▆▆
[Chapter 8 ] ▆▆▆▆▆▁▆▆▆▆▆▆▆▆▆▆▆▁▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▁▆▆▆▆▆▆▆▆▆▆▆▆
[Chapter 9 ] ▆▆▆▆▆▆▆▆▆▆
[Chapter 10] ▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▁▆▆▆▆▆▆▆▆▆
[Chapter 11] ▆▆▆▆
[Chapter 12] ▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▁▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▁▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆▆
[Chapter 13] ▆▆▆▆▁▆▁▆▆▆
```