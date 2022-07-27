
source("config.R")
source("utility_fun.R")

########## Sum Scores Culture & Environment Youth ########### 
sscey01 = load_instrument("abcd_sscey01", abcd_files_path)

#remove nt (Number Total Questions) and nm (Number Missing Answers) and na (Number Answered)
sscey01 = sscey01[,!grepl("_(nm|nt|na|answered|pr|dfs)$", colnames(sscey01))] 

summary(droplevels(sscey01))

# select variables
sscey01 = sscey01[,grepl("src|interview|event|sex|fes|pmq|crpbi|srpf", colnames(sscey01))]


########### ABCD Sum Scores Mobil Tech Youth ########### 
ssmty = load_instrument("abcd_ssmty01", abcd_files_path)

#select variables
ssmty = ssmty[, grepl("src|interview|event|sex|(weekday|weekend)$", colnames(ssmty))]
summary(droplevels(ssmty))



# merge tables
exposome_sum_baseline = merge(sscey01, ssmty)
write.csv(file = "outputs/exposome_sum_baseline.csv", x = exposome_sum_baseline, row.names = F, na = "")



