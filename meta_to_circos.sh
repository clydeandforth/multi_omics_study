#!/bin/bash
# metagenome_to_circos
# by_James_Doonan

# find all matches to 'Gibb_' and print the four characters after the matches
awk -F 'Gibb_' '{print substr($2,0,5)}' ALS_matches.txt > RLS_Gibb_hits | xargs sed -i '/^[[:space:]]*$/d' RLS_Gibb_hits 

# remove the emptyp lines from the file
# sed -i '/^[[:space:]]*$/d' RLS_Gibb_hits |

# prepend all lines with the string Gibb_
awk '{print "Gibb_" $0;}' RLS_Gibb_hits > RLS_string | xargs awk 'BEGIN{i=0} FNR==NR { a[i++]=$1; next } { for(j=0;j<i;j++) if(index($0,a[j])) {print $0;break} }' RLS_string GQ13_mod.gff > RLS_Gibb_matches 

# match one file against the other line by line and write matches to new file
#awk 'BEGIN{i=0} FNR==NR { a[i++]=$1; next } { for(j=0;j<i;j++) if(index($0,a[j])) {print $0;break} }' RLS_string GQ13_mod.gff > RLS_Gibb_matches |

# remove all lines the the text 'CDS'
awk '!/CDS/' RLS_Gibb_matches > RLS_no_CDS_Gibb | xargs awk '/gene/' RLS_no_CDS_Gibb > RLS_genes_Gibb

# select all of the lines matching the word 'gene' and write them to a new file
#awk '/gene/' RLS_no_CDS_Gibb > RLS_genes_Gibb 

# print columns 1,4 and 5 to a new file
awk '{print $1,$4,$5}' RLS_genes_Gibb > GQ13_RLS1 | xargs sed 's/GQ13_pacbio/chr1/g' GQ13_RLS1 > GQ13_RLS

# substitue the text unitig_0_quiver and replace it with chr1
#sed 's/unitig_0_quiver/chr1/g' GQ13_RLS > GQ13_RLS

