
import matplotlib.pyplot as plt
import numpy as np


def plotLifts(axes,xdata,ydata_num,ydata_direct,ydata_adjoint,label):
    plt.rc('text', usetex=True)

    colors=['r','k','g']
    styles=['-o','-','--']
    labels=['FD','direct','adjoint']
    haligns=['center','left','right']
    poss=[np.average(xdata),np.min(xdata),np.max(xdata)]
    ydatas=[ydata_num,ydata_direct,ydata_adjoint]

    for c,s,l,halign,pos,ydata in zip(colors,styles,labels,haligns,poss,ydatas):

        axes.semilogx(xdata, ydata,s+c, label=l)
        avg=np.average(ydata)
        axes.text(pos,np.max(ydata)*1.01,l+"\navg;: "+"{:.2E}".format(avg),
                  color=c,horizontalalignment=halign)


    axes.semilogx(xdata, ydata_num*0,  '-.', color='b', linewidth=4)
    axes.set_ylabel(label)
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
        f, (multiaxes) = plt.subplots(1, 3, sharey=False)
        f.set_size_inches(size_x,size_y)
        # plt.suptitle(plottitle,usetex=False)
        multiaxes[0].set_xlabel("step-size")
        multiaxes[1].set_xlabel("step-size")
        multiaxes[2].set_xlabel("iteration")
        multiaxes[0].set_title("Sensitivity-x")
        multiaxes[1].set_title("Sensitivity-y")
        multiaxes[2].set_title("Linear Solver residual")
        return f, (multiaxes)
    
def save_plot(plotfile):
    plt.savefig(plotfile, format='png', dpi=200)
    plt.close()
    return;
