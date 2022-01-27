import sys
a= open(sys.argv[1],"r")
b=a.readlines()
c1= open(sys.argv[2],"w") #file for partitions with sequences in one file
c2= open(sys.argv[3],"w") #file for naive sequences
l=len(b)
x=""
n=0

for i in range (0,l,1):
        x= b[i]
        y= x.rsplit(': ["') #finding pattern to file using : [" as the start
l= len(y)
for j in range(1,l,6): #6 because skipping the lines that don't have sequences
	n=n+1
	c1.write("partition"+"_" +str(n)+ "\n")
	#c2.write(">partition"+" " +str(n)+ "\n")
	z= y[j]
	d= z.split('"], "d_5p_del') #omitting everything other than the family of sequences
	s= d[0]
	r= s.split('", "') #splitting each sequence in the family
	l1 = len(r)
	for k in range (0, l1, 1):
		c1.write("seq"+str(k+1) +"\n"+ r[k] + "\n")
	c1.write("\n")        

n=0
for j in range(2,l,6):
    n=n+1
    c2.write("partition"+"_" +str(n)+ "\n")
    z2= y[j]
    d2= z2.split(', "cdr3_length": ')
    d3 = d2[0]
    d4=d3.split("naive_seq")
    d5=d4[1]
    d6=d5.split('": "')
    d7 = d6[1][:-1]
    c2.write(str(d7)+ "\n" + "\n")
    
