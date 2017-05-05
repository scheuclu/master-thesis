#!/usr/bin/python3

import os as os
import matplotlib.pyplot as plt
import numpy as np
import sys
import time

sys.path.append("../")

from functionlib  import extractLifts, doFD, writeCSVana
from functionlib2 import MainText, ReadInfo, ReadInputFiles
from plotlib      import plotLifts, plotIterations, getCSVdata, setup_plots, save_plot

os.system("rm -rf ./results/Ma*/*")

MainText("\nREADING INPUT-FILES")
machvalues, anglevalues, shapevars, perturbvals, NUMMACH, NUMANGLES, NUMSHAPEVARS, NUMPERTURB = ReadInputFiles('scriptinput/')

print(NUMSHAPEVARS)


MainText("\nSTART PlOTTING")
for type in ['force','liftdrag']:
    for index_mach in range(1,NUMMACH+1):
        #check if an appropriate outputfolder exist; if not, create it
        if  not os.path.exists("./results/Ma"+str(machvalues[index_mach-1])):
          os.makedirs("./results/Ma"+str(machvalues[index_mach-1]))
        readmefile=open('./results/Ma'+str(machvalues[index_mach-1])+'/README.md','a+')
        for index_angle in range(1,NUMANGLES+1):
            plotfile='./results/Ma'+str(machvalues[index_mach-1])+'/'+type+'_angle'+str(anglevalues[index_angle-1])+".png"
            print("Writing file"+plotfile)


            #create filenames of analytic simulations resuts from the manual on
            filedirect           = 'anasim_'+str(index_mach)+'_'+str(index_angle)+'_direct_'+type+'.csv'
            fileadjoint          = 'anasim_'+str(index_mach)+'_'+str(index_angle)+'_adjoint_'+type+'.csv'

            plottitle=os.getcwd().split('/')[-1]+"  angle="+str(anglevalues[index_angle-1])+" mach="+str(machvalues[index_mach-1]+" "+time.strftime("%d/%m/%Y"))
            f, multiaxes = setup_plots(plottitle,NUMSHAPEVARS,17,14)

            for shapevarindex in range(1,NUMSHAPEVARS+1):
                
                  file_sim='./results/sim_'+str(index_mach)+'_'+str(index_angle)+'_'+str(shapevarindex)+'_'+type+'.csv'
                  filedirect_linsolve  = 'anasim_'+str(index_mach)+'_'+str(index_angle)+'_'+str(shapevarindex)+'_direct_linearsolver.csv'
                  fileadjoint_linsolve = 'anasim_'+str(index_mach)+'_'+str(index_angle)+'_'+str(shapevarindex)+'_adjoint_linearsolver.csv'


                  data_sim, data_direct, data_adjoint, data_direct_linsolve,data_adjoint_linsolve=getCSVdata(file_sim,filedirect,fileadjoint,filedirect_linsolve,fileadjoint_linsolve)
                  # data_sim = np.genfromtxt(file_sim, delimiter=',', skip_header=1,skip_footer=0, names=['stepsize', 'dLx', 'dLy'])

                  ################################################
                  # Plots for Lx sensitivity                     #
                  ################################################
                  axes         =multiaxes[shapevarindex-1][0]
                  xdata        =data_sim['stepsize']
                  ydata_num    =data_sim['dLx']
                  ydata_direct =data_sim['dLx']*0+data_direct["dLx"][int(shapevars[shapevarindex-1])-1]
                  ydata_adjoint=data_sim['dLx']*0+data_adjoint["dLx"][int(shapevars[shapevarindex-1])-1]
                  label="dLx/ds_"+str(shapevars[shapevarindex-1])
                  plotLifts(axes,xdata,ydata_num,ydata_direct,ydata_adjoint,label)
            

                  ################################################
                  # Plots for Ly sensitivity                     #
                  ################################################
                  axes         =multiaxes[shapevarindex-1][1]
                  xdata        =data_sim['stepsize']
                  ydata_num    =data_sim['dLy']
                  ydata_direct =data_sim['dLy']*0+data_direct["dLy"][int(shapevars[shapevarindex-1])-1]
                  ydata_adjoint=data_sim['dLy']*0+data_adjoint["dLy"][int(shapevars[shapevarindex-1])-1]
                  label="dLy/ds_"+str(shapevars[shapevarindex-1])
                  plotLifts(axes,xdata,ydata_num,ydata_direct,ydata_adjoint,label)

                  
                  ################################################
                  # Plots for linear solver                      #
                  ################################################
                  axes=multiaxes[shapevarindex-1][2]
                  iter_direct =data_direct_linsolve ['iteration']
                  iter_adjoint=data_adjoint_linsolve['iteration']
                  res_direct  =data_direct_linsolve ['residual']
                  res_adjoint =data_adjoint_linsolve['residual']

                  plotIterations(axes,iter_direct,res_direct,iter_adjoint,res_adjoint)

            multiaxes[NUMSHAPEVARS-1][0].legend(loc='upper center', bbox_to_anchor=(1, -0.20),
                                    fancybox=True, shadow=True, ncol=5)

            save_plot(plotfile)
            readmefile.write('#'+type+'results for  Ma: '+machvalues[index_mach-1]+' angle: '+anglevalues[index_angle-1]+'\n')
            readmefile.write('!['+plotfile.split('/')[-1]+']'+'('+plotfile.split('/')[-1]+')\n')
        readmefile.close()

MainText("")
