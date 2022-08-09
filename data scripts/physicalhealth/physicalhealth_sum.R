library(dplyr)
source("config.R")
source("utility_fun.R")

########## ABCD Sum Scores Physical Health Parent ###########
ssphp01 = load_instrument("abcd_ssphp01", abcd_files_path)

#select variables 
ssphp01 = ssphp01[,grepl("src|sex|inter|event|total$|cna_p_ss_sum", colnames(ssphp01))]
summary(ssphp01[ssphp01$eventname == "baseline_year_1_arm_1", ])


########### Summary Scores Medical History - baseline only ########### 
medhxss01 = load_instrument("abcd_medhxss01", abcd_files_path)

#select variables
medhxss01 = medhxss01[,grepl("src|interview|event|sex|6(a|l)_times_p$", colnames(medhxss01))]

#change the names to be alligned with the longitudinal instrument 
medhxss01 = medhxss01 %>% rename_with(., ~ paste0(.x, "_l"), .cols = contains("medhx"))

########### Longitudinal Summary Scores Medical History ########### 
lssmh01 = load_instrument("abcd_lssmh01", abcd_files_path)
lssmh01 = lssmh01[, grepl("src|interview|event|sex|6(a|l)_times_p_l$", colnames(lssmh01))]

asthma_inflammation_ss = bind_rows(medhxss01, lssmh01)


physicalhealth_sum = merge(asthma_inflammation_ss, ssphp01)


write.csv(file = "outputs/physicalhealth_sum.csv", x = physicalhealth_sum, row.names = F, na = "")
