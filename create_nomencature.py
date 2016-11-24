import os as os
import re as re

file = open('./customcommands.tex','r')
content=file.read().splitlines()
symbols={}
abbrevations={}
operators={}

#loop over all lines
while len(content)>0:
    curline=content.pop(0) #get a line
    if curline.startswith("%%")==False: #just ignore it
        if curline.find("SYMBOLS") > -1:
            # print("Found a new symbol line")
            description=content.pop(0)[2:].strip()
            symbols[description]={}
            # print(description)
            content.pop(0)
            commandline=content.pop(0)
            while commandline:
                macro=commandline.split("%")[0].strip()
                explanation=commandline.split("%")[1].strip()
                # print(macro+"->"+explanation)
                commandline=content.pop(0)
                symbols[description][explanation]=macro
        if curline.find("ABBREVATIONS") > -1:
            # print("Found a new abbrevation section")
            description=content.pop(0)[2:].strip()
            abbrevations[description]={}
            # print(description)
            content.pop(0)
            commandline=content.pop(0)
            while commandline:
                macro=commandline.split("%")[1].strip()
                explanation=commandline.split("%")[2].strip()
                # print(macro+"->"+explanation)
                commandline=content.pop(0)
                abbrevations[description][explanation]=macro
        if curline.find("OPERATORS") > -1:
            # print("Found a new abbrevation section")
            description=content.pop(0)[2:].strip()
            operators[description]={}
            # print(description)
            content.pop(0)
            commandline=content.pop(0)
            while commandline:
                macro=commandline.split("%")[0].strip()
                explanation=commandline.split("%")[1].strip()
                # print(macro+"->"+explanation)
                commandline=content.pop(0)
                operators[description][explanation]=macro
# print(symbols)
# print(abbrevations)



with open("testfile.tex","w") as outfile:
    outfile.write("\\section*{Nomenclature}\\label{sec:nomenclature}\n\n")

    outfile.write("\\subsection*{Symbols}\n\n")
    for descr in sorted(symbols.keys()):
        print(descr)
        outfile.write("\\subsubsection*{"+descr+"}\n")
        outfile.write("\\begin{tabular}{l l l}\n")
        for expl in symbols[descr]:
            command=symbols[descr][expl].split("{")[1].split("}")[0]
            outfile.write("$"+command+"$ & "+expl+"& \\texttt{"+command[1:]+"}\\\\\n")
        outfile.write("\end{tabular}\n\n")

    outfile.write("\\subsection*{Abbrevations}\n\n")
    for secname in sorted(abbrevations.keys()):
        print(secname)
        outfile.write("\subsection*{"+secname+"}\n")
        outfile.write("\\begin{tabular}{l l l}\n")
        for expl in abbrevations[secname]:
            abb=abbrevations[secname][expl].split("{")[1].split("}")[0]
            outfile.write(abb +" & "+expl+"& \\texttt{"+abb+"}\\\\\n")
        outfile.write("\end{tabular}\n\n")

    outfile.write("\\subsection*{Operators}\n\n")
    for secname in sorted(operators.keys()):
        print(secname)
        outfile.write("\subsection*{"+secname+"}\n")
        outfile.write("\\begin{tabular}{l l l}\n")
        for expl in operators[secname]:
            withexpr=re.search("with{.*}",expl).group(0)
            explclean=expl.replace(withexpr,"").strip()
            withexpr=withexpr.replace('with{','').replace('}','')
            command=operators[secname][expl].split("{")[1].split("}")[0]
            numarg=int(operators[secname][expl].split("{")[1].split("}")[1][1])
            if numarg != 1:
                error("Currently only operators with one argument are supported")
                exit()

            print(command+str(numarg))

            outfile.write("$"+command+"{"+withexpr+"}$" +" & "+explclean+"& \\texttt{"+command[1:]+"}\\\\\n")
        outfile.write("\end{tabular}\n\n")
