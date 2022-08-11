library(dplyr)
source("config.R")
source("utility_fun.R")

########### Parent Medical History Questionnaire (MHX) ########### 
mx01 = load_instrument("abcd_mx01", abcd_files_path)

#select variables
mx01 = mx01[,grepl("src|interview|event|sex|(2(a|b|d|g|m)|6(a|l))$", colnames(mx01))]
mx01 = mx01 %>% rename_with(., ~ paste0(.x, "_l"), .cols = contains("medhx"))

########### Longitudinal Parent Medical History Questionnaire ########### 
lpmh01 = load_instrument("abcd_lpmh01", abcd_files_path)

#select variables
lpmh01 = lpmh01[, grepl("src|interview|event|sex|(2(a|b|d|g|m)|6(a|l)_l)", colnames(lpmh01))]


asthma_inflammation_ph = bind_rows(lpmh01, mx01)

# Rename the asthma exposure
asthma_inflammation_ph <- asthma_inflammation_ph %>% 
  dplyr::rename(asthma_diagnosis_l = medhx_2a_l,
         asthma_attack_l = medhx_6l_l)


write.csv(file = "outputs/asthma_inflammation_ph_notcarry.csv", x = asthma_inflammation_ph, row.names = F, na = "")

