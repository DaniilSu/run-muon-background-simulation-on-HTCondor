#include <iostream>
#include <fstream>

#include "TChain.h"
#include "TString.h"
using namespace std;

void number_of_evts (TString arg) {
  TChain * ch = new TChain("cbmsim");
  ch->Add("/eos/experiment/ship/data/Mbias/background-prod-2018/"+arg);
  ofstream myfile;
  myfile.open ("number.txt");
  myfile << ch->GetEntries() << endl;
  myfile.close();
}
