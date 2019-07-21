************************************************
*      Master do file for enrollmentdata       *
************************************************

/*
Created by: Chris
Started on: 11/07/2019
Last updated on: 11/07/2019
	
This runs all the code I have written for V6 in succession

Content:
1) set globals
2) running of do files

*/

**set globals which correspond to file structure--------------------------------

**root filepath
gl path "C:\Users\chris\Google Drive\Charitysciencehealth\datawork"

**target data
global raw "$path\1_all enrollment raw"

**target dofiles
global doit "$path\2_do files"

**target ouput
global output "$path\3_output files"


**running do files--------------------------------------------------------------
clear all
do "$doit\enrollmentdata_v6_clean.do"
do "$doit\enrollmentdata_v5_clean.do"
do "$doit\enrollmentdata_merge.do"



