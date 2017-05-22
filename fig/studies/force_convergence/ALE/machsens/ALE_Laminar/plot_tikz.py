#!/usr/bin/python3

import os as os
#import matplotlib.pyplot as plt
#import numpy as np
import sys
import time

sys.path.append("../")
from functionlib  import extractLifts, doFD, writeCSVana
from functionlib2 import MainText, ReadInfo, ReadInputFiles
from plotlib_tikz import plotLifts, plotIterations, getCSVdata, setup_plots

import matplotlib.pyplot as plt
from matplotlib import rc
rc('text', usetex=True)

from cycler import cycler


c1=(140/255,21/255,21/255,1.0)
c2=(77/255,79/255,83/255,1.0)
c3=(179/255,153/255,93/255,1.0)
c4=(182/255,177/255,169/255,1.0)
markerlist=['-o','-o','-o','-o']

def getLabel(dir,type):
    path=os.path.dirname(os.path.abspath(__file__))
    if path.find('alphasens')!=-1:
        svar='\\alpha'
    elif path.find('machsens')!=-1:
        # svar='Ma_{infty}'
        svar='Ma'
    else:
        svar="s_{i}"

    if type=='liftdrag':
        q="L"
    else:
        q="F"

    # label=r'$\frac{\partial '+q+'_'+dir+'}{\partial '+svar+'}\rvert_{analytic}-\frac{\partial '+q+'_'+dir+'}{\partial '+svar+'}\rvert_{FD}$'
    label=r'${\frac{\partial '+q+'_'+dir+'}{\partial '+svar+'}}_{analytic}$'+' - '+r'$\frac{\partial '+q+'_'+dir+'}{\partial '+svar+'}_{FD}$'
    # label=r"$"+label+"$"
    return label


os.system("rm -rf ./tikzfiles/Ma*/*")

MainText("\nREADING INPUT-FILES")
machvalues, anglevalues, perturbvals, NUMMACH, NUMANGLES, NUMPERTURB = ReadInputFiles('scriptinput/')

MainText("\nSTART PlOTTING")
for type in ['liftdrag', 'force']:
    for index_mach in range(1,NUMMACH+1):
        if  not os.path.exists("./tikzfiles/Ma"+str(machvalues[index_mach-1])):
          os.makedirs("./tikzfiles/Ma"+str(machvalues[index_mach-1]))
        #readmefile=open('./tikzfiles/Ma'+str(machvalues[index_mach-1])+'/README.md','a+')
        tikzfile='./tikzfiles/Ma'+str(machvalues[index_mach-1])+'/'+type+".tex"
        f, multiaxes = setup_plots('sometitle',3.5,2)
        multiaxes[0].set_prop_cycle(cycler('color', [c1,c2,c3,c4]))
        multiaxes[1].set_prop_cycle(cycler('color', [c1,c2,c3,c4])+cycler( 'marker',markerlist))
        #plt.tight_layout()
        for index_angle,style in zip(range(1,NUMANGLES+1),markerlist):
            print("Writing file"+tikzfile)

            #create filenames of analytic simulations resuts from the manual on
            filedirect           = 'anasim_'+str(index_mach)+'_'+str(index_angle)+'_direct_'+type+'.csv'
            fileadjoint          = 'anasim_'+str(index_mach)+'_'+str(index_angle)+'_adjoint_'+type+'.csv'
            filedirect_linsolve  = 'anasim_'+str(index_mach)+'_'+str(index_angle)+'_direct_linearsolver.csv'
            fileadjoint_linsolve = 'anasim_'+str(index_mach)+'_'+str(index_angle)+'_adjoint_linearsolver.csv'
            file_sim='./results/sim_'+str(index_mach)+'_'+str(index_angle)+'_'+type+'.csv'

            data_sim, data_direct, data_adjoint, data_direct_linsolve,data_adjoint_linsolve=getCSVdata(
                    file_sim,filedirect,fileadjoint,filedirect_linsolve,fileadjoint_linsolve)


            #Initializing the plot
            #plottitle=os.getcwd().split('/')[-1]+'  angle='+str(anglevalues[index_angle-1])+\
            #         ' mach='+str(machvalues[index_mach-1])+' '+time.strftime('%d/%m/%Y')



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
            multiaxes[0].set_title(label)
            plotLifts(axes,xdata,ydata_num,ydata_direct,ydata_adjoint,style,r'$\alpha_o$='+str(anglevalues[index_angle-1]))
            multiaxes[0].legend(loc=2)


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
            multiaxes[1].set_title(label)
            plotLifts(axes,xdata,ydata_num,ydata_direct,ydata_adjoint,'-o',r'$\alpha_o$='+str(anglevalues[index_angle-1]))
            multiaxes[1].legend(loc=2)
            
            #readmefile.write('#'+type+' tikzfiles for  Ma: '+machvalues[index_mach-1]+' angle: '+anglevalues[index_angle-1]+'\n')
            #readmefile.write('!['+plotfile.split('/')[-1]+']'+'('+plotfile.split('/')[-1]+')\n')


        from matplotlib2tikz import save as tikz_save
        tikz_save(tikzfile)
        #plt.show()
        #time.sleep(5)
        plt.close('all')
        #save_plot(plotfile)
        #sys.exit(0)
            


        #readmefile.close()
        
MainText("")
