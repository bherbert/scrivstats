# Scrivener Document Stats Generator

## Disclaimer

I'm not a Scrivener user nor an author. This is written for an author friend to give them a better overview of the "shape" of a manuscript in terms of relative sizes of chapters and scenes. Maybe this kind of report is possible in Scrivener somewhere but I was unable to find that functionality. Hence this script.

## Features

* Analyses document structure and prints an outline view showing chapters and scenes, with word counts at the scene, chapter, and overall document levels.
* Generates a 'heat map' showing relative sizes (based on word counts) of chapters and scenes within, useful when working to refactor a manuscript (e.g. to minimize exceedingly wordy chapters/scenes relative to others).

## Scrivener Document Structure Assumptions
* The Scrivener Binder folder holding the manuscript content is titled "Manuscript"
* The manuscript chapters are prefixed with "Chapter" (e.g. Chapter 1, Chapter 2, ...)

## Requirements

0. A Mac (uses `textutil`)
0. [Ruby 2.5.x](https://www.ruby-lang.org).
1. A Scrivener version 2.x document (has **not** been tested with Scrivener 3.x)

## Setup

Type the following to install:

    gem install scrivstats

## Usage

### Command Line Interface (CLI)

From the command line, type: `scrivstas --help`

    scrivstats -f PATH [--file=PATH]  # Generate stats on Scriverer doc at PATH
    scrivstats -h, [--help=COMMAND]   # Show this message or get help for a command.
    scrivstats -v, [--version]        # Show gem version.

## Chapter & Scene "Heat Map"

Following is an example 'heat map' showing relative sizes of chapters and scenes within each chapter.  Scenes are delimited with an underscore.

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

## License

[MIT License](
https://choosealicense.com/licenses/mit/)
