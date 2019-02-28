cls
//use NSDUH_2017.DTA
//gen suicide = 0 if suicplan != 1
//replace suicide = 1 if suicplan == 1
//gen opioid = 1 if irpnrnmrec == 1
//replace opioid = 1 if irpnrnmrec == 2
//replace opioid = 0 if opioid !=1
logistic suicide i.CATAG2
logistic suicide i.irsex
logistic suicide i.NEWRACE2
logistic suicide i.income
logistic suicide i.amdeyr
logistic suicide i.sexident
logistic suicide i.opioid i.NEWRACE2 i.irsex i.CATAG2 i.income i.amdeyr i.sexident


