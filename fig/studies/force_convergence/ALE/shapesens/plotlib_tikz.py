
import matplotlib.pyplot as plt
import numpy as np


def plotLifts(axes,xdata,ydata_num,ydata_direct,ydata_adjoint,label1):
    colors=['r','k','g']
    styles=['-o','-','--']
    haligns=['center','left','right']
    poss=[np.average(xdata),np.min(xdata),np.max(xdata)]

    axes.loglog(xdata, abs((ydata_direct-ydata_num)/ydata_num),'-o', label=label1)
    # axes.set_title("aaabb")
    # avg=np.average(ydata)
        # axes.text(pos,np.max(ydata)*1.01,'avg;: '+"{:.2E}".format(avg),

    # axes.set_ylabel(label1)
    return;


def plotIterations(axes,iter_direct,res_direct,iter_adjoint,res_adjoint):
    axes.semilogy(iter_direct,res_direct,'-', color='k',label='residual')
    axes.semilogy(iter_adjoint,res_adjoint,'--', color='g',label='residual')
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

def setup_plots(plottitle,num_shapevars,size_x,size_y):
        f, (multiaxes) = plt.subplots(num_shapevars, 2, sharey=False)
        # plt.tight_layout(w_pad=0.5, h_pad=8.0)
        f.set_size_inches(size_x,size_y)
        # plt.suptitle(plottitle)
        for i in range(num_shapevars):
            multiaxes[i][0].set_xlabel(r"$\epsilon$")
            multiaxes[i][1].set_xlabel(r"$\epsilon$")
            # multiaxes[0][0].set_title("Sensitivity Lx")
            # multiaxes[0][1].set_title("Sensitivity Ly")
        return f, (multiaxes)
    
def save_plot(plotfile):
    plt.savefig(plotfile, format='png', dpi=200)
    plt.close()
    return;
