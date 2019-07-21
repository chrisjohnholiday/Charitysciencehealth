## Charitysciencehealth
This is datawork that I have done for Charity Science health

None of the files contain any personal or sensitive data because this repository is publc and it is necessary to link the survey CTO raw data to the file structure using the globals at the top of each dofile in order to make them work.

#File descriptions

1. IDI_report_v6_June.do
STATA do file which generated a distribution report for IDinsight for the month of june based on enrollment data from Survey CTO that was cleaned in a seperate dofile. Unable to use without the corresponding cleaned .dta

2.enrollmentdata_master.do
STATA dofile which runs subsequent clean and merge files on raw survey data from survey CTO

3. enrollmentdata_v5_clean.do
STATA do file which cleans and formats v5 enrollment data to be merged with newer type of survey data. Several complex conversion operations including bulk renaming, reshaping and re "keying" variables to fit to those in v6 enrollment data then performs basic cleaning operations

4. enrollmentdata_v6_clean.do
STATA do file which cleans and formats v6 enrollment data to fit to a standard set in the codebook posted on the repository

5. enrollmentdata_merge.do 
The do file which combines all cleaned enrollment data into a single dofile

6. monitoring_and_evaluation_0223.do
Deprecated do file which generates dynamically and persistently generates audit reports for organizations based on audit data and cleaned survey CTO data. The reports are generated as latex files

7. v6_codebook.xls
This is an excel spreadsheet that contains my current standard of cleaned survey CTO data, this is what I aim to keep for all raw survey data IF available
