bowtie2/2.2.4

bowtie2-build BL.fsa  BL_index

bowtie2 -x BL_index -1 Sample_1-R1.fq -2 Sample_1-R2.fq --local -S BL_L1.sam

samtools/1.2

samtools view -bS BL_L1.sam > BL_L1.bam

samtools sort BL_L1.bam BL_L1_sorted

samtools index BL_L1_sorted.bam


Bedops 

gff2bed < BL.gff > BL.bed


Bedtools v2.19.1 

bedtools multicov -bams  BL_L1_sorted.bam BL_L2_sorted.bam  -bed BL.bed  > BL_hits.bed

bedtools coverage -a BL.bed -b BL_L1_sorted.bam > L1_BL.bed

bedtools coverage -a BL.bed -b BL_L2_sorted.bam > L2_BL.bed


Use awk to add metatranscript hits against genes together;

awk 'BEGIN{FS = OFS = "\t"} {print $0, $11 + $12}' L1_BL.bed > L1_BL_hit_results.bed

and to calculate combined coverage; 

awk 'BEGIN{FS = OFS = "\t"} FNR==NR {a[(FNR"")] = $0; next} {print a[(FNR"")], $14}' L1_BL.bed L2_BL.bed > BL_combined_coverage.bed