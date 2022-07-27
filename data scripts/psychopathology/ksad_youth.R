#note: 2-year follow up: there are new features available that weren't tag yet by ran as internal/external and dsm5
# 2-year Kevin data: not use this
source("config.R")
source("utility_fun.R")

ksad_y = load_instrument("abcd_ksad501", abcd_files_path)

#555 and 888 will be treated as NA
ksad_y[ksad_y == "888" | ksad_y == "555"] = NA

ksad_y = droplevels(ksad_y)


#################### internal diagnosis #################### 
#all kids diagnosis
ksad_y_diagnosis = ksad_y[, grepl("src|inter|event|sex|_((8[3-4][0-9])|863|864|869|870|(91[1-4])|969|970)_t", colnames(ksad_y))]

#remove empty col
ksad_y_diagnosis = ksad_y_diagnosis[,!colSums(is.na(ksad_y_diagnosis)) == nrow(ksad_y_diagnosis)]

#create diagnosis variables
#if 0 or NA then 0
ksad_y_diagnosis$diagnosis_bipolar_y = apply(ksad_y_diagnosis[,grepl("ksads_2_.*_t", colnames(ksad_y_diagnosis))],1 ,function(x) {any(x == 1)*1})
ksad_y_diagnosis$diagnosis_depression_y = apply(ksad_y_diagnosis[,grepl("ksads_1_.*_t", colnames(ksad_y_diagnosis))],1 ,function(x) {any(x == 1)*1})
ksad_y_diagnosis$diagnosis_DMDD_y = ksad_y_diagnosis$ksads_3_848_t
ksad_y_diagnosis$diagnosis_anxiety_y = apply(ksad_y_diagnosis[,grepl("ksads_(8|10)_.*_t", colnames(ksad_y_diagnosis))],1 ,function(x) {any(x == 1)*1})
ksad_y_diagnosis$diagnosis_sleep_y = apply(ksad_y_diagnosis[,grepl("ksads_22_.*_t", colnames(ksad_y_diagnosis))],1 ,function(x) {any(x == 1)*1})

summary(ksad_y_diagnosis[ksad_y_diagnosis$eventname == "baseline_year_1_arm_1",]) 


#################### anhedonia symptoms #################### 
ksad_y_anhedonia = ksad_y[,grepl("src|inter|event|sex|ksads_1_(5|6)_t",colnames(ksad_y))]

ksad_y_anhedonia$symptom_anhedonia_y = apply(ksad_y_anhedonia[,grepl("ksads_",colnames(ksad_y_anhedonia))],1 ,function(x) {any(x ==1)*1})


ksad_y_diagnosis_anhedonia = merge(ksad_y_anhedonia,ksad_y_diagnosis)

write.csv(file = "outputs/ksad_y_diagnosis_anhedonia.csv",x = ksad_y_diagnosis_anhedonia, row.names=F, na = "")

