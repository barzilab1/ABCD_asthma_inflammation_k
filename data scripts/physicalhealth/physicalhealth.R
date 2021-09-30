
source("config.R")
source("utility_fun.R")

########### ABCD Parent Medical History Questionnaire (MHX) ########### 

mx01 = load_instrument("abcd_mx01",physicalhealth_files_path)

#select variables
mx01 = mx01[,grepl("src|interview|event|sex|(2(a|b|d|g|m)|6(a|l))$",colnames(mx01))]


########### Longitudinal Parent Medical History Questionnaire ########### 

lpmh01 = load_instrument("abcd_lpmh01",physicalhealth_files_path)

#select variables
lpmh01 = lpmh01[,grepl("src|interview|event|sex|(2(a|b|d|g|m)|6(a|l)_l)",colnames(lpmh01))]
lpmh01$asthma_composite_l = apply(lpmh01[,c("medhx_2a_l","medhx_6l_l")], 1, function(r) any(r==1)*1)

lpmh01 = lpmh01[lpmh01$eventname == "1_year_follow_up_y_arm_1",]

summary(lpmh01)
lpmh01[,c("eventname", "interview_date", "interview_age")] = NULL

asthma_inflammation_physicalhealth = merge(mx01,lpmh01, all = T )

write.csv(file = "outputs/asthma_inflammation_physicalhealth.csv",x = asthma_inflammation_physicalhealth, row.names = F, na = "")

