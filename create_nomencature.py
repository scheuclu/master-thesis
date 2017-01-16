import os as os
import re as re
import sys

file = open('./customcommands.tex','r')
content=file.read().splitlines()
symbols={}
abbrevations={}
operators={}

################################################
# Read customcommands.tex file                 #
################################################
while len(content)>0:
    curline=content.pop(0) #get a line
    if curline.startswith("%%")==False: #just ignore it
        if curline.find("SYMBOLS") > -1:
            description=content.pop(0)[2:].strip()
            symbols[description]={}
            content.pop(0)
            commandline=content.pop(0)
            while commandline:
                macro=commandline.split("%")[0].strip()
                explanation=commandline.split("%")[1].strip()
                commandline=content.pop(0)
                symbols[description][explanation]=macro
        if curline.find("OPERATORS") > -1:
            description=content.pop(0)[2:].strip()
            operators[description]=[]
            content.pop(0)
            commandline=content.pop(0)
            while commandline:
                macro=commandline.split("%")[0].strip()
                explanation=commandline.split("%")[1].strip()
                commandline=content.pop(0)
                operators[description].append([explanation,macro])


#################################################
# Write Nomenclature.tex file                   #
#################################################
with open("Nomenclature.tex","w") as outfile:
    outfile.write("\\section*{Nomenclature}\\label{sec:nomenclature}\n\n")

    #############################################
    # Writing Operator commands                 #
    #############################################
    outfile.write("\\subsection*{Operators}\n\n")
    print(operators.keys())
    for secname in operators.keys():
        print(secname)
        outfile.write("\subsection*{"+secname+"}\n")
        outfile.write("\\begin{tabular}{l l l}\n")
        for temp in operators[secname]:
            print("===="+str(temp)+"\n")
            withexpr=re.search("with{.*}",temp[0]).group(0)
            print("::::eithexpr: "+withexpr)
            explclean=temp[0].replace(withexpr,"").strip()
            withexpr=withexpr.replace('with{','').replace('}','')
            command=temp[1].split("{")[1].split("}")[0]
            numarg=int(temp[1].split("{")[1].split("}")[1][1])
            if numarg==1:
                print(command+str(numarg))
                outfile.write("$"+command+"{"+withexpr+"}$" +" & "+explclean+"& \\texttt{"+command[1:]+"}\\\\\n")
            elif numarg==2:
                print(command+str(numarg))
                outfile.write("$"+command+"{"+withexpr.split('&')[0]+"}"+"{"+withexpr.split('&')[1]+"}$" +" & "+explclean+"& \\texttt{"+command[1:]+"}\\\\\n")
            else:
                print("\033[91mERROR Currently only operators with one argument are supported\033[00m")
                sys.exit()

        outfile.write("\end{tabular}\n\n")

    ###########################################
    # Writing Symbol commands                 #
    ###########################################
    outfile.write("\\subsection*{Symbols}\n\n")
    for descr in symbols.keys():
        print(descr)
        outfile.write("\\subsubsection*{"+descr+"}\n")
        outfile.write("\\begin{tabular}{l l l}\n")
        for expl in symbols[descr]:
            command=symbols[descr][expl].split("{")[1].split("}")[0]
            outfile.write("$"+command+"$ & "+expl+"& \\texttt{"+command[1:]+"}\\\\\n")
        outfile.write("\end{tabular}\n\n")


