import sys
a= open(sys.argv[1],"r") # .yaml file from partis partition as input
b=a.readlines()
c1= open(sys.argv[2],"w") # .txt file for partitions with sequences in one file
c2= open(sys.argv[3],"w") #.txt file for naive sequences
l=len(b)
x=""
n=0
for i in range (0,l,1):
        x= b[i]
        y= x.rsplit(': ["') #finding pattern to file using : [" as the start
l= len(y)
for j in range(1,l,5): #5 because skipping the lines that don't have sequences
	n=n+1
	c1.write("partition"+" " +str(n)+ "\n")
	c2.write(">partition"+" " +str(n)+ "\n")
	z= y[j]
	d= z.split('"], "d_5p_del') #omitting everything other than the family of sequences
	s= d[0]
	r= s.split('", "') #splitting each sequence in the family
	l1 = len(r)
	for k in range (0, l1, 1):
		c1.write("fam"+ str(n) + "seq"+str(k+1) +"\n"+ r[k] + "\n")
	c1.write("\n")        
	s1= d[1] #contains naive sequences
	q= s1.split('naive_seq": "') #pattern for naive sequences
	s2= q[1]
	q2= s2.split('", "cdr3_length":')
	c2.write(str(q2[0])+ "\n" + "\n")

