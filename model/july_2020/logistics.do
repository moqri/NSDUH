cls
set cformat %9.2f

use NewCombined.DTA
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
label define race_label 1 "white" 2 "black" 3 "hispanic" 4 "other"
label values race race_label
logistic suicide ib1.race

logistic suicide i.irmarit

logistic suicide ib1.eduhighcat

logistic suicide i.IRWRKSTAT18

gen income_high_low = 1 if income ==1 
replace income_high_low = 2 if income > 1
label define income_label 1 "less than 20K" 2 "more than 20K"
label values income_high_low income_label
logistic suicide ib2.income_high_low

gen sexual_identity = 1 if sexident==1
replace sexual_identity =2 if sexident ==2
replace sexual_identity =3 if sexident ==3
label define sexual_identity_label 1 "Heterosexual" 2 "Lesbian or Gay" 3 "Bisexual"
label values sexual_identity sexual_identity_label
logistic suicide i.sexual_identity

logistic suicide ib2.amdeyr

logistic suicide i.opioid

logistic suicide  ib1.race ib2.irsex ib1.CATAG2 i.irmarit ib1.eduhighcat i.IRWRKSTAT18 ib2.income_high_low i.sexual_identity ib2.amdeyr i.opioid i.opioid##ib2.amdeyr


table CATAG2 suicide opioid, contents(freq)
