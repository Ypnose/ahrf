#!/bin/sh
# Script by Ypnose - http://ypnose.org

WORKDIR="test"
TESTREG="BLOCK_CODE_PRE BLOCK_CODE_PRE_2 BLOCK_CODE_PRE_3 
 ESCAPE_CHARS LIST_UL PAGE_LINKS_A PARAGRAPH_P TITLES_H"
OUTE="outvalid"
GENE="gen"

if [ ! -d "$WORKDIR" ]; then
	printf "%s\n" "$WORKDIR not found" >&2
	exit 1
fi

cd "$WORKDIR"
for f in $TESTREG; do
	if [ ! -f "$f" ] || [ ! -f "${f}.${OUTE}" ]; then
		printf "%s\n" "$f / ${f}.${OUTE} is missing!" >&2
		exit 1
	fi
	../ahrf.awk "$f" >"${f}.${GENE}"
	[ $? -ne 0 ] && exit 1
	diff -u "${f}.${OUTE}" "${f}.${GENE}"
	if [ $? -eq 0 ]; then
		printf "%-20s%s\n" "* $f" "...  OK" && rm "${f}.${GENE}"
	fi
done

exit
