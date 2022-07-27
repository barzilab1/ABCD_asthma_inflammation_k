library(dplyr)
source("config.R")
source("utility_fun.R")

########### Parent Medical History Questionnaire (MHX) ########### 
mx01 = load_instrument("abcd_mx01", abcd_files_path)

#select variables
mx01 = mx01[,grepl("src|interview|event|sex|(2(a|b|d|g|m)|6(a|l))$", colnames(mx01))]

# mx01$asthma_composite = apply(mx01[, c("medhx_2a","medhx_6l")], 1, function(r) any(r==1)*1)
mx01 = mx01 %>% rename_with(., ~ paste0(.x, "_l"), .cols = contains("medhx"))

########### Longitudinal Parent Medical History Questionnaire ########### 
lpmh01 = load_instrument("abcd_lpmh01", abcd_files_path)

#select variables
lpmh01 = lpmh01[, grepl("src|interview|event|sex|(2(a|b|d|g|m)|6(a|l)_l)", colnames(lpmh01))]
# lpmh01$asthma_composite_l = apply(lpmh01[, c("medhx_2a_l","medhx_6l_l")], 1, function(r) any(r==1)*1)

# lpmh01 = lpmh01[lpmh01$eventname == "1_year_follow_up_y_arm_1",]

summary(lpmh01)
# lpmh01[, c("eventname", "interview_date", "interview_age")] = NULL

asthma_inflammation_ph = bind_rows(lpmh01, mx01)

# Combine data at baseline and longitudinal, using the longitudinal colnames for future analyses
# asthma_inflammation_ph <- asthma_inflammation_ph %>% 
#   mutate(medhx_2a_l = coalesce(medhx_2a_l, medhx_2a),
#          medhx_2b_l = coalesce(medhx_2b_l, medhx_2b),
#          medhx_2d_l = coalesce(medhx_2d_l, medhx_2d),
#          medhx_2g_l = coalesce(medhx_2g_l, medhx_2g),
#          medhx_2m_l = coalesce(medhx_2m_l, medhx_2m),
#          medhx_6a_l = coalesce(medhx_6a_l, medhx_6a),
#          medhx_6l_l = coalesce(medhx_6l_l, medhx_6l),
#          asthma_composite_l = coalesce(asthma_composite_l, asthma_composite)
#          ) %>% 
#   dplyr::select(-medhx_2a, -medhx_2b, -medhx_2d, -medhx_2g, -medhx_2m, -medhx_6a, -medhx_6l, -asthma_composite)

# Rename the asthma exposure
asthma_inflammation_ph <- asthma_inflammation_ph %>% 
  dplyr::rename(asthma_diagnosis_l = medhx_2a_l,
         asthma_attack_l = medhx_6l_l)

# Not carry asthma diagnosis over later timepoint
write.csv(file = "outputs/asthma_inflammation_ph_notcarry.csv", x = asthma_inflammation_ph, row.names = F, na = "")



# Once asthma_diagnosis_l == 1 then later timepoint will be 1
# asthma_inflammation_ph_baseline_year_1_arm_1 <- asthma_inflammation_ph %>% filter(eventname == "baseline_year_1_arm_1") %>%
#   dplyr::select(src_subject_id, asthma_diagnosis_l_baseline_year_1_arm_1 = asthma_diagnosis_l)
# 
# asthma_inflammation_ph_1_year_follow_up_y_arm_1 <- asthma_inflammation_ph %>% filter(eventname == "1_year_follow_up_y_arm_1") %>%
#   dplyr::select(src_subject_id, asthma_diagnosis_l_1_year_follow_up_y_arm_1 = asthma_diagnosis_l)
# 
# asthma_inflammation_ph_2_year_follow_up_y_arm_1 <- asthma_inflammation_ph %>% filter(eventname == "2_year_follow_up_y_arm_1") %>%
#   dplyr::select(src_subject_id, asthma_diagnosis_l_2_year_follow_up_y_arm_1 = asthma_diagnosis_l)
# 
# asthma_inflammation_ph_3_year_follow_up_y_arm_1 <- asthma_inflammation_ph %>% filter(eventname == "3_year_follow_up_y_arm_1") %>%
#   dplyr::select(src_subject_id, asthma_diagnosis_l_3_year_follow_up_y_arm_1 = asthma_diagnosis_l)
# 
# 
# asthma_inflammation_ph_wide <- asthma_inflammation_ph_baseline_year_1_arm_1 %>%
#   full_join(asthma_inflammation_ph_1_year_follow_up_y_arm_1) %>%
#   full_join(asthma_inflammation_ph_2_year_follow_up_y_arm_1) %>%
#   full_join(asthma_inflammation_ph_3_year_follow_up_y_arm_1)
# # 
# # write.csv(file = "outputs/asthma_inflammation_ph_wide.csv", x = asthma_inflammation_ph_wide, row.names = F, na = "")
# 
# # Add 2 columns: those who said yy (1) and yn(0) for asthma diagnosis from baseline to 1year, and same for suicidality
# asthma_inflammation_ph_wide <- asthma_inflammation_ph_wide %>%
#   mutate(
#     asthma_diagnosis_yesyes = case_when(asthma_diagnosis_l_baseline_year_1_arm_1 == 1 & asthma_diagnosis_l_1_year_follow_up_y_arm_1 == 1 ~ "ast_11",
#                                         asthma_diagnosis_l_baseline_year_1_arm_1 == 1 & asthma_diagnosis_l_1_year_follow_up_y_arm_1 == 0 ~ "ast_10",
#                                         asthma_diagnosis_l_baseline_year_1_arm_1 == 0 & asthma_diagnosis_l_1_year_follow_up_y_arm_1 == 0 ~ "ast_00",
#                                         asthma_diagnosis_l_baseline_year_1_arm_1 == 0 & asthma_diagnosis_l_1_year_follow_up_y_arm_1 == 1 ~ "ast_01",
#                                      TRUE ~ NA_character_) # 1 is yesyes, 0 is yesno, NA others
#   )
# 
# 
# 
# 
# asthma_inflammation_ph_wide$asthma_diagnosis_l_1_year_follow_up_y_arm_1[asthma_inflammation_ph_wide$asthma_diagnosis_l_baseline_year_1_arm_1 == 1] <- 1
# asthma_inflammation_ph_wide$asthma_diagnosis_l_2_year_follow_up_y_arm_1[asthma_inflammation_ph_wide$asthma_diagnosis_l_baseline_year_1_arm_1 == 1 |
#                                                             asthma_inflammation_ph_wide$asthma_diagnosis_l_1_year_follow_up_y_arm_1 == 1] <- 1
# asthma_inflammation_ph_wide$asthma_diagnosis_l_3_year_follow_up_y_arm_1[asthma_inflammation_ph_wide$asthma_diagnosis_l_baseline_year_1_arm_1 == 1 |
#                                                             asthma_inflammation_ph_wide$asthma_diagnosis_l_1_year_follow_up_y_arm_1 == 1 |
#                                                             asthma_inflammation_ph_wide$asthma_diagnosis_l_2_year_follow_up_y_arm_1 == 1] <- 1
# 
# 
# asthma_inflammation_ph_long <- asthma_inflammation_ph_wide %>%
#   tidyr::pivot_longer(!src_subject_id, names_to = "eventname", values_to = "asthma_diagnosis_l", names_prefix = "asthma_diagnosis_l_")
# # 
# asthma_inflammation_ph <- asthma_inflammation_ph %>% dplyr::select(-asthma_diagnosis_l) %>%
#   left_join(asthma_inflammation_ph_long)
# # 
# write.csv(file = "outputs/asthma_inflammation_ph.csv", x = asthma_inflammation_ph, row.names = F, na = "")

