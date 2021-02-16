
source("config.R")
source("utility_fun.R")

########## ABCD Sum Scores Physical Health Parent ###########

ssphp01 = load_instrument("abcd_ssphp01", physicalhealth_files_path)

#select variables for immune study
ssphp01 = ssphp01[,grepl("src|interview|event|sex|sds_p_ss_sbd$|cna_p_ss_sum$|pds_p_ss_male_category|pds_(.*)_category",colnames(ssphp01))]


########### ABCD Summary Scores Medical History ########### 

medhxss01 = load_instrument("abcd_medhxss01",physicalhealth_files_path)

#remove empty columns 
medhxss01 = medhxss01[,(colSums(is.na(medhxss01)) != dim(medhxss01)[1])]

#select variables for immune study
medhxss01 = medhxss01[,grepl("src|interview|event|sex|((6a|6l)_times_p)$",colnames(medhxss01))]
