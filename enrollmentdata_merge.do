************************************************
*        Merging Available Datasets            *
************************************************

/*
Created by: Chris
Started on: 18/07/2019
Last updated on: 18/07/2019

Goals: 
	1/ Merge available survey data
Content:
Appending all available datasets

*/
clear all

use "$output\enrollmentdata0223_v6_clean.dta"

append using "$output\enrollmentdata_v5_clean.dta"

save "$output\enrollmentdata_merged.dta", replace
