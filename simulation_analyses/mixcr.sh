for i in *.fasta
do
mixcr align --species HomoSapiens $i $i.vdjca
mixcr assemble $i.vdjca $i.clns
mixcr exportClones $i.clns $i.txt
done
