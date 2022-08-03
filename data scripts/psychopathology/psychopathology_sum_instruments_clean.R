source("config.R")
source("utility_fun.R")

################### cbcls ################### 
cbcls01 = load_instrument("abcd_cbcls01",abcd_files_path)

cbcls01 = cbcls01[, grepl("^(src|event)|cbcl_scr_syn_totprob_(r|t)", colnames(cbcls01))]

# write.csv(file = "outputs/cbcls.csv", x = cbcls, row.names = F, na = "")

################### Youth Summary Scores BPM and POA ################### 
yssbpm01 = load_instrument("abcd_yssbpm01", abcd_files_path)
yssbpm01 = yssbpm01[,grepl("^(src|interv|event|sex)|bpm_y_scr_totalprob_(r|t)", colnames(yssbpm01))]

psychopathology_sum_scores = merge(cbcls01, yssbpm01)

write.csv(file = "outputs/psychopathology_sum_scores.csv", x = psychopathology_sum_scores, row.names = F, na = "")