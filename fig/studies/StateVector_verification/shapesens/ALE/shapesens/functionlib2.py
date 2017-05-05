def MainText(text1):
    greentext=""
    for i in range(0,60):
        greentext=greentext+" "
    greentext=text1+greentext[len(text1):]
    greentext2="\033[1;4;092m"+greentext+"\033[00m"
    print(greentext2)
    
    
def ReadInfo(infofile):
    dic={}
    with open(infofile) as f:
        for line in f.readlines():
            [name,num]=line.split()
            dic[line.split()[0]]=int(num)
            print("read "+name+"="+num)
    return dic


def ReadInputFiles(dir):
    perturbvals=[float(item.strip()) for item in open(dir+'perturbations').readlines()]
    angles     =[str(item.strip()) for item in open(dir+'angles').readlines()]
    machnums   =[str(item.strip()) for item in open(dir+'machnumbers').readlines()]
    shapevars  =[str(item.strip()) for item in open(dir+'shapevariables').readlines()]
    NUMMACH     =len(machnums)
    NUMANGLES   =len(angles)
    NUMSHAPEVARS=len(shapevars)
    NUMPERTURB  =len(perturbvals)

    print("read NUMMACH="+str(NUMMACH))
    print("read NUMANGLES="+str(NUMANGLES))
    print("read NUMSHAPEVARS="+str(NUMSHAPEVARS))
    print("read NUMPERTURB="+str(NUMPERTURB))
    
    return machnums, angles, shapevars, perturbvals, NUMMACH, NUMANGLES, NUMSHAPEVARS, NUMPERTURB

