#!/usr/bin/python

import os as os
import sys

sys.path.append("../")

os.system("rm -f ./results/*")
os.system("rm -f ./results/Ma*/*.png")

from functionlib import extractLifts, doFD, writeCSVana
from functionlib2 import MainText, ReadInfo, ReadInputFiles




def append_spaces(string):
  L=len(string)
  L0=50
  diff=L0-L
  if diff>0:
    string=string+"".join([" " for i in range(diff)])
  return string;

def a_s(string):
  return append_spaces(string)

MainText("\nREADING INPUT-FILES")
machnums, angles, perturbvals, NUMMACH, NUMANGLES, NUMPERTURB = ReadInputFiles('scriptinput/')


MainText("STARTING CALCULATIONS ")
for type in ['liftdrag', 'force']:
  for index_mach in range(1,NUMMACH+1):
      for index_angle in range(1,NUMANGLES+1):
          csvfilename='results/sim_'+str(index_mach)+'_'+str(index_angle)+'_'+type+'.csv'
          with open(csvfilename,'w') as resultfile:
              resultfile.write("absvar-value,dLx,dLy\n")
              print('\033[4mMACH: '+machnums[index_mach-1]+'   ANGLE: '+angles[index_angle-1]+'\033[00m')
              for index_perturb in range(1,NUMPERTURB+1):
                  simname = "sim_"+str(index_mach)+'_'+str(index_angle)+"_"+str(index_perturb)

                  absvar=float(perturbvals[index_perturb-1])

                  pathplus = simname+'/results/naca_plus_steady.'+type
                  pathminus= simname+'/results/naca_minus_steady.'+type
                  #reading the lift results for that simulations
                  Lx_plus, Ly_plus = extractLifts(pathplus,type)
                  Lx_minus, Ly_minus = extractLifts(pathminus,type)

                  #calculating the finite difference
                  writeline=doFD(Lx_minus,Lx_plus,Ly_minus,Ly_plus,absvar)
                  print(a_s(pathplus)+' -> '+csvfilename)
                  print(a_s(pathminus)+' -> '+csvfilename)

                  #writing the result
                  resultfile.write(writeline+"\n")


          anasimname="anasim_"+str(index_mach)+'_'+str(index_angle)
          #print('\033[4mMACH: '+machnums[index_mach-1]+'   ANGLE: '+angles[index_angle-1]+'\033[00m')
          for method in ['direct','adjoint']:
              csvfile='results/'+anasimname+'_'+method+'_'+type+'.csv'

              #opening the .csv file
              csvfilename ='results/'+anasimname+'_'+method+'_'+type+'.csv'
              with open(csvfilename,'w') as resultfile:
                  resultfile.write('ABSVAR,dLx,dLy\n')
                  fluidresultfile=anasimname+'/results/naca_'+method+'_sens.'+type
                  print(a_s(csvfilename)+" -> "+fluidresultfile)
                  writeCSVana(fluidresultfile,csvfile,type)

              csvfilename = 'results/'+anasimname+'_'+method+'_linearsolver.csv'
              with open(csvfilename,'w') as resultfile:
                  resultfile.write('iteration,residual\n')
                  solverresultfile=anasimname+'/results/linearsolver_'+method+'.txt'
                  print(a_s(solverresultfile)+" -> "+csvfilename)
                  with open(solverresultfile) as sfile:
                    sfile.readline()
                    for line in sfile:
                      resultfile.write(','.join(line.split()[0:2])+"\n")
  MainText("")
