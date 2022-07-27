
source("config.R")
source("utility_fun.R")

################### cbcls ################### 
cbcls01 = load_instrument("abcd_cbcls01",abcd_files_path)

cbcls = cbcls01[, grepl("^(src|event)|cbcl_scr_syn_totprob_r", colnames(cbcls01))]

write.csv(file = "outputs/cbcls.csv",x = cbcls, row.names = F, na = "")

