#!/bin/bash
CURR_DIR="$(pwd)"
cd /afs/cern.ch/user/d/dasukhon/workspace/FairShip-align-1.7
source /cvmfs/ship.cern.ch/SHiP-2020/latest/setUp.sh
cd -
set -ux
cd $CURR_DIR
export ALIBUILD_WORK_DIR=/afs/cern.ch/user/d/dasukhon/workspace/FairShip-align-1.7/sw
source /afs/cern.ch/user/d/dasukhon/workspace/FairShip-align-1.7/config.sh
if [ -f $(dirname $(dirname "$2"))/"$1"_TM_rec.root ]; then
	echo "Target exists. Nothing to do"
else
	hadd "$1"_TM_rec.root $(eval echo "$2"_TM_rec.root) && xrdcp "$1"_TM_rec.root root://eospublic.cern.ch/$(dirname $(dirname "$2"))/"$1"_TM_rec.root
fi
	python "$FAIRSHIP"/python/shipStrawTracking.py -f root://eospublic.cern.ch/$(dirname $(dirname "$2"))/"$1"_TM_rec.root -g root://eospublic.cern.ch/$(dirname $(dirname "$2"))/geofile_full.conical.MuonBack-TGeant4.root --output=hists_TM.root
	xrdcp -f hists_TM.root root://eospublic.cern.ch/$(dirname $(dirname "$2"))/
if [ -f $(dirname $(dirname "$2"))/"$1"_FH_rec.root ]; then
	echo "Target exists. Nothing to do"
else
	hadd "$1"_FH_rec.root $(eval echo "$2"_FH_rec.root) && xrdcp "$1"_FH_rec.root root://eospublic.cern.ch/$(dirname $(dirname "$2"))/"$1"_FH_rec.root
fi
	python "$FAIRSHIP"/python/shipStrawTracking.py -f root://eospublic.cern.ch/$(dirname $(dirname "$2"))/"$1"_FH_rec.root -g root://eospublic.cern.ch/$(dirname $(dirname "$2"))/geofile_full.conical.MuonBack-TGeant4.root --output=hists_FH.root
	xrdcp -f hists_FH.root root://eospublic.cern.ch/$(dirname $(dirname "$2"))/
if [ -f $(dirname $(dirname "$2"))/"$1"_AR_rec.root ]; then
	echo "Target exists. Nothing to do"
else
	hadd "$1"_AR_rec.root $(eval echo "$2"_AR_rec.root) && xrdcp "$1"_AR_rec.root root://eospublic.cern.ch/$(dirname $(dirname "$2"))/"$1"_AR_rec.root
fi
	python "$FAIRSHIP"/python/shipStrawTracking.py -f root://eospublic.cern.ch/$(dirname $(dirname "$2"))/"$1"_AR_rec.root -g root://eospublic.cern.ch/$(dirname $(dirname "$2"))/geofile_full.conical.MuonBack-TGeant4.root --output=hists_AR.root
	xrdcp -f hists_AR.root root://eospublic.cern.ch/$(dirname $(dirname "$2"))/
if [ ! -f $(dirname $(dirname "$2"))/ship.conical.MuonBack-TGeant4_TM_piled_up_rec.root ]; then
	python "$FAIRSHIP"/macro/ShipReco.py -f root://eospublic.cern.ch/$(dirname $(dirname "$2"))/ship.conical.MuonBack-TGeant4_TM_piled_up.root -g root://eospublic.cern.ch/$(dirname $(dirname "$2"))/geofile_full.conical.MuonBack-TGeant4.root --realPR=TemplateMatching
	xrdcp ship.conical.MuonBack-TGeant4_TM_piled_up_rec.root root://eospublic.cern.ch/$(dirname $(dirname "$2"))/
fi
	python "$FAIRSHIP"/python/shipStrawTracking.py -f root://eospublic.cern.ch/$(dirname $(dirname "$2"))/"$1"_TM_piled_up_rec.root -g root://eospublic.cern.ch/$(dirname $(dirname "$2"))/geofile_full.conical.MuonBack-TGeant4.root --output=hists_TM_piled_up.root
	xrdcp -f hists_TM_piled_up.root root://eospublic.cern.ch/$(dirname $(dirname "$2"))/

if [ ! -f $(dirname $(dirname "$2"))/ship.conical.MuonBack-TGeant4_FH_piled_up_rec.root ]; then
	python "$FAIRSHIP"/macro/ShipReco.py -f root://eospublic.cern.ch/$(dirname $(dirname "$2"))/ship.conical.MuonBack-TGeant4_FH_piled_up.root -g root://eospublic.cern.ch/$(dirname $(dirname "$2"))/geofile_full.conical.MuonBack-TGeant4.root --realPR=FH
	xrdcp ship.conical.MuonBack-TGeant4_FH_piled_up_rec.root root://eospublic.cern.ch/$(dirname $(dirname "$2"))/
fi
	python "$FAIRSHIP"/python/shipStrawTracking.py -f root://eospublic.cern.ch/$(dirname $(dirname "$2"))/"$1"_FH_piled_up_rec.root -g root://eospublic.cern.ch/$(dirname $(dirname "$2"))/geofile_full.conical.MuonBack-TGeant4.root --output=hists_FH_piled_up.root
	xrdcp -f hists_FH_piled_up.root root://eospublic.cern.ch/$(dirname $(dirname "$2"))/

if [ ! -f $(dirname $(dirname "$2"))/ship.conical.MuonBack-TGeant4_AR_piled_up_rec.root ]; then
	python "$FAIRSHIP"/macro/ShipReco.py -f root://eospublic.cern.ch/$(dirname $(dirname "$2"))/ship.conical.MuonBack-TGeant4_AR_piled_up.root -g root://eospublic.cern.ch/$(dirname $(dirname "$2"))/geofile_full.conical.MuonBack-TGeant4.root --realPR=AR
	xrdcp ship.conical.MuonBack-TGeant4_AR_piled_up_rec.root root://eospublic.cern.ch/$(dirname $(dirname "$2"))/
fi
	python "$FAIRSHIP"/python/shipStrawTracking.py -f root://eospublic.cern.ch/$(dirname $(dirname "$2"))/"$1"_AR_piled_up_rec.root -g root://eospublic.cern.ch/$(dirname $(dirname "$2"))/geofile_full.conical.MuonBack-TGeant4.root --output=hists_AR_piled_up.root
	xrdcp -f hists_AR_piled_up.root root://eospublic.cern.ch/$(dirname $(dirname "$2"))/
exit 0
