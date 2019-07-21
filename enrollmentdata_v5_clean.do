************************************************
*       Cleaning In house CSH survey V5        *
************************************************

/*
Created by: Chris
Started on: 17/07/2019
Last updated on: 17/07/2019

Goals: 
	1/ Prepare V5 enrollment data to be merged with other data
Content:
1. Name Conversions
2. Variable Conversions
3. Reshape
4. Post Reshape Conversions
5. Basic Cleaning
*/

**Setting Globals (only set these if you do not have master file)

	gl path "C:\Users\chris\Google Drive\Charitysciencehealth\datawork"

	global raw "$path\1_all enrollment raw"
	global output "$path\3_output files"
	
*-----------------------------------------------------------------------
clear all

import delimited "$raw\v5_enrollment_survey_CSH_WIDE.csv" 

tostring _all, force replace

save "$output\v5_enrollment_tostring.dta", replace

//This is a repeat for debugging purposes
clear all

use "$output\v5_enrollment_tostring.dta"

**name oonversions--------------------------------------------------------------
rename (csh_employee_name  cg_name_1 cg_name_2 cg_name_3 ///
complete_text_audits cns_frm_sign gps_loc_hhlatitude gps_loc_hhlongitude ///
gps_loc_hhaltitude gps_loc_hhaccuracy can_pr_any_phn_nm_in_sur_1 ///
can_pr_any_phn_nm_in_sur_2  can_pr_any_phn_nm_in_sur_3 ///
curr_cg_preg_1 curr_cg_preg_2 curr_cg_preg_3 curr_cg_elg_ch_1 ///
curr_cg_elg_ch_2 curr_cg_elg_ch_3 literacy_1 literacy_2 literacy_3) ///
(member_name mothers_name_1 mothers_name_2 mothers_name_3 ///
complete_text_audit consent_sign ///
latitude longitude altitude accuracy eligibility_check_phone_number_1 ///
eligibility_check_phone_number_2 eligibility_check_phone_number_3 ///
eligibility_check_pregnant_1 eligibility_check_pregnant_2 ///
eligibility_check_pregnant_3 eligibility_check_child_1 ///
eligibility_check_child_2 eligibility_check_child_3 ///
respondent_literacy_level_1 respondent_literacy_level_2 ///
respondent_literacy_level_3)

rename (phone_number_main_1_1 phone_number_main_2_1 phone_number_main_3_1  ///
is_main_phn_smart_phone_1_1 is_main_phn_smart_phone_2_1 ///
is_main_phn_smart_phone_3_1) (mothers_contact_number_1 ///
mothers_contact_number_2 mothers_contact_number_3 ///
mothers_contact_smartphone_flag1 mothers_contact_smartphone_flag2 ///
mothers_contact_smartphone_flag3)

rename (alt_phn_num_onr_nm_1_1_1 alt_phn_num_onr_nm_1_1_2 ///
alt_phn_num_onr_nm_1_1_3 alt_phn_num_onr_nm_2_1_1 alt_phn_num_onr_nm_2_1_2 ///
alt_phn_num_onr_nm_2_1_3 alt_phn_num_onr_nm_3_1_1 alt_phn_num_onr_nm_3_1_2 ///
alt_phn_num_onr_nm_3_1_3 alt_ph_num_own_rel_wth_ch_1_1_1 ///
alt_ph_num_own_rel_wth_ch_1_1_2 alt_ph_num_own_rel_wth_ch_1_1_3 ///
alt_ph_num_own_rel_wth_ch_2_1_1 alt_ph_num_own_rel_wth_ch_2_1_2 ///
alt_ph_num_own_rel_wth_ch_2_1_3 alt_ph_num_own_rel_wth_ch_3_1_1 ///
alt_ph_num_own_rel_wth_ch_3_1_2 alt_ph_num_own_rel_wth_ch_3_1_3) ///
(alternate_contact_1_name_1 ///
alternate_contact_2_name_1 alternate_contact_3_name_1 ///
alternate_contact_1_name_2 alternate_contact_2_name_2 ///
alternate_contact_3_name_2 alternate_contact_1_name_3 ///
alternate_contact_2_name_3 alternate_contact_3_name_3 ///
alternate_contact_1_rel_1 alternate_contact_2_rel_1 ///
alternate_contact_3_rel_1 alternate_contact_1_rel_2 ///
alternate_contact_2_rel_2 alternate_contact_3_rel_2 ///
alternate_contact_1_rel_3 alternate_contact_2_rel_3 ///
alternate_contact_3_rel_3) 


rename (alt_p_smart_phone_1_1_1 alt_p_smart_phone_1_1_2 alt_p_smart_phone_1_1_3 ///
alt_p_smart_phone_2_1_1 alt_p_smart_phone_2_1_2 alt_p_smart_phone_2_1_3 ///
alt_p_smart_phone_3_1_1 alt_p_smart_phone_3_1_2 alt_p_smart_phone_3_1_3) ///
(alternate_contact1_smartphone_f1 ///
alternate_contact2_smartphone_f1 alternate_contact3_smartphone_f1 ///
alternate_contact1_smartphone_f2 alternate_contact2_smartphone_f2 ///
alternate_contact3_smartphone_f2 alternate_contact1_smartphone_f3 ///
alternate_contact2_smartphone_f3 alternate_contact3_smartphone_f3) 


rename ///
(alt_ph_nm_own_phn_nm_1_1_1 alt_ph_nm_own_phn_nm_1_1_2 ///
alt_ph_nm_own_phn_nm_1_1_3 alt_ph_nm_own_phn_nm_2_1_1 ///
alt_ph_nm_own_phn_nm_2_1_2 alt_ph_nm_own_phn_nm_2_1_3 ///
alt_ph_nm_own_phn_nm_3_1_1 alt_ph_nm_own_phn_nm_3_1_2 ///
alt_ph_nm_own_phn_nm_3_1_3 sms_language_preference_1_1 ///
sms_language_preference_2_1 sms_language_preference_3_1) ///
(alternate_contact1_number_1 alternate_contact2_number_1 ///
alternate_contact3_number_1 alternate_contact1_number_2 ///
alternate_contact2_number_2 alternate_contact3_number_2 ///
alternate_contact1_number_3 alternate_contact2_number_3 ///
alternate_contact3_number_3 mothers_preferred_language_1 ///
mothers_preferred_language_2 mothers_preferred_language_3)

rename (child_name_1_1 child_name_1_2 child_name_2_1 child_name_2_2 ///
child_name_3_1 child_name_3_2 child_dob_1_1 child_dob_1_2 child_dob_2_1 ///
child_dob_2_2 child_dob_3_1 child_dob_3_2) ///
(name1_1 name2_1 name1_2 name2_2 name1_3 name2_3 dob1_1 dob2_1 dob1_2 ///
dob2_2 dob3_1 dob3_2)

rename (vc_card_avl_to_hv_look_1_1 vc_card_avl_to_hv_look_1_2 ///
vc_card_avl_to_hv_look_2_1 vc_card_avl_to_hv_look_2_2 ///
vc_card_avl_to_hv_look_3_1 vc_card_avl_to_hv_look_3_2 ///
curr_cg_elg_ch_qnt_1 curr_cg_elg_ch_qnt_2 curr_cg_elg_ch_qnt_3 ///
vacc_card_photo_take_1_1 vacc_card_photo_take_1_2 vacc_card_photo_take_2_1 ///
vacc_card_photo_take_2_2 vacc_card_photo_take_3_1 vacc_card_photo_take_3_2 ///
vacc_card_child_dob_1_1 vacc_card_child_dob_1_2 vacc_card_child_dob_2_1 ///
vacc_card_child_dob_2_2 vacc_card_child_dob_3_1 vacc_card_child_dob_3_2) ///
(vaccination_card_availabl1_1 vaccination_card_availabl2_1 ///
vaccination_card_availabl1_2 vaccination_card_availabl2_2 ///
vaccination_card_availabl1_3 vaccination_card_availabl2_3 ///
second_child_flag_1 second_child_flag_2 second_child_flag_3 ///
vacc_card_photo1_1 vacc_card_photo2_1 vacc_card_photo1_2 vacc_card_photo2_2 ///
vacc_card_photo1_3 vacc_card_photo2_3 ///
dob_vacc_card1_1 dob_vacc_card2_1 dob_vacc_card1_2 dob_vacc_card2_2 ///
dob_vacc_card1_3 dob_vacc_card2_3)

rename (vc_on_vc_card_date_1_1_1 ///
vc_on_vc_card_date_1_1_2 vc_on_vc_card_date_1_1_3 vc_on_vc_card_date_1_1_4 ///
vc_on_vc_card_date_1_1_5 vc_on_vc_card_date_1_1_6 vc_on_vc_card_date_1_1_7 ///
vc_on_vc_card_date_1_1_8 vc_on_vc_card_date_1_1_9 vc_on_vc_card_date_1_1_10 ///
vc_on_vc_card_date_1_1_11 vc_on_vc_card_date_1_1_12 vc_on_vc_card_date_1_1_13 ///
vc_on_vc_card_date_1_1_14 vc_on_vc_card_date_1_1_15 vc_on_vc_card_date_1_1_16 ///
vc_on_vc_card_date_1_2_1 vc_on_vc_card_date_1_2_2 vc_on_vc_card_date_1_2_3 ///
vc_on_vc_card_date_1_2_4 vc_on_vc_card_date_1_2_5 vc_on_vc_card_date_1_2_6 ///
vc_on_vc_card_date_1_2_7 vc_on_vc_card_date_1_2_8 vc_on_vc_card_date_1_2_9 ///
vc_on_vc_card_date_1_2_10 vc_on_vc_card_date_1_2_11 vc_on_vc_card_date_1_2_12 ///
vc_on_vc_card_date_1_2_13 vc_on_vc_card_date_1_2_14 vc_on_vc_card_date_1_2_15 ///
vc_on_vc_card_date_1_2_16 vc_on_vc_card_date_2_1_1 vc_on_vc_card_date_2_1_2 ///
vc_on_vc_card_date_2_1_3 vc_on_vc_card_date_2_1_4 vc_on_vc_card_date_2_1_5 ///
vc_on_vc_card_date_2_1_6 vc_on_vc_card_date_2_1_7 vc_on_vc_card_date_2_1_8 ///
vc_on_vc_card_date_2_1_9 vc_on_vc_card_date_2_1_10 vc_on_vc_card_date_2_1_11 ///
vc_on_vc_card_date_2_1_12 vc_on_vc_card_date_2_1_13 vc_on_vc_card_date_2_1_14 ///
vc_on_vc_card_date_2_1_15 vc_on_vc_card_date_2_1_16 vc_on_vc_card_date_2_2_1 ///
vc_on_vc_card_date_2_2_2 vc_on_vc_card_date_2_2_3 vc_on_vc_card_date_2_2_4 ///
vc_on_vc_card_date_2_2_5 vc_on_vc_card_date_2_2_6 vc_on_vc_card_date_2_2_7 ///
vc_on_vc_card_date_2_2_8 vc_on_vc_card_date_2_2_9 vc_on_vc_card_date_2_2_10 ///
vc_on_vc_card_date_2_2_11 vc_on_vc_card_date_2_2_12 vc_on_vc_card_date_2_2_13 ///
vc_on_vc_card_date_2_2_14 vc_on_vc_card_date_2_2_15 vc_on_vc_card_date_2_2_16 ///
vc_on_vc_card_date_3_1_1 vc_on_vc_card_date_3_1_2 vc_on_vc_card_date_3_1_3 ///
vc_on_vc_card_date_3_1_4 vc_on_vc_card_date_3_1_5 vc_on_vc_card_date_3_1_6 ///
vc_on_vc_card_date_3_1_7 vc_on_vc_card_date_3_1_8 vc_on_vc_card_date_3_1_9 ///
vc_on_vc_card_date_3_1_10 vc_on_vc_card_date_3_1_11 vc_on_vc_card_date_3_1_12 ///
vc_on_vc_card_date_3_1_13 vc_on_vc_card_date_3_1_14 vc_on_vc_card_date_3_1_15 ///
vc_on_vc_card_date_3_1_16 vc_on_vc_card_date_3_2_1 vc_on_vc_card_date_3_2_2 ///
vc_on_vc_card_date_3_2_3 vc_on_vc_card_date_3_2_4 vc_on_vc_card_date_3_2_5 ///
vc_on_vc_card_date_3_2_6 vc_on_vc_card_date_3_2_7 vc_on_vc_card_date_3_2_8 ///
vc_on_vc_card_date_3_2_9 vc_on_vc_card_date_3_2_10 vc_on_vc_card_date_3_2_11 ///
vc_on_vc_card_date_3_2_12 vc_on_vc_card_date_3_2_13 vc_on_vc_card_date_3_2_14 ///
vc_on_vc_card_date_3_2_15 vc_on_vc_card_date_3_2_16) ///
(vc_on_vc_card_date_1_1_1 ///
vc_on_vc_card_date_2_1_1 vc_on_vc_card_date_3_1_1 vc_on_vc_card_date_4_1_1 ///
vc_on_vc_card_date_5_1_1 vc_on_vc_card_date_6_1_1 vc_on_vc_card_date_7_1_1 ///
vc_on_vc_card_date_8_1_1 vc_on_vc_card_date_9_1_1 vc_on_vc_card_date_10_1_1 ///
vc_on_vc_card_date_11_1_1 vc_on_vc_card_date_12_1_1 vc_on_vc_card_date_13_1_1 ///
vc_on_vc_card_date_14_1_1 vc_on_vc_card_date_15_1_1 vc_on_vc_card_date_16_1_1 ///
vc_on_vc_card_date_1_2_1 vc_on_vc_card_date_2_2_1 vc_on_vc_card_date_3_2_1 ///
vc_on_vc_card_date_4_2_1 vc_on_vc_card_date_5_2_1 vc_on_vc_card_date_6_2_1 ///
vc_on_vc_card_date_7_2_1 vc_on_vc_card_date_8_2_1 vc_on_vc_card_date_9_2_1 ///
vc_on_vc_card_date_10_2_1 vc_on_vc_card_date_11_2_1 vc_on_vc_card_date_12_2_1 ///
vc_on_vc_card_date_13_2_1 vc_on_vc_card_date_14_2_1 vc_on_vc_card_date_15_2_1 ///
vc_on_vc_card_date_16_2_1 vc_on_vc_card_date_1_1_2 vc_on_vc_card_date_2_1_2 ///
vc_on_vc_card_date_3_1_2 vc_on_vc_card_date_4_1_2 vc_on_vc_card_date_5_1_2 ///
vc_on_vc_card_date_6_1_2 vc_on_vc_card_date_7_1_2 vc_on_vc_card_date_8_1_2 ///
vc_on_vc_card_date_9_1_2 vc_on_vc_card_date_10_1_2 vc_on_vc_card_date_11_1_2 ///
vc_on_vc_card_date_12_1_2 vc_on_vc_card_date_13_1_2 vc_on_vc_card_date_14_1_2 ///
vc_on_vc_card_date_15_1_2 vc_on_vc_card_date_16_1_2 vc_on_vc_card_date_1_2_2 ///
vc_on_vc_card_date_2_2_2 vc_on_vc_card_date_3_2_2 vc_on_vc_card_date_4_2_2 ///
vc_on_vc_card_date_5_2_2 vc_on_vc_card_date_6_2_2 vc_on_vc_card_date_7_2_2 ///
vc_on_vc_card_date_8_2_2 vc_on_vc_card_date_9_2_2 vc_on_vc_card_date_10_2_2 ///
vc_on_vc_card_date_11_2_2 vc_on_vc_card_date_12_2_2 vc_on_vc_card_date_13_2_2 ///
vc_on_vc_card_date_14_2_2 vc_on_vc_card_date_15_2_2 vc_on_vc_card_date_16_2_2 ///
vc_on_vc_card_date_1_1_3 vc_on_vc_card_date_2_1_3 vc_on_vc_card_date_3_1_3 ///
vc_on_vc_card_date_4_1_3 vc_on_vc_card_date_5_1_3 vc_on_vc_card_date_6_1_3 ///
vc_on_vc_card_date_7_1_3 vc_on_vc_card_date_8_1_3 vc_on_vc_card_date_9_1_3 ///
vc_on_vc_card_date_10_1_3 vc_on_vc_card_date_11_1_3 vc_on_vc_card_date_12_1_3 ///
vc_on_vc_card_date_13_1_3 vc_on_vc_card_date_14_1_3 vc_on_vc_card_date_15_1_3 ///
vc_on_vc_card_date_16_1_3 vc_on_vc_card_date_1_2_3 vc_on_vc_card_date_2_2_3 ///
vc_on_vc_card_date_3_2_3 vc_on_vc_card_date_4_2_3 vc_on_vc_card_date_5_2_3 ///
vc_on_vc_card_date_6_2_3 vc_on_vc_card_date_7_2_3 vc_on_vc_card_date_8_2_3 ///
vc_on_vc_card_date_9_2_3 vc_on_vc_card_date_10_2_3 vc_on_vc_card_date_11_2_3 ///
vc_on_vc_card_date_12_2_3 vc_on_vc_card_date_13_2_3 vc_on_vc_card_date_14_2_3 ///
vc_on_vc_card_date_15_2_3 vc_on_vc_card_date_16_2_3) 

rename (vc_on_vc_crd_nm_erlier_1_1_1 ///
vc_on_vc_crd_nm_erlier_1_1_2 vc_on_vc_crd_nm_erlier_1_1_3 vc_on_vc_crd_nm_erlier_1_1_4 ///
vc_on_vc_crd_nm_erlier_1_1_5 vc_on_vc_crd_nm_erlier_1_1_6 vc_on_vc_crd_nm_erlier_1_1_7 ///
vc_on_vc_crd_nm_erlier_1_1_8 vc_on_vc_crd_nm_erlier_1_1_9 vc_on_vc_crd_nm_erlier_1_1_10 ///
vc_on_vc_crd_nm_erlier_1_1_11 vc_on_vc_crd_nm_erlier_1_1_12 vc_on_vc_crd_nm_erlier_1_1_13 ///
vc_on_vc_crd_nm_erlier_1_1_14 vc_on_vc_crd_nm_erlier_1_1_15 vc_on_vc_crd_nm_erlier_1_1_16 ///
vc_on_vc_crd_nm_erlier_1_2_1 vc_on_vc_crd_nm_erlier_1_2_2 vc_on_vc_crd_nm_erlier_1_2_3 ///
vc_on_vc_crd_nm_erlier_1_2_4 vc_on_vc_crd_nm_erlier_1_2_5 vc_on_vc_crd_nm_erlier_1_2_6 ///
vc_on_vc_crd_nm_erlier_1_2_7 vc_on_vc_crd_nm_erlier_1_2_8 vc_on_vc_crd_nm_erlier_1_2_9 ///
vc_on_vc_crd_nm_erlier_1_2_10 vc_on_vc_crd_nm_erlier_1_2_11 vc_on_vc_crd_nm_erlier_1_2_12 ///
vc_on_vc_crd_nm_erlier_1_2_13 vc_on_vc_crd_nm_erlier_1_2_14 vc_on_vc_crd_nm_erlier_1_2_15 ///
vc_on_vc_crd_nm_erlier_1_2_16 vc_on_vc_crd_nm_erlier_2_1_1 vc_on_vc_crd_nm_erlier_2_1_2 ///
vc_on_vc_crd_nm_erlier_2_1_3 vc_on_vc_crd_nm_erlier_2_1_4 vc_on_vc_crd_nm_erlier_2_1_5 ///
vc_on_vc_crd_nm_erlier_2_1_6 vc_on_vc_crd_nm_erlier_2_1_7 vc_on_vc_crd_nm_erlier_2_1_8 ///
vc_on_vc_crd_nm_erlier_2_1_9 vc_on_vc_crd_nm_erlier_2_1_10 vc_on_vc_crd_nm_erlier_2_1_11 ///
vc_on_vc_crd_nm_erlier_2_1_12 vc_on_vc_crd_nm_erlier_2_1_13 vc_on_vc_crd_nm_erlier_2_1_14 ///
vc_on_vc_crd_nm_erlier_2_1_15 vc_on_vc_crd_nm_erlier_2_1_16 vc_on_vc_crd_nm_erlier_2_2_1 ///
vc_on_vc_crd_nm_erlier_2_2_2 vc_on_vc_crd_nm_erlier_2_2_3 vc_on_vc_crd_nm_erlier_2_2_4 ///
vc_on_vc_crd_nm_erlier_2_2_5 vc_on_vc_crd_nm_erlier_2_2_6 vc_on_vc_crd_nm_erlier_2_2_7 ///
vc_on_vc_crd_nm_erlier_2_2_8 vc_on_vc_crd_nm_erlier_2_2_9 vc_on_vc_crd_nm_erlier_2_2_10 ///
vc_on_vc_crd_nm_erlier_2_2_11 vc_on_vc_crd_nm_erlier_2_2_12 vc_on_vc_crd_nm_erlier_2_2_13 ///
vc_on_vc_crd_nm_erlier_2_2_14 vc_on_vc_crd_nm_erlier_2_2_15 vc_on_vc_crd_nm_erlier_2_2_16 ///
vc_on_vc_crd_nm_erlier_3_1_1 vc_on_vc_crd_nm_erlier_3_1_2 vc_on_vc_crd_nm_erlier_3_1_3 ///
vc_on_vc_crd_nm_erlier_3_1_4 vc_on_vc_crd_nm_erlier_3_1_5 vc_on_vc_crd_nm_erlier_3_1_6 ///
vc_on_vc_crd_nm_erlier_3_1_7 vc_on_vc_crd_nm_erlier_3_1_8 vc_on_vc_crd_nm_erlier_3_1_9 ///
vc_on_vc_crd_nm_erlier_3_1_10 vc_on_vc_crd_nm_erlier_3_1_11 vc_on_vc_crd_nm_erlier_3_1_12 ///
vc_on_vc_crd_nm_erlier_3_1_13 vc_on_vc_crd_nm_erlier_3_1_14 vc_on_vc_crd_nm_erlier_3_1_15 ///
vc_on_vc_crd_nm_erlier_3_1_16 vc_on_vc_crd_nm_erlier_3_2_1 vc_on_vc_crd_nm_erlier_3_2_2 ///
vc_on_vc_crd_nm_erlier_3_2_3 vc_on_vc_crd_nm_erlier_3_2_4 vc_on_vc_crd_nm_erlier_3_2_5 ///
vc_on_vc_crd_nm_erlier_3_2_6 vc_on_vc_crd_nm_erlier_3_2_7 vc_on_vc_crd_nm_erlier_3_2_8 ///
vc_on_vc_crd_nm_erlier_3_2_9 vc_on_vc_crd_nm_erlier_3_2_10 vc_on_vc_crd_nm_erlier_3_2_11 ///
vc_on_vc_crd_nm_erlier_3_2_12 vc_on_vc_crd_nm_erlier_3_2_13 vc_on_vc_crd_nm_erlier_3_2_14 ///
vc_on_vc_crd_nm_erlier_3_2_15 vc_on_vc_crd_nm_erlier_3_2_16) ///
(vc_on_vc_crd_nm_erlier_1_1_1 ///
vc_on_vc_crd_nm_erlier_2_1_1 vc_on_vc_crd_nm_erlier_3_1_1 vc_on_vc_crd_nm_erlier_4_1_1 ///
vc_on_vc_crd_nm_erlier_5_1_1 vc_on_vc_crd_nm_erlier_6_1_1 vc_on_vc_crd_nm_erlier_7_1_1 ///
vc_on_vc_crd_nm_erlier_8_1_1 vc_on_vc_crd_nm_erlier_9_1_1 vc_on_vc_crd_nm_erlier_10_1_1 ///
vc_on_vc_crd_nm_erlier_11_1_1 vc_on_vc_crd_nm_erlier_12_1_1 vc_on_vc_crd_nm_erlier_13_1_1 ///
vc_on_vc_crd_nm_erlier_14_1_1 vc_on_vc_crd_nm_erlier_15_1_1 vc_on_vc_crd_nm_erlier_16_1_1 ///
vc_on_vc_crd_nm_erlier_1_2_1 vc_on_vc_crd_nm_erlier_2_2_1 vc_on_vc_crd_nm_erlier_3_2_1 ///
vc_on_vc_crd_nm_erlier_4_2_1 vc_on_vc_crd_nm_erlier_5_2_1 vc_on_vc_crd_nm_erlier_6_2_1 ///
vc_on_vc_crd_nm_erlier_7_2_1 vc_on_vc_crd_nm_erlier_8_2_1 vc_on_vc_crd_nm_erlier_9_2_1 ///
vc_on_vc_crd_nm_erlier_10_2_1 vc_on_vc_crd_nm_erlier_11_2_1 vc_on_vc_crd_nm_erlier_12_2_1 ///
vc_on_vc_crd_nm_erlier_13_2_1 vc_on_vc_crd_nm_erlier_14_2_1 vc_on_vc_crd_nm_erlier_15_2_1 ///
vc_on_vc_crd_nm_erlier_16_2_1 vc_on_vc_crd_nm_erlier_1_1_2 vc_on_vc_crd_nm_erlier_2_1_2 ///
vc_on_vc_crd_nm_erlier_3_1_2 vc_on_vc_crd_nm_erlier_4_1_2 vc_on_vc_crd_nm_erlier_5_1_2 ///
vc_on_vc_crd_nm_erlier_6_1_2 vc_on_vc_crd_nm_erlier_7_1_2 vc_on_vc_crd_nm_erlier_8_1_2 ///
vc_on_vc_crd_nm_erlier_9_1_2 vc_on_vc_crd_nm_erlier_10_1_2 vc_on_vc_crd_nm_erlier_11_1_2 ///
vc_on_vc_crd_nm_erlier_12_1_2 vc_on_vc_crd_nm_erlier_13_1_2 vc_on_vc_crd_nm_erlier_14_1_2 ///
vc_on_vc_crd_nm_erlier_15_1_2 vc_on_vc_crd_nm_erlier_16_1_2 vc_on_vc_crd_nm_erlier_1_2_2 ///
vc_on_vc_crd_nm_erlier_2_2_2 vc_on_vc_crd_nm_erlier_3_2_2 vc_on_vc_crd_nm_erlier_4_2_2 ///
vc_on_vc_crd_nm_erlier_5_2_2 vc_on_vc_crd_nm_erlier_6_2_2 vc_on_vc_crd_nm_erlier_7_2_2 ///
vc_on_vc_crd_nm_erlier_8_2_2 vc_on_vc_crd_nm_erlier_9_2_2 vc_on_vc_crd_nm_erlier_10_2_2 ///
vc_on_vc_crd_nm_erlier_11_2_2 vc_on_vc_crd_nm_erlier_12_2_2 vc_on_vc_crd_nm_erlier_13_2_2 ///
vc_on_vc_crd_nm_erlier_14_2_2 vc_on_vc_crd_nm_erlier_15_2_2 vc_on_vc_crd_nm_erlier_16_2_2 ///
vc_on_vc_crd_nm_erlier_1_1_3 vc_on_vc_crd_nm_erlier_2_1_3 vc_on_vc_crd_nm_erlier_3_1_3 ///
vc_on_vc_crd_nm_erlier_4_1_3 vc_on_vc_crd_nm_erlier_5_1_3 vc_on_vc_crd_nm_erlier_6_1_3 ///
vc_on_vc_crd_nm_erlier_7_1_3 vc_on_vc_crd_nm_erlier_8_1_3 vc_on_vc_crd_nm_erlier_9_1_3 ///
vc_on_vc_crd_nm_erlier_10_1_3 vc_on_vc_crd_nm_erlier_11_1_3 vc_on_vc_crd_nm_erlier_12_1_3 ///
vc_on_vc_crd_nm_erlier_13_1_3 vc_on_vc_crd_nm_erlier_14_1_3 vc_on_vc_crd_nm_erlier_15_1_3 ///
vc_on_vc_crd_nm_erlier_16_1_3 vc_on_vc_crd_nm_erlier_1_2_3 vc_on_vc_crd_nm_erlier_2_2_3 ///
vc_on_vc_crd_nm_erlier_3_2_3 vc_on_vc_crd_nm_erlier_4_2_3 vc_on_vc_crd_nm_erlier_5_2_3 ///
vc_on_vc_crd_nm_erlier_6_2_3 vc_on_vc_crd_nm_erlier_7_2_3 vc_on_vc_crd_nm_erlier_8_2_3 ///
vc_on_vc_crd_nm_erlier_9_2_3 vc_on_vc_crd_nm_erlier_10_2_3 vc_on_vc_crd_nm_erlier_11_2_3 ///
vc_on_vc_crd_nm_erlier_12_2_3 vc_on_vc_crd_nm_erlier_13_2_3 vc_on_vc_crd_nm_erlier_14_2_3 ///
vc_on_vc_crd_nm_erlier_15_2_3 vc_on_vc_crd_nm_erlier_16_2_3)

rename (vc_crd_miss_recl_vc_nm_1_1_2 vc_crd_miss_recl_vc_nm_2_1_2 ///
vc_crd_miss_recl_vc_nm_3_1_2 vc_crd_miss_recl_vc_nm_4_1_2 ///
vc_crd_miss_recl_vc_nm_5_1_2 vc_crd_miss_recl_vc_nm_6_1_2 ///
vc_crd_miss_recl_vc_nm_7_1_2 vc_crd_miss_recl_vc_nm_8_1_2 ///
vc_crd_miss_recl_vc_nm_9_1_2 vc_crd_miss_recl_vc_nm_10_1_2 ///
vc_crd_miss_recl_vc_nm_11_1_2 vc_crd_miss_recl_vc_nm_12_1_2 ///
vc_crd_miss_recl_vc_nm_13_1_2 vc_crd_miss_recl_vc_nm_14_1_2 ///
vc_crd_miss_recl_vc_nm_15_1_2 vc_crd_miss_recl_vc_nm_16_1_2 ///
vc_crd_miss_recl_vc_nm_17_1_2 vc_crd_miss_recl_vc_nm_18_1_2 ///
vc_crd_miss_recl_vc_nm_19_1_2 vc_crd_miss_recl_vc_nm_20_1_2 ///
vc_crd_miss_recl_vc_nm_1_2_1 vc_crd_miss_recl_vc_nm_2_2_1 ///
vc_crd_miss_recl_vc_nm_3_2_1 vc_crd_miss_recl_vc_nm_4_2_1 ///
vc_crd_miss_recl_vc_nm_5_2_1 vc_crd_miss_recl_vc_nm_6_2_1 ///
vc_crd_miss_recl_vc_nm_7_2_1 vc_crd_miss_recl_vc_nm_8_2_1 ///
vc_crd_miss_recl_vc_nm_9_2_1 vc_crd_miss_recl_vc_nm_10_2_1 ///
vc_crd_miss_recl_vc_nm_11_2_1 vc_crd_miss_recl_vc_nm_12_2_1 ///
vc_crd_miss_recl_vc_nm_13_2_1 vc_crd_miss_recl_vc_nm_14_2_1 ///
vc_crd_miss_recl_vc_nm_15_2_1 vc_crd_miss_recl_vc_nm_16_2_1 ///
vc_crd_miss_recl_vc_nm_17_2_1 vc_crd_miss_recl_vc_nm_18_2_1 ///
vc_crd_miss_recl_vc_nm_19_2_1 vc_crd_miss_recl_vc_nm_20_2_1 ///
vc_crd_miss_recl_vc_nm_1_3_1  vc_crd_miss_recl_vc_nm_2_3_1  ///
vc_crd_miss_recl_vc_nm_3_3_1  vc_crd_miss_recl_vc_nm_4_3_1  ///
vc_crd_miss_recl_vc_nm_5_3_1  vc_crd_miss_recl_vc_nm_6_3_1  ///
vc_crd_miss_recl_vc_nm_7_3_1  vc_crd_miss_recl_vc_nm_8_3_1  ///
vc_crd_miss_recl_vc_nm_9_3_1  vc_crd_miss_recl_vc_nm_10_3_1  ///
vc_crd_miss_recl_vc_nm_11_3_1  vc_crd_miss_recl_vc_nm_12_3_1  ///
vc_crd_miss_recl_vc_nm_13_3_1  vc_crd_miss_recl_vc_nm_14_3_1  ///
vc_crd_miss_recl_vc_nm_15_3_1  vc_crd_miss_recl_vc_nm_16_3_1  ///
vc_crd_miss_recl_vc_nm_17_3_1  vc_crd_miss_recl_vc_nm_18_3_1  ///
vc_crd_miss_recl_vc_nm_19_3_1  vc_crd_miss_recl_vc_nm_20_3_1 ///
vc_crd_miss_recl_vc_nm_1_3_2  vc_crd_miss_recl_vc_nm_2_3_2  ///
vc_crd_miss_recl_vc_nm_3_3_2  vc_crd_miss_recl_vc_nm_4_3_2  ///
vc_crd_miss_recl_vc_nm_5_3_2  vc_crd_miss_recl_vc_nm_6_3_2  ///
vc_crd_miss_recl_vc_nm_7_3_2  vc_crd_miss_recl_vc_nm_8_3_2  ///
vc_crd_miss_recl_vc_nm_9_3_2  vc_crd_miss_recl_vc_nm_10_3_2  ///
vc_crd_miss_recl_vc_nm_11_3_2  vc_crd_miss_recl_vc_nm_12_3_2  ///
vc_crd_miss_recl_vc_nm_13_3_2  vc_crd_miss_recl_vc_nm_14_3_2  ///
vc_crd_miss_recl_vc_nm_15_3_2  vc_crd_miss_recl_vc_nm_16_3_2  ///
vc_crd_miss_recl_vc_nm_17_3_2  vc_crd_miss_recl_vc_nm_18_3_2  ///
vc_crd_miss_recl_vc_nm_19_3_2  vc_crd_miss_recl_vc_nm_20_3_2) ///
(vc_crd_miss_recl_vc_nm_1_2_1 vc_crd_miss_recl_vc_nm_2_2_1 ///
vc_crd_miss_recl_vc_nm_3_2_1 vc_crd_miss_recl_vc_nm_4_2_1 ///
vc_crd_miss_recl_vc_nm_5_2_1 vc_crd_miss_recl_vc_nm_6_2_1 ///
vc_crd_miss_recl_vc_nm_7_2_1 vc_crd_miss_recl_vc_nm_8_2_1 ///
vc_crd_miss_recl_vc_nm_9_2_1 vc_crd_miss_recl_vc_nm_10_2_1 ///
vc_crd_miss_recl_vc_nm_11_2_1 vc_crd_miss_recl_vc_nm_12_2_1 ///
vc_crd_miss_recl_vc_nm_13_2_1 vc_crd_miss_recl_vc_nm_14_2_1 ///
vc_crd_miss_recl_vc_nm_15_2_1 vc_crd_miss_recl_vc_nm_16_2_1 ///
vc_crd_miss_recl_vc_nm_17_2_1 vc_crd_miss_recl_vc_nm_18_2_1 ///
vc_crd_miss_recl_vc_nm_19_2_1 vc_crd_miss_recl_vc_nm_20_2_1 ///
vc_crd_miss_recl_vc_nm_1_1_2 vc_crd_miss_recl_vc_nm_2_1_2 ///
vc_crd_miss_recl_vc_nm_3_1_2 vc_crd_miss_recl_vc_nm_4_1_2 ///
vc_crd_miss_recl_vc_nm_5_1_2 vc_crd_miss_recl_vc_nm_6_1_2 ///
vc_crd_miss_recl_vc_nm_7_1_2 vc_crd_miss_recl_vc_nm_8_1_2 ///
vc_crd_miss_recl_vc_nm_9_1_2 vc_crd_miss_recl_vc_nm_10_1_2 ///
vc_crd_miss_recl_vc_nm_11_1_2 vc_crd_miss_recl_vc_nm_12_1_2 ///
vc_crd_miss_recl_vc_nm_13_1_2 vc_crd_miss_recl_vc_nm_14_1_2 ///
vc_crd_miss_recl_vc_nm_15_1_2 vc_crd_miss_recl_vc_nm_16_1_2 ///
vc_crd_miss_recl_vc_nm_17_1_2 vc_crd_miss_recl_vc_nm_18_1_2 ///
vc_crd_miss_recl_vc_nm_19_1_2 vc_crd_miss_recl_vc_nm_20_1_2 ///
vc_crd_miss_recl_vc_nm_1_1_3 vc_crd_miss_recl_vc_nm_2_1_3 ///
vc_crd_miss_recl_vc_nm_3_1_3 vc_crd_miss_recl_vc_nm_4_1_3 ///
vc_crd_miss_recl_vc_nm_5_1_3 vc_crd_miss_recl_vc_nm_6_1_3 ///
vc_crd_miss_recl_vc_nm_7_1_3 vc_crd_miss_recl_vc_nm_8_1_3 ///
vc_crd_miss_recl_vc_nm_9_1_3 vc_crd_miss_recl_vc_nm_10_1_3 ///
vc_crd_miss_recl_vc_nm_11_1_3 vc_crd_miss_recl_vc_nm_12_1_3 ///
vc_crd_miss_recl_vc_nm_13_1_3 vc_crd_miss_recl_vc_nm_14_1_3 ///
vc_crd_miss_recl_vc_nm_15_1_3 vc_crd_miss_recl_vc_nm_16_1_3 ///
vc_crd_miss_recl_vc_nm_17_1_3 vc_crd_miss_recl_vc_nm_18_1_3 ///
vc_crd_miss_recl_vc_nm_19_1_3 vc_crd_miss_recl_vc_nm_20_1_3 ///
vc_crd_miss_recl_vc_nm_1_2_3 vc_crd_miss_recl_vc_nm_2_2_3 ///
vc_crd_miss_recl_vc_nm_3_2_3 vc_crd_miss_recl_vc_nm_4_2_3 ///
vc_crd_miss_recl_vc_nm_5_2_3 vc_crd_miss_recl_vc_nm_6_2_3 ///
vc_crd_miss_recl_vc_nm_7_2_3 vc_crd_miss_recl_vc_nm_8_2_3 ///
vc_crd_miss_recl_vc_nm_9_2_3 vc_crd_miss_recl_vc_nm_10_2_3 ///
vc_crd_miss_recl_vc_nm_11_2_3 vc_crd_miss_recl_vc_nm_12_2_3 ///
vc_crd_miss_recl_vc_nm_13_2_3 vc_crd_miss_recl_vc_nm_14_2_3 ///
vc_crd_miss_recl_vc_nm_15_2_3 vc_crd_miss_recl_vc_nm_16_2_3 ///
vc_crd_miss_recl_vc_nm_17_2_3 vc_crd_miss_recl_vc_nm_18_2_3 ///
vc_crd_miss_recl_vc_nm_19_2_3 vc_crd_miss_recl_vc_nm_20_2_3)

rename (send_rem_cg_mat_home_1 send_rem_cg_mat_home_2 send_rem_cg_mat_home_3 ///
have_mcp_card_or_not_1 have_mcp_card_or_not_2 have_mcp_card_or_not_3 ///
mcp_card_refuse_show_reas_1 mcp_card_refuse_show_reas_2 ///
mcp_card_refuse_show_reas_3 ///
mcp_card_due_date_on_card_1 mcp_card_due_date_on_card_2 ///
mcp_card_due_date_on_card_3 child_due_date_mcp_card_1_1 ///
child_due_date_mcp_card_1_2 child_due_date_mcp_card_1_3 ///
child_due_date_mcp_card_2_1 child_due_date_mcp_card_2_2 ///
child_due_date_mcp_card_2_3) ///
(maternal_home_visit_1 maternal_home_visit_2 maternal_home_visit_3 ///
mcp_card_available_1 mcp_card_available_2 mcp_card_available_3 ///
mcp_card_not_available_reason1 mcp_card_not_available_reason2 ///
mcp_card_not_available_reason3 due_date_mcp_cardpresent_flag1 ///
due_date_mcp_card_present_flag2 due_date_mcp_card_present_flag3 ///
due_date_mcp_card_1 due_date_mcp_card_2 due_date_mcp_card_3 ///
due_date_mcp_card_redundant1 due_date_mcp_card_redundant2 ///
due_date_mcp_card_redundant3)

rename (phone_number_main_mf_1 phone_number_main_mf_2 phone_number_main_mf_3) ///
(maternal_contact_number_1 maternal_contact_number_2 maternal_contact_number_3)
rename (is_main_phn_smart_phone_mf_1 is_main_phn_smart_phone_mf_2 ///
is_main_phn_smart_phone_mf_3) ///
(maternalhome_contact_smartphone1 maternalhome_contact_smartphone2 ///
maternalhome_contact_smartphone3)
rename (ch_due_date_rec_enter_1_1 ///
ch_due_date_rec_enter_2_1 ch_due_date_rec_enter_1_2 ///
ch_due_date_rec_enter_2_2 ch_due_date_rec_enter_1_3 ///
ch_due_date_rec_enter_2_3) (due_date_recall_1 due_date_recall_redu_1 /// 
due_date_recall_2 due_date_recall_redu_2 due_date_recall_3 ///
due_date_recall_redu_3)

**Variable Conversions---------------------------------------------------------------

replace second_child_flag_1 = "0" if second_child_flag_1 == "1"
replace second_child_flag_1 = "1" if second_child_flag_1 == "2"
replace second_child_flag_2 = "0" if second_child_flag_2 == "1"
replace second_child_flag_2 = "1" if second_child_flag_2 == "2"
replace second_child_flag_3 = "0" if second_child_flag_3 == "1"
replace second_child_flag_3 = "1" if second_child_flag_3 == "2"




**Rehape------------------------------------------------------------------------
gen id = _n

reshape long eligibility_check_phone_number_ eligibility_check_pregnant_ ///
eligibility_check_child_ respondent_literacy_level_ mothers_contact_number_ ///
mothers_contact_smartphone_flag alternate_contact_1_name_ ///
alternate_contact_2_name_ alternate_contact_3_name_ ///
alternate_contact1_smartphone_f alternate_contact2_smartphone_f ///
alternate_contact3_smartphone_f alternate_contact1_number_ ///
alternate_contact2_number_ alternate_contact3_number_ ///
alternate_contact_1_rel_ alternate_contact_2_rel_ ///
alternate_contact_3_rel_ mothers_preferred_language_ name1_ name2_ dob1_ ///
dob2_ vc_on_vc_card_date_1_1_ ///
vc_on_vc_card_date_2_1_ vc_on_vc_card_date_3_1_ vc_on_vc_card_date_4_1_ ///
vc_on_vc_card_date_5_1_ vc_on_vc_card_date_6_1_ vc_on_vc_card_date_7_1_ ///
vc_on_vc_card_date_8_1_ vc_on_vc_card_date_9_1_ vc_on_vc_card_date_10_1_ ///
vc_on_vc_card_date_11_1_ vc_on_vc_card_date_12_1_ vc_on_vc_card_date_13_1_ ///
vc_on_vc_card_date_14_1_ vc_on_vc_card_date_15_1_ vc_on_vc_card_date_16_1_ ///
vc_on_vc_card_date_1_2_ vc_on_vc_card_date_2_2_ vc_on_vc_card_date_3_2_ ///
vc_on_vc_card_date_4_2_ vc_on_vc_card_date_5_2_ vc_on_vc_card_date_6_2_ ///
vc_on_vc_card_date_7_2_ vc_on_vc_card_date_8_2_ vc_on_vc_card_date_9_2_ ///
vc_on_vc_card_date_10_2_ vc_on_vc_card_date_11_2_ vc_on_vc_card_date_12_2_ ///
vc_on_vc_card_date_13_2_ vc_on_vc_card_date_14_2_ vc_on_vc_card_date_15_2_ ///
vc_on_vc_card_date_16_2_ vc_on_vc_crd_nm_erlier_1_1_ ///
vc_on_vc_crd_nm_erlier_2_1_ vc_on_vc_crd_nm_erlier_3_1_ vc_on_vc_crd_nm_erlier_4_1_ ///
vc_on_vc_crd_nm_erlier_5_1_ vc_on_vc_crd_nm_erlier_6_1_ vc_on_vc_crd_nm_erlier_7_1_ ///
vc_on_vc_crd_nm_erlier_8_1_ vc_on_vc_crd_nm_erlier_9_1_ vc_on_vc_crd_nm_erlier_10_1_ ///
vc_on_vc_crd_nm_erlier_11_1_ vc_on_vc_crd_nm_erlier_12_1_ vc_on_vc_crd_nm_erlier_13_1_ ///
vc_on_vc_crd_nm_erlier_14_1_ vc_on_vc_crd_nm_erlier_15_1_ vc_on_vc_crd_nm_erlier_16_1_ ///
vc_on_vc_crd_nm_erlier_1_2_ ///
vc_on_vc_crd_nm_erlier_2_2_ vc_on_vc_crd_nm_erlier_3_2_ vc_on_vc_crd_nm_erlier_4_2_ ///
vc_on_vc_crd_nm_erlier_5_2_ vc_on_vc_crd_nm_erlier_6_2_ vc_on_vc_crd_nm_erlier_7_2_ ///
vc_on_vc_crd_nm_erlier_8_2_ vc_on_vc_crd_nm_erlier_9_2_ vc_on_vc_crd_nm_erlier_10_2_ ///
vc_on_vc_crd_nm_erlier_11_2_ vc_on_vc_crd_nm_erlier_12_2_ vc_on_vc_crd_nm_erlier_13_2_ ///
vc_on_vc_crd_nm_erlier_14_2_ vc_on_vc_crd_nm_erlier_15_2_ vc_on_vc_crd_nm_erlier_16_2_ ///
maternal_home_visit_ mcp_card_not_available_reason mcp_card_available_ ///
due_date_mcp_card_present_flag due_date_mcp_card_ due_date_mcp_card_redundant ///
first_prenatal_visit_ second_prenatal_visit_ third_prenatal_visit_ ///
fourth_prenatal_visit_ first_prenatal_visit_date_ sec_prenat_vis_date_ ///
third_prenatal_visit_date_ fourth_prenat_vis_date_ second_child_flag_ ///
mothers_name_ maternal_contact_number maternalhome_contact_smartphone ///
due_date_recall_ due_date_recall_redu_  ///
vc_crd_miss_recl_vc_nm_1_1_ vc_crd_miss_recl_vc_nm_2_1_ ///
vc_crd_miss_recl_vc_nm_3_1_ vc_crd_miss_recl_vc_nm_4_1_ ///
vc_crd_miss_recl_vc_nm_5_1_ vc_crd_miss_recl_vc_nm_6_1_ ///
vc_crd_miss_recl_vc_nm_7_1_ vc_crd_miss_recl_vc_nm_8_1_ ///
vc_crd_miss_recl_vc_nm_9_1_ vc_crd_miss_recl_vc_nm_10_1_ ///
vc_crd_miss_recl_vc_nm_11_1_ vc_crd_miss_recl_vc_nm_12_1_ ///
vc_crd_miss_recl_vc_nm_13_1_ vc_crd_miss_recl_vc_nm_14_1_ ///
vc_crd_miss_recl_vc_nm_15_1_ vc_crd_miss_recl_vc_nm_16_1_ ///
vc_crd_miss_recl_vc_nm_17_1_ vc_crd_miss_recl_vc_nm_18_1_ ///
vc_crd_miss_recl_vc_nm_19_1_ vc_crd_miss_recl_vc_nm_20_1_ ///
vc_crd_miss_recl_vc_nm_1_2_ vc_crd_miss_recl_vc_nm_2_2_ ///
vc_crd_miss_recl_vc_nm_3_2_ vc_crd_miss_recl_vc_nm_4_2_ ///
vc_crd_miss_recl_vc_nm_5_2_ vc_crd_miss_recl_vc_nm_6_2_ ///
vc_crd_miss_recl_vc_nm_7_2_ vc_crd_miss_recl_vc_nm_8_2_ ///
vc_crd_miss_recl_vc_nm_9_2_ vc_crd_miss_recl_vc_nm_10_2_ ///
vc_crd_miss_recl_vc_nm_11_2_ vc_crd_miss_recl_vc_nm_12_2_ ///
vc_crd_miss_recl_vc_nm_13_2_ vc_crd_miss_recl_vc_nm_14_2_ ///
vc_crd_miss_recl_vc_nm_15_2_ vc_crd_miss_recl_vc_nm_16_2_ ///
vc_crd_miss_recl_vc_nm_17_2_ vc_crd_miss_recl_vc_nm_18_2_ ///
vc_crd_miss_recl_vc_nm_19_2_ vc_crd_miss_recl_vc_nm_20_2_ ///
 child_vaccinated_where_1_ child_vaccinated_where_2_ ///
 child_vaccinated_where_3_ child_vaccinated_where_4_ ///
 child_vaccinated_where_5_ child_vaccinated_where_6_ ///
 child_vaccinated_where_7_ child_vaccinated_where_8_ ///
 child_vaccinated_where_9_ ///
, i(id) j(Mother)

**Post reshape operations-----------------------------------------------------------
rename (alternate_contact1_smartphone_f ///
alternate_contact2_smartphone_f ///
alternate_contact3_smartphone_f) (alternate_contact1_smartphone_fl ///
alternate_contact2_smartphone_fl alternate_contact3_smartphone_fl)


**drop empty observations
drop if eligibility_check_child == "." & eligibility_check_pregnant == "."

**vaccination card date conversions
gen date_vacc_card_opv0_prese1 = 0
gen date_vacc_card_opv01 = ""
gen date_vacc_card_bcg_presen1 = 0
gen date_vacc_card_bcg1 = ""
gen date_vacc_card_opv1_prese1 = 0
gen date_vacc_card_opv11 = ""
gen date_vacc_card_opv2_prese1 = 0
gen date_vacc_card_opv21 = ""
gen date_vacc_card_penta1_pre1 = 0 
gen date_vacc_card_penta11 = "" 
gen date_vacc_card_penta2_pre1 = 0
gen date_vacc_card_penta21 = ""
gen date_vacc_card_penta3_pre1 = 0
gen date_vacc_card_penta31 = ""
gen date_vacc_card_opvbooster1 = 0
gen date_vacc_card_OPVBooster1 = ""
gen date_vacc_card_opv0_prese2 = 0
gen date_vacc_card_opv02 = ""
gen date_vacc_card_bcg_presen2 = 0
gen date_vacc_card_bcg2 = ""
gen date_vacc_card_opv1_prese2 = 0
gen date_vacc_card_opv12 = ""
gen date_vacc_card_opv2_prese2 = 0
gen date_vacc_card_opv22 = ""
gen date_vacc_card_penta1_pre2 = 0 
gen date_vacc_card_penta12 = "" 
gen date_vacc_card_penta2_pre2 = 0
gen date_vacc_card_penta22 = ""
gen date_vacc_card_penta3_pre2 = 0
gen date_vacc_card_penta32 = ""
gen date_vacc_card_opvbooster2 = 0
gen date_vacc_card_OPVBooster2 = ""


foreach var of varlist vc_on_vc_crd_nm_erlier_1_1_ ///
vc_on_vc_crd_nm_erlier_2_1_ vc_on_vc_crd_nm_erlier_3_1_ vc_on_vc_crd_nm_erlier_4_1_ ///
vc_on_vc_crd_nm_erlier_5_1_ vc_on_vc_crd_nm_erlier_6_1_ vc_on_vc_crd_nm_erlier_7_1_ ///
vc_on_vc_crd_nm_erlier_8_1_ vc_on_vc_crd_nm_erlier_9_1_ vc_on_vc_crd_nm_erlier_10_1_ ///
vc_on_vc_crd_nm_erlier_11_1_ vc_on_vc_crd_nm_erlier_12_1_ vc_on_vc_crd_nm_erlier_13_1_ ///
vc_on_vc_crd_nm_erlier_14_1_ vc_on_vc_crd_nm_erlier_15_1_ vc_on_vc_crd_nm_erlier_16_1_ ///
 ///
{
local secondlastspace = length("`var'")-4
	local secondlast = substr("`var'",`secondlastspace',1)
	if "`secondlast'" == "_" {
	local suffixlength = length("`var'")-4
	local frontlength = length("`var'")-5
	} 
		else {
	local suffixlength = length("`var'")-5
	local frontlength = length("`var'")-6
	}
	local suffix = substr("`var'",`suffixlength',.)

replace date_vacc_card_opv0_prese1 = 1 if `var' ///
== "OPV0"
replace date_vacc_card_opv01 = vc_on_vc_card_date`suffix' if `var' ///
== "OPV0"
replace date_vacc_card_bcg_presen1 = 1 if `var' ///
== "BCG"
replace date_vacc_card_bcg1 = vc_on_vc_card_date`suffix' if `var' ///
== "BCG"
replace date_vacc_card_opv1_prese1 = 1 if `var' ///
== "OPV1"
replace date_vacc_card_opv11 = vc_on_vc_card_date`suffix' if `var' ///
== "OPV1"
replace date_vacc_card_opv2_prese1 = 1 if `var' ///
== "OPV2"
replace date_vacc_card_opv21 = vc_on_vc_card_date`suffix' if `var' ///
== "OPV2"
replace date_vacc_card_penta1_pre1 = 1 if `var' ///
== "PENTA1"
replace date_vacc_card_penta11 = vc_on_vc_card_date`suffix' if `var' ///
== "PENTA1"
replace date_vacc_card_penta2_pre1 = 1 if `var' ///
== "PENTA2"
replace date_vacc_card_penta21 = vc_on_vc_card_date`suffix' if `var' ///
== "PENTA2"
replace date_vacc_card_penta3_pre1 = 1 if `var' ///
== "PENTA3"
replace date_vacc_card_penta31 = vc_on_vc_card_date`suffix' if `var' ///
== "PENTA3"
replace date_vacc_card_opvbooster1 = 1 if `var' ///
== "OPV3"
replace date_vacc_card_OPVBooster1 = vc_on_vc_card_date`suffix' if `var' ///
== "OPV3"
}

foreach var of varlist vc_on_vc_crd_nm_erlier_1_2_ ///
vc_on_vc_crd_nm_erlier_2_2_ vc_on_vc_crd_nm_erlier_3_2_ vc_on_vc_crd_nm_erlier_4_2_ ///
vc_on_vc_crd_nm_erlier_5_2_ vc_on_vc_crd_nm_erlier_6_2_ vc_on_vc_crd_nm_erlier_7_2_ ///
vc_on_vc_crd_nm_erlier_8_2_ vc_on_vc_crd_nm_erlier_9_2_ vc_on_vc_crd_nm_erlier_10_2_ ///
vc_on_vc_crd_nm_erlier_11_2_ vc_on_vc_crd_nm_erlier_12_2_ vc_on_vc_crd_nm_erlier_13_2_ ///
vc_on_vc_crd_nm_erlier_14_2_ vc_on_vc_crd_nm_erlier_15_2_ vc_on_vc_crd_nm_erlier_16_2_ ///
{
local secondlastspace = length("`var'")-4
	local secondlast = substr("`var'",`secondlastspace',1)
	if "`secondlast'" == "_" {
	local suffixlength = length("`var'")-4
	local frontlength = length("`var'")-5
	} 
		else {
	local suffixlength = length("`var'")-5
	local frontlength = length("`var'")-6
	}
	local suffix = substr("`var'",`suffixlength',.)

replace date_vacc_card_opv0_prese2 = 1 if `var' ///
== "OPV0"
replace date_vacc_card_opv02 = vc_on_vc_card_date`suffix' if `var' ///
== "OPV0"
replace date_vacc_card_bcg_presen2 = 1 if `var' ///
== "BCG"
replace date_vacc_card_bcg2 = vc_on_vc_card_date`suffix' if `var' ///
== "BCG"
replace date_vacc_card_opv1_prese2 = 1 if `var' ///
== "OPV1"
replace date_vacc_card_opv12 = vc_on_vc_card_date`suffix' if `var' ///
== "OPV1"
replace date_vacc_card_opv2_prese2 = 1 if `var' ///
== "OPV2"
replace date_vacc_card_opv22 = vc_on_vc_card_date`suffix' if `var' ///
== "OPV2"
replace date_vacc_card_penta1_pre2= 1 if `var' ///
== "PENTA1"
replace date_vacc_card_penta12 = vc_on_vc_card_date`suffix' if `var' ///
== "PENTA1"
replace date_vacc_card_penta2_pre2 = 1 if `var' ///
== "PENTA2"
replace date_vacc_card_penta22 = vc_on_vc_card_date`suffix' if `var' ///
== "PENTA2"
replace date_vacc_card_penta3_pre2 = 1 if `var' ///
== "PENTA3"
replace date_vacc_card_penta32 = vc_on_vc_card_date`suffix' if `var' ///
== "PENTA3"
replace date_vacc_card_opvbooster2 = 1 if `var' ///
== "OPV3"
replace date_vacc_card_OPVBooster2 = vc_on_vc_card_date`suffix' if `var' ///
== "OPV3"
}

**recalling DOB Vaccines
gen birth_vacc_recall_flag1 = 0
gen birth_vacc_recall_flag2 = 0
replace birth_vacc_recall_flag1 = 1 if vc_crd_miss_recl_vc_nm_4_1_ == "1" ///
& vc_crd_miss_recl_vc_nm_5_1_ == "1"
replace birth_vacc_recall_flag2 = 1 if vc_crd_miss_recl_vc_nm_4_2_ == "1" ///
& vc_crd_miss_recl_vc_nm_5_2_ == "1"


**sum of total vaccination recall dates 

destring vc_crd_miss_recl_vc_nm_*_*_ , replace
gen number_of_vacc_visits_rec1 = vc_crd_miss_recl_vc_nm_1_1_ + ///
vc_crd_miss_recl_vc_nm_2_1_ + ///
vc_crd_miss_recl_vc_nm_3_1_ + vc_crd_miss_recl_vc_nm_4_1_ + ///
vc_crd_miss_recl_vc_nm_5_1_ + vc_crd_miss_recl_vc_nm_6_1_ + ///
vc_crd_miss_recl_vc_nm_7_1_ + vc_crd_miss_recl_vc_nm_8_1_ + ///
vc_crd_miss_recl_vc_nm_9_1_ + vc_crd_miss_recl_vc_nm_10_1_ + ///
vc_crd_miss_recl_vc_nm_11_1_ + vc_crd_miss_recl_vc_nm_12_1_ + ///
vc_crd_miss_recl_vc_nm_13_1_ + vc_crd_miss_recl_vc_nm_14_1_ + ///
vc_crd_miss_recl_vc_nm_15_1_ + vc_crd_miss_recl_vc_nm_16_1_ + ///
vc_crd_miss_recl_vc_nm_17_1_ + vc_crd_miss_recl_vc_nm_18_1_ + ///
vc_crd_miss_recl_vc_nm_19_1_ + vc_crd_miss_recl_vc_nm_20_1_ 
gen number_of_vacc_visits_rec2 = vc_crd_miss_recl_vc_nm_1_2_ + ///
vc_crd_miss_recl_vc_nm_2_2_ + ///
vc_crd_miss_recl_vc_nm_3_2_ + vc_crd_miss_recl_vc_nm_4_2_ + ///
vc_crd_miss_recl_vc_nm_5_2_ + vc_crd_miss_recl_vc_nm_6_2_ + ///
vc_crd_miss_recl_vc_nm_7_2_ + vc_crd_miss_recl_vc_nm_8_2_ + ///
vc_crd_miss_recl_vc_nm_9_2_ + vc_crd_miss_recl_vc_nm_10_2_ + ///
vc_crd_miss_recl_vc_nm_11_2_ + vc_crd_miss_recl_vc_nm_12_2_ + ///
vc_crd_miss_recl_vc_nm_13_2_ + vc_crd_miss_recl_vc_nm_14_2_ + ///
vc_crd_miss_recl_vc_nm_15_2_ + vc_crd_miss_recl_vc_nm_16_2_ + ///
vc_crd_miss_recl_vc_nm_17_2_ + vc_crd_miss_recl_vc_nm_18_2_ + ///
vc_crd_miss_recl_vc_nm_19_2_ + vc_crd_miss_recl_vc_nm_20_2_

//max prenatal visit date for prenatal visit aka last+prenatal_visit_date_mcp_car

gen last_prenatal_visit_date_mcp_ca1 = ""
replace last_prenatal_visit_date_mcp_ca1 = first_prenatal_visit_date_ ///
if first_prenatal_visit_ == "1"
replace last_prenatal_visit_date_mcp_ca1 = sec_prenat_vis_date_ ///
if second_prenatal_visit_ == "1"
replace last_prenatal_visit_date_mcp_ca1 = third_prenatal_visit_date_  ///
if third_prenatal_visit_ == "1"
replace last_prenatal_visit_date_mcp_ca1 = fourth_prenat_vis_date_ ///
if fourth_prenatal_visit_ == "1"
gen last_prenatal_visit_date_mcp_car = 1 if last_prenatal_visit_date_mcp_ca1 ///
!= ""

//Rekey preferred language
destring mothers_preferred_language_, replace force
replace mothers_preferred_language_ = mothers_preferred_language_ - 1


**Bulk drop suffixes------------------------------------------------------------

** Dropping necessary for it to work
drop vc_crd_miss_recl_vc_nm_1_1 vc_crd_miss_recl_vc_nm_1_2 ///
vc_crd_miss_recl_vc_nm_2_1 vc_crd_miss_recl_vc_nm_2_2 ///
vc_crd_miss_recl_vc_nm_3_1 vc_crd_miss_recl_vc_nm_3_2 ///
child_vaccinated_where_1 child_vaccinated_where_2 child_vaccinated_where_3

 foreach var of varlist _all {
	local lastletter = substr("`var'",length("`var'"),.)
	if "`lastletter'" == "_" {
	local newname = substr("`var'",1,length("`var'")-1)
	rename `var' `newname'
	}
 }

 **date and time variables and formatting for easy analysis
**DMYhms
foreach var of varlist submissiondate starttime endtime {
	gen `var't = Clock(`var', "DMYhms")
	drop `var'
	local newname = substr("`var't", 1,length("`var't")-1)
   	rename `var' `newname'
	format `var' %tC
	}

	foreach var of varlist /*last_prenatal_visit_date_mcp_ca1*/ ///
 due_date_recall ///
date_vacc_card_opv01 date_vacc_card_bcg1 date_vacc_card_opv11 ///
date_vacc_card_penta11 date_vacc_card_opv21 date_vacc_card_penta21 ///
date_vacc_card_penta31  ///
date_vacc_card_opv02 date_vacc_card_bcg2 date_vacc_card_opv12 ///
date_vacc_card_penta12 date_vacc_card_opv22 date_vacc_card_penta22 ///
date_vacc_card_penta32  ///
dob1 dob2 due_date_mcp_card ///
due_date_mcp_card_redundant {
gen `var't = date(`var', "DMY")
	drop `var'
	local newname = substr("`var't", 1,length("`var'"))
   	rename `var't `newname'
	format `var' %td
	di "`var'"
}
 
keep instanceid submissiondate starttime endtime member_name deviceid ///
simid devicephonenum complete_text_audit complete_audio_audit consent ///
mothers_name eligibility_check_pregnant eligibility_check_child ///
eligibility_check_phone_number consent_sign latitude longitude altitude ///
accuracy respondent_literacy_level mothers_preferred_language ///
mothers_contact_number  ///
mothers_contact_smartphone_flag alternate_contact_1_name alternate_contact_3_name ///
alternate_contact1_number alternate_contact2_number  ///
alternate_contact1_smartphone_fl alternate_contact_2_name ///
alternate_contact3_number alternate_contact2_smartphone_fl ///
alternate_contact3_smartphone_fl maternal_home_visit mcp_card_available ///
mcp_card_not_available_reason due_date_mcp_card_present_flag ///
due_date_mcp_card due_date_mcp_card_redundant ///
last_prenatal_visit_date_mcp_car last_prenatal_visit_date_mcp_ca1 ///
name* dob* second_child_flag vaccination_card_availabl* ///
vacc_card_photo* date_vacc_card_opv0_prese* date_vacc_card_opv0* ///
date_vacc_card_bcg_presen* date_vacc_card_bcg* date_vacc_card_opv1_prese* ///
date_vacc_card_opv1* date_vacc_card_opv2_prese* date_vacc_card_opv2* ///
date_vacc_card_penta1_pre* date_vacc_card_penta1* date_vacc_card_penta2_pre* ///
date_vacc_card_penta2* date_vacc_card_penta3_pre* date_vacc_card_penta3* ///
date_vacc_card_opvbooster* date_vacc_card_OPVBooster* maternal_contact_number ///
maternalhome_contact_smartphone due_date_recall due_date_recall_redu ///
birth_vacc_recall_flag1 birth_vacc_recall_flag2 ///
number_of_vacc_visits_rec1 number_of_vacc_visits_rec2 child_vaccinated_where_*

destring consent devicephonenum eligibility_check_pregnant ///
eligibility_check_child eligibility_check_phone_number ///
alternate_contact1_smartphone_fl alternate_contact2_smartphone_fl ///
 alternate_contact1_number alternate_contact3_number ///
alternate_contact2_number maternal_contact_number alternate_contact3_smartphone_fl ///
maternalhome_contact_smartphone maternal_home_visit mcp_card_available ///
mcp_card_not_available_reason due_date_mcp_card_present_flag ///
respondent_literacy_level mothers_preferred_language ///
latitude longitude altitude accuracy second_child_flag mothers_contact_number ///
mothers_contact_smartphone_flag child_vaccinated_where_* ///
mcp_card_not_available_reason, replace force

tostring date_vacc_card_opv0_prese* date_vacc_card_bcg_presen* ///
date_vacc_card_opv1_prese* date_vacc_card_opv2_prese*  ///
date_vacc_card_penta1_pre*  date_vacc_card_penta2_pre* ///
date_vacc_card_penta3_pre* date_vacc_card_opvbooster1,replace 
**basic cleaning operations-----------------------------------------------------

**dropping empty observations
//those who are not eligible
drop if eligibility_check_child ==. & eligibility_check_pregnant ==. 

//those who cannot provie any phone number
drop if mothers_contact_number ==. & alternate_contact1_number ==. ///
& alternate_contact2_number ==. 
**dropping other observations which have the same mother and phone number
duplicates drop mothers_name mothers_contact_number ///
alternate_contact1_number alternate_contact2_number ///
alternate_contact3_number, force

save "$output\enrollmentdata_v5_clean.dta", replace
