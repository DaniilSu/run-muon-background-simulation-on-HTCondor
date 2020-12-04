#!/bin/bash

for i in `seq 1000 1000 66000`;
do
	cp job0.dag job"$i".dag
	sed -i '1s|.*|VARS ALL_NODES directory="MuonBackSim2018Alignment/1.7/MuonBackSim2018straw10file'"$i"'" N="100"|' job"$i".dag
	sed -i '2s|.*|VARS simulation filename="pythia8_Geant4_10.0_withCharmandBeauty'"$i"'_mu.root"|' job"$i".dag
	sed -i '9s|.*|DOT dag'"$i"'.dot UPDATE|' job"$i".dag
done
