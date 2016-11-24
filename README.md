# master-thesis
Repository for the LaTeX elaboration of my Master's Thesis at Stanford university.

## Build
No special LaTex packages are used, so comiplation should be easy. Use PDFLaTeX to compile main.tex.
IMPORTANT: You have to change the macro for "\mainpath" in "header.tex" to fit your directory structure.

## Structure

### main.tex
Main document routines. Inputs all prepocessing commands from "Header.tex". "main.tex" itself does not contain any content itself, instead it links preface, chapters and bibilography in. Chapters are linked via the subfile package. All subfiles link to main.tex as their reference file.

### header.tex
Contains all formatting commands and package inclusions. It also inputs the file "customcommands.tex".

### customcommands.tex
This file contains all user defined macros and commands. Please note that if done in a specific syntax, the script "create_nomenclature.tex" will be able to automatically create a nomencature.tex file for your document. That way, it can be ensured that your nomencalture is always up to date, and you get a nice overview of your commands.
See "create_nomencature.py" for details

### colordefinitions.tex
The file contains custom color tables for usage all over the document, especially for the Tikz and pgfplots figures. Colors are inputed in simple RGB format. More details are provided in the file.

### /chapters/*
The folder "chapters" contains all chapters of the documents. Thanks to the usage of the subfile-package, they can be compiled independently.
