cls
use NSDUH_2017.DTA
gen suicide = 0 if suicplan != 1
replace suicide = 1 if suicplan == 1
gen opioid = 1 if irpnrnmrec == 1
replace opioid = 1 if irpnrnmrec == 2
replace opioid = 0 if opioid !=1

logistic suicide i.irsex

logistic suicide i.CATAG2

gen race=1 if NEWRACE2==1
replace race=2 if NEWRACE2==2
replace race=3 if NEWRACE2==7 
replace race = 4 if NEWRACE2==3 | NEWRACE2==4 | NEWRACE2==5 | NEWRACE2==6
label variable race "race"
label define race_label 1 "white" 2 "black" 3 "hispanic" 4 "other"
label values race race_label
logistic suicide ib1.race

gen income_high_low = 1 if income ==1 
replace income_high_low = 2 if income > 1
label variable income_high_low "income_h/l"
label define income_label 1 "less than 20K" 2 "more than 20K"
label values income_high_low income_label
logistic suicide i.income_high_low

logistic suicide i.amdeyr
logistic suicide i.sexident
logistic suicide i.opioid i.NEWRACE2 i.irsex i.CATAG2 i.income i.amdeyr i.sexident


