#!/bin/sh
CURR_DIR="$(pwd)"
cd /afs/cern.ch/user/d/dasukhon/workspace/FairShip-align-1.7
source /cvmfs/ship.cern.ch/SHiP-2020/latest/setUp.sh
set -uxm
echo "Starting script."
DIR=$1
ProcId=$2
LSB_JOBINDEX=$((ProcId+1))
NJOBS=$3
cd $CURR_DIR
export ALIBUILD_WORK_DIR=/afs/cern.ch/user/d/dasukhon/workspace/FairShip-align-1.7/sw
source /afs/cern.ch/user/d/dasukhon/workspace/FairShip-align-1.7/config.sh
#if eos stat /eos/experiment/ship/user/dasukhon/"$DIR"/"$LSB_JOBINDEX"/ship.conical.MuonBack-TGeant4_rec.root; then
if [ -f /eos/experiment/ship/user/dasukhon/"$DIR"/"$LSB_JOBINDEX"/ship.conical.MuonBack-TGeant4_TM_rec.root ]; then
	echo "Target exists, nothing to do."
else
	python "$FAIRSHIP"/macro/ShipReco.py -f root://eospublic.cern.ch//eos/experiment/ship/user/dasukhon/"$DIR"/"$LSB_JOBINDEX"/ship.conical.MuonBack-TGeant4_TM.root -g root://eospublic.cern.ch//eos/experiment/ship/user/dasukhon/"$DIR"/geofile_full.conical.MuonBack-TGeant4.root --realPR=TemplateMatching
	xrdcp ship.conical.MuonBack-TGeant4_TM_rec.root root://eospublic.cern.ch//eos/experiment/ship/user/dasukhon/"$DIR"/"$LSB_JOBINDEX"/
fi
if [ -f /eos/experiment/ship/user/dasukhon/"$DIR"/"$LSB_JOBINDEX"/ship.conical.MuonBack-TGeant4_FH_rec.root ]; then
	echo "Target exists, nothing to do."
else
	python "$FAIRSHIP"/macro/ShipReco.py -f root://eospublic.cern.ch//eos/experiment/ship/user/dasukhon/"$DIR"/"$LSB_JOBINDEX"/ship.conical.MuonBack-TGeant4_FH.root -g root://eospublic.cern.ch//eos/experiment/ship/user/dasukhon/"$DIR"/geofile_full.conical.MuonBack-TGeant4.root --realPR=FH
	xrdcp ship.conical.MuonBack-TGeant4_FH_rec.root root://eospublic.cern.ch//eos/experiment/ship/user/dasukhon/"$DIR"/"$LSB_JOBINDEX"/
fi
if [ -f /eos/experiment/ship/user/dasukhon/"$DIR"/"$LSB_JOBINDEX"/ship.conical.MuonBack-TGeant4_AR_rec.root ]; then
	echo "Target exists, nothing to do."
else
	python "$FAIRSHIP"/macro/ShipReco.py -f root://eospublic.cern.ch//eos/experiment/ship/user/dasukhon/"$DIR"/"$LSB_JOBINDEX"/ship.conical.MuonBack-TGeant4_AR.root -g root://eospublic.cern.ch//eos/experiment/ship/user/dasukhon/"$DIR"/geofile_full.conical.MuonBack-TGeant4.root --realPR=AR
	xrdcp ship.conical.MuonBack-TGeant4_AR_rec.root root://eospublic.cern.ch//eos/experiment/ship/user/dasukhon/"$DIR"/"$LSB_JOBINDEX"/
fi
exit 0
