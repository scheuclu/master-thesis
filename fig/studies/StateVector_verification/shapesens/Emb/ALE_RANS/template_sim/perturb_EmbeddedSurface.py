
prenodelines=[]
afternodelines=[]
nodelines=[]
with open('../../../mesh/runmesh/embedded_surface.top') as meshfile:
    prenodelines.append(meshfile.readline())
    fileline=meshfile.readline()
    while fileline.count('Elements')==0:
        nodelines.append(fileline)
        fileline=meshfile.readline()
    afternodelines.append(fileline)
    afternodelines=afternodelines+meshfile.readlines()
        

with open('./sdesign/naca_plus.vmo') as vmofile:
    vmofile.readline()
    vmofile.readline()
    vmofile.readline()
    vmolines_plus=vmofile.readlines()
    perturb_plus=[[float(nodeval)+float(vmoval) for nodeval, vmoval  in zip(nodeline.split()[1:],vmolineplus.split())] for nodeline, vmolineplus in zip(nodelines,vmolines_plus)]



with open('./sdesign/naca_minus.vmo') as vmofile:
    vmofile.readline()
    vmofile.readline()
    vmofile.readline()
    vmolines_minus=vmofile.readlines()
    perturb_minus=[[float(nodeval)+float(vmoval) for nodeval, vmoval  in zip(nodeline.split()[1:],vmolineplus.split())] for nodeline, vmolineplus in zip(nodelines,vmolines_minus)]



with open('./sdesign/embedded_surface_plus.top','w') as f:
    f.writelines(prenodelines)
    i=1
    for line in perturb_plus:
        printline=" ".join([str(i)]+[str(n) for n in line])
        f.writelines(printline)
        f.write("\n")
        i=i+1
    f.writelines(afternodelines)


with open('./sdesign/embedded_surface_minus.top','w') as f:
    f.writelines(prenodelines)
    i=1
    for line in perturb_minus:
        printline=" ".join([str(i)]+[str(n) for n in line])
        f.writelines(printline)
        f.write("\n")
        i=i+1
    f.writelines(afternodelines)

