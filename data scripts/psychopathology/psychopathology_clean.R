
source("config.R")
source("utility_fun.R")


########## ABCD Parent Sleep Disturbance Scale for Children (SDS) ###########

sds01 = load_instrument("abcd_sds01",psychopathology_files_path)

#select variables
sds01 = sds01[,grepl("src|interview|event|sex|sleepdisturb1_p",colnames(sds01))]

sds01 = unique(sds01)

write.csv(file = "outputs/psychopathology_1year.csv",x = sds01, row.names = F, na = "")

