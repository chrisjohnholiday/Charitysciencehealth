************************************************
*              IDI Report 0223                 *
************************************************

/*
Created by: Chris
Started on: 02/07/2019
Last updated on: 02/07/2019

Goals: 
	1/ Generate report for IDI enrollment data
Content:
**Importing**
**Distribution report**


*/
**setpaths only if you do not have access to the master file
gl path "C:\Users\chris\Google Drive\Charitysciencehealth\datawork"
	
	global raw "$path\1_all enrollment raw"
	global output "$path\3_output files"
global doit "$path\2_do files"

**path generation

capture mkdir "$output\IDI_Report"

**Importing---------------------------------------------------------------------

clear all 
use "$output\enrollmentdata_0223_monitoring_and_evaluation.dta"

**keep if IDI data

/*keep if member_name == "Suchita tiwari" | member_name == "Sonu verma" ///
 | member_name == "Sangeeta Devi" | member_name == "Rajan Singh" | ///
 member_name == "Pradeep kumar mishra" | member_name == "BRAHM DEV VERMA" 
*/
**General information about survey----------------------------------------------

estpost tab member_name
	esttab using "$output\IDI_report\member_name_distribution.tex", ///
	replace cells("b(label(Number of Submissions)) pct(fmt(2))") unstack noobs ///
	title("Number of Submissions for each Surveyor")
	eststo clear


**General information about respondent------------------------------------------

local generalinfo eligibility_check_pregnant eligibility_check_child ///
eligibility_check_phone_number


foreach var of local generalinfo {
	replace `var' = "Yes" if `var' == "1"
	replace `var' = "No" if `var' == "0"
	estpost tab `var'
	esttab using "$output\IDI_report\\`var'_distribution.tex", ///
	replace cells("b(label(Frequency)) pct(fmt(2))") unstack noobs ///
	title("`var' Distribution")
	eststo clear
	
}

replace maternal_home_visit = "Yes" if maternal_home_visit == "1"
	replace maternal_home_visit = "No" if maternal_home_visit == "0"
	estpost tab maternal_home_visit if eligibility_check_pregnant == "Yes"
	esttab using "$output\IDI_report\maternal_home_visit_distribution.tex", ///
	replace cells("b(label(Frequency)) pct(fmt(2))") unstack noobs ///
	title("Returning to Maternal Home to Give Birth?")
	eststo clear

replace respondent_relationship_to_mothe = "The Mother" ///
if respondent_relationship_to_mothe == "0"
replace respondent_relationship_to_mothe = "Husband" ///
if respondent_relationship_to_mothe == "1"
replace respondent_relationship_to_mothe = "Sister" ///
if respondent_relationship_to_mothe == "2"
replace respondent_relationship_to_mothe = "Sister-in-law" ///
if respondent_relationship_to_mothe == "3"
replace respondent_relationship_to_mothe = "Brother" ///
if respondent_relationship_to_mothe == "4"
replace respondent_relationship_to_mothe = "Brother-in-law" ///
if respondent_relationship_to_mothe == "5"
replace respondent_relationship_to_mothe = "Father" ///
if respondent_relationship_to_mothe == "6"
replace respondent_relationship_to_mothe = "Father-in-law" ///
if respondent_relationship_to_mothe == "7"
replace respondent_relationship_to_mothe = "Mother" ///
if respondent_relationship_to_mothe == "8"
replace respondent_relationship_to_mothe = "Mother-in-law" ///
if respondent_relationship_to_mothe == "9"
replace respondent_relationship_to_mothe = "Nephew/niece" ///
if respondent_relationship_to_mothe == "10"
replace respondent_relationship_to_mothe = "Neighbour" ///
if respondent_relationship_to_mothe == "11"
replace respondent_relationship_to_mothe = "Any Other" ///
if respondent_relationship_to_mothe == "12"

estpost tab respondent_relationship_to_mothe
	esttab using "$output\IDI_report\respondentrelation_distribution.tex", ///
	replace cells("b(label(Frequency)) pct(fmt(2))") unstack noobs ///
	title("Respondent Relationship to Mother Distribution")
	eststo clear


replace respondent_literacy_level = "Respondent understands in full" ///
if respondent_literacy_level == "0"
replace respondent_literacy_level = "Respondent understands partly" ///
if respondent_literacy_level == "1"
replace respondent_literacy_level = "Respondent does not understand" ///
if respondent_literacy_level == "2"
estpost tab respondent_literacy_level
	esttab using "$output\IDI_report\respondentliteracy_distribution.tex", ///
	replace cells("b(label(Frequency)) pct(fmt(2))") unstack noobs ///
	title("Respondent Relationship Literacy")
	eststo clear

	
replace mothers_preferred_language = "Hindi" ///
if mothers_preferred_language == "0"
replace mothers_preferred_language = "English" ///
if mothers_preferred_language == "1"
replace mothers_preferred_language = "Bengali" ///
if mothers_preferred_language == "2"
replace mothers_preferred_language = "Gujarati" ///
if mothers_preferred_language == "3"
replace mothers_preferred_language = "Marathi" ///
if mothers_preferred_language == "4"
replace mothers_preferred_language = "Assameese" ///
if mothers_preferred_language == "5"
replace mothers_preferred_language = "Kashmiri" ///
if mothers_preferred_language == "6"
replace mothers_preferred_language = "Tamil" ///
if mothers_preferred_language == "7"
replace mothers_preferred_language = "Any other" ///
if mothers_preferred_language == "8"

estpost tab mothers_preferred_language
esttab using "$output\IDI_report\preferredlanguage_distribution.tex", ///
replace cells("b(label(Frequency)) pct(fmt(2))") unstack noobs ///
title("Mother Preferred Language Distribution")
eststo clear


**Consent data------------------------------------------------------------------

local consentdata preliminary_consent consent mcp_card_photo_consent ///
prenatal_receipt_photo_consent vacc_card_photo_consent1 ///
vacc_receipt_photo_consen1

foreach var of local consentdata {
	replace `var' = "Yes" if `var' == "1"
	replace `var' = "No" if `var' == "0"
	replace `var' = "Unrecorded" if `var' == "."
	estpost tab `var'
	esttab using "$output\IDI_report\\`var'_distribution.tex", ///
	replace cells("b(label(Frequency)) pct(fmt(2))") unstack noobs ///
	title("`var' Consent Distribution")
	eststo clear
}

**Past SMS vaccination reminders------------------------------------------------
local pasts past_sms_vaccination_reminders past_voice_vaccination_reminders

foreach var of local pasts {
	replace `var' = "Yes" if `var' == "1"
	replace `var' = "No" if `var' == "0"
	replace `var' = "Unrecorded" if `var' == "."
	estpost tab `var'
	esttab using "$output\IDI_report\\`var'_distribution.tex", ///
	replace cells("b(label(Frequency)) pct(fmt(2))") unstack noobs
	eststo clear
}


**Smartphone flags (These are dummys)-------------------------------------------

local smartphoneflags alternate_contact1_smartphone_fl ///
mothers_contact_smartphone_flag fathers_contact_smartphone_flag ///
 maternalhome_contact_smartphone_ alternate_contact2_smartphone_fl 

foreach var of local smartphoneflags {
	replace `var' = "Button Wala Phone" if `var' == "1"
	replace `var' = "Touch Wala Phone" if `var' == "2"
	replace `var' = "No Phone" if `var' == "0"
	replace `var' = "Unrecorded" if `var' == "."
	estpost tab `var'
	esttab using "$output\IDI_report\\`var'_distribution.tex", ///
	replace cells("b(label(Frequency)) pct(fmt(2))") unstack noobs ///
	title("`var' Distribution")
	eststo clear
}


**Availability of documents (These are dummys)----------------------------------

local availabledocs mcp_card_available due_date_mcp_card_present_flag ///
last_menstrual_prd_ last_prenatal_visit_date_mcp_car ///
prenatal_receipt_available vaccination_card_availabl1 ///
vacc_receipt_flag1

foreach var of local availabledocs {
	replace `var' = "Yes" if `var' == "1"
	replace `var' = "No" if `var' == "0"
	replace `var' = "Unrecorded" if `var' == "."
}

estpost tab mcp_card_available if eligibility_check_pregnant == "Yes"
esttab using "$output\IDI_report\mcpcardavailable_distribution.tex", ///
replace cells("b(label(Frequency)) pct(fmt(2))") unstack noobs ///
title("MCP Card Availability Distribution") ///
addnotes("Given that the respondent is a pregnant mother")
eststo clear

estpost tab last_menstrual_prd_ if mcp_card_available == "Yes"
esttab using "$output\IDI_report\menstrualprdavailable_distribution.tex", ///
replace cells("b(label(Frequency)) pct(fmt(2))") unstack noobs ///
title("MCP Card Last Menstrual Period Availability Distribution") ///
addnotes("Given that the respondent has an MCP card")
eststo clear

estpost tab last_prenatal_visit_date_mcp_car if mcp_card_available == "Yes"
esttab using "$output\IDI_report\last_prenatal_visit_date_mcp_car_distribution.tex", ///
replace cells("b(label(Frequency)) pct(fmt(2))") unstack noobs ///
title("MCP Card Last Last Prenatal Visit Availability Distribution") ///
addnotes("Given that the respondent has an MCP card")
eststo clear

estpost tab prenatal_receipt_available if eligibility_check_pregnant == "Yes"
esttab using "$output\IDI_report\prenatalreceiptavailable_distribution.tex", ///
replace cells("b(label(Frequency)) pct(fmt(2))") unstack noobs ///
title("Prenatal Reciept Availability Distribution")
eststo clear

estpost tab vaccination_card_availabl1 if eligibility_check_child == "Yes"
esttab using "$output\IDI_report\vaccinatinocardavailable_distribution.tex", ///
replace cells("b(label(Frequency)) pct(fmt(2))") unstack noobs ///
title("Vaccination Card Availability Distribution") ///
addnotes("Given that the respondent has an eligible child")
eststo clear

estpost tab vacc_receipt_flag1 if eligibility_check_child == "Yes"
esttab using "$output\IDI_report\vaccreceiptavailable_distribution.tex", ///
replace cells("b(label(Frequency))") unstack noobs ///
title("Vaccination Reciept Availability Distribution") ///
addnotes("Given that the respondent has an eligible child")
eststo clear


**Recalls (These are integers)--------------------------------------------------

local recalls due_date_recall_confidence last_prenatal_visit_recall_cnf ///
last_vacc_date_recall_con1 number_of_vacc_visits_rec1

foreach var of local recalls {
	replace `var' = "Sure of exact date" if `var' == "0"
	replace `var' = "Sure of date within week" if `var' == "1"
	replace `var' = "Sure only of month" if `var' == "2"
	replace `var' = "Not sure at all" if `var' == "3"
	estpost tab `var'
	esttab using "$output\IDI_report\\`var'_distribution.tex", ///
	replace cells("b(label(Frequency)) pct(fmt(2))") unstack noobs ///
	title("`var'_Distribution")
	eststo clear
}


**Demographics of children------------------------------------------------------

replace second_child_flag = "Second Eligible Child" ///
if second_child_flag == "1" 
replace second_child_flag = "No Second Eligible Child" ///
if second_child_flag == "0"
replace second_child_flag = "Unrecorded" if second_child_flag == "."
estpost tab second_child_flag
esttab using "$output\IDI_report\Secondeligible_distribution.tex", ///
replace cells("b(label(Frequency)) pct(fmt(2))") unstack noobs ///
title("Was there a second eligible child?")
eststo clear

replace first_child1 = "Was her first child" ///
if first_child1 == "1" 
replace first_child1 = "Was not her first child" ///
if first_child1 == "0"
replace first_child1 = "Unrecorded" if first_child1 == "."
estpost tab first_child1
esttab using "$output\IDI_report\firstchild_distribution.tex", ///
replace cells("b(label(Frequency)) pct(fmt(2))") unstack noobs ///
title("Was the eligible child her first child?")
eststo clear

estpost tab gender1 if eligibility_check_child == "Yes"
esttab using "$output\IDI_report\gender_distribution.tex", ///
replace cells("b(label(Frequency)) pct(fmt(2))") unstack noobs ///
title("Gender of the Child")
eststo clear

**Dates of birth----------------------------------------------------------------

estpost sum due_date_recall if eligibility_check_pregnant == "Yes"
	esttab using "$output\IDI_report\due_date_recall_distribution.tex", ///
	replace cells("mean(fmt(%td)) sd(fmt(%9.0g)) min(fmt(%td))  max(fmt(%td))") ///
	title("Summary of Due Date Recalls")
	eststo clear
	
estpost sum due_date_mcp_card if eligibility_check_pregnant == "Yes"
	esttab using "$output\IDI_report\due_date_mcp_card_distribution.tex", ///
	replace cells("mean(fmt(%td)) sd(fmt(%9.0g)) min(fmt(%td))  max(fmt(%td))") ///
	title("Summary of Due Date On MCP Card")
	eststo clear

estpost sum dob1 dob2 if eligibility_check_child == "Yes"
	esttab using "$output\IDI_report\dateofbirth_distribution.tex", ///
	replace cells("mean(fmt(%td)) sd(fmt(%9.0g)) min(fmt(%td))  max(fmt(%td))") ///
	title("Summary of Date of Birth For Child 1 and 2")
	eststo clear

**vaccination statistics--------------------------------------------------------

//Birth vaccination questions
/*local vaccs date_vacc_card_opv0_prese1 last_vacc1 birth_vacc_recall_flag1 ///
date_vacc_card_bcg_presen1


	destring `vaccs', replace
	estpost total `var'
	esttab using "$output\IDI_report\\`var'_distribution.tex", ///
	replace cells("b(label(freq))") unstack noobs
	eststo clear
*/

local vacctotals date_vacc_card_opv0_prese1 date_vacc_card_opv0_prese1 ///
date_vacc_card_bcg_presen1 date_vacc_card_opv1_prese1 ///
date_vacc_card_opv2_prese1 date_vacc_card_penta1_pre1 ///
date_vacc_card_penta2_pre1 date_vacc_card_penta3_pre1

destring `vacctotals', replace
egen vacctotal = rowtotal(`vacctotals')
estpost tab vacctotal
	esttab using "$output\IDI_report\vacctotal_distribution.tex", ///
	replace cells("b(label(Frequency)) pct(fmt(2))") unstack noobs ///
	title("Total Vaccinations on Vaccination Card")
	eststo clear

	

//these vaccinations should be given at the same time
estpost tab date_vacc_card_opv0_prese1 date_vacc_card_bcg_presen1
	esttab using "$output\IDI_report\birthvaccine_distribution.tex", ///
	replace cell("b(label(Frequency)) pct(fmt(2))") unstack noobs ///
	title("Recorded Vaccinations At Birth") ///
	coeflabels("BCG") ///
	addnotes("Prescense of OPV0 vaccine column and BCG rows." ///
	"These vaccinations should be given at the same time") 
	eststo clear

**late vaccinations-------------------------------------------------------------

gen late_vacc_card_opv01 = date_vacc_card_opv01 - dob1
gen late_vacc_card_bcg1 = date_vacc_card_bcg1 - dob1
gen late_vacc_card_opv11 = date_vacc_card_opv11 + 42 - date_vacc_card_opv01 
gen late_vacc_card_opv21 = date_vacc_card_opv21 + 28 - date_vacc_card_opv01 
gen late_vacc_card_penta11 = date_vacc_card_penta11 + 42 - dob1
gen late_vacc_card_penta21 = date_vacc_card_penta21 + 28 - date_vacc_card_penta11 
gen late_vacc_card_penta31 = date_vacc_card_penta31 + 28 - date_vacc_card_penta21

local lates  late_vacc_card_opv01 late_vacc_card_bcg1 late_vacc_card_opv11 ///
late_vacc_card_opv21 late_vacc_card_penta11 late_vacc_card_penta21 ///
late_vacc_card_penta31

	estpost sum `lates'
	esttab using "$output\IDI_report\lates_distribution.tex", ///
	replace cells("mean sd min max") title("Late Vaccination Dates")
	eststo clear
	
**Preferred Medical Facility----------------------------------------------------
/*
preferred_medical_facili11 preferred_medical_facili21 preferred_medical_facili31 preferred_medical_facili41 preferred_medical_facili51 preferred_medical_facili61 preferred_medical_facili71 preferred_medical_facili81 preferred_medical_facili91
