
source("config.R")
source("utility_fun.R")

########### ABCD Summary Scores Medical History ########### 

medhxss01 = load_instrument("abcd_medhxss01",physicalhealth_files_path)

#select variables for immune study
medhxss01 = medhxss01[,grepl("src|interview|event|sex|6(a|l)_times_p$",colnames(medhxss01))]


write.csv(file = "outputs/physicalhealth_sum_baseline.csv",x = medhxss01, row.names = F, na = "")

