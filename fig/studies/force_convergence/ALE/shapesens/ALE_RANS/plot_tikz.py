#!/usr/bin/python3

import os as os
#import matplotlib.pyplot as plt
#import numpy as np
import sys
import time

#rc('text', usetex=True)

sys.path.append("../")

from functionlib  import extractLifts, doFD, writeCSVana
from functionlib2 import MainText, ReadInfo, ReadInputFiles
from plotlib_tikz import plotLifts, plotIterations, getCSVdata, setup_plots


import matplotlib.pyplot as plt
from matplotlib import rc
plt.rc('text', usetex=True)
from matplotlib2tikz import save as tikz_save

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

            #create filenames of analytic simulations resuts from the manual on

            # plottitle=os.getcwd().split('/')[-1]+"  angle="+str(anglevalues[index_angle-1])+" mach="+str(machvalues[index_mach-1]+" "+time.strftime("%d/%m/%Y"))
            f, multiaxes = setup_plots("plottitle",NUMSHAPEVARS,17,14)

            for shapevarindex in range(1,NUMSHAPEVARS+1):
               tikzfile='./tikzfiles/Ma'+str(machvalues[index_mach-1])+'/'+type+".tex"
               print("Writing file"+tikzfile)
               for index_angle in range(1,NUMANGLES+1):
                  filedirect           = 'anasim_'+str(index_mach)+'_'+str(index_angle)+'_direct_'+type+'.csv'
                  fileadjoint          = 'anasim_'+str(index_mach)+'_'+str(index_angle)+'_adjoint_'+type+'.csv'
                
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
                  label=r"$\alpha_{\infty}="+str(anglevalues[index_angle-1])+"$"
                  plotLifts(axes,xdata,ydata_num,ydata_direct,ydata_adjoint,label)
                  suptitle=r"$\left( \frac{L_x}{s_<numsvar>}_{analytic}-\frac{L_x}{s_<numsvar>}_{FD}\right) \Big/ \frac{L_x}{s_<numsvar>}_{FD}$"
                  suptitle=suptitle.replace("<numsvar>",str(shapevars[shapevarindex-1]))
                  multiaxes[shapevarindex-1][0].set_title(suptitle)
                  multiaxes[shapevarindex-1][0].legend(loc=4)
            

                  ################################################
                  # Plots for Ly sensitivity                     #
                  ################################################
                  axes         =multiaxes[shapevarindex-1][1]
                  xdata        =data_sim['stepsize']
                  ydata_num    =data_sim['dLy']
                  ydata_direct =data_sim['dLy']*0+data_direct["dLy"][int(shapevars[shapevarindex-1])-1]
                  ydata_adjoint=data_sim['dLy']*0+data_adjoint["dLy"][int(shapevars[shapevarindex-1])-1]
                  label=r"$\alpha_{\infty}="+str(anglevalues[index_angle-1])+"$"
                  plotLifts(axes,xdata,ydata_num,ydata_direct,ydata_adjoint,label)
                  suptitle=r"$\left( \frac{L_y}{s_<numsvar>}_{analytic}-\frac{L_y}{s_<numsvar>}_{FD}\right) \Big/ \frac{L_y}{s_<numsvar>}_{FD}$"
                  suptitle=suptitle.replace("<numsvar>",str(shapevars[shapevarindex-1]))
                  
                  multiaxes[shapevarindex-1][1].set_title(suptitle)
                  multiaxes[shapevarindex-1][1].legend(loc=4)

                  
                  # ################################################
                  # # Plots for linear solver                      #
                  # ################################################
                  # axes=multiaxes[shapevarindex-1][2]
                  # iter_direct =data_direct_linsolve ['iteration']
                  # iter_adjoint=data_adjoint_linsolve['iteration']
                  # res_direct  =data_direct_linsolve ['residual']
                  # res_adjoint =data_adjoint_linsolve['residual']

                  # plotIterations(axes,iter_direct,res_direct,iter_adjoint,res_adjoint)

            # multiaxes[NUMSHAPEVARS-1][0].legend(loc='upper center', bbox_to_anchor=(1, -0.20),
                                    # fancybox=True, shadow=True, ncol=5)
            # plt.legend(loc=9, bbox_to_anchor=(0.5, -0.1), ncol=NUMANGLES)

            
            tikz_save(tikzfile)
            command="sed -i 's/group size/vertical sep=3cm, horizontal sep=2cm, group size/g' "+tikzfile
            os.system(command)
            ###command = "sed -i 'begin\{tikzpicture\}/begin\{tikzpicture\:wq}[scale=0.75]/g' "+tikzfile
            ###os.system(command)

            # sed -i 's/;/ /g' yourBigFile.txt

            #plt.show()
            #plt.close("all")
            #sys.exit(-1)
            # vertical sep=3cm, horizontal sep=2cm, group size


MainText("")
