
source("config.R")
source("utility_fun.R")

########## Sum Scores Culture & Environment Youth ########### 
sscey01 = load_instrument("abcd_sscey01",exposome_files_path)

#remove nt (Number Total Questions) and nm (Number Missing Answers) and na (Number Answered)
sscey01 = sscey01[,!grepl("_(nm|nt|na|answered)$",colnames(sscey01))] #pr


# sscey01$school_protective_factors = as.numeric(as.character(sscey01$srpf_y_ss_ses)) + as.numeric(as.character(sscey01$srpf_y_ss_iiss))

summary(droplevels(sscey01))

# select variables
sscey01 = sscey01[,grepl("src|interview|event|sex|fes_y_ss_fc$|crpbi_y_ss_(parent$|caregiver$)",colnames(sscey01))]


########### Longitudinal Summary Scores Sports Activity ########### 
lsssa = load_instrument("abcd_lsssa01",exposome_files_path)
lsssa[lsssa == 999] = NA

#remove empty columns
lsssa = lsssa[,colSums(is.na(lsssa)) != dim(lsssa)[1]]
summary(droplevels(lsssa))

# how to treat variables?

########### ABCD Sum Scores Mobil Tech Youth ########### 
ssmty = load_instrument("abcd_ssmty01",exposome_files_path)

#remove empty columns
ssmty = ssmty[,colSums(is.na(ssmty)) != dim(ssmty)[1]]
summary(droplevels(ssmty))

#select variables
ssmty = ssmty[,grepl("src|interview|event|sex|stq_y_ss_(weekday$|weekend$)",colnames(ssmty))]



# merge tables
exposome_sum_1year = merge(sscey01,ssmty)
exposome_sum_1year = merge(exposome_sum_1year,lsssa)
write.csv(file = "outputs/exposome_sum_1year.csv",x = exposome_sum_1year, row.names = F, na = "")

exposome_sum_baseline = merge(sscey01,ssmty)
write.csv(file = "outputs/exposome_sum_baseline.csv",x = exposome_sum_baseline, row.names = F, na = "")



