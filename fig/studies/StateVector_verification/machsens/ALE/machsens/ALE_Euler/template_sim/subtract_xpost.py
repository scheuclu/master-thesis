import os
import sys
import time #just for the sleep command


def divide_plus_minus(filelist):
  pluslist=[]
  minuslist=[]
  for file in filelist:
    if file.find('plus')!=-1:
      pluslist.append(file)
    if file.find('minus')!=-1:
      minuslist.append(file)
  return pluslist, minuslist


def create_outtext(header,pluslines,minuslines,perturb):
  outtext=[]
  outtext=header[:]
  for plusline, minusline in zip(pluslines,minuslines):
    resultline=[]
    for plusval,minusval in zip (plusline.split(),minusline.split()):
      fdval=(float(plusval)-float(minusval))/(2*perturb)
      # print(fdval)
      # resultline.append(str(fdval))
      # resultline.append("{:.9f}".format(fdval))
      resultline.append('{:{w}.{p}f}'.format(fdval, w=19, p=15 ))
    # print(' '.join(resultline))
    outtext.append(' '.join(resultline)+'\n' )
    #print(outtext)
    #outtext.append(' '.join(outtext))
  # print("\033[93mThe outtext looks looks like this:\033[00m")
  # print(outtext)
  return outtext

if __name__ == "__main__":
  filelist=os.listdir("./results/xpost")
  # print(filelist)

  pluslist, minuslist = divide_plus_minus(filelist)


  if len(pluslist)!=len(minuslist):
    print("ERROR the number of plusfiles is not equal to the number of minus files")
    sys.exit()

  for plusfile,minusfile in zip(pluslist,minuslist):
  # for plusfile,minusfile in zip(['Mach_plus.xpost'],['Mach_minus.xpost']):
    outfile=plusfile.replace('_plus','Sensitivity')
    with open("./results/xpost/"+outfile,'w') as writefile:
        with open("./results/xpost/"+plusfile) as readfileplus:
            # print("plusfile opened")
            time.sleep(1)
            with open("./results/xpost/"+minusfile) as readfileminus:
              plustext=readfileplus.readlines()
              header=plustext[0:3]
              # print(header); time.sleep(1);
              header[0]=header[0].replace('_plus','Sensitivity')
              pluslines=plustext[3:-1]
              minuslines=readfileminus.readlines()[3:-1]
        with open('./siminfo') as siminfofile:
          perturb=float(siminfofile.readlines()[1].split()[1])
          # print(perturb)
          # time.sleep(1)
          # print(pluslines)
          # time.sleep(2)
          # print(minuslines)
          # time.sleep(2)
        outtext=create_outtext(header,pluslines,minuslines,perturb)
        # print(outtext)
        writefile.writelines(outtext)
        print(str(outfile)+" with "+str(len(plustext))+" nodes created")

      





