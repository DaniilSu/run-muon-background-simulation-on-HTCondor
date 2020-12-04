#!/bin/bash

while IFS=' ' read -ra i || [[ -n "$line" ]];
do
	rm -v "$1""${i[0]}"/ship*
#	rm -v "$1""${i[0]}"/*/*_rec.root
	rm -v "$1""${i[0]}"/"${i[1]}"/*
done < "$2"
