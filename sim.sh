#!/bin/bash
CURR_DIR="$(pwd)"
cd /afs/cern.ch/user/d/dasukhon/workspace/FairShip-align-1.7
source /cvmfs/ship.cern.ch/SHiP-2020/latest/setUp.sh
set -uxm
echo "Starting script."
DIR=$1
ProcId=$2
LSB_JOBINDEX=$((ProcId+1))
MUONS=/eos/experiment/ship/data/Mbias/background-prod-2018/"$4"
NJOBS=$3
TANK=6
ISHIP=3
MUSHIELD=9
STRAWS=10
CALO=3
SEED=1
cd $CURR_DIR
export ALIBUILD_WORK_DIR=/afs/cern.ch/user/d/dasukhon/workspace/FairShip-align-1.7/sw
source /afs/cern.ch/user/d/dasukhon/workspace/FairShip-align-1.7/config.sh
#if eos stat /eos/experiment/ship/user/dasukhon/"$DIR"/"$LSB_JOBINDEX"/ship.conical.MuonBack-TGeant4.root; then
if [ -f /eos/experiment/ship/user/dasukhon/"$DIR"/"$LSB_JOBINDEX"/ship.conical.MuonBack-TGeant4.root ]; then
	echo "Target exists, nothing to do."
else
	root -q -b number_of_evts.C'("'$4'")'
	NTOTAL=$(cat number.txt)
	N=$(( NTOTAL/NJOBS + ( LSB_JOBINDEX == NJOBS ? NTOTAL % NJOBS : 0 ) ))
	FIRST=$(((NTOTAL/NJOBS)*(LSB_JOBINDEX-1)))
	python "$FAIRSHIP"/macro/run_simScript.py --strawDesign $STRAWS --caloDesign $CALO --tankDesign $TANK --muShieldDesign $MUSHIELD --MuonBack --nEvents $N --firstEvent $FIRST --seed $SEED --sameSeed $SEED -f $MUONS --nuTauTargetDesign $ISHIP
	if [ ! -d /eos/experiment/ship/user/dasukhon/"$DIR"/"$LSB_JOBINDEX" ]; then
		mkdir /eos/experiment/ship/user/dasukhon/"$DIR"/"$LSB_JOBINDEX"
	fi
	xrdcp ship.conical.MuonBack-TGeant4.root root://eospublic.cern.ch//eos/experiment/ship/user/dasukhon/"$DIR"/"$LSB_JOBINDEX"/
	if [ "$LSB_JOBINDEX" -eq 1 ]; then
		xrdcp geofile_full.conical.MuonBack-TGeant4.root root://eospublic.cern.ch//eos/experiment/ship/user/dasukhon/"$DIR"/
	fi
fi
if [ ! -f /eos/experiment/ship/user/dasukhon/"$DIR"/"$LSB_JOBINDEX"/ship.conical.MuonBack-TGeant4_TM.root ]; then
	xrdcp root://eospublic.cern.ch//eos/experiment/ship/user/dasukhon/"$DIR"/"$LSB_JOBINDEX"/ship.conical.MuonBack-TGeant4.root root://eospublic.cern.ch//eos/experiment/ship/user/dasukhon/"$DIR"/"$LSB_JOBINDEX"/ship.conical.MuonBack-TGeant4_TM.root
fi
if [ ! -f /eos/experiment/ship/user/dasukhon/"$DIR"/"$LSB_JOBINDEX"/ship.conical.MuonBack-TGeant4_FH.root ]; then
	xrdcp root://eospublic.cern.ch//eos/experiment/ship/user/dasukhon/"$DIR"/"$LSB_JOBINDEX"/ship.conical.MuonBack-TGeant4.root root://eospublic.cern.ch//eos/experiment/ship/user/dasukhon/"$DIR"/"$LSB_JOBINDEX"/ship.conical.MuonBack-TGeant4_FH.root
fi
if [ ! -f /eos/experiment/ship/user/dasukhon/"$DIR"/"$LSB_JOBINDEX"/ship.conical.MuonBack-TGeant4_AR.root ]; then
	xrdcp root://eospublic.cern.ch//eos/experiment/ship/user/dasukhon/"$DIR"/"$LSB_JOBINDEX"/ship.conical.MuonBack-TGeant4.root root://eospublic.cern.ch//eos/experiment/ship/user/dasukhon/"$DIR"/"$LSB_JOBINDEX"/ship.conical.MuonBack-TGeant4_AR.root
fi
exit 0
