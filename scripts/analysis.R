library(readr)
library(tableone)
library(sjPlot)

dataset = read_csv("outputs/asthma_inflammation_set.csv")

old_dataset = read_csv("~/Box Sync/2. Barzi Lab - Restricted Access/2-ABCD Data Files/Projects/Kevin projects/3.0/asthma_inflammation_dictionary/data/old/asthma_inflammation_set.csv")
stirling_dataset = read_csv("outputs/Kevin_dataset_07182021.csv")

########################
# table 1
########################
catVars = c("sex","race_white", "race_black", "race_asian", "ethnicity_hisp",
            "medhx_2a","medhx_6l", "medhx_2a_l","medhx_6l_l", "asthma_composite_l", "asthma_composite",
            "Asthma_medications",
            # "Montelukast", "Immune_modulators", "ATC_class_L", 
            # "Systemic_steroids_class_H02","Topical_steroids", "Diabetes_meds",
            "suicidality_y", "SI_y", "SA_y")

myVars = c("age",catVars )
tab <- CreateTableOne(vars = myVars, data = dataset, factorVars = catVars )
table1 <- print(tab, quote = FALSE, noSpaces = TRUE, printToggle = FALSE, missing = T)


tab2 = CreateTableOne(vars = "suicidality_y", data = dataset, factorVars = "suicidality_y", strata = "asthma_composite")
t2 = print(tab2, quote = FALSE, noSpaces = TRUE, printToggle = FALSE )
t2

tab3 = CreateTableOne(vars = "suicidality_y", data = dataset, factorVars = "suicidality_y", strata = "medhx_2a")
t3 = print(tab3, quote = FALSE, noSpaces = TRUE, printToggle = FALSE )
t3

tab4 = CreateTableOne(vars = "suicidality_y", data = dataset, factorVars = "suicidality_y", strata = "medhx_6l")
t4 = print(tab4, quote = FALSE, noSpaces = TRUE, printToggle = FALSE )
t4

tab5 = CreateTableOne(vars = "suicidality_y", data = dataset, factorVars = "suicidality_y", strata = "Asthma_medications")
t5 = print(tab5, quote = FALSE, noSpaces = TRUE, printToggle = FALSE )
t5

tab6 = CreateTableOne(vars = "suicidality_1_year_y", data = dataset, factorVars = "suicidality_1_year_y", strata = "asthma_composite_l")
t6 = print(tab6, quote = FALSE, noSpaces = TRUE, printToggle = FALSE )
t6

########################
# main regressions
########################

mod1 = glm(suicidality_y ~ asthma_composite + interview_age + sex_br + race_white + race_black + ethnicity_hisp  , data = dataset, family = "binomial")
mod2 = glm(suicidality_y ~ asthma_composite + interview_age + sex_br + race_white + race_black + ethnicity_hisp + household_income + parents_avg_edu + devhx_3_p, data = dataset, family = "binomial")
mod3 = glm(suicidality_y ~ asthma_composite + interview_age + sex_br + race_white + race_black + ethnicity_hisp + household_income + parents_avg_edu + devhx_3_p + reshist_addr1_adi_wsum + reshist_addr1_popdensity +reshist_addr1_no2 + reshist_addr1_pm25+ reshist_addr1_proxrd, data = dataset, family = "binomial")

tab_model(mod1,mod2,mod3, show.intercept = F , terms = "asthma_composite")


mod1_l = glm(suicidality_1_year_y ~ asthma_composite_l + interview_age_1_year + sex_br + race_white + race_black + ethnicity_hisp  , data = dataset, family = "binomial")
mod2_l = glm(suicidality_1_year_y ~ asthma_composite_l + interview_age_1_year + sex_br + race_white + race_black + ethnicity_hisp + household_income + parents_avg_edu + devhx_3_p, data = dataset, family = "binomial")
mod3_l = glm(suicidality_1_year_y ~ asthma_composite_l + interview_age_1_year + sex_br + race_white + race_black + ethnicity_hisp + household_income + parents_avg_edu + devhx_3_p + reshist_addr1_adi_wsum + reshist_addr1_popdensity +reshist_addr1_no2 + reshist_addr1_pm25+ reshist_addr1_proxrd, data = dataset, family = "binomial")

tab_model(mod1_l,mod2_l,mod3_l, show.intercept = F, terms = "asthma_composite_l" )


##############################
# regressions with depression 
##############################

mod1_d = glm(suicidality_y ~ asthma_composite + diagnosis_depression_y + interview_age + sex_br + race_white + race_black + ethnicity_hisp  , data = dataset, family = "binomial")
mod2_d = glm(suicidality_y ~ asthma_composite + diagnosis_depression_y + interview_age + sex_br + race_white + race_black + ethnicity_hisp + household_income + parents_avg_edu + devhx_3_p, data = dataset, family = "binomial")
mod3_d = glm(suicidality_y ~ asthma_composite + diagnosis_depression_y + interview_age + sex_br + race_white + race_black + ethnicity_hisp + household_income + parents_avg_edu + devhx_3_p + reshist_addr1_adi_wsum + reshist_addr1_popdensity +reshist_addr1_no2 + reshist_addr1_pm25+ reshist_addr1_proxrd, data = dataset, family = "binomial")

tab_model(mod1_d,mod2_d,mod3_d, show.intercept = F , terms = "asthma_composite")



