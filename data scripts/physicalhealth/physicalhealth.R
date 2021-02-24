
source("config.R")
source("utility_fun.R")

########### ABCD Parent Medical History Questionnaire (MHX) ########### 

mx01 = load_instrument("abcd_mx01",physicalhealth_files_path)

#continuous variables - remove outliers (replace with NA)

#select variables
mx01 = mx01[,grepl("src|interview|event|sex|(2(a|b|d|g|m)|6(a|l))$",colnames(mx01))]


########### ABCD Longitudinal Parent Medical History Questionnaire ########### 

lpmh01 = load_instrument("abcd_lpmh01",physicalhealth_files_path)

#not using in this study


########### ABCD Parent Pubertal Development Scale and Menstrual Cycle Survey History (PDMS) ########### 

ppdms = load_instrument("abcd_ppdms01",physicalhealth_files_path)

summary(droplevels(ppdms))

#"Don't know" will be treated as NA
ppdms[ppdms == "999"] = NA

#all variables will be taken


########### ABCD Youth Pubertal Development Scale and Menstrual Cycle Survey History (PDMS) ########### 

ypdms = load_instrument("abcd_ypdms01",physicalhealth_files_path)

#"Don't know" and "Decline to answer" will be treated as NA
ypdms[ypdms == "777" | ypdms == "999"] = NA

#all variables will be taken


########### ABCD Youth Youth Risk Behavior Survey Exercise Physical Activity (YRB) ########### 

yrb = load_instrument("abcd_yrb01",physicalhealth_files_path)

#select variables
yrb = yrb[,grepl("src|interview|event|sex|physical_activity(1_y|2_y)",colnames(yrb))]



physicalhealth_1year = merge(ppdms,ypdms)
write.csv(file = "outputs/physicalhealth_1year.csv",x = physicalhealth_1year, row.names = F, na = "")

physicalhealth_baseline = merge(mx01,yrb)
write.csv(file = "outputs/physicalhealth_baseline.csv",x = physicalhealth_baseline, row.names = F, na = "")

write.csv(file = "outputs/asthma_inflammation_physicalhealth.csv",x = mx01, row.names = F, na = "")

