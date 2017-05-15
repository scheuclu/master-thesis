import pandas as pd

#extraxting lift values from the steady state simulations
def extractLifts(filename,type):
    #reading the lift results for that simulations
    Lx=0
    Ly=0

    xkey  ={'liftdrag':'Lx', 'force':'Fx'}
    ykey  ={'liftdrag':'Ly', 'force':'Fy'}
    t=pd.read_csv(filename,delim_whitespace=True)
    tlen = len(t)-1
    Lx = t[xkey[type]][tlen]
    Ly = t[ykey[type]][tlen]

    return Lx, Ly


def doFD(Lx_minus,Lx_plus,Ly_minus,Ly_plus,absvar):
    dLx="{:.10e}".format((Lx_plus-Lx_minus)/(absvar*2  ))
    dLy="{:.10e}".format((Ly_plus-Ly_minus)/(absvar*2  ))
    absvar="{:.10e}".format(absvar)
    return ",".join([absvar,dLx,dLy])

def writeCSVana(fluidresultfile,csvfile,type):
    #opeing the .csv file
    f = open(csvfile,'w')
    f.write('ABSVAR,dLx,dLy\n')

    xkey  ={'liftdrag':'dLx', 'force':'dFx'}
    ykey  ={'liftdrag':'dLy', 'force':'dFy'}
    t=pd.read_csv(fluidresultfile,delim_whitespace=True)
    dLx = t[xkey[type]]
    dLy = t[ykey[type]]
    Var = t['Step']

    for v,dlx,dly in zip(Var,dLx,dLy):
        writeline=",".join([str(v),str(dlx),str(dly)])
        f.write(writeline)
        f.write("\n")
    f.close()

    return 0

