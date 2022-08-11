
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

dhx01 = dhx01[,grep("src|event|interview|sex|devhx_3_p$", colnames(dhx01))]


exposome_baseline = merge(acspsw03, dhx01)

write.csv(file = "outputs/exposome_baseline.csv",x = exposome_baseline, row.names = F, na = "")






