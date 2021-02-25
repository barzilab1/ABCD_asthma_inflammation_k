
source("config.R")
source("utility_fun.R")


########### family relationship section ########### 
acspsw03 = load_instrument("acspsw03",exposome_files_path)

summary(acspsw03)

#select variables
acspsw03 = acspsw03[,grepl("src|interview|event|^sex|rel_family_id",colnames(acspsw03))]


########## developmental history ########### 
dhx01 = load_instrument("dhx01",exposome_files_path)

#select variables
dhx01 = dhx01[,grepl("src|interview|event|sex|devhx_(3|4)_p$",colnames(dhx01))]

#remove outliers
dhx01$devhx_3_p = as.numeric(as.character(dhx01$devhx_3_p))
dhx01$devhx_3_p[dhx01$devhx_3_p > 55] = NA

dhx01$devhx_4_p = as.numeric(as.character(dhx01$devhx_4_p))
dhx01$devhx_4_p[dhx01$devhx_4_p > 80] = NA




exposome_baseline = merge(acspsw03,dhx01)
write.csv(file = "outputs/exposome_baseline.csv",x = exposome_baseline, row.names = F, na = "")






