#!/usr/bin/python3

import os as os
import sys

sys.path.append('../')
from functionlib import extractLifts, doFD, writeCSVana
from functionlib2 import MainText, ReadInfo

os.system("rm -rf ./results/*")

MainText("\nREADING INPUT FILE")
dic=ReadInfo('info')
NUMANGLES=dic['NUMANGLES']; NUMPERTURB=dic['NUMPERTURB']; NUMMACH=dic['NUMMACH']; NUMSHAPEVARS=dic['NUMSHAPEVARS']


perturbvals=[]
with open('scriptinput/perturbations') as f:
  for line in f.readlines():
    perturbvals.append(float(line))


MainText("STARTING CALCULATIONS")
for index_mach in range(1,NUMMACH+1):
    for index_angle in range(1,NUMANGLES+1):
        for index_shapevar in range(1,NUMSHAPEVARS+1):
            csvfilename='results/sim_'+str(index_mach)+'_'+str(index_angle)+'_'+str(index_shapevar)+'.csv'
            with open(csvfilename,'w') as resultfile:
                resultfile.write("absvar-value,dLx,dLy\n")
                for index_perturb in range(1,NUMPERTURB+1):
                    simname = "sim_"+str(index_mach)+'_'+str(index_angle)+'_'+str(index_shapevar)+"_"+str(index_perturb)
                    absvar=float(perturbvals[index_perturb-1])
                    plusfilename =simname+'/results/naca_plus_steady.liftdrag'
                    minusfilename=simname+'/results/naca_minus_steady.liftdrag'

                    #reading the lift results for that simulations
                    Lx_plus, Ly_plus  = extractLifts(plusfilename)
                    Lx_minus,Ly_minus = extractLifts(minusfilename)

                    writeline=doFD(Lx_minus,Lx_plus,Ly_minus,Ly_plus,absvar)
                    print(plusfilename+ " -> "+csvfilename)
                    print(minusfilename+" -> "+csvfilename)
                    
                    resultfile.write(writeline)
                    resultfile.write("\n")


for index_mach in range(1,NUMMACH+1):
    for index_angle in range(1,NUMANGLES+1):
        simname="anasim_"+str(index_mach)+'_'+str(index_angle)
        for method in ['direct','adjoint']:
            writeCSVana(simname+'/results/naca_'+method+'_sens.liftdrag', #aerof_resultfile
                        'results/'+simname+'_'+method+'.csv')             #csv-file

MainText("")
