#!/bin/bash

FILE=$1
SAMPLEID=${FILE%.gbf}

grep '/gene=' ${FILE} \
| sed 's/_1//p' \
| sed 's/_2//p' \
| sed 's/_3//p' \
| sed 's/_4//p' \
| sed 's/_5//p' \
| sed 's/_6//p' \
| tr -d "[:blank:]" \
| sed 's_/gene=__p' > ${SAMPLEID}.txt
