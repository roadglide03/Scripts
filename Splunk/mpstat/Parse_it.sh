#!/bin/sh                                                                                                
# Copyright 2009-2011 Splunk, Inc.                                                                       
#                                                                                                        
#   Licensed under the Apache License, Version 2.0 (the "License");                                      
#   you may not use this file except in compliance with the License.                                     
#   You may obtain a copy of the License at                                                              
#                                                                                                        
#       http://www.apache.org/licenses/LICENSE-2.0                                                       
#                                                                                                        
#   Unless required by applicable law or agreed to in writing, software                                  
#   distributed under the License is distributed on an "AS IS" BASIS,                                    
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.                             
#   See the License for the specific language governing permissions and                                  
#   limitations under the License.      

. `dirname $0`/common.sh
LOGME=Walgreens
ExploDir=/Users/andy/Documents/Work/Customers/Walgreens/Data/Explorers
#CAT=`for i in `ls -1 /Users/andy/Documents/Work/Customers/Walgreens/Data/Perf/Output`; do for d in `ls -1 /Users/andy/Documents/Work/Customers/Walgreens/Data/Perf/Output/$i/`; do cat /Users/andy/Documents/Work/Customers/Walgreens/Data/Perf/Output/$i/$d/mpstat.out;done;done`
HEADER='CPU    pctUser    pctSystem    pctIowait    pctIdle'
HEADERIZE="BEGIN {print \"$HEADER\"}"
# CPU minf mjf xcal  intr ithr  csw icsw migr smtx  srw syscl  usr sys  wt idl
PRINTF='{printf "%-3s  %9s  %9s  %9s  %9s\n", cpu, pctUser, pctSystem, pctIowait, pctIdle}'

CMD=Exec_Parse.sh
	
        assertHaveCommand  $CMD
	FILTER='(NR<=2) {next} ($1 >= "0") {inBlock=1} (!inBlock) {next}'
        FORMAT='{cpu=$1; pctUser=$(NF-3); pctSystem=$(NF-2); pctIowait=$(NF-1); pctIdle=$(NF-0)}'

$CMD | tee $TEE_DEST | $AWK "$HEADERIZE $FILTER $FORMAT $PRINTF"  header="$HEADER"
#echo "Cmd = [$CMD];  | $AWK '$HEADERIZE $FILTER $FORMAT $PRINTF' header=\"$HEADER\"" >> $TEE_DEST
echo "Cmd = [$CMD];  | $AWK '$HEADERIZE $FILTER $FORMAT $PRINTF' header=\"$HEADER\"" >> $LOGME
