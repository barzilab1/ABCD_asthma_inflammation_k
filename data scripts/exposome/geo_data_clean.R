
source("config.R")
source("utility_fun.R")


########### School Risk and Protective Factors ########### 
rhds01 = load_instrument("abcd_rhds01", abcd_files_path)

#select variables
rhds01 = rhds01[,grepl("^(src|interview|event|sex)|addr1_(popdensity|no2|pm25|proxrd|adi_(income|pov|wsum|perc))$", colnames(rhds01))]
rhds01 = rhds01[rhds01$eventname == "baseline_year_1_arm_1",]
rhds01$eventname = NULL

# summary(droplevels(rhds01[rhds01$eventname == "baseline_year_1_arm_1",]))


write.csv(file = "outputs/geo_data_baseline.csv", x = rhds01, row.names = F, na = "")


