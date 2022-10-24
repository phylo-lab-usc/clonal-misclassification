## download dataset from iReceptor
## extract only the sequence ID and the sequence column of interest
## for the input file
import argparse

parser = argparse.ArgumentParser()
# Add an argument
parser.add_argument('-i', '--input_tsv', type=str, required=True)
parser.add_argument('-o', '--output', type=str, required=True)
# Parse the argument
args = parser.parse_args()
# Print "Hello" + the user input argument
x = open(args.input_tsv, "r")
z = x.readlines()
y = open(args.output, "w")
l = len(z)
#TODO: adapt so it can read files like minervina
for i in range(2, l, 1):
    f = z[i]
    l1 = len(f)
    if "\t" in f:
        n = f.find("\t")
        #id = f[0:(n)]
        s = f[(n + 1):l1].find("\t")
        #seq = f[(n + 1):(s+1)]
        y.write(">" + f[0:(n)] + "\n")
        y.write(f[(n + 1):(s+1)] + "\n")
