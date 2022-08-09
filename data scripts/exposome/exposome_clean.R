
source("config.R")
source("utility_fun.R")


########### family relationship section ########### 
acspsw03 = load_instrument("acspsw03", abcd_files_path)

#select variables
acspsw03 = acspsw03[acspsw03$eventname == "baseline_year_1_arm_1", c("src_subject_id","eventname","rel_family_id")]


########## developmental history ########### 
dhx01 = load_instrument("dhx01", abcd_files_path)

dhx01[dhx01 == 999 | dhx01 == -1] = NA
dhx01$accult_select_language = NULL

#remove empty columns 
dhx01 = dhx01[,colSums(is.na(dhx01)) != nrow(dhx01)]

#change the scale
dhx01$devhx_caffeine_11[dhx01$devhx_caffeine_11 == 0] = 4

#remove outliers

# dhx01$devhx_3_p[dhx01$devhx_3_p > 55] = NA
dhx01$devhx_4_p[dhx01$devhx_4_p > 80] = NA

dhx01$devhx_11_p[dhx01$devhx_11_p > 50] = NA
dhx01$devhx_16_p[dhx01$devhx_16_p > 60] = NA


dhx01$devhx_19a_p[dhx01$devhx_19a_p > 24] = NA
dhx01$devhx_19b_p[dhx01$devhx_19b_p < 3 | dhx01$devhx_19b_p > 60] = NA
dhx01$devhx_19c_p[dhx01$devhx_19c_p < 7 | dhx01$devhx_19c_p > 60] = NA
dhx01$devhx_19d_p[dhx01$devhx_19d_p < 4 | dhx01$devhx_19d_p > 72] = NA

dhx01$devhx_caff_amt_week[dhx01$devhx_caff_amt_week > 24] = NA


exposome_baseline = merge(acspsw03, dhx01)

write.csv(file = "outputs/exposome_baseline.csv",x = exposome_baseline, row.names = F, na = "")






