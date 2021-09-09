
library(readr)

demographics_baseline <- read_csv("outputs/demographics_baseline.csv")
exposome_baseline <- read_csv("outputs/exposome_baseline.csv")
geo_data_baseline <- read_csv("outputs/geo_data_baseline.csv")
ksad_y_diagnosis_anhedonia <- read_csv("outputs/ksad_y_diagnosis_anhedonia.csv")
asthma_inflammation_physicalhealth <- read_csv("outputs/asthma_inflammation_physicalhealth.csv")
physicalhealth_sum_baseline <- read_csv("outputs/physicalhealth_sum_baseline.csv")
exposome_sum_baseline <- read_csv("outputs/exposome_sum_baseline.csv")
suicide_firstyear_ontopof_baseline <- read_csv("outputs/suicide_firstyear_ontopof_baseline.csv")
site <- read_csv("outputs/site.csv")
medications <- read_csv("outputs/medications.csv", col_types = cols(.default = "n", 
                                                                    "src_subject_id" = "c",
                                                                    "eventname" = "c") )



asthma_inflammation_set = merge(asthma_inflammation_physicalhealth, medications)

#create the asthma composite feature
asthma_inflammation_set$asthma_composite = apply(asthma_inflammation_set[,c("Asthma_medications","medhx_2a","medhx_6l")], 1, function(r) any(r==1)*1)


asthma_inflammation_set = merge(demographics_baseline, asthma_inflammation_set)
asthma_inflammation_set = merge(asthma_inflammation_set, exposome_baseline)
asthma_inflammation_set = merge(asthma_inflammation_set, geo_data_baseline)
asthma_inflammation_set = merge(asthma_inflammation_set, ksad_y_diagnosis_anhedonia)
asthma_inflammation_set = merge(asthma_inflammation_set, physicalhealth_sum_baseline)
asthma_inflammation_set = merge(asthma_inflammation_set, exposome_sum_baseline)
asthma_inflammation_set = merge(asthma_inflammation_set, suicide_firstyear_ontopof_baseline)
asthma_inflammation_set = merge(asthma_inflammation_set, site)


write.csv(file = "outputs/asthma_inflammation_set.csv",x = asthma_inflammation_set, row.names = F, na = "")



set.seed(131)
one_family_member = do.call(rbind, 
                            lapply(split(asthma_inflammation_set,asthma_inflammation_set$rel_family_id),
                                   function(x){x[sample(nrow(x),1),]}))

write.csv(file = "outputs/one_family_member.csv",x = one_family_member, row.names=F, na = "")








