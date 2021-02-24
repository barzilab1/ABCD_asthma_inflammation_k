##MERGING##

#baseline
##excluding suicide and demographics and medications
anthropometrics <- read_csv("outputs/anthropometrics.csv")
exposome_baseline <- read_csv("outputs/exposome_baseline.csv")
geo_data_baseline <- read_csv("outputs/geo_data_baseline.csv")
ksad_y_diagnosis_anhedonia_baseline <- read_csv("outputs/ksad_y_diagnosis_anhedonia_baseline.csv")
physicalhealth_baseline <- read_csv("outputs/physicalhealth_baseline.csv")
physicalhealth_sum_baseline <- read_csv("outputs/physicalhealth_sum_baseline.csv")

kevin_baseline = merge(anthropometrics,exposome_baseline)
kevin_baseline = merge(kevin_baseline,geo_data_baseline)
kevin_baseline = merge(kevin_baseline,ksad_y_diagnosis_anhedonia_baseline)
kevin_baseline = merge(kevin_baseline,physicalhealth_baseline)
kevin_baseline = merge(kevin_baseline,physicalhealth_sum_baseline)

kevin_baseline = kevin_baseline[kevin_baseline$eventname == "baseline_year_1_arm_1",]

write.csv(file = "outputs/kevin_baseline_set.csv",x = kevin_baseline, row.names = F, na = "")



#1year
##excluding suicide and demographics and medications
anthropometrics <- read_csv("outputs/anthropometrics.csv")
exposome_1year <- read_csv("outputs/exposome_1year.csv")
exposome_sum_1year <- read_csv("outputs/exposome_sum_1year.csv")
physicalhealth_1year <- read_csv("outputs/physicalhealth_1year.csv")
physicalhealth_sum_1year <- read_csv("outputs/physicalhealth_sum_1year.csv")
psychopathology_1year <- read_csv("outputs/psychopathology_1year.csv")
psychopathology_sum_1year <- read_csv("outputs/psychopathology_sum_1year.csv")

kevin_1year = merge(anthropometrics,exposome_1year)
kevin_1year = merge(kevin_1year,exposome_sum_1year)
kevin_1year = merge(kevin_1year,physicalhealth_1year)
kevin_1year = merge(kevin_1year,physicalhealth_sum_1year)
kevin_1year = merge(kevin_1year,psychopathology_1year)
kevin_1year = merge(kevin_1year,psychopathology_sum_1year)

kevin_1year = kevin_1year[kevin_1year$eventname == "1_year_follow_up_y_arm_1",]

write.csv(file = "outputs/kevin_1year_set.csv",x = kevin_1year, row.names = F, na = "")



####asthma_inflammation_set####

##excluding medications
##need to define anhedonia variable + asthma variables
demographics_baseline_full <- read_csv("outputs/demographics_baseline_full.csv")
exposome_baseline <- read_csv("outputs/exposome_baseline.csv")
geo_data_baseline <- read_csv("outputs/geo_data_baseline.csv")
ksad_y_diagnosis_anhedonia_baseline <- read_csv("outputs/ksad_y_diagnosis_anhedonia_baseline.csv")
asthma_inflammation_physicalhealth <- read_csv("outputs/asthma_inflammation_physicalhealth.csv")
physicalhealth_sum_baseline <- read_csv("outputs/physicalhealth_sum_baseline.csv")
exposome_sum_baseline <- read_csv("outputs/exposome_sum_baseline.csv")
suicide_firstyear_ontopof_baseline <- read_csv("outputs/suicide_firstyear_ontopof_baseline.csv")

asthma_inflammation_set = merge(demographics_baseline_full,exposome_baseline)
asthma_inflammation_set = merge(asthma_inflammation_set,geo_data_baseline)
asthma_inflammation_set = merge(asthma_inflammation_set,ksad_y_diagnosis_anhedonia_baseline)
asthma_inflammation_set = merge(asthma_inflammation_set,asthma_inflammation_physicalhealth)
asthma_inflammation_set = merge(asthma_inflammation_set,physicalhealth_sum_baseline)
asthma_inflammation_set = merge(asthma_inflammation_set,exposome_sum_baseline)
asthma_inflammation_set = merge(asthma_inflammation_set,suicide_firstyear_ontopof_baseline)

write.csv(file = "outputs/asthma_inflammation_set.csv",x = asthma_inflammation_set, row.names = F, na = "")



####stress_bmi_set####

##1-year items
##excluding medications
anthropometrics <- read_csv("outputs/anthropometrics.csv")
exposome_1year <- read_csv("outputs/exposome_1year.csv")
exposome_sum_1year <- read_csv("outputs/exposome_sum_1year.csv")
physicalhealth_1year <- read_csv("outputs/physicalhealth_1year.csv")
physicalhealth_sum_1year <- read_csv("outputs/physicalhealth_sum_1year.csv")
psychopathology_1year <- read_csv("outputs/psychopathology_1year.csv")
psychopathology_sum_1year <- read_csv("outputs/psychopathology_sum_1year.csv")
demographics_longitudinal <- read_csv("outputs/demographics_longitudinal.csv")
suicide_1year <- read_csv("outputs/suicide_1year.csv")

stress_bmi_set_1year = merge(anthropometrics,exposome_1year)
stress_bmi_set_1year = merge(stress_bmi_set_1year,exposome_sum_1year)
stress_bmi_set_1year = merge(stress_bmi_set_1year,physicalhealth_1year)
stress_bmi_set_1year = merge(stress_bmi_set_1year,physicalhealth_sum_1year)
stress_bmi_set_1year = merge(stress_bmi_set_1year,psychopathology_1year)
stress_bmi_set_1year = merge(stress_bmi_set_1year,psychopathology_sum_1year)
stress_bmi_set_1year = merge(stress_bmi_set_1year,demographics_longitudinal)
#### somehow the demographics longitudinal messes things up - goes from 17,000 to 445,000 obs
stress_bmi_set_1year = merge(stress_bmi_set_1year,suicide_1year)

write.csv(file = "outputs/stress_bmi_set_1year.csv",x = stress_bmi_set_1year, row.names = F, na = "")

##baseline items
##excluding suicide
##need to define baseline BMI, sports variables
anthropometrics <- read_csv("outputs/anthropometrics.csv")
demographics_baseline_short <- read_csv("outputs/demographics_baseline_short.csv")
physicalhealth_baseline <- read_csv("outputs/physicalhealth_baseline.csv")
#physicalhealth_sum_baseline <- read_csv("outputs/physicalhealth_sum_baseline.csv")
exposome_baseline <- read_csv("outputs/exposome_baseline.csv")
ksad_y_diagnosis <- read_csv("outputs/ksad_y_diagnosis.csv")
geo_data_baseline <- read_csv("outputs/geo_data_baseline.csv")
suicide_baseline <- read_csv("outputs/suicide_baseline.csv")

stress_bmi_set_baseline = merge(anthropometrics,demographics_baseline_short)
stress_bmi_set_baseline = merge(stress_bmi_set_baseline,physicalhealth_baseline)
#stress_bmi_set_baseline = merge(stress_bmi_set_baseline,physicalhealth_sum_baseline)
stress_bmi_set_baseline = merge(stress_bmi_set_baseline,exposome_baseline)
stress_bmi_set_baseline = merge(stress_bmi_set_baseline,ksad_y_diagnosis)
stress_bmi_set_baseline = merge(stress_bmi_set_baseline,geo_data_baseline)
stress_bmi_set_baseline = merge(stress_bmi_set_baseline,suicide_baseline)

write.csv(file = "outputs/stress_bmi_set_baseline.csv",x = stress_bmi_set_baseline, row.names = F, na = "")

