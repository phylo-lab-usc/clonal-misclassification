import sys
a=open(sys.argv[1],"r")
b= a.readlines()
#c= open(sys.argv[2],"w")
l= len(b)
n=0

for i in range(0,l,1):
    if "partition" in b[i]:
        x= str(b[i])
        n=n+1
        #c.write("partition"+"_"+str(b[i]) + ".fasta")
        c=open(x, "a")
    else:
        if "seq" in b[i]:
            c.write(b[i])
        else:
            c.write(b[i])
   


