#!/bin/bash



usage () {

cat  << EO_MARCUS_MAIL 
  $0 <tissue> <chr> <ma_file> <outname> <filterd_unrelated_path> <basepath> 


\${tissue} = Tissue name (can be used in output dir)
\${chr} = chromosome = --bfile for gcta (add path/filename: "/lustre03/project/6004777/projects/uk_biobank/GCTA/full_unrel/filtered_unrelated_chr"
\${ma_file} = table with conditioning variants
\${outname} = name for output file
/lustre03/project/6004777/projects/uk_biobank/GCTA/full_unrel/filtered_unrelated_chr\${chr} = full named path and --bfile (redundant to $chr)
\${BASEPATH}/\${tissue}/snplist_files/snplist_\${ma_file} = --extract file
\${BASEPATH}/\${tissue}/\${ma_file} = --cojo-file, simple list
\${BASEPATH}/\${tissue}/out/\${outname} = output name incl directory for my downstream R runs.
EO_MARCUS_MAIL
}


if [ $# -ne 6  ]; then

  usage

fi

