## download dataset from iReceptor
## extract only the sequence ID and the sequence column of interest
## for the input file

x= open("/path_to_file.tsv", "r")
z= x.readlines()
y= open("/path_to_file.fasta", "w")
l= len(z)
for i in range (2, l, 1):
	f= z[i]
	l1= len(f)
	if "\t" in f:
		n= f.find("\t")
		y.write(">"+f[0:(n)] + "\n")
                y.write(f[(n+1):l1] + "\n")

