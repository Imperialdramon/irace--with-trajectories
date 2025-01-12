#!/bin/bash

cnf_filename=$1
outfile=$2
seed=$3
shift 3

#echo $@

me=100000
while [ $# != 0 ]; do
    flag="$1"
    case "$flag" in
        -cr) if [ $# -gt 1 ]; then
              arg="$2"
              shift
              cr=$arg
            fi
            ;;
        -mr) if [ $# -gt 1 ]; then
              arg="$2"
              shift
              mr=$arg
            fi
            ;;
        -ps) if [ $# -gt 1 ]; then
              arg="$2"
              shift
              ps=$arg
            fi
            ;;
#        -co) if [ $# -gt 1 ]; then
#              arg="$2"
#              shift
#              co=$arg
#            fi
#	    ;;
        *) echo "Unrecognized flag or argument: $flag"
            ;;
        esac
    shift
done

temp=temp.dat
rm -rf ${temp}

co=1

#linea de codigo a especificar 
echo "./ga-nk-wols ${cnf_filename} ${temp} ${cr} ${mr} ${ps} ${me} ${seed} ${co}"
#echo "./ga-nk-wols ${cnf_filename} ${temp} ${cr} ${mr} ${ps} ${me} ${seed} ${co}" 1>&2
./ga-nk-wols ${cnf_filename} ${temp} ${cr} ${mr} ${ps} ${me} ${seed} ${co}
evals=`tail -1 ${temp} |awk '{print $5}'`

runlength=${evals}

solved="SAT"
runtime=0
best_sol=0

#echo "Result for ParamILS: ${solved}, ${runtime}, ${runlength}, ${best_sol}, ${seed}"

echo ${runlength} > ${outfile}

