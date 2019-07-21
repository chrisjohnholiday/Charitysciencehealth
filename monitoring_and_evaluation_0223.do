************************************************
*          M&E for D2D Enrollment Surveys      *
************************************************

/*
Created by: Chris
Started on: 13/06/2019
Last updated on: 28/06/201906

Goals: 
	1/ generate daily/weekly/monthly survey frequency data and average
	survey duration data and export
	2/ export relevant audit information: links to photo and audio audits, phone
	numbers, precense of vaccination card, date of birth on vaccination card,
	all vaccination dates

Content:
1. importing of enrollment survey and generating frequency and averages 
statistics and exporting backcheck data
2. importing of audit data and cleaning
3. merging of audit and backcheck data and generation of checks
4. export of audit report including frequencies checks etc


*/
**setpaths----------------------------------------------------------------------


**setpaths only if you do not have access to the master file
//gl path "C:\Users\chris\Google Drive\Charitysciencehealth\datawork"
	
	//global raw "$path\1_all enrollment raw"
	//global output "$path\3_output files"
	//global audit "$path\4_ audit files"
**important for auditting (insert paths of the audit files to be compared to
	//global audio "$audit\v1 Audio Audits D2D Partners Survey IDI Pilot.xlsx"
	//global photo "$audit\v1 Vaccination Card Photo Review D2D Partners IDI Pilot.xlsx"

**importing dataset**----------------------------------------------------------------------
clear all 
use "$output\enrollmentdata_0223_monitoring_and_evaluation.dta"


**data preperation for backchecking---------------------------------------------

**generate frequency data
	gen day = dofC(submissiondate)
	format %td day 
	gen week = wofd(day)
	format %tw week
	gen month = mofd(day)

	
**generating survey duration in minutes
	gen surveydurationminutes = (endtime - starttime)/60000

**information that corresponds for auditing and M&E
keep complete_text_audits complete_audio_audit member_name ///
member_organization_name preliminary_consent eligibility_check_pregnant ///
eligibility_check_child eligibility_check_phone_number consent_sign dob* ///
consent mothers_name name* dob_confidence* alternate_contact_*_name ///
alternate_contact*_smartphone_fl alternate_contact*_number ///
mothers_contact_number mothers_contact_number_redundant fathers_name fathers_contact_smartphone_flag ///
fathers_contact_number mcp_card_photo_consent gender* vaccination_card_availabl* ///
vaccination_card_not_avai* vaccination_receipt_not_a* ///
vacc_receipt_photo_consen* vacc_card_photo_consent*	///
 dob_vacc_card* date_vacc_card_opv0_prese* ///
date_vacc_card_opv0* date_vacc_card_bcg_presen* date_vacc_card_bcg* ///
date_vacc_card_opv1_prese* date_vacc_card_opv1* date_vacc_card_penta1_pre* ///
date_vacc_card_penta1* date_vacc_card_opv2_prese* date_vacc_card_opv2* ///
date_vacc_card_penta2_pre* date_vacc_card_penta2* ///
date_vacc_card_opv3_prese* date_vacc_card_opv3* date_vacc_card_penta3_pre* ///
date_vacc_card_penta3* date_vacc_card_mr1_presen* date_vacc_card_mr1* ///
date_vacc_card_mr2_presen* date_vacc_card_mr2* date_vacc_card_opvbooster* ///
date_vacc_card_OPVBooster* vacc_card_photo* member_organization ///
submissiondate starttime endtime surveydurationminutes day week month ///
instanceid dob_vacc_card_photo1 dob_vacc_card_photo2 /// 
advice_start_child1 advice_end_child1 ///
advice_start_child2 advice_end_child2 first_child* advice_time

order submissiondate starttime endtime surveydurationminutes day week month ///
instanceid member_name member_organization_name member_organization ///
complete_text_audits complete_audio_audit vacc_card_photo* ///
preliminary_consent eligibility_check_pregnant ///
eligibility_check_child eligibility_check_phone_number consent_sign dob* ///
consent mothers_name name* dob_confidence* alternate_contact_*_name ///
alternate_contact*_smartphone_fl alternate_contact*_number ///
mothers_contact_number fathers_name fathers_contact_smartphone_flag ///
fathers_contact_number mcp_card_photo_consent ///
first_child* vaccination_card_availabl* ///
vaccination_card_not_avai* vaccination_receipt_not_a* ///
vacc_receipt_photo_consen* vacc_card_photo_consent*	///
dob_vacc_card* date_vacc_card_opv0_prese* ///
date_vacc_card_opv0* date_vacc_card_bcg_presen* date_vacc_card_bcg* ///
date_vacc_card_opv1_prese* date_vacc_card_opv1* date_vacc_card_penta1_pre* ///
date_vacc_card_penta1* date_vacc_card_opv2_prese* date_vacc_card_opv2* ///
date_vacc_card_penta2_pre* date_vacc_card_penta2* ///
date_vacc_card_opv3_prese* date_vacc_card_opv3* date_vacc_card_penta3_pre* ///
date_vacc_card_penta3* date_vacc_card_mr1_presen* date_vacc_card_mr1* ///
date_vacc_card_mr2_presen* date_vacc_card_mr2* date_vacc_card_opvbooster* ///
date_vacc_card_OPVBooster*

save "$output\enrollmentdata_0223_monitoring_and_evaluation_report.dta", replace

**importing the excel audits----------------------------------------------------

clear all

**audio audit

import excel  using "$audio", cellrange(A10) firstrow 

keep MemberName ForAudioAuditorBlankrecordi RespondentPhoneNumber ///
RespondentPhoneNumberConfirm fathers_contact_number FathersPhoneNumberConfirm ///
MaternalHomeContactPhoneNumb AJ AlternateContactPhoneNumber ///
AlternateContactPhoneNumberC child1_vaccination_card_availabl KEY AudioLink ///
SubmissionDate

**renaming improperly named variables
rename (AJ KEY fathers_contact_number AudioLink MemberName SubmissionDate) (MaternalHomeContactPhConf instanceid ///
fathers_contact_num complete_audio_audit member_name submissiondate)

save "$output\0223_audio_audit.dta", replace


**photo audit

clear all
import excel using "$photo", firstrow

**dropping empty observation
drop in 1


**renaming audio audits
rename (uniqID U X AA AD AG AJ AM AP AS AV AY BB SurveyorName) (instanceid bcgdate ///
OPV0date hepbdate OPV1date Penta1date OPV2date Penta2date OPV3date ///
Penta3date IPV1date MR1date DPT1date member_name)

keep member_name instanceid Child1DOB bcgdate OPV0date hepbdate OPV1date ///
Penta1date OPV2date Penta2date OPV3date Penta3date IPV1date MR1date DPT1date

**generating dates from the photo audit data
qui foreach var of varlist /*Child1DOB*/ bcgdate OPV0date hepbdate OPV1date ///
Penta1date OPV2date Penta2date OPV3date Penta3date IPV1date MR1date DPT1date {
   gen `var't = date(`var', "DMY")
	drop `var'
	local newname = substr("`var't", 1,length("`var'"))
   	rename `var't `newname'
	di "`var'"
}

save "$output\0223_photo_audit.dta", replace


**merging all of them together for comparison making----------------------------
clear all 
use "$output\enrollmentdata_0223_monitoring_and_evaluation_report.dta"
merge m:m member_name instanceid using "$output\0223_photo_audit.dta", keep(master ///
 match)
rename _merge merge_photo
merge m:m member_name instanceid using "$output\0223_audio_audit.dta", keep(master ///
 match)
rename _merge merge_audio



	
**generation of comparison variables which generate the difference between
**audit and backcheck data
**the prefix mtch_ indicates a match between audit and backcheck dataa

gen blank_recording = "Complete"
gen mtch_mother_phnnumber = "Unmatched"
gen mtch_father_phnnumber = "Unmatched"
gen mtch_have_vc_card = "Incorrect Response"
gen mtch_dob_vc_card = "Unmatched"
gen mtch_opv0 = 0
gen mtch_opv1 = 0
gen mtch_opv2 = 0
gen mtch_penta1 = 0
gen mtch_penta2 = 0
gen mtch_penta3 = 0
gen mtch_bcg = 0
gen mtch_mr1 = 0

//before summing all these variables together we
foreach var of varlist date_vacc_card_opv0_prese1 ///
date_vacc_card_bcg_presen1 date_vacc_card_opv1_prese1 ///
date_vacc_card_penta1_pre1 date_vacc_card_opv2_prese1 ///
date_vacc_card_penta2_pre1 date_vacc_card_opv3_prese1 ///
date_vacc_card_penta3_pre1 date_vacc_card_mr1_presen1 ///
date_vacc_card_mr2_presen1 {
	gen `var't = real(`var')
	drop `var'
	local newname = substr("`var't", 1,length("`var'"))
   	rename `var't `newname'
	replace `var' = 0 if missing(`var') == 1
}

gen total_vaccine_on_vaccine_card = date_vacc_card_opv0_prese1 + ///
date_vacc_card_bcg_presen1 + date_vacc_card_opv1_prese1 + ///
date_vacc_card_penta1_pre1 + date_vacc_card_opv2_prese1 + ///
date_vacc_card_penta2_pre1 +  date_vacc_card_opv3_prese1 + ///
date_vacc_card_penta3_pre1 + date_vacc_card_mr1_presen1 + ///
date_vacc_card_mr2_presen1 if merge_photo == 3



**Audio Audit statistics--------------------------------------------------------


**blank recordings
replace blank_recording = "Blank" if ForAudioAuditorBlankrecordi == "Fully blank" ///
| ForAudioAuditorBlankrecordi == "Partially blank"

 **mismatch in mothers phone number
replace mtch_mother_phnnumber = "Matched" if RespondentPhoneNumber == ///
mothers_contact_number | RespondentPhoneNumberConfirm == ///
mothers_contact_number | RespondentPhoneNumber == ///
mothers_contact_number_redundant | RespondentPhoneNumberConfirm == ///
mothers_contact_number_redundant 

**mismatch in fathers phone number
replace mtch_father_phnnumber = "Matched" if fathers_contact_num == ///
fathers_contact_number | FathersPhoneNumberConfirm == fathers_contact_num ///

**less than one minute spent on advice section

gen lessthanoneminute = "Less than 60sec" if advice_time < 60 & eligibility_check_child == "1"
replace lessthanoneminute = "More than 60sec" if advice_time >= 60 & eligibility_check_child == "1"

**Photo Audit section-----------------------------------------------------------


replace mtch_have_vc_card = "Correct Response" if child1_vaccination_card_availabl == "Yes" & vaccination_card_availabl1 == "1" 
replace mtch_have_vc_card = "Correct Response" if child1_vaccination_card_availabl == "No" & vaccination_card_availabl1 == "0" 


replace mtch_dob_vc_card = "Matched" if Child1DOB == dob_vacc_card1

**vaccination card matches
replace mtch_opv0 = 1 if date_vacc_card_opv01 == OPV0date & date_vacc_card_opv0_prese1 == 1
replace mtch_opv1 = 1 if date_vacc_card_opv11 == OPV1date & date_vacc_card_opv1_prese1 == 1
replace mtch_opv2 = 1 if date_vacc_card_opv21 == OPV2date & date_vacc_card_opv2_prese1 == 1
replace mtch_penta1 = 1 if date_vacc_card_penta11 == Penta1date & date_vacc_card_penta1_pre1 == 1
replace mtch_penta2 = 1 if date_vacc_card_penta21 == Penta2date & date_vacc_card_penta2_pre1 == 1
replace mtch_penta3 = 1 if date_vacc_card_penta31 == Penta3date & date_vacc_card_penta3_pre1 == 1
replace mtch_bcg = 1 if date_vacc_card_bcg1 == bcgdate & date_vacc_card_bcg_presen1 == 1
replace mtch_mr1 = 1 if date_vacc_card_mr11 == MR1date & date_vacc_card_mr1_presen1 == 1

gen mtch_vaccine_dates_all = mtch_opv0 + mtch_opv1 + mtch_opv2 + mtch_penta1 + ///
mtch_penta2 + mtch_penta3 + mtch_bcg + mtch_mr1

gen vaccine_percent = mtch_vaccine_dates_all / total_vaccine_on_vaccine_card

save "$output\enrollmentdata_0223_monitoring_and_evaluation_report.dta", replace

**generating reports by organization-------------------------------------------- 

**debugging clear
clear all
use "$output\enrollmentdata_0223_monitoring_and_evaluation_report.dta"


replace member_organization= "0" if member_organization == "."
levelsof member_organization, local(organization)




**Generation of report files, for last month, week and day --------------------


/*


	In this section of code:
	
	For each organization for each of the most recent time periods of month
	week and day we give the following statistics
	
	Audio Audit
	1. Number of blank recordings by surveyor
	2. Mismatch of phone numbers entered by surveyor
	3. Mismatch in response to the question do you have a vaccination card
	by surveyor
	4. Surveys spent less than 1 minute on the advice by surveyor
	Photo Audit
	1. Number of surveys where DOB does not match by surveyor 
	2. Percentage of vaccination dates entered incorrectly  by surveyors

*/

**this code gives us the most recent day in our dataset to examine
qui su day, meanonly
local days  = r(max)
local today = string(`days', "%tdMonth_dd_CCYY") 

	
foreach partner in `organization' {
	
	**generate string labels for partner 
	if "`partner'" == "0" local partnername = "CSH"
	if "`partner'" == "1" local partnername = "Datamation"
	if "`partner'" == "2" local partnername = "IDI"
	
	**Last 30 Days------------------------------------------------------------
	
	
	**setting up folder and segregation of organization and time period
	capture mkdir "$output\Monitoring_and_evaluation_for_`partnername'_month_`today'" 	 
	
	clear all 
	use "$output\enrollmentdata_0223_monitoring_and_evaluation_report.dta"
	if "`partner'" == "2" {
	keep if member_name == "Suchita tiwari" | member_name == "Sonu verma" ///
 | member_name == "Sangeeta Devi" | member_name == "Rajan Singh" | ///
 member_name == "Pradeep kumar mishra" | member_name == "BRAHM DEV VERMA" 
	}
	else {
	keep if member_organization == "`partner'" 
	}
	keep if day >= `days' - 30
	
	**average survey duration graph
	graph hbar (mean) surveydurationminutes , over(member_name) bargap(2) ///
	title("Average Survey Duration") 
	graph export "$output\Monitoring_and_evaluation_for_`partnername'_month_`today'\surveyduration.png", replace
	
	**Surveyor output graph and table
	graph hbar (count), over(member_name) bargap(2) ///
	title("Number of Survey Submissions") ytitle("Submissions")
	graph export "$output\Monitoring_and_evaluation_for_`partnername'_month_`today'\productivity.png", replace
	estpost tab member_name 
	esttab using "$output\Monitoring_and_evaluation_for_`partnername'_month_`today'\productivity.tex", ///
	replace cells("b(label(Number)) pct(fmt(%3.1f)label((%)))") ///
    varlabels(, blist(Total)) nonumber nomtitle noobs ///
	addnotes("The number of total submissions each surveyor has submitted in the last 30 days")
	eststo clear
	
	**number of blank recordings
	capture estpost tab member_name blank_recording if merge_audio == 3
	capture esttab using ///
	"$output\Monitoring_and_evaluation_for_`partnername'_month_`today'\blank_recordings.tex", ///
	replace cells("b(label(freq)) rowpct(fmt(2))") unstack noobs ///
	addnotes("The number of blank or partially blank recordings submitted by each surveyor in the" "last 30 days")
	eststo clear
	
	**number of surveyors spending less than one minute on advice section
	capture estpost tab member_name lessthanoneminute 
	esttab using "$output\Monitoring_and_evaluation_for_`partnername'_month_`today'\less_than_one_minute.tex", ///
	replace cells("b(label(freq)) rowpct(fmt(2))") unstack noobs ///
	addnotes("The number of surveys that the surveyor spent more than one minute on" "the advice section given that their was one eligible child in the survey.")
	eststo clear
	
	**mismatch in mothers phone number
	capture estpost tab member_name mtch_mother_phnnumber if merge_audio == 3 & RespondentPhoneNumber != "Section did not come up"
	esttab using "$output\Monitoring_and_evaluation_for_`partnername'_month_`today'\match_mother_number.tex", ///
	replace cells("b(label(freq)) rowpct(fmt(2))") unstack noobs ///
	addnotes("The number of properly recorded phone numbers from the audit and" "the number of improperly recorded phone numbers in the last 7 days.")
	eststo clear
	
	**mismatch in fathers phone number
	capture estpost tab member_name mtch_father_phnnumber if merge_audio == 3 & fathers_contact_num != "Section did not come up"
	esttab using "$output\Monitoring_and_evaluation_for_`partnername'_month_`today'\match_father_number.tex", ///
	replace cells("b(label(freq)) rowpct(fmt(2))") unstack noobs ///
	addnotes("The amount of unmatched phone numbers the number of matched phone" "numbers recorded by each surveyor in the last month")
	eststo clear
	
	**mismatch in respone to the answer to the question do you have vc card
	capture estpost tab member_name mtch_have_vc_card if merge_audio == 3 & child1_vaccination_card_availabl != "Section did not come up"
	esttab using "$output\Monitoring_and_evaluation_for_`partnername'_month_`today'\match_have_vc_card.tex", ///
	replace cells("b(label(freq)) rowpct(fmt(2))") unstack noobs ///
	addnotes("The amount of times that the surveyor did not accurately record" "the response to the question Do you have a vaccination card? and the amount of properly recorded dates")
	eststo clear
	
	**mismatch in date of birth on vaccination card
	capture estpost tab member_name mtch_dob_vc_card if merge_photo == 3
	esttab using "$output\Monitoring_and_evaluation_for_`partnername'_month_`today'\match_dob_vacc_card.tex", ///
	replace cells("b(label(freq)) rowpct(fmt(2))") unstack noobs ///
	addnotes("The number of mismatches in recorded birth date on vaccination" "card and entry for each surveyor in the last month.")
	eststo clear
	
	**generate missed vaccination percentages
	collapse (sum) mtch_vaccine_dates_all total_vaccine_on_vaccine_card, by(member_name)
	gen vaccination_accuracy = mtch_vaccine_dates_all / total_vaccine_on_vaccine_card
	dataout, save("$output\Monitoring_and_evaluation_for_`partnername'_month_`today'\match_vacc.tex") tex replace
	
	
	**Latex File Generation
	
	file open month using "$output\Monitoring_and_evaluation_for_`partnername'_month_`today'\month_`today'_tex.tex", write replace
	file write month "\documentclass{article}" _newline ///
	"\usepackage[utf8]{inputenc}" _newline "\usepackage{float}" _newline ///      
 "  \restylefloat{figure}" _newline " \restylefloat{table}" _newline ///
 "\usepackage{graphicx}" _newline "\usepackage{booktabs}" _newline ///
 "\usepackage{adjustbox}" _newline "\usepackage{geometry}" _newline ///
 "\usepackage{setspace}" _newline "\usepackage{changepage}" _newline ///
 "\usepackage{cleveref}" _newline "\usepackage{tabularx}" _newline ///
 "\usepackage{standalone}" _newline ///
  "\title{Monitoring and Evaluation for `partnername'}" ///
  _newline "\date{month ending `today'}" _newline "\begin{document}" _newline ///
  "\maketitle" _newline "\begin{center}" _newline ///
  "\section*{Average Survey Duration}" _newline ///
"\includegraphics[width=\textwidth]{surveyduration.png}" _newline ///
"\section*{Number of Survey Submissions}" _newline ///
"\includegraphics[width=\textwidth]{productivity.png}" _newline ///
"\end{center}" _newline "\par" _newline "\input{productivity.tex}" ///
_newline "\par" _newline "\section*{Blank Recordings}" _newline ///
"\input{blank_recordings.tex}" _newline "\par" _newline ///
"\section*{Matches in Mothers Number}" _newline ///
"\input{match_mother_number.tex}" _newline ///
"\par" _newline "\section*{Matches in Fathers Number}" _newline ///
"\input{match_father_number.tex}" _newline "\par" _newline ///
"\section*{Matches in response to asking for vaccination card}" _newline ///
"\input{match_have_vc_card.tex}" _newline "\par" _newline ///
"\section*{Number of surveys spending less than one minute on advice section}" ///
_newline "\input{less_than_one_minute.tex}" _newline "\par" _newline ///
"\section*{Matches in date of birth on vaccination card}" _newline ///
"\input{match_dob_vacc_card.tex}" _newline "\par" _newline ///
"\section*{Vaccination Card Recording Accuracy}" _newline ///
"\input{match_vacc.tex}" _newline "\par" _newline ///
"The second column is the amount of accurately recorded vaccination dates by each surveyor for the last 30 days. The third column is the number of total vaccinations on the vaccination card recorded by auditors. The last column is the ratio of matched vaccinations per surveyor." ///
_newline "\end{document}" 
file close month
	
	
	**Last 7 Days------------------------------------------------------------
	
	capture {
	
	**setting up folder and segregation of organization and time period
	capture mkdir "$output\Monitoring_and_evaluation_for_`partnername'_week_`today'" 	 
	clear all 
	use "$output\enrollmentdata_0223_monitoring_and_evaluation_report.dta"
	keep if member_organization == "`partner'" 
	keep if day >= `days' - 7
	
		**average survey duration graph
	graph hbar (mean) surveydurationminutes , over(member_name) bargap(2) ///
	title("Average Survey Duration") 
	graph export "$output\Monitoring_and_evaluation_for_`partnername'_week_`today'\surveyduration.png", replace
	
	**Surveyor output graph and table
	graph hbar (count), over(member_name) bargap(2) ///
	title("Number of Survey Submissions") ytitle("Submissions")
	graph export "$output\Monitoring_and_evaluation_for_`partnername'_week_`today'\productivity.png", replace
	estpost tab member_name 
	esttab using "$output\Monitoring_and_evaluation_for_`partnername'_week_`today'\productivity.tex", ///
	replace cells("b(label(freq)) pct(fmt(2))") ///
    varlabels(, blist(Total)) nonumber nomtitle noobs ///
	addnotes("The number of total submissions each surveyor has submitted in the last 7 days.")
	eststo clear
	
	**number of blank recordings
	capture estpost tab member_name blank_recording if merge_audio == 3
	capture esttab using ///
	"$output\Monitoring_and_evaluation_for_`partnername'_week_`today'\blank_recordings.tex", ///
	replace cells("b(label(freq)) rowpct(fmt(2))") unstack noobs ///
	addnotes("The number of blank or partially blank recordings submitted by each surveyor in the" "last 7 days.")
	eststo clear
	
	**number of surveyors spending less than one minute on advice section
	capture estpost tab member_name lessthanoneminute 
	esttab using "$output\Monitoring_and_evaluation_for_`partnername'_week_`today'\less_than_one_minute.tex", ///
	replace cells("b(label(freq)) rowpct(fmt(2))") unstack noobs ///
	addnotes("The number of surveys that the surveyor spent more than one minute on" "the advice section given that their was one eligible child in the survey.")
	eststo clear
	
	**mismatch in mothers phone number
	capture estpost tab member_name mtch_mother_phnnumber if merge_audio == 3 & RespondentPhoneNumber != "Section did not come up"
	esttab using "$output\Monitoring_and_evaluation_for_`partnername'_week_`today'\match_mother_number.tex", ///
	replace cells("b(label(freq)) rowpct(fmt(2))") unstack noobs ///
	addnotes("The number of properly recorded phone numbers from the audit and" "the number of improperly recorded phone numbers in the last 7 days")
	eststo clear
	
	**mismatch in fathers phone number
	capture estpost tab member_name mtch_father_phnnumber if merge_audio == 3 & fathers_contact_num != "Section did not come up"
	esttab using "$output\Monitoring_and_evaluation_for_`partnername'_week_`today'\match_father_number.tex", ///
	replace cells("b(label(freq)) rowpct(fmt(2))") unstack noobs ///
	addnotes("The amount of unmatched phone numbers the number of matched phone" "numbers recorded by each surveyor in the last 7 days")
	eststo clear
	
	**mismatch in respone to the answer to the question do you have vc card
	capture estpost tab member_name mtch_have_vc_card if merge_audio == 3 & child1_vaccination_card_availabl != "Section did not come up"
	esttab using "$output\Monitoring_and_evaluation_for_`partnername'_week_`today'\match_have_vc_card.tex", ///
	replace cells("b(label(freq)) rowpct(fmt(2))") unstack noobs ///
	addnotes("The amount of times that the surveyor did not accurately record" "the response to the question Do you have a vaccination card? and the amount of properly recorded dates")
	eststo clear
	
	**mismatch in date of birth on vaccination card
	capture estpost tab member_name mtch_dob_vc_card if merge_photo == 3
	esttab using "$output\Monitoring_and_evaluation_for_`partnername'_week_`today'\match_dob_vacc_card.tex", ///
	replace cells("b(label(freq)) rowpct(fmt(2))") unstack noobs ///
	addnotes("The number of mismatches in recorded birth date on vaccination" "card and entry for each surveyor in the last month.")
	eststo clear
	
	**generate missed vaccination percentages
	collapse (sum) mtch_vaccine_dates_all total_vaccine_on_vaccine_card, by(member_name)
	gen vaccination_accuracy = mtch_vaccine_dates_all / total_vaccine_on_vaccine_card
	dataout, save("$output\Monitoring_and_evaluation_for_`partnername'_week_`today'\match_vacc.tex") tex replace
	}
	
	**file generation
	file open month using "$output\Monitoring_and_evaluation_for_`partnername'_week_`today'\week_`today'_tex.tex", write replace
	file write month "\documentclass{article}" _newline ///
	"\usepackage[utf8]{inputenc}" _newline "\usepackage{float}" _newline ///      
 "  \restylefloat{figure}" _newline " \restylefloat{table}" _newline ///
 "\usepackage{graphicx}" _newline "\usepackage{booktabs}" _newline ///
 "\usepackage{adjustbox}" _newline "\usepackage{geometry}" _newline ///
 "\usepackage{setspace}" _newline "\usepackage{changepage}" _newline ///
 "\usepackage{cleveref}" _newline "\usepackage{tabularx}" _newline ///
 "\usepackage{standalone}" _newline ///
  "\title{Monitoring and Evaluation for `partnername'}" ///
  _newline "\date{Week ending `today'}" _newline "\begin{document}" _newline ///
  "\maketitle" _newline "\begin{center}" _newline ///
  "\section*{Average Survey Duration}" _newline ///
"\includegraphics[width=\textwidth]{surveyduration.png}" _newline ///
"\section*{Number of Survey Submissions}" _newline ///
"\includegraphics[width=\textwidth]{productivity.png}" _newline ///
"\end{center}" _newline "\par" _newline "\input{productivity.tex}" ///
_newline "\par" _newline "\section*{Blank Recordings}" _newline ///
"\input{blank_recordings.tex}" _newline "\par" _newline ///
"\section*{Matches in Mothers Number}" _newline ///
"\input{match_mother_number.tex}" _newline ///
"\par" _newline "\section*{Matches in Fathers Number}" _newline ///
"\input{match_father_number.tex}" _newline "\par" _newline ///
"\section*{Matches in response to asking for vaccination card}" _newline ///
"\input{match_have_vc_card.tex}" _newline "\par" _newline ///
"\section*{Number of surveys spending less than one minute on advice section}" ///
_newline "\input{less_than_one_minute.tex}" _newline "\par" _newline ///
"\section*{Matches in date of birth on vaccination card}" _newline ///
"\input{match_dob_vacc_card.tex}" _newline "\par" _newline ///
"\section*{Vaccination Card Recording Accuracy}" _newline ///
"\input{match_vacc.tex}" _newline "\par" _newline ///
"The second column is the amount of accurately recorded vaccination dates by each surveyor for the last 7 days. The third column is the number of total vaccinations on the vaccination card recorded by auditors. The last column is the ratio of matched vaccinations per surveyor." ///
_newline "\end{document}" 
file close month
	
	
	
	
	**Daily report--------------------------------------------------------------
	
	
	**setting up folder and segregation of organization and time period
	capture mkdir "$output\Monitoring_and_evaluation_for_`partnername'_day_`today'" 	 
	clear all 
	use "$output\enrollmentdata_0223_monitoring_and_evaluation_report.dta"
	keep if member_organization == "`partner'" 
	keep if day == `days'
	
	capture {
		**average survey duration graph
	graph hbar (mean) surveydurationminutes , over(member_name) bargap(2) ///
	title("Average Survey Duration") 
	graph export "$output\Monitoring_and_evaluation_for_`partnername'_day_`today'\surveyduration.png", replace
	
	**Surveyor output graph and table
	graph hbar (count), over(member_name) bargap(2) ///
	title("Number of Survey Submissions") ytitle("Submissions")
	graph export "$output\Monitoring_and_evaluation_for_`partnername'_day_`today'\productivity.png", replace
	estpost tab member_name 
	esttab using "$output\Monitoring_and_evaluation_for_`partnername'_day_`today'\productivity.tex", ///
	replace cells("b(label(freq)) pct(fmt(2))*") ///
    varlabels(, blist(Total)) nonumber nomtitle noobs ///
	addnotes("The number of total submissions each surveyor has submitted in the last day.")
	eststo clear
	
	**number of blank recordings
	capture estpost tab member_name blank_recording if merge_audio == 3
	capture esttab using ///
	"$output\Monitoring_and_evaluation_for_`partnername'_day_`today'\blank_recordings.tex", ///
	replace cells("b(label(Frequency)) rowpct(Percent)") unstack noobs ///
	addnotes("The number of blank or partially blank recordings submitted by each surveyor in the" "last day.")
	eststo clear
	
	**number of surveyors spending less than one minute on advice section
	capture estpost tab member_name lessthanoneminute 
	esttab using "$output\Monitoring_and_evaluation_for_`partnername'_day_`today'\less_than_one_minute.tex", ///
	replace cells("b(label(freq)) rowpct(fmt(2))") unstack noobs ///
	addnotes("The number of surveys that the surveyor spent more than one minute on" "the advice section given that their was one eligible child in the survey.")
	eststo clear
	
	**mismatch in mothers phone number
	capture estpost tab member_name mtch_mother_phnnumber if merge_audio == 3 & RespondentPhoneNumber != "Section did not come up"
	esttab using "$output\Monitoring_and_evaluation_for_`partnername'_day_`today'\match_mother_number.tex", ///
	replace cells("b(label(freq)) rowpct(fmt(2))") unstack noobs ///
	addnotes("The number of properly recorded phone numbers from the audit and" "the number of improperly recorded phone numbers in the last day")
	eststo clear
	
	**mismatch in fathers phone number
	capture estpost tab member_name mtch_father_phnnumber if merge_audio == 3 & fathers_contact_num != "Section did not come up"
	esttab using "$output\Monitoring_and_evaluation_for_`partnername'_day_`today'\match_father_number.tex", ///
	replace cells("b(label(freq)) rowpct(fmt(2))") unstack noobs ///
	addnotes("The amount of unmatched phone numbers the number of matched phone" "numbers recorded by each surveyor in the last day")
	eststo clear
	
	**mismatch in respone to the answer to the question do you have vc card
	capture estpost tab member_name mtch_have_vc_card if merge_audio == 3 & child1_vaccination_card_availabl != "Section did not come up"
	esttab using "$output\Monitoring_and_evaluation_for_`partnername'_day_`today'\match_have_vc_card.tex", ///
	replace cells("b(label(freq)) rowpct(fmt(2))") unstack noobs ///
	addnotes("The amount of times that the surveyor did not accurately record" "the response to the question Do you have a vaccination card? and the amount of properly recorded dates")
	eststo clear
	
	**mismatch in date of birth on vaccination card
	capture estpost tab member_name mtch_dob_vc_card if merge_photo == 3
	esttab using "$output\Monitoring_and_evaluation_for_`partnername'_day_`today'\match_dob_vacc_card.tex", ///
	replace cells("b(label(freq)) rowpct(fmt(2))") unstack noobs ///
	addnotes("The number of mismatches in recorded birth date on vaccination" "card and entry for each surveyor in the last day.")
	eststo clear
	
	**generate missed vaccination percentages
	collapse (sum) mtch_vaccine_dates_all total_vaccine_on_vaccine_card, by(member_name)
	gen vaccination_accuracy = mtch_vaccine_dates_all / total_vaccine_on_vaccine_card
	dataout, save("$output\Monitoring_and_evaluation_for_`partnername'_day_`today'\match_vacc.tex") tex replace
	}
	**file generation
	file open month using "$output\Monitoring_and_evaluation_for_`partnername'_day_`today'\day_`today'_tex.tex", write replace
	file write month "\documentclass{article}" _newline ///
	"\usepackage[utf8]{inputenc}" _newline "\usepackage{float}" _newline ///      
 "  \restylefloat{figure}" _newline " \restylefloat{table}" _newline ///
 "\usepackage{graphicx}" _newline "\usepackage{booktabs}" _newline ///
 "\usepackage{adjustbox}" _newline "\usepackage{geometry}" _newline ///
 "\usepackage{setspace}" _newline "\usepackage{changepage}" _newline ///
 "\usepackage{cleveref}" _newline "\usepackage{tabularx}" _newline ///
 "\usepackage{standalone}" _newline ///
  "\title{Monitoring and Evaluation for `partnername'}" ///
  _newline "\date{For `today'}" _newline "\begin{document}" _newline ///
  "\maketitle" _newline "\begin{center}" _newline ///
  "\section*{Average Survey Duration}" _newline ///
"\includegraphics[width=\textwidth]{surveyduration.png}" _newline ///
"\section*{Number of Survey Submissions}" _newline ///
"\includegraphics[width=\textwidth]{productivity.png}" _newline ///
"\end{center}" _newline "\par" _newline "\input{productivity.tex}" ///
_newline "\par" _newline "\section*{Blank Recordings}" _newline ///
"\input{blank_recordings.tex}" _newline "\par" _newline ///
"\section*{Matches in Mothers Number}" _newline ///
"\input{match_mother_number.tex}" _newline ///
"\par" _newline "\section*{Matches in Fathers Number}" _newline ///
"\input{match_father_number.tex}" _newline "\par" _newline ///
"\section*{Matches in response to asking for vaccination card}" _newline ///
"\input{match_have_vc_card.tex}" _newline "\par" _newline ///
"\section*{Number of surveys spending less than one minute on advice section}" ///
_newline "\input{less_than_one_minute.tex}" _newline "\par" _newline ///
"\section*{Matches in date of birth on vaccination card}" _newline ///
"\input{match_dob_vacc_card.tex}" _newline "\par" _newline ///
"\section*{Vaccination Card Recording Accuracy}" _newline ///
"\input{match_vacc.tex}" _newline "\par" _newline ///
"The second column is the amount of accurately recorded vaccination dates by each surveyor for the last 7 days. The third column is the number of total vaccinations on the vaccination card recorded by auditors. The last column is the ratio of matched vaccinations per surveyor." ///
_newline "\end{document}" 
file close month
	}
	

	
	




