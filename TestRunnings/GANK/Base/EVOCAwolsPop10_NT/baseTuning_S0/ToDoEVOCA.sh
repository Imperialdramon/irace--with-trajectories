#!/bin/bash

toTune=$1
seed=$2

nSeeds=10
maxM=10
maxEvaluations=100000
maxTime=0
minimize=1
candidatesFile=cf.in
algo=GA

logFile=EVOCA.log
outFile=EVOCA.params

respaldos=respaldos${algo}
mkdir ${respaldos}

#maxSeeds=1
for set in $( cat ${toTune} ); do
	#crear archivo scenario y archivo parametros
        params=ALL.params
        instance=${set}.inst

	echo "cp inst/${instance} ."
        cp inst/${instance} .

	#while [ ${seed} -lt ${maxSeeds} ]; do
                outputTuner=EVOCA_A${algo}_F${set}_S${seed}.out
                echo "outputTuner=EVOCA_A${algo}_F${set}_S${seed}.out"
                echo "time ./EVOCA GA.sh ${params} inst/${instance} ${seed} ${nSeeds} ${maxM} ${maxEvaluations} ${maxTime} ${minimize} ${candidatesFile}> ${outputTuner}"
                time ./EVOCA GA.sh ${params} inst/${instance} ${seed} ${nSeeds} ${maxM} ${maxEvaluations} ${maxTime} ${minimize} ${candidatesFile}> ${outputTuner}
                echo "mv ${logFile} ${respaldos}/${logFile}_${algo}_F${set}_S${seed}"
                mv ${logFile} ${respaldos}/${logFile}_${algo}_F${set}_S${seed}
                echo "mv ${outFile} ${respaldos}/${outFile}_${algo}_F${set}_S${seed}"
                mv ${outFile} ${respaldos}/${outFile}_${algo}_F${set}_S${seed}
		tar -cvzf ${outputTuner}.tar.gz ${outputTuner}
		rm -rf ${outputTuner}

		#seed=$[$seed+1]
	#done
        mv ${instance} ${respaldos}
done

