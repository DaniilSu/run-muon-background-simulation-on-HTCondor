#!/bin/bash
CURR_DIR="$(pwd)"
cd /afs/cern.ch/user/d/dasukhon/workspace/FairShip-align-1.7
source /cvmfs/ship.cern.ch/SHiP-2020/latest/setUp.sh
cd -
set -ux
cd $CURR_DIR
export ALIBUILD_WORK_DIR=/afs/cern.ch/user/d/dasukhon/workspace/FairShip-align-1.7/sw
source /afs/cern.ch/user/d/dasukhon/workspace/FairShip-align-1.7/config.sh
if [ -f $(dirname $(dirname "$2"))/"$1" ]; then
	echo "Target exists. Nothing to do"
else
	hadd "$1" $(eval echo "$2") && xrdcp "$1" root://eospublic.cern.ch/$(dirname $(dirname "$2"))/"$1"
fi
if [ ! -f $(dirname $(dirname "$2"))/ship.conical.MuonBack-TGeant4_TM_piled_up.root ]; then
	xrdcp root://eospublic.cern.ch/$(dirname $(dirname "$2"))/"$1" ship.conical.MuonBack-TGeant4_TM.root
	python "$FAIRSHIP"/python/pileUpEventsStrawTubes.py -f ship.conical.MuonBack-TGeant4_TM.root -g root://eospublic.cern.ch/$(dirname $(dirname "$2"))/geofile_full.conical.MuonBack-TGeant4.root
	xrdcp ship.conical.MuonBack-TGeant4_TM_piled_up.root root://eospublic.cern.ch/$(dirname $(dirname "$2"))/ship.conical.MuonBack-TGeant4_TM_piled_up.root
fi
if [ ! -f $(dirname $(dirname "$2"))/ship.conical.MuonBack-TGeant4_FH_piled_up.root ]; then
	xrdcp root://eospublic.cern.ch/$(dirname $(dirname "$2"))/"$1" ship.conical.MuonBack-TGeant4_FH.root
	python "$FAIRSHIP"/python/pileUpEventsStrawTubes.py -f ship.conical.MuonBack-TGeant4_FH.root -g root://eospublic.cern.ch/$(dirname $(dirname "$2"))/geofile_full.conical.MuonBack-TGeant4.root
	xrdcp ship.conical.MuonBack-TGeant4_FH_piled_up.root root://eospublic.cern.ch/$(dirname $(dirname "$2"))/ship.conical.MuonBack-TGeant4_FH_piled_up.root
fi
if [ ! -f $(dirname $(dirname "$2"))/ship.conical.MuonBack-TGeant4_AR_piled_up.root ]; then
	xrdcp root://eospublic.cern.ch/$(dirname $(dirname "$2"))/"$1" ship.conical.MuonBack-TGeant4_AR.root
	python "$FAIRSHIP"/python/pileUpEventsStrawTubes.py -f ship.conical.MuonBack-TGeant4_AR.root -g root://eospublic.cern.ch/$(dirname $(dirname "$2"))/geofile_full.conical.MuonBack-TGeant4.root
	xrdcp ship.conical.MuonBack-TGeant4_AR_piled_up.root root://eospublic.cern.ch/$(dirname $(dirname "$2"))/ship.conical.MuonBack-TGeant4_AR_piled_up.root
fi
exit 0
