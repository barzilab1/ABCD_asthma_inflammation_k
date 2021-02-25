
source("config.R")
source("utility_fun.R")

########### ABCD Parent Medical History Questionnaire (MHX) ########### 

mx01 = load_instrument("abcd_mx01",physicalhealth_files_path)

#select variables
mx01 = mx01[,grepl("src|interview|event|sex|(2(a|b|d|g|m)|6(a|l))$",colnames(mx01))]


write.csv(file = "outputs/asthma_inflammation_physicalhealth.csv",x = mx01, row.names = F, na = "")

