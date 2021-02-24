
source("config.R")
source("utility_fun.R")

########### Discrimination ########### 
ydmes01 = load_instrument("abcd_ydmes01",exposome_files_path)

ydmes01[ydmes01 == 777 | ydmes01 == 999] = NA
ydmes01 = droplevels(ydmes01)

summary(ydmes01[ydmes01$eventname == "1_year_follow_up_y_arm_1",])

#check collinearity 
library("psych")
matrix_names = colnames(ydmes01[ ,grep("_matrix_", colnames(ydmes01)) ])
ydmes01[,matrix_names] = apply(ydmes01[,matrix_names], 2, function(x) {as.numeric(as.character(x))})
xcor <- polychoric(ydmes01[,matrix_names])$rho
VSS.scree(xcor)
eigen(xcor)$values[1]/eigen(xcor)$values[2]

#select variables
ydmes01 = ydmes01[,grepl("src|interview|event|sex|dim_yesno_q4",colnames(ydmes01))]


########### family relationship section ########### 
acspsw03 = load_instrument("acspsw03",exposome_files_path)

summary(acspsw03)

#select variables
acspsw03 = acspsw03[,grepl("src|interview|event|^sex|rel_family_id",colnames(acspsw03))]

########## youth life events ########### 
yle = load_instrument("abcd_yle01",exposome_files_path)

yle = yle[,!grepl("_(fu|fu2|yr)_y$",colnames(yle))]


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

exposome_1year = merge (ydmes01,yle)
write.csv(file = "outputs/exposome_1year.csv",x = exposome_1year, row.names = F, na = "")








