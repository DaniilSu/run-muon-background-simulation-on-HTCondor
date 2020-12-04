#!/bin/bash
if true
then
	for i in `seq 0 1000 66000`;
	do
		condor_submit_dag job"$i".dag
		sleep 2
	done
else
	tmp=-1
	while IFS=' ' read -ra i || [[ -n "$line" ]];
	do
		
		if [ $tmp -ne ${i[0]} ]; then
			condor_submit_dag job"${i[0]}".dag
			tmp=${i[0]}
			sleep 2
		fi
	done < "$1"
fi
