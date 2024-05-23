#!/bin/bash

CURRENT_DIR=$(cd $(dirname $0); pwd)

target_dir=$1
if [ -z "$target_dir" ]; then
    target_dir=$CURRENT_DIR
fi

if [ ! -d "$target_dir" ]; then
    echo "${target_dir} unkown directory"
    exit 1
fi


cd $target_dir
echo "finding<= ${target_dir}"

# convert
find . -type f -name "*.json" | while read filename; do
    srs_file=${filename%.json}.srs
    echo "source << ${filename}"
    ./sing-box rule-set compile $filename -o $srs_file
    echo -e "output >> ${srs_file}\n"
done

#END FILE