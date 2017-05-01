# master-thesis
Repository for the LaTeX elaboration of my Master's Thesis at Stanford university.

The thesis is being supervised by the Chair of Computational Mechanics ([LNM](https://www.lnm.mw.tum.de/home/)) at TU Munich.

## Build
No special LaTex packages are used, so comiplation should be easy. Use PDFLaTeX to compile main.tex.
IMPORTANT: You have to change the macro for "\mainpath" in "header.tex" to fit your directory structure.

## Structure
All chapters are found under [./chapters](./chapters) in seperate files respectively. The documents uses the [subfile](https://www.ctan.org/pkg/subfiles?lang=en) package, so all chapters can be built into independent documents withput losing crucial references to other chapters.

Figures are stored in the [./fig](./fig) folder. Subfolders are organized by file formats. The [pgfplots](https://www.ctan.org/pkg/pgf?lang=en) package is used for figure generation whenever possbile.

### [main.tex](main.tex)
Main document routines. Inputs all prepocessing commands from "Header.tex". "main.tex" itself does not contain any content itself, instead it links preface, chapters and bibilography in. Chapters are linked via the subfile package. All subfiles link to main.tex as their reference file.

### [Header.tex](Header.tex)
Contains all formatting commands and package inclusions. It also inputs the file "customcommands.tex".

### [customcommands.tex](customcommands.tex)
This file contains all user defined macros and commands. Please note that if done in a specific syntax, the script "create_nomenclature.tex" will be able to automatically create a nomencature.tex file for your document. That way, it can be ensured that your nomencalture is always up to date, and you get a nice overview of your commands.
See "create_nomencature.py" for details

### [colordefinitions.tex](colordefinitions.tex)
The file contains custom color tables for usage all over the document, especially for the Tikz and pgfplots figures. Colors are inputed in simple RGB format. More details are provided in the file.


### [acronyms.tex](acronyms.tex)
This files contains a list of acronyms that are used in the thesis. The [acronym](https://www.ctan.org/pkg/acronym?lang=en) package is used for that purpose.



## Scripts

### [clean.sh](clean.sh)
Deletes all auxiliary files created during the LaTeX compilation

### [find_nomatch.sh](find_nomatch.sh)
Used by [clean.sh](clean.sh). Returns all files that do not match a regular expression.