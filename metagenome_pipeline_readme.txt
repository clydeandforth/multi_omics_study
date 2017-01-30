Prokka v1.11

Annotate assembled metagenome fasta file and bacterial genome assembly

prokka AES_ray.fasta --outdir AES_prokka --locustag AES --metagenome --centre AES

prokka --evalue 0.001 --addgenes --prefix BL --locustag BL --genus Bacillus --species licheniformis --strain spp --kingdom Bacteria --rfam Blich.fsa --outdir BL_annotated --centre -BL



BLAST v2.2.26

formatdb -i ~BL.faa -o T -p T

blastall -p blastp -i AES.faa -d ~BL.faa -F F -m 9 -b 1 -v 1 -e 0.1 > BL_blast_matches.txt



Use custom perl script to filter matching proteins for >= 97% homology for at least 50 amino acids;

./perl_search.pl BL_blast_matches.txt > BL_filtered_blast_matches.txt



To get the bacterial CD ID use Prokka gff file.

First remove the CD identified from the perl_serach.pl results

awk '{print $3}' BL_filtered_blast_matches.txt > CD_IDs.txt

Take CDS from the gff file 

awk '/CDS/' BL.gff > BL_mod.gff

then match the files against each other to get genomic coordinates

awk 'BEGIN{i=0} FNR==NR { a[i++]=$1; next } { for(j=0;j<i;j++) if(index($0,a[j])) {print $0;break}}' CD_IDS.txt BL_mod.gff > Homologous_coding_domains.txt
