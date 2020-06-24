#!/bin/bash
# awk 'BEGIN{} { print length($2) } END{}' wbck.txt
awk 'BEGIN{} { if(length($2)==1) print $0 } END{}' wbck.txt
