
library(data.table)
library(dplyr)
library(car)
library(ggplot2)

NASDUH   = fread("NASDUH2017.csv", sep = "," , header = TRUE)

NASDUH_4 = NASDUH  %>%  filter(NASDUH$CATAG2 != "1 - 12-17 Years Old") %>% filter(suicplan %in% c("1 - Yes","2 - No","99 - LEGITIMATE SKIP")) %>% 
                        mutate(suic = ifelse(suicplan == "1 - Yes", "Plan", ifelse(suicplan == "2 - No", "Thought", "No"))) %>% 
                        mutate(pr = ifelse(irpnrnmrec %in% c("9 - NEVER MISUSED PAIN RELIEVERS"), "Never", ifelse(irpnrnmrec %in% c("3 - More than 12 months ago"),"Sometime", "Recent User"))) %>%
                        select(suic,pr,amdeyr)
table(NASDUH_4)


d1o1sp1  = (nrow(NASDUH_4[ which(NASDUH_4$pr=='Recent User' 
                       & NASDUH_4$amdeyr=='1 - Yes'
                       & NASDUH_4$suic =='Plan'), ]))/(nrow(NASDUH_4[ which(NASDUH_4$pr=='Recent User' 
                                                                               & NASDUH_4$amdeyr=='1 - Yes'), ]))

d1o1st1sp1 = (nrow(NASDUH_4[ which(NASDUH_4$pr=='Recent User' 
                                & NASDUH_4$amdeyr=='1 - Yes'
                                & NASDUH_4$suic =='Plan'), ]))/(nrow(NASDUH_4[ which(NASDUH_4$pr=='Recent User' 
                                                                                     & NASDUH_4$amdeyr=='1 - Yes'
                                                                                     & (NASDUH_4$suic == 'Plan'|NASDUH_4$suic=='Thought')), ]))


d0o1sp1    = (nrow(NASDUH_4[ which(NASDUH_4$pr=='Recent User' 
                                & NASDUH_4$amdeyr=='2 - No'
                                & NASDUH_4$suic =='Plan'), ]))/(nrow(NASDUH_4[ which(NASDUH_4$pr=='Recent User' 
                                                                                     & NASDUH_4$amdeyr=='2 - No'), ]))


d0o0sp1    = (nrow(NASDUH_4[ which(NASDUH_4$pr=='Never' 
                                & NASDUH_4$amdeyr=='2 - No'
                                & NASDUH_4$suic =='Plan'), ]))/(nrow(NASDUH_4[ which(NASDUH_4$pr=='Never' 
                                                                                     & NASDUH_4$amdeyr=='2 - No'), ]))


d0o1st1sp1 = (nrow(NASDUH_4[ which(NASDUH_4$pr=='Recent User' 
                                   & NASDUH_4$amdeyr=='2 - No'
                                   & NASDUH_4$suic =='Plan'), ]))/(nrow(NASDUH_4[ which(NASDUH_4$pr=='Recent User' 
                                                                                        & NASDUH_4$amdeyr=='2 - No'
                                                                                        & (NASDUH_4$suic == 'Plan'|NASDUH_4$suic=='Thought')), ]))



NASDUH_4_1 = NASDUH_4 %>% mutate(sui = ifelse(suic == "No", 1,0))

with(NASDUH_4_1, aov(c(sui[pr=="Never"],sui[pr=="Sometime"],sui[pr=="Recent User"]) ~ pr))

model <- glm(sui~pr, data = NASDUH_4_1, family="binomial")

summary(model)

chisq.test(NASDUH_4_1$pr, NASDUH_4_1$sui)


