
source("config.R")
source("utility_fun.R")

########## Sum Scores Culture & Environment Youth ########### 
sscey01 = load_instrument("abcd_sscey01",exposome_files_path)

#remove nt (Number Total Questions) and nm (Number Missing Answers) and na (Number Answered)
sscey01 = sscey01[,!grepl("_(nm|nt|na|answered|pr|dfs)$",colnames(sscey01))] 

summary(droplevels(sscey01))

# select variables
sscey01 = sscey01[,grepl("src|interview|event|sex|fes|pmq|crpbi|srpf",colnames(sscey01))]


########### Longitudinal Summary Scores Sports Activity ########### 
lsssa = load_instrument("abcd_lsssa01",exposome_files_path)
lsssa[lsssa == 999] = NA

#remove empty columns
lsssa = lsssa[,colSums(is.na(lsssa)) != dim(lsssa)[1]]
summary(droplevels(lsssa))


########### ABCD Sum Scores Mobil Tech Youth ########### 
ssmty = load_instrument("abcd_ssmty01",exposome_files_path)

#select variables
ssmty = ssmty[,grepl("src|interview|event|sex|(weekday|weekend)$",colnames(ssmty))]
summary(droplevels(ssmty))


# merge tables
exposome_sum_1year = merge(sscey01,ssmty)
exposome_sum_1year = merge(exposome_sum_1year,lsssa)
write.csv(file = "outputs/exposome_sum_1year.csv",x = exposome_sum_1year, row.names = F, na = "")

exposome_sum_baseline = merge(sscey01,ssmty)
write.csv(file = "outputs/exposome_sum_baseline.csv",x = exposome_sum_baseline, row.names = F, na = "")



