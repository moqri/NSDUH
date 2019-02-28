use NSDUH_2017.DTA
gen suicide = 0 if suicplan != 1
replace suicide = 1 if suicplan == 1
