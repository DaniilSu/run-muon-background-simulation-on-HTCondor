#!/bin/bash

for i in `seq 0 1000 66000`
do
	rm job"$i".dag.*
	rm dag"$i".dot
done
