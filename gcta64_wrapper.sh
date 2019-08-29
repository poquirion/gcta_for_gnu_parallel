#!/bin/bash

export GCTA_BASEDIR=${GCT_BASEDIR:=/lustre03/project/6004777/projects/uk_biobank/GCTA/GTEx2_data_june_2019/}


export GCTA_FULL_UREL_DIR=${GCT_FULL_UREL_DIR:=/lustre03/project/6004777/projects/uk_biobank/GCTA/full_unrel/}


usage () {

cat  << EO_MARCUS_MAIL
  $0  <tissue> <chr> <ma_file> <outname> 
  tissue = Tissue name
  chr = chromosome
  ma_file = table with conditioning variants
  outname = name for output file

  GCTA_BASEDIR  = ${GCT_BASEDIR}
  GCTA_FULL_UREL_DIR = ${GCTA_FULL_UREL_DIR}
  you can set these two env vars to change their value
EO_MARCUS_MAIL
}


if [ $# -ne 4  ]; then

  usage
  echo exit 0
fi

tissue=$1
chr=$2
ma_file=$3
outname=$4



GCTA_BIN=/lustre03/project/6004777/projects/uk_biobank/GCTA/gcta64


move_locally () {
  src_dir=$1
  tmp_dir=$2
  file_name=$3
  echo $src_dir $file_name $tmp_dir
  mkdir ${tmp_dir} 2>/dev/null
  not_first=$?

  # if not first wait for file to be there
  # if first transfert the file in .tmp and rename them when all is done.
  if [ $not_first -eq 1 ] ; then
    echo transfer by other process
    # wait for another process to finish the transfer
    while [ ! -f ${tmp_dir}/${file_name}.fam ];   do
      sleep 2
    done
  else
    echo This process do the file transfere
    # you'r the first process, do the transfer yourself!
    mkdir ${tmp_dir}/.tmp
    cp ${src_dir}/${file_name}.{bim,bed,fam} ${tmp_dir}/.tmp/
    mv  ${tmp_dir}/.tmp/* ${tmp_dir}
    rm -r ${tmp_dir}/.tmp

  fi

  echo transfere of ${file_name} to ${tmp_dir} done

}


file_input=filtered_unrelated_chr${chr}
tmp_dir=$(echo ${GCTA_FULL_UREL_DIR} | tr '/' '_')
tmp_dir=${SLURM_TMPDIR}/${tmp_dir}_${file_input} 2>/dev/null

move_locally ${GCTA_FULL_UREL_DIR}  $tmp_dir $file_input

running
cat << TRUITE
${GCTA_BIN} \
  --bfile ${tmp_dir}/${file_input} \
  --extract ${GCTA_BASEDIR}/${tissue}/snplist_files/snplist_${ma_file} \
  --threads 1 \
  --maf 0.01 \
  --cojo-file ${GCTA_BASEDIR}/${tissue}/${ma_file} \
  --cojo-slct \
  --out ${GCTA_BASEDIR}/${tissue}/out/${outname}
TRUITE

mkdir -p ${GCTA_BASEDIR}/${tissue}/out

${GCTA_BIN} \
   --bfile ${tmp_dir}/${file_input} \
  --extract ${GCTA_BASEDIR}/${tissue}/snplist_files/snplist_${ma_file} \
  --threads 1 \
  --maf 0.01 \
  --cojo-file ${GCTA_BASEDIR}/${tissue}/${ma_file} \
  --cojo-slct \
  --out ${GCTA_BASEDIR}/${tissue}/out/${outname}

