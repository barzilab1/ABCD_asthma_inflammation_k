
source("config.R")
source("utility_fun.R")

################### Sum Scores Mental Health Youth ################### 
mhy = load_instrument("abcd_mhy02", psychopathology_files_path)

#remove nt (Number Total Questions) and nm (Number Missing Answers)
mhy = mhy[,!grepl("_(nm|nt)$",colnames(mhy))]

summary(mhy[mhy$eventname == "baseline_year_1_arm_1" ,])
summary(mhy[mhy$eventname == "1_year_follow_up_y_arm_1" ,])

#select variables
mhy = mhy[,grepl("src|interview|event|sex|ple_(.*)_(number$|good$|bad$|sum$|mean$)|pps_(.*)_(number$|sum$|n_1$|score$|severity$)",colnames(mhy))]




write.csv(file = "outputs/psychopathology_sum_1year.csv",x = mhy, row.names = F, na = "")

