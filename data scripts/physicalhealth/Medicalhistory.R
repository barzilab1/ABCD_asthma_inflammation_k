
source("config.R")
source("utility_fun.R")

########### ABCD Parent Medical History Questionnaire (MHX) ########### 

mx01 = load_instrument("abcd_mx01",physicalhealth_files_path)

#remove empty columns
mx01 = mx01[,(colSums(is.na(mx01)) != dim(mx01)[1])]

#"Don't know" and "Decline to answer" will be treated as NA
mx01[mx01 == "6" | mx01 == "7"] = NA

#continuous variables - remove outliers (replace with NA)

#remove language column
mx01 = mx01[,!grepl("(medhx_select_language___1)$",colnames(mx01))]

#select variables for immune study
mx01 = mx01[,grepl("src|interview|event|sex|(2(a|b|d|g|m)|6(a|l))$",colnames(mx01))]


########### ABCD Longitudinal Parent Medical History Questionnaire ########### 

lpmh01 = load_instrument("abcd_lpmh01",physicalhealth_files_path)

#remove empty columns 
names(lpmh01)[sapply(lpmh01, function(x) all((x=="NA")|(is.na(x))))]
lpmh01 = lpmh01[!sapply(lpmh01, function(x) all((x=="NA")|(is.na(x))))]



