************************************************
*      Enrollment v6 partners cleaning file    *
************************************************

/*
Created by: Chris
Started on: 17/07/2019
Last updated on: 17/07/2019

Goals: 
	1/ Structuring dataset in logical way for appending to other datasets
	2/ remove duplicates
Content:
**Importing enrollment data**
**Automatic renaming of variables**
**Manual renaming**
**Removing duplicates**
**formatting dates**
**basic cleaning operations**

*/

**Setting Globals (only set these if you do not have master file)

	gl path "C:\Users\chris\Google Drive\Charitysciencehealth\datawork"

	global raw "$path\1_all enrollment raw"
	global output "$path\3_output files"

**Cleaning file**----------------------------------------------------------------------

**importing enrollment data
clear all
import delimited "$raw\Enrollment survey D2D partners 20190223_WIDE_IDI_Pilot.csv"

qui tostring _all, replace force

**Automatic Renaming**

//Correcting varnames that were imported improperly 
foreach var of varlist v* {
 	rename `var' `:permname `=strtoname("`: var lab `var''")''
 }
 

//moving child identifiers to back of varname for renaming
foreach var of varlist child1_* {
   	local newname = substr("`var'", 8,.) + "1"
   	rename `var' `newname'
}
foreach var of varlist child1s_* {
   	local newname = substr("`var'", 9,.) + "1"
   	rename `var' `newname'
}
foreach var of varlist child2_* {
   	local newname = substr("`var'", 8,.) + "2"
   	rename `var' `newname'
}
foreach var of varlist child2s_* {
   	local newname = substr("`var'", 9,.) + "2"
   	rename `var' `newname'
}


**manual renaming of variables
rename last_menstrual_period_date_mcp_c last_menstrual_prd_
rename last_prenatal_visit_date_recall_ last_prenatal_visit_recall_cnf
rename (advice_for_eligible_child1_start advice_for_eligible_child1_end_t ///
advice_for_eligible_child2_start advice_for_eligible_child2_end_t ///
survey_location_post_consent_sig survey_location_post_consent_si1 ///
survey_location_post_consent_si2 survey_location_post_consent_si3) ///
(advice_start_child1 advice_end_child1 ///
advice_start_child2 advice_end_child2 ///
latitude longitude altitude accuracy)

**dropping empty observations

**todo drop same observations with same phone number etc



**formatting dates--------------------------------------------------------------

**date and time variables and formatting for easy analysis
**DMYhms
foreach var of varlist submissiondate starttime endtime {
	gen `var't = Clock(`var', "DMYhms")
	drop `var'
	local newname = substr("`var't", 1,length("`var't")-1)
   	rename `var' `newname'
	format `var' %tC
	}

**YMDhms
foreach var of varlist advice_end_child1 advice_start_child1 {
	gen double `var't = Clock(`var', "YMDhms")
	drop `var'
	local newname = substr("`var't", 1,length("`var't")-1)
   	rename `var' `newname'
	format `var' %tC
	}
gen advice_time = (advice_end_child1 - advice_start_child1)/1000

**formatting date variables in DMY format


foreach var of varlist /*last_prenatal_visit_date_mcp_ca1*/ ///
prenatal_receipt_due_date due_date_recall last_prenatal_visit_date_recall ///
date_vacc_card_opv01 date_vacc_card_bcg1 date_vacc_card_opv11 ///
date_vacc_card_penta11 date_vacc_card_opv21 date_vacc_card_penta21 ///
date_vacc_card_penta31 date_vacc_card_mr11 ///
date_vacc_card_mr21  date_last_vacc1 date_recall_last_vacc_vis1 ///
date_vacc_card_opv02 date_vacc_card_bcg2 date_vacc_card_opv12 ///
date_vacc_card_penta12 date_vacc_card_opv22 date_vacc_card_penta22 ///
date_vacc_card_penta32 date_vacc_card_mr12 ///
date_recall_last_vacc_vis2 dob1 dob2 dob_vacc_card1 due_date_mcp_card ///
due_date_mcp_card_redundant last_menstrual_period_mcp_card {
gen `var't = date(`var', "DMY")
	drop `var'
	local newname = substr("`var't", 1,length("`var'"))
   	rename `var't `newname'
	format `var' %td
	di "`var'"
}

rename (alternate_contact1_number alternate_contact1_number_redund ///
alternate_contact2_contact_numbe alternate_contact2_contact_numb1) ///
(alternate_contact1_number ///
alternate_contact1_number_redund alternate_contact2_number ///
alternate_contact2_number_redund)


**Keeping variables that are necessary
keep instanceid submissiondate starttime endtime member_name ///
member_organization member_organization_name deviceid subscriberid ///
simid devicephonenum confirm_surveyor_identity complete_text_audit ///
complete_audio_audit consent preliminary_consent mothers_name ///
eligibility_check_pregnant eligibility_check_child ///
eligibility_check_phone_number consent_sign latitude longitude ///
altitude accuracy respondent_literacy_level mothers_preferred_language ///
mothers_contact_number mothers_contact_number_redundant ///
mothers_contact_smartphone_flag fathers_name fathers_contact_number ///
fathers_contact_number_redundant fathers_contact_smartphone_flag ///
alternate_contact_1_name alternate_contact1_number ///
alternate_contact1_number_redund alternate_contact1_smartphone_fl ///
alternate_contact_2_name alternate_contact2_number ///
alternate_contact2_number_redund alternate_contact2_smartphone_fl ///
maternal_home_visit maternalhome_contact_number ///
maternalhome_contact_number_redu maternalhome_contact_smartphone_ ///
mcp_card_available mcp_card_not_available_reason mcp_card_photo_consent ///
mcp_card_photo_due_date due_date_mcp_card_present_flag due_date_mcp_card ///
due_date_mcp_card_redundant last_menstrual_period_mcp_card ///
last_menstrual_period_mcp_card_r ///
last_prenatal_visit_date_mcp_ca1 mcp_card_photo_last_prenatal_vis ///
prenatal_receipt_available prenatal_receipt_photo_consent ///
prenatal_receipt_photo_due_date prenatal_receipt_due_date_presen ///
prenatal_receipt_due_date prenatal_receipt_last_visit_pres ///
prenatal_receipt_last_visit prenatal_receipt_photo_last_visi ///
due_date_recall_confidence due_date_recall last_prenatal_visit_recall_cnf ///
last_prenatal_visit_date_recall gender* name* dob* dob_redundant* ///
first_child* second_child_flag vaccination_card_availabl* ///
vaccination_card_not_avai* vacc_card_photo_consent* ///
vacc_card_photo* dob_vacc_card* dob_vacc_card_photo* ///
date_vacc_card_opv0_prese* date_vacc_card_opv0* date_vacc_card_bcg_presen* ///
date_vacc_card_bcg* date_vacc_card_opv1_prese* date_vacc_card_opv1* ///
date_vacc_card_opv2_prese* date_vacc_card_opv2* date_vacc_card_penta1_pre* ///
date_vacc_card_penta1* date_vacc_card_penta2_pre* date_vacc_card_penta2* ///
date_vacc_card_penta3_pre* date_vacc_card_penta3* ///
 vacc_receipt_flag* last_vacc* ///
date_last_vacc_present_fl* date_last_vacc* vacc_receipt_photo_consen* ///
date_last_vacc_photo* birth_vacc_recall_flag* number_of_vacc_visits_rec* ///
last_vacc_date_recall_con* date_recall_last_vacc_vis* ///
 vacc_card_vaccines_misse* ///
recall_vaccines_missed_r* no_action_tomorrow_reaso* ///
past_sms_vaccination_reminders past_voice_vaccination_reminders ///
past_voice_message_provider_* past_voice_message_provider_othe ///
preferred_medical_facili*


rename (preferred_medical_facili11 preferred_medical_facili21 ///
preferred_medical_facili31 preferred_medical_facili41 ///
preferred_medical_facili51 preferred_medical_facili61 ///
preferred_medical_facili71 preferred_medical_facili81 ///
preferred_medical_facili91) (child_vaccinated_where_1 ///
child_vaccinated_where_2 child_vaccinated_where_3 ///
child_vaccinated_where_4 child_vaccinated_where_5 ///
child_vaccinated_where_6 child_vaccinated_where_7 ///
child_vaccinated_where_8 child_vaccinated_where_9)


rename maternalhome_contact_number maternal_contact_number
destring consent devicephonenum eligibility_check_pregnant ///
eligibility_check_child eligibility_check_phone_number ///
alternate_contact1_smartphone_fl alternate_contact2_smartphone_fl ///
alternate_contact1_number alternate_contact2_number maternal_contact_number ///
maternalhome_contact_smartphone maternal_home_visit mcp_card_available ///
mcp_card_not_available_reason due_date_mcp_card_present_flag ///
respondent_literacy_level mothers_preferred_language ///
latitude longitude altitude accuracy second_child_flag mothers_contact_number ///
mothers_contact_smartphone_flag child_vaccinated_where_* ///
mcp_card_not_available_reason fathers_contact_number birth_vacc_recall_flag1 ///
birth_vacc_recall_flag2 number_of_vacc_visits_rec* ///
, replace force

**basic cleaning operations-----------------------------------------------------

**dropping empty observations
//those who are not eligible
drop if eligibility_check_child ==. & eligibility_check_pregnant ==. 

//those who cannot provie any phone number
drop if mothers_contact_number ==. & alternate_contact1_number ==. ///
& alternate_contact2_number ==. & fathers_contact_number ==.

**dropping other observations which have the same mother and phone number
duplicates drop mothers_name mothers_contact_number ///
alternate_contact1_number alternate_contact2_number ///
fathers_contact_number, force

save "$output\enrollmentdata0223_v6_clean.dta", replace



