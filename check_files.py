#!/bin/env python2
import click
import ROOT
import re


@click.command()
@click.argument('jobname')
@click.argument('n_jobs', default=100)
def check_files(jobname, n_jobs):
    j = 0
    total_entries = 0
    chain = ROOT.TChain('cbmsim')
    print "Folder %s" % (jobname)
    out_file = open("files_to_run.txt","a")
    for i in [
            '''root://eospublic.cern.ch//eos/experiment/ship/user/dasukhon/'''
            '''{0}/{1}/ship.conical.MuonBack-TGeant4.root'''.format(
                jobname,
                n
            )
            for n in range(1, n_jobs + 1)
    ]:
	job_number = re.findall('\d+',jobname)[-1]
        f = ROOT.TFile.Open(i)
	try:
		tree = f.Get("cbmsim")
        	print "File %d, Number of Entries: %d" % (j+1,tree.GetEntries())
        	chain.Add(i)
        	total_entries = total_entries + tree.GetEntries()
		if tree.GetEntries() == 0:
			print "    !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!   Empty File %d    !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" % (j+1)
			out_file.write(job_number+" "+str(j+1)+"\n")
			f.Close()
	except AttributeError:
		print "    !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!   Corrupted File %d    !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" % (j+1)
		out_file.write(job_number+" "+str(j+1)+"\n")
		f.Close()
		pass
	except ReferenceError:
		print "    !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!    Missing File %d     !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" % (j+1)
		out_file.write(job_number+" "+str(j+1)+"\n")
		pass
	j = j + 1

    out_file.close()
    print "Sum of Entries: %d" % (total_entries)
    print "Entries in final file: %d" % chain.GetEntries()
    if total_entries != chain.GetEntries() :
    		print "    !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!    Not Equal Entries   !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"


if __name__ == '__main__':
    check_files()
