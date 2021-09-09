
source("config.R")
source("utility_fun.R")

########## ABCD Sum Scores Physical Health Parent ###########

ssphp01 = load_instrument("abcd_ssphp01", physicalhealth_files_path)

#select variables 
ssphp01 = ssphp01[,grepl("src|sex|inter|event|total$",colnames(ssphp01))]

summary(ssphp01[ssphp01$eventname == "baseline_year_1_arm_1", ])




########### ABCD Summary Scores Medical History ########### 

medhxss01 = load_instrument("abcd_medhxss01",physicalhealth_files_path)

#select variables for immune study
medhxss01 = medhxss01[,grepl("src|interview|event|sex|6(a|l)_times_p$",colnames(medhxss01))]


physicalhealth_sum = merge(medhxss01, ssphp01)


write.csv(file = "outputs/physicalhealth_sum_baseline.csv",x = physicalhealth_sum, row.names = F, na = "")

