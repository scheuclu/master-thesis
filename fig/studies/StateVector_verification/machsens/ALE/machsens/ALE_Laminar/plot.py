#!/usr/bin/python3

import os as os
#import matplotlib.pyplot as plt
#import numpy as np
import sys
import time

sys.path.append("../")
from functionlib  import extractLifts, doFD, writeCSVana
from functionlib2 import MainText, ReadInfo, ReadInputFiles
from plotlib      import plotLifts, plotIterations, getCSVdata, setup_plots, save_plot



def getLabel(dir,type):
    path=os.path.dirname(os.path.abspath(__file__))
    if path.find('alphasens')!=-1:
        svar='\\alpha'
    elif path.find('machsens')!=-1:
        svar='Ma_{\inf}'
    else:
        svar="s_{i}"

    if type=='liftdrag':
        q="L"
    else:
        q="F"

    label=r'$\frac{\partial '+q+'_'+dir+'}{\partial '+svar+'}$'
    # label=r"$"+label+"$"
    return label


os.system("rm -rf ./results/Ma*/*")

MainText("\nREADING INPUT-FILES")
machvalues, anglevalues, perturbvals, NUMMACH, NUMANGLES, NUMPERTURB = ReadInputFiles('scriptinput/')

MainText("\nSTART PlOTTING")
for type in ['liftdrag', 'force']:
    for index_mach in range(1,NUMMACH+1):
        if  not os.path.exists("./results/Ma"+str(machvalues[index_mach-1])):
          os.makedirs("./results/Ma"+str(machvalues[index_mach-1]))
        readmefile=open('./results/Ma'+str(machvalues[index_mach-1])+'/README.md','a+')
        for index_angle in range(1,NUMANGLES+1):
            plotfile='./results/Ma'+str(machvalues[index_mach-1])+'/'+type+'_angle'+str(anglevalues[index_angle-1])+".png"
            print("Writing file"+plotfile)

            #create filenames of analytic simulations resuts from the manual on
            filedirect           = 'anasim_'+str(index_mach)+'_'+str(index_angle)+'_direct_'+type+'.csv'
            fileadjoint          = 'anasim_'+str(index_mach)+'_'+str(index_angle)+'_adjoint_'+type+'.csv'
            filedirect_linsolve  = 'anasim_'+str(index_mach)+'_'+str(index_angle)+'_direct_linearsolver.csv'
            fileadjoint_linsolve = 'anasim_'+str(index_mach)+'_'+str(index_angle)+'_adjoint_linearsolver.csv'
            file_sim='./results/sim_'+str(index_mach)+'_'+str(index_angle)+'_'+type+'.csv'

            data_sim, data_direct, data_adjoint, data_direct_linsolve,data_adjoint_linsolve=getCSVdata(
                    file_sim,filedirect,fileadjoint,filedirect_linsolve,fileadjoint_linsolve)


            #Initializing the plot
            plottitle=os.getcwd().split('/')[-1]+'  angle='+str(anglevalues[index_angle-1])+\
                      ' mach='+str(machvalues[index_mach-1])+' '+time.strftime('%d/%m/%Y')
            f, multiaxes = setup_plots(plottitle,17,6)


            ################################################
            # Plots for Lx sensitivity                     #
            ################################################
            axes     =multiaxes[0]
            xdata    =data_sim['stepsize']
            ydata_num=data_sim['dLx']
            ydata_direct =data_sim['dLx']*0+data_direct["dLx"]
            ydata_adjoint=data_sim['dLx']*0+data_adjoint["dLx"]
            # label=r"$\frac{\partial L_x}{\partial \alpha}$"
            label=getLabel('x',type)
            plotLifts(axes,xdata,ydata_num,ydata_direct,ydata_adjoint,label)


            ################################################
            # Plots for Ly sensitivity                     #
            ################################################
            axes     =multiaxes[1]
            xdata    =data_sim['stepsize']
            ydata_num=data_sim['dLy']
            ydata_direct =data_sim['dLy']*0+data_direct["dLy"]
            ydata_adjoint=data_sim['dLy']*0+data_adjoint["dLy"]
            # label=r"$\frac{\partial L_y}{\partial \alpha}$"
            label=getLabel('y',type)
            plotLifts(axes,xdata,ydata_num,ydata_direct,ydata_adjoint,label)


            # axes.legend(loc='lower center',mode="expand", borderaxespad=0., 
                         # bbox_to_anchor=(0.,-0.13, 1.,-0.13),
                        # fancybox=True, shadow=True, ncol=5)


            ################################################
            # Plots for linear solver                      #
            ################################################
            axes=multiaxes[2]
            iter_direct =data_direct_linsolve ['iteration']
            iter_adjoint=data_adjoint_linsolve['iteration']
            res_direct  =data_direct_linsolve ['residual']
            res_adjoint =data_adjoint_linsolve['residual']

            plotIterations(axes,iter_direct,res_direct,iter_adjoint,res_adjoint)


            # axes.legend(loc='upper center', bbox_to_anchor=(1, -0.20),
                                    # fancybox=True, shadow=True, ncol=5)

            save_plot(plotfile)
            readmefile.write('#'+type+' results for  Ma: '+machvalues[index_mach-1]+' angle: '+anglevalues[index_angle-1]+'\n')
            readmefile.write('!['+plotfile.split('/')[-1]+']'+'('+plotfile.split('/')[-1]+')\n')
        readmefile.close()
        
MainText("")
