library(dplyr)
source("config.R")
source("utility_fun.R")

########## ABCD Sum Scores Physical Health Parent ###########

ssphp01 = load_instrument("abcd_ssphp01", abcd_files_path)

#select variables 
ssphp01 = ssphp01[,grepl("src|sex|inter|event|total$|cna_p_ss_sum", colnames(ssphp01))]

summary(ssphp01[ssphp01$eventname == "baseline_year_1_arm_1", ])




########### ABCD Summary Scores Medical History - baseline only ########### 

medhxss01 = load_instrument("abcd_medhxss01", abcd_files_path)

#select variables for immune study
medhxss01 = medhxss01[,grepl("src|interview|event|sex|6(a|l)_times_p$", colnames(medhxss01))]


########### ABCD Longitudinal Summary Scores Medical History ########### 
lssmh01 = load_instrument("abcd_lssmh01", abcd_files_path)
# medhx_ss_6l_times_p_l, medhx_ss_6a_times_p_l
lssmh01 = lssmh01[, grepl("src|interview|event|sex|6(a|l)_times_p_l$", colnames(lssmh01))]


asthma_inflammation_ss = bind_rows(medhxss01, lssmh01)

# Combine data at baseline and longitudinal, using the longitudinal colnames for future analyses
asthma_inflammation_ss <- asthma_inflammation_ss %>% 
  mutate(medhx_ss_6a_times_p_l = coalesce(medhx_ss_6a_times_p_l, medhx_ss_6a_times_p),
         medhx_ss_6l_times_p_l = coalesce(medhx_ss_6l_times_p_l, medhx_ss_6l_times_p)
  ) %>% 
  dplyr::select(-medhx_ss_6a_times_p, -medhx_ss_6l_times_p)

# Rename the asthma exposure to ease use
asthma_inflammation_ss <- asthma_inflammation_ss %>% 
  rename(broken_bones_freq_l = medhx_ss_6a_times_p_l,
         asthma_attack_freq_l = medhx_ss_6l_times_p_l)



physicalhealth_sum = merge(asthma_inflammation_ss, ssphp01)


write.csv(file = "outputs/physicalhealth_sum.csv", x = physicalhealth_sum, row.names = F, na = "")
