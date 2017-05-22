
import matplotlib.pyplot as plt
import numpy as np


def plotLifts(axes,xdata,ydata_num,ydata_direct,ydata_adjoint,style,label1):
    plt.rc('text', usetex=True)

    #colors=['r']
    styles=['-o','-2','-s']
    haligns=['center']
    poss=[np.average(xdata),np.min(xdata),np.max(xdata)]
    ydatas=[np.absolute((ydata_num-ydata_direct),ydata_num)]

    for s,halign,pos,ydata in zip(styles,haligns,poss,ydatas):

        axes.loglog(xdata, ydata,style, label=label1)
        #avg=np.average(ydata)
        #axes.text(pos,np.max(ydata)*1.01,l+"\navg;: "+"{:.2E}".format(avg),
        #          color=c,horizontalalignment=halign)


    # axes.semilogx(xdata, ydata_num*0,  '-.', color='b', linewidth=4)
    #axes.set_ylabel(label)
    return;


def plotIterations(axes,iter_direct,res_direct,iter_adjoint,res_adjoint):
    axes.plot(iter_direct,res_direct,'-', color='k',label='residual')
    axes.plot(iter_adjoint,res_adjoint,'--', color='g',label='residual')
    axes.yaxis.tick_right()
    axes.set_ylabel("res")
    return;

def getCSVdata(file_sim,filedirect,fileadjoint,filedirect_linsolve,fileadjoint_linsolve):
        data_direct  = np.genfromtxt('./results/'+filedirect,  delimiter=',',
                                     max_rows=8, skip_header=1,skip_footer=0,
                                     names=['absvar', 'dLx', 'dLy'])
        data_adjoint = np.genfromtxt('./results/'+fileadjoint, delimiter=',',
                                     max_rows=8, skip_header=1, skip_footer=0,
                                     names=['absvar', 'dLx', 'dLy'])
        data_direct_linsolve  = np.genfromtxt('./results/'+filedirect_linsolve,
                                              delimiter=',', skip_header=1,skip_footer=0,
                                              names=['iteration', 'residual'])
        data_adjoint_linsolve = np.genfromtxt('./results/'+fileadjoint_linsolve,
                                              delimiter=',', skip_header=1,skip_footer=0,
                                              names=['iteration', 'residual'])
        data_sim = np.genfromtxt(file_sim, delimiter=',', skip_header=1,skip_footer=0,
                                 names=['stepsize', 'dLx', 'dLy'])
        return data_sim, data_direct, data_adjoint, data_direct_linsolve, data_adjoint_linsolve

def setup_plots(plottitle,size_x,size_y):
        plt.rc('text', usetex=False)
        f, (multiaxes) = plt.subplots(1, 2, sharey=False)
        f.set_size_inches(size_x,size_y)
        # plt.suptitle(plottitle,usetex=False)
        multiaxes[0].set_xlabel(r"$\epsilon$")
        multiaxes[1].set_xlabel(r"$\epsilon$")
        multiaxes[1].yaxis.tick_right()
        #multiaxes[0].set_title("Sensitivity-x")
        #multiaxes[1].set_title("Sensitivity-y")
        plt.subplots_adjust(right=2.0)
        return f, (multiaxes)
    
