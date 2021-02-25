
source("config.R")
source("utility_fun.R")

########## ABCD Sum Scores Physical Health Parent ###########

ssphp01 = load_instrument("abcd_ssphp01", physicalhealth_files_path)

#select variables for immune study
ssphp01 = ssphp01[,grepl("src|interview|event|sex|sds_p_ss_sbd$|cna_p_ss_sum$|pds_(.*)_category|pds_(.*)_category_2",colnames(ssphp01))]


########## ABCD Sum Scores Physical Health Youth ###########

ssphy = load_instrument("abcd_ssphy01", physicalhealth_files_path)

#select variables for immune study
ssphy = ssphy[,grepl("src|interview|event|sex|sds_p_ss_sbd$|cna_p_ss_sum$|pds_(.*)_category|pds_y_ss_female_category_2|pds_y_ss_male_cat_2",colnames(ssphy))]



########### ABCD Summary Scores Medical History ########### 

medhxss01 = load_instrument("abcd_medhxss01",physicalhealth_files_path)

#select variables for immune study
medhxss01 = medhxss01[,grepl("src|interview|event|sex|6(a|l)_times_p$",colnames(medhxss01))]




physicalhealth_sum_1year = merge(ssphp01,ssphy)
write.csv(file = "outputs/physicalhealth_sum_1year.csv",x = physicalhealth_sum_1year, row.names = F, na = "")

write.csv(file = "outputs/physicalhealth_sum_baseline.csv",x = medhxss01, row.names = F, na = "")

